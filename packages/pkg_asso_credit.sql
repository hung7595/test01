create or replace
PACKAGE PKG_ASSO_CREDIT AS

  deciLexchange_rate decimal(18,2);

  --cron_fe_insert_associate_link_order_process
  PROCEDURE link_order_proccess;

  --sp_fe_asso_insertProductCommissionByRevenue
  PROCEDURE insertProductCommissionByRev;

  --sp_fe_asso_insertProductCommissionByAttribute
  PROCEDURE insertProductCommissionByAttr;

  --cron_fe_asso_greporder
  PROCEDURE greporder;

  --corn_fe_update_associate_coupon
  PROCEDURE update_associate_coupon;

  --Aprove Credit (1)
  PROCEDURE approve_credit_01;

  --Aprove Credit (2)
  PROCEDURE approve_credit_02;

  --Void Credit
  PROCEDURE void_credit;

  --Bogus Credit
  PROCEDURE bogus_credit;

  --cron_fe_asso_grepOrderRMB
  PROCEDURE grep_order_rmb;


  --Approve Credit(RMB payment, method id = 13)
  PROCEDURE approve_credit_rmb_payment;
  
  --pending_credit_cleanUp
  PROCEDURE pending_credit_cleanUp;


END PKG_ASSO_CREDIT;
/


create or replace
PACKAGE BODY PKG_ASSO_CREDIT AS

--Prepare Short-Listed Order Number
  PROCEDURE link_order_proccess AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'link_order_proccess';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');
    
      /*truncate table(s)*/
      EXECUTE IMMEDIATE 'TRUNCATE TABLE ya_asso_link_orders_process';


      insert into ya_asso_link_orders_process (origin_order_Id)
      select distinct a.origin_order_id
      from
      (
      select o.origin_order_id, o.cmt
      from order_info o
      left join ya_associate_link_orders alo on o.origin_order_id = alo.origin_order_id
      inner join ya_associate_link al on o.sales_id = al.link_id
      inner join ya_associate asso on al.associate_id = asso.associate_id and asso.type_id <> 1-- exclude regular type associate
      where
         1=1
--         alo.origin_order_id is null
         and o.order_dt>to_date('11/09/2006', 'dd/mm/yyyy')
         and o.origin_order_id is not null
         and o.category in
         (
            1  --B2C relationship
            ,4  --eBay
         )
         and o.order_dt >= to_date('01/01/2008', 'dd/mm/yyyy')
      ) a ;

      COMMIT;
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');
    
      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;
          
  END link_order_proccess;


--Gather Product Commission By Revenue Account
  PROCEDURE insertProductCommissionByRev AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'insertProductCommissionByRev';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

      DELETE  ya_associate_prod_commission WHERE type=3;

-- ==============================================================
-- Step 1
-- Select the sku which are needed to be inserted into the ya_associate_product
-- (Revenue account_id is valid in the associate revenue commission)
-- ==============================================================
      INSERT INTO  ya_associate_prod_commission
      (
        sku,
        commission_type,
        commission_amount,
        type
      )
      SELECT DISTINCT
        tmp.sku,
        yarc.commission_type,
        yarc.commission,
        3 AS type
      FROM
        ya_associate_rev_commission yarc,
        (
          select yp1.sku, yp1.account_id from ya_product yp1
          LEFT OUTER JOIN  ya_associate_prod_commission yapc1 ON (yp1.sku = yapc1.sku)
          WHERE
            yapc1.sku IS NULL
        ) tmp
      WHERE
        yarc.account_id = tmp.account_id AND
        yarc.commission > 0;


-- ==============================================================
-- Step 2
-- Select the sku which are needed to be updated
-- ==============================================================
      INSERT INTO ya_associate_prod_commission
      (
        sku,
        commission_type,
        commission_amount,
        type
      )
      SELECT DISTINCT
        yp.sku,
        yarc.commission_type,
        yarc.commission,
        3 AS type
      FROM
        ya_associate_prod_commission yapc,
        ya_associate_rev_commission yarc,
        ya_product yp
      WHERE
        yp.sku = yapc.sku AND
        yp.account_id = yarc.account_id AND
        (
          yarc.commission <> yapc.commission_amount OR
          yarc.commission_type <> yapc.commission_type
        );

      COMMIT;
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');
    
      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;
    
  END insertProductCommissionByRev;


--Gather Product Commission By Attribute
  PROCEDURE insertProductCommissionByAttr

  AS

  BEGIN

-- ==============================================================
-- 1st part
-- Delete the sku which no record  in ya_prod_attr
-- ==============================================================

      DELETE ya_associate_prod_commission
      WHERE
        sku NOT IN
        (
          SELECT distinct
            ypa1.sku
          FROM
            ya_associate_attr_commission yaac1,
            ya_prod_attr ypa1
          WHERE
            yaac1.attribute_id = ypa1.attribute_id
        ) AND
        type = 2;


-- ==============================================================
-- 2nd part
-- Select the sku in the ya_associate_product_commision which are needed to be modified
-- ==============================================================
      INSERT INTO Temp_Associate_Prod_Commission
      (
        sku,
        commission_type,
        commission_amount,
        type
      )
      SELECT DISTINCT
        yapc.sku,
        yapc.commission_type,
        yaac.commission,
        2 AS type
      FROM
        ya_associate_prod_commission yapc,
        ya_prod_attr ypa,
        ya_associate_attr_commission yaac,
        (
          SELECT yapc.sku, MIN(yaac.priority) as minPriority
          FROM ya_associate_prod_commission yapc
            INNER join ya_prod_attr ypa ON yapc.sku = ypa.sku and yapc.type = 2
            INNER join ya_associate_attr_commission yaac ON (ypa.attribute_id = yaac.attribute_id)
          group by yapc.sku
        ) tmp
      WHERE
        yapc.type = 2
        and ypa.attribute_id = yaac.attribute_id
        and yaac.priority = tmp.minPriority
        and yaac.commission <> yapc.commission_amount
        and tmp.sku = yapc.sku
        and tmp.sku = ypa.sku;


-- ====================================================
-- 3rd part
-- Select the sku do not exist in ya_associate_product_commision
-- And then insert into temp table
-- ====================================================
      INSERT INTO Temp_Associate_Prod_Commission
      (
        sku,
        commission_type,
        commission_amount,
        type
      )
      SELECT DISTINCT
        tmp.sku,
        yaac.commission_type,
        yaac.commission,
        2 AS type
      FROM
        ya_associate_prod_commission yapc,
        ya_associate_attr_commission yaac,
        ya_prod_attr ypa,
        (
          SELECT
            ypa.sku, MIN(yaac.priority) as minPriority
          FROM
            ya_prod_attr ypa
          INNER JOIN ya_associate_attr_commission yaac ON (ypa.attribute_id = yaac.attribute_id)
          WHERE
            ypa.sku NOT IN (SELECT sku FROM ya_associate_prod_commission)
          group by ypa.sku
        ) tmp
      WHERE
        tmp.sku = ypa.sku
         and  ypa.attribute_id = yaac.attribute_id
        and yaac.priority = tmp.minPriority;

      INSERT INTO
        ya_associate_prod_commission
      SELECT
        sku,
        commission_type,
        commission_amount,
        type
      FROM Temp_Associate_Prod_Commission
          WHERE
            sku NOT IN (SELECT sku FROM ya_associate_prod_commission);

      COMMIT;

  END insertProductCommissionByAttr;


--Grep Credit Lines from Order
  PROCEDURE grepOrder
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);

  BEGIN

    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'grepOrder';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

--################################################################
--# 1st part
--# Handle PS3 and Wii sku:
--# 1004496821 Playstation 3 Console HDD 60GB (Japan Version)
--# 1004061184 Playstation 3 Console HDD 20GB (Japan Version)
--# 1004512384 Nintendo Wii Console (US Version)
--# 1004061187 Nintendo Wii Console (Japan Version)
--#################################################################

      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id,--// link_id
        (--//order_num
          CASE
            WHEN Isnumber(o.origin_order_id) = 1 THEN o.origin_order_id
            ELSE NULL
          END
        ),
        ol.id,--// row_id
        ol.prod_id,--//sku
        o.order_dt,--//order_date
        (-- credit_amount
          CASE
            WHEN apc.commission_type = 1 THEN (ol.qnty *apc.commission_amount)
            WHEN apc.commission_type = 2 THEN (ol.qnty * ol.unit_price * apc.commission_amount)
            ELSE NULL
          END
        ),
        1,-- credit_status
        sysdate,--// last_change_date
        ol.qnty,--// quantity
        ol.unit_price,--// unit_price
        o.origin_order_id--// origin_order_id
      FROM order_info o
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id AND bi.method <> 13)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_associate_prod_commission apc
          ON (apc.sku = ol.prod_id)
      WHERE 1=1
        --o.origin_order_id IN (1,7,10)
        AND o.sales_id > -1
        AND o.parent_id = -1;

--###############################
--# 2nd part
--# Normal SKU
--##############################
      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id,--// link_id
        (--//order_num
          CASE
            WHEN Isnumber(o.origin_order_id) = 1 THEN o.origin_order_id
            ELSE NULL
          END
        ),
        ol.id,--// row_id
        ol.prod_id,--//sku
        o.order_dt,--//order_date
        NULL,-- credit_amount
        1,-- credit_status
        sysdate,--// last_change_date
        ol.qnty,--// quantity
        ol.unit_price,--// unit_price
        o.origin_order_id--// origin_order_id
      FROM order_info o
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id AND bi.method <> 13)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_product p
          ON (p.sku = ol.prod_id)
        LEFT OUTER JOIN ya_associate_prod_commission apc
          ON (apc.sku = p.sku)
      WHERE 1=1
        --o.origin_id IN (1,7,10,11,12,13,14)
        AND o.sales_id > -1
        AND o.parent_id = -1
        AND apc.sku IS NULL
        AND ol.prod_id NOT IN
        (
          1001819827,1001819829,1001819831,1001819833,1001819834,1001819836-- Gift Cert
          ,1004076030,1004673975,1004673976-- asta subscription
        )
        AND
        (
          p.sku NOT IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon
            WHERE
              coupon_code IN
              (
                SELECT DISTINCT coupon_code
                FROM ya_associate_link_coupon
              )
          )
          OR
          p.sku IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon yc1
            WHERE
              coupon_code NOT IN
              (
                SELECT DISTINCT alc1. coupon_code
                FROM ya_associate_link_coupon alc1
                INNER JOIN ya_associate_link al1 ON (al1.link_id = alc1.associate_link_id)
                INNER JOIN ya_order fo1 ON ( fo1.coupon_code = alc1.coupon_code)
              )
          )
        )
        AND
        (
          (
            o.sales_id IN
            (
              SELECT link_id
              FROM ya_associate_link
              WHERE associate_id IN (6428, 8050, 3968, 6378, 3986, 4935)
            )
            OR
            (
              p.account_id NOT IN
              (
                SELECT g.account_id
                FROM ya_group g
                WHERE
                  division_id = 12
                  AND group_id IN (23,25)
              )
              AND p.sku NOT IN (1004178114,1004194529 )-- asta subscription
            )
          )
        );


--####################################################
--##  3rd part
--## 7 % Comm Rate of Electronics and Game Products
--####################################################

      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id,
        (
          CASE
            WHEN Isnumber(o.origin_order_id) = 1 THEN o.origin_order_id
            ELSE NULL
          END
        ),
        ol.id,
        ol.prod_id,
        o.order_dt,
        (ol.qnty * ol.unit_price * 0.07),-- credit_amount
        1,-- credit_status
        sysdate,
        ol.qnty,
        ol.unit_price,
        o.origin_order_id
      FROM order_info o
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id AND bi.method <> 13)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_product p
          ON (p.sku = ol.prod_id)
        LEFT OUTER JOIN ya_associate_prod_commission apc
          ON (apc.sku = p.sku)
      WHERE 1=1
        --o.origin_id IN (1,7,10,11,12,13,14)
        AND sales_id > -1
        AND o.parent_id = -1
        AND apc.sku IS NULL
        AND ol.prod_id NOT IN
        (
          1001819827,1001819829,1001819831,1001819833,1001819834,1001819836-- Gift Cert
         ,1004076030,1004673975,1004673976-- asta subscription
        )
        AND
        (
          p.sku NOT IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon
            WHERE
              coupon_code IN
              (
                SELECT DISTINCT coupon_code
                FROM ya_associate_link_coupon
              )
          )
          OR
          p.sku IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon yc1
            WHERE
              coupon_code NOT IN
              (
                SELECT DISTINCT alc1. coupon_code
                FROM ya_associate_link_coupon alc1
                INNER JOIN ya_associate_link al1 ON (al1.link_id = alc1.associate_link_id)
                INNER JOIN ya_order fo1 ON ( fo1.coupon_code = alc1.coupon_code)
              )
          )
        )
        AND o.sales_id IN
        (
          SELECT link_id FROM ya_associate_link WHERE associate_id NOT IN (6428, 8050, 3968, 6378, 3986, 4935)
        )
        AND
        (
          p.account_id IN
          (
            SELECT g.account_id FROM ya_group g WHERE division_id = 12 AND group_id IN (23,25)
          )
          OR p.sku IN (1004178114,1004194529)-- asta subscription
        );

      COMMIT;

    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END grepOrder;


--Get Credit Lines from Order related to Coupon(sku-1004059979)
  PROCEDURE update_associate_coupon
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);

  BEGIN

    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'update_associate_coupon';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

-- Set Exchange Rate

      SELECT exchange_rate INTO deciLexchange_rate
      FROM
        ya_exchange_rate er
      WHERE
        er.source_currency_id = 5
        AND er.currency_id = 3; --from USD to RMB

-- Associate have $5 Commission when any shopper use his coupon
-- Not need to handle RMB since it is a fix US$5
      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT DISTINCT
        o.sales_id,--//link_id
        o.origin_order_id,--//order_num
        ol.id,--//row_id
        ol.prod_id,--//sku
        o.order_dt,--//order_date
        (--//credit_amount
          CASE
            WHEN alc.commission_type = 1 THEN alc.commission_amount
            WHEN alc.commission_type = 2 THEN alc.commission_amount * ol.qnty * ol.unit_price
            WHEN alc.commission_type = 3 THEN NULL
          END
        ),
        1,--//credit_status(default: 1=Pending)
        sysdate,--// last_change_date
        ol.qnty,
        (--//unit_price
          CASE
            WHEN bi.method = 13 THEN ROUND( ol.unit_price / deciLexchange_rate, 2)
            ELSE ol.unit_price
          END
        ),
        o.origin_order_id--//origin_order_id
      FROM order_info o
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id)
        INNER JOIN ya_order fo
          ON (fo.order_num = o.origin_order_id)
        INNER JOIN ya_associate_link_coupon alc
          ON (alc.coupon_code = fo.coupon_code)
      WHERE
        o.sales_id > -1
        AND o.category = 1--B2C relationship
        AND o.parent_id = -1
        AND NOT EXISTS
        (
          SELECT *
          FROM ya_associate_link_orders a
          WHERE
            a.credit_amount = 5
            AND a.origin_order_id = o.origin_order_id
        )
        AND isNumber(o.origin_order_id) = 1
        AND
        (
          ol.prod_id IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon yc1
            WHERE
              coupon_code IN
                (
                  SELECT DISTINCT alc1. coupon_code
                  FROM ya_associate_link_coupon alc1
                )
          )
        );


-- Associate have 10% Commission when his shopper use others coupon or  not use coupon
      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id,--//link_id
        o.origin_order_id,--//order_num
        ol.id,--//row_id
        ol.prod_id,--//sku
        o.order_dt,--//order_date
        (--//credit_amount
          CASE
            WHEN bi.method = 13 THEN ROUND(link_percentage * ol.unit_price * ol.qnty / deciLexchange_rate, 2)
            ELSE link_percentage * ol.unit_price * ol.qnty
          END
        ),
        1,--//credit_status(default: 1=Pending)
        sysdate,
        ol.qnty,
        (--//unit_price
          CASE
            WHEN bi.method = 13 THEN ROUND(ol.unit_price / deciLexchange_rate, 2)
            ELSE ol.unit_price
          END
        ),
        o.origin_order_id--//origin_order_id
      FROM order_info o
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_Id = o.origin_order_id)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id)
        INNER JOIN ya_order fo
          ON (fo.order_num = o.origin_order_id)
      WHERE
        o.sales_id > -1
        AND o.category = 1--B2C relationship
        AND o.parent_id = -1
        AND NOT EXISTS
        (
          SELECT 1
          FROM ya_associate_link_orders a
          WHERE
            (a.credit_amount<> 5 OR credit_amount IS NULL)
            AND a.origin_Order_Id = o.origin_order_id
        )
        AND isNumber(o.origin_order_id) = 1
        AND
        (
          ol.prod_id IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon yc1
            WHERE
              coupon_code IN
                (
                  SELECT DISTINCT alc1. coupon_code
                  FROM ya_associate_link_coupon alc1
                  INNER JOIN ya_associate_link al1 ON (al1.link_id = alc1.associate_link_id)
                  INNER JOIN ya_order fo1 ON ( fo1.coupon_code = alc1.coupon_code)
                )
          )
        );

      COMMIT;

    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END update_associate_coupon;


  PROCEDURE approve_credit_01
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'approve_credit_01';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

      update ya_associate_link_orders alo
         set alo.credit_status=2, alo.last_change_date=sysdate
         where (link_id, origin_order_id, row_id) in
      (select alo.link_id, alo.origin_order_id, alo.row_id from order_info o
          inner join order_line ol on (o.id=ol.order_info_id)
          inner join order_line_dtl old on (ol.id = old.order_line_id)
          inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
          inner join ya_associate_link al on alo.link_id = al.link_id
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
            where old.sts = 6
             and alo.credit_status = 1
             and (a.shopper_id <> o.cust_id
             or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
             and a.associate_id <> 2779
             and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
       );

      COMMIT;
      
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END approve_credit_01;


  PROCEDURE approve_credit_02
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'approve_credit_02';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

/*
      insert into Temp_Approve_Credit02 
      select  ol.id, o.cust_id, alo.link_id, alo.origin_order_id, alo.row_id, 
              case
                when (alo.sku in (1004059979, 1004076030) and alo.credit_amount=5) then 5
                    else null
                end as credit_amount,
              ol.qnty, ol.unit_price from order_info o
          inner join order_line ol on (o.id=ol.order_info_id)
          inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
          inner join billing_info bi on (bi.order_info_id = o.id and bi.method <> 13)
          inner join ya_associate_link al on 1=1
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
      where alo.credit_status = 1
        and (a.shopper_id <> o.cust_id
        or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
        and a.associate_id <> 2779
        and alo.link_id = al.link_id
        and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
        and exists(select 1 from order_line ol2 where ol.id=ol2.parent_line_id and ol.id=ol2.id);

        
      update ya_associate_link_orders alo set (credit_status, last_change_date, credit_amount, quantity, unit_price)=
      (select 2, sysdate, tmp.credit_amount, tmp.qnty, tmp.unit_price from Temp_Approve_Credit02 tmp
      where (alo.link_id = tmp.link_id and alo.origin_order_id = tmp.origin_order_id and alo.row_id = tmp.row_id)
        and exists (select 1 from order_line ol2 inner join order_line_dtl old2 on ol2.id = old2.order_line_id where ol2.parent_line_id = tmp.id and old2.sts = 6 and ol2.parent_line_id <> ol2.id)
      ) where exists
      (select 1 from Temp_Approve_Credit02 tmp
      where (alo.link_id = tmp.link_id and alo.origin_order_id = tmp.origin_order_id and alo.row_id = tmp.row_id)
        and exists (select 1 from order_line ol2 inner join order_line_dtl old2 on ol2.id = old2.order_line_id where ol2.parent_line_id = tmp.id and old2.sts = 6 and ol2.parent_line_id <> ol2.id)
      );
*/
      insert into temp_approve_credit02 
      select  ol.id, o.cust_id, alo.link_id, alo.origin_order_id, alo.row_id, 
              case
                when (alo.sku in (1004059979, 1004076030) and alo.credit_amount=5) then 5
                    else null
                end as credit_amount,
              ol.qnty, ol.unit_price from order_info o
          inner join order_line ol on (o.id=ol.order_info_id)
          inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
          inner join billing_info bi on (bi.order_info_id = o.id and bi.method <> 13)
          inner join ya_associate_link al on 1=1
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
      --where alo.credit_status = 1
      where (CASE WHEN (alo.credit_status=1) THEN 'Y' ELSE NULL END) = 'Y'
        and (a.shopper_id <> o.cust_id
        or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
        and a.associate_id <> 2779
        and alo.link_id = al.link_id
        and o.cust_id <> 'm7ga5htkwset9lvqn9a9bbxuad4q4qu9'
        and exists(select 1 from order_line ol2 inner join order_line_dtl old2 on ol2.id = old2.order_line_id where ol.id=ol2.parent_line_id and ol.id=ol2.id and old2.sts = 6 and ol2.parent_line_id <> ol2.id);

      update ya_associate_link_orders alo set (credit_status, last_change_date, credit_amount, quantity, unit_price)=
      (select 2, sysdate, tmp.credit_amount, tmp.qnty, tmp.unit_price from temp_approve_credit02 tmp
      where (alo.link_id = tmp.link_id and alo.origin_order_id = tmp.origin_order_id and alo.row_id = tmp.row_id)
      ) where exists
      (select 1 from temp_approve_credit02 tmp
      where (alo.link_id = tmp.link_id and alo.origin_order_id = tmp.origin_order_id and alo.row_id = tmp.row_id)        
      );
      
      COMMIT;



/* check normal product line */
/*
      update ya_associate_link_orders alo
         set (credit_status, last_change_date, credit_amount, quantity, unit_price)=
      (select 2, sysdate,
              case
                when (alo.sku in (1004059979, 1004076030) and alo.credit_amount=5) then 5
                    else null
                end,
              ol.qnty, ol.unit_price from order_info o
          inner join order_line ol on (o.id=ol.order_info_id)
--          inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
          inner join ya_associate_link al on 1=1 --alo.link_id = al.link_id
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
          inner join order_line_dtl ld on (ol.id = ld.order_line_id and ld.sts = 6)
      where 1=1
        and alo.credit_status = 1
        and (a.shopper_id <> o.cust_id
        or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
        and a.associate_id <> 2779
        and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
        and ol.parent_line_id  = -1
        and alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id
        and alo.link_id = al.link_id
      ) WHERE EXISTS
      (SELECT distinct 1 from order_info o
          inner join order_line ol on (o.id=ol.order_info_id)
--          inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
          inner join ya_associate_link al on 1=1 --alo.link_id = al.link_id
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
          inner join order_line_dtl ld on (ol.id = ld.order_line_id and ld.sts = 6)
      where 1=1
        and alo.credit_status = 1
        and (a.shopper_id <> o.cust_id
        or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
        and a.associate_id <> 2779
        and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
        and ol.parent_line_id  = -1
        and alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id
        and alo.link_id = al.link_id
      );
*/
      insert into Temp_Order_Line_Dtl_Getsts
          select distinct ld.order_line_id, o.cust_id, 
          case
                when (alo.sku in (1004059979, 1004076030) and alo.credit_amount=5) then 5
                    else null
                end as credit_amount, 
          alo.quantity, alo.unit_price,
          alo.link_id, alo.origin_order_id, alo.row_id from order_info o
          inner join order_line ol on (o.id=ol.order_info_id)
          inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
          inner join order_line_dtl ld on (ol.id = ld.order_line_id and ld.sts = 6)
      where 1=1
        and alo.credit_status=1
        and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
        and ol.parent_line_id  = -1;

        
       delete temp_order_line_dtl_getsts t
       where exists
       (select 1
          from order_line_dtl ld
         where t.order_line_id = ld.order_line_id
               and ld.sts not in (6,8,9));
        
        
        
      update ya_associate_link_orders alo
         set (credit_status, last_change_date, credit_amount, quantity, unit_price)=
      (select 2, sysdate, tldg.credit_amount, tldg.qnty, tldg.unit_price
              from temp_order_line_dtl_getsts tldg
          inner join ya_associate_link al on tldg.link_id = al.link_id
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
      where 1=1
        and (a.shopper_id <> tldg.cust_id
        or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
        and a.associate_id <> 2779
        and (alo.link_id=tldg.link_id and alo.origin_order_id=tldg.origin_order_id and alo.row_id=tldg.row_id)
      ) where exists
      (select 1 from temp_order_line_dtl_getsts tldg
          inner join ya_associate_link al on tldg.link_id = al.link_id
          inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1
      where 1=1
        and (a.shopper_id <> tldg.cust_id
        or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
        and a.associate_id <> 2779
        and (alo.link_id=tldg.link_id and alo.origin_order_id=tldg.origin_order_id and alo.row_id=tldg.row_id)
      );

      COMMIT;
      
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END approve_credit_02;


  PROCEDURE void_credit
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'void_credit';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

      update ya_associate_link_orders
         set credit_status=4, last_change_date = sysdate
         where (link_id, origin_order_id, row_id) in
      (select alo.link_id, alo.origin_order_id, alo.row_id from order_info o
            inner join order_line ol on (o.id = ol.order_info_id)
            inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_Id)
            inner join ya_associate_link al on alo.link_id = al.link_id
            inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1 -- exclude b2c associate (regular)
       where alo.credit_status = 1
        and (a.associate_id = 2779
          or (a.shopper_id = o.cust_id and a.associate_id not in (7176, 7312, 5672, 6638, 8673, 8491) )
          or o.cust_id = 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9')
      );

      COMMIT;
      
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END void_credit;


  PROCEDURE bogus_credit
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'bogus_credit';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

      update ya_associate_link_orders alo
           set credit_status = 3, last_change_date = sysdate
      where alo.credit_status = 1
       and exists
      (select 1 from order_line ol, order_info o, order_line_dtl old
       where o.origin_order_id = alo.origin_order_id
        and ol.prod_id = alo.sku
        and o.id = ol.order_info_id
        and ol.id = old.order_line_id
        and old.sts in (8,9)
      );

      COMMIT;
      
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END bogus_credit;



  PROCEDURE grep_order_rmb
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'grep_order_rmb';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

      SELECT exchange_rate INTO deciLexchange_rate
      FROM
        ya_exchange_rate er
      WHERE
        er.source_currency_id = 5
        AND er.currency_id = 3;    --from USD to RMB


--################################################################
-- 1st part
-- Handle PS3 and Wii sku:
--1004496821 Playstation 3 Console HDD 60GB (Japan Version)
--1004061184 Playstation 3 Console HDD 20GB (Japan Version)
--1004512384 Nintendo Wii Console (US Version)
--1004061187 Nintendo Wii Console (Japan Version)
--#################################################################

      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id, --// link_id
        (--//order_num
          CASE
            WHEN isNumber(o.origin_order_id) = 1 THEN o.origin_order_id
            ELSE NULL
          END
        ),
        ol.id, --// row_id
        ol.prod_id, --//sku
        o.order_dt, --//order_date
        (-- credit_amount
          CASE
            WHEN apc.commission_type = 1 THEN (ol.qnty *apc.commission_amount)
            WHEN apc.commission_type = 2 THEN (ol.qnty * ROUND(ol.unit_price / deciLexchange_rate, 2) * apc.commission_amount)
            ELSE NULL
          END
        ),
        1, -- credit_status
        sysdate, --// last_change_date
        ol.qnty, --// quantity
        ol.unit_price, --// unit_price
        o.origin_order_id --// origin_order_id
      FROM order_info o
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id AND bi.method = 13)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_associate_prod_commission apc
          ON (apc.sku = ol.prod_id)
      WHERE 1=1
        --o.origin_id IN (1,7,10)
        AND o.sales_id > -1
        AND o.parent_id = -1;

--##################################
-- 2nd part
-- Normal Order
--##################################
      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id,
        (
          CASE
            WHEN isNumber(o.origin_order_id) = 1 THEN o.origin_order_id
            ELSE NULL
          END
        ),
        ol.id,
        ol.prod_id,
        o.order_dt,
        NULL, -- credit_amount
        1, -- credit_status
        sysdate,
        ol.qnty,
        ROUND(ol.unit_price / deciLexchange_rate, 2),
        o.origin_order_id
      FROM order_info o
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id AND bi.method = 13)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_product p
          ON (p.sku = ol.prod_id)
        LEFT OUTER JOIN ya_associate_prod_commission apc
          ON (apc.sku = p.sku)
      WHERE 1=1
        --o.origin_id IN (1,7,10,11)
        AND o.sales_id > -1
        AND o.parent_id = -1
        AND apc.sku IS NULL
        AND ol.prod_id NOT IN
        (
          1001819827,1001819829,1001819831,1001819833,1001819834,1001819836 -- Gift Cert
          ,1004076030,1004673975,1004673976 -- asta subscription
        )
        AND
        (
          p.sku NOT IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon
            WHERE
              coupon_code IN
              (
                SELECT DISTINCT coupon_code
                FROM ya_associate_link_coupon
              )
          )
          OR
          p.sku IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon yc1
            WHERE
              coupon_code NOT IN
              (
                SELECT DISTINCT alc1. coupon_code
                FROM ya_associate_link_coupon alc1
                INNER JOIN ya_associate_link al1 ON (al1.link_id = alc1.associate_link_id)
                INNER JOIN ya_order fo1 ON ( fo1.coupon_code = alc1.coupon_code)
              )
          )
        )
        AND
        (
          (
            o.sales_id IN
            (
              SELECT link_id
              FROM ya_associate_link
              WHERE associate_id IN (6428, 8050, 3968, 6378, 3986, 4935)
            )
            OR
            (
              p.account_id NOT IN
              (
                SELECT g.account_id
                FROM ya_group g
                WHERE
                  division_id = 12
                  AND group_id IN (23,25)
              )
              AND p.sku NOT IN (1004178114,1004194529 ) -- asta subscription
            )
          )
        );


--#################################################
-- 3rd part
-- 7 % Comm Rate of Electronics and Game Products
--#################################################
      INSERT INTO ya_associate_link_orders
      (
        link_id,
        order_num,
        row_id,
        sku,
        order_date,
        credit_amount,
        credit_status,
        last_change_date,
        quantity,
        unit_price,
        origin_order_id
      )
      SELECT
        o.sales_id,
        (
          CASE
            WHEN isNumber(o.origin_order_id) = 1 THEN o.origin_order_id
            ELSE NULL
          END
        ),
        ol.id,
        ol.prod_id,
        o.order_dt,
        (ol.qnty * ROUND(ol.unit_price / deciLexchange_rate, 2) * 0.07), -- credit_amount
        1, -- credit_status
        sysdate,
        ol.qnty,
        ROUND(ol.unit_price / deciLexchange_rate, 2),
        o.origin_order_id
      FROM order_info o
        INNER JOIN ya_associate_link al
          ON (al.link_id = o.sales_id)
        INNER JOIN ya_asso_link_orders_process alop
          ON (alop.origin_order_id = o.origin_order_id)
        INNER JOIN billing_info bi
          ON (bi.order_info_id = o.id AND bi.method = 13)
        INNER JOIN order_line ol
          ON (o.id = ol.order_info_id)
        INNER JOIN ya_product p
          ON (p.sku = ol.prod_id)
        LEFT OUTER JOIN ya_associate_prod_commission apc
          ON (apc.sku = p.sku)
      WHERE 1=1
        --o.origin_id IN (1,7,10,11)
        AND o.sales_id > -1
        AND o.parent_id = -1
        AND apc.sku IS NULL
        AND ol.prod_id NOT IN
        (
          1001819827,1001819829,1001819831,1001819833,1001819834,1001819836 -- Gift Cert
          ,1004076030,1004673975,1004673976 -- asta subscription
        )
        AND
        (
          p.sku NOT IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon
            WHERE
              coupon_code IN
              (
                SELECT DISTINCT coupon_code
                FROM ya_associate_link_coupon
              )
          )
          OR
          p.sku IN
          (
            SELECT DISTINCT item_sku_trigger
            FROM ya_coupon yc1
            WHERE
              coupon_code NOT IN
              (
                SELECT DISTINCT alc1. coupon_code
                FROM ya_associate_link_coupon alc1
                INNER JOIN ya_associate_link al1 ON (al1.link_id = alc1.associate_link_id)
                INNER JOIN ya_order fo1 ON ( fo1.coupon_code = alc1.coupon_code)
              )
          )
        )
        AND o.sales_id IN
        (
          SELECT link_id FROM ya_associate_link WHERE associate_id NOT IN (6428, 8050, 3968, 6378, 3986, 4935)
        )
        AND
        (
          p.account_id IN
          (
            SELECT g.account_id FROM ya_group g WHERE division_id = 12 AND group_id IN (23,25)
          )
          OR p.sku IN (1004178114,1004194529) -- asta subscription
        );

    COMMIT;
    
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

  END grep_order_rmb;


  PROCEDURE approve_credit_rmb_payment
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'approve_credit_rmb_payment';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

-- Set Exchange Rate

      SELECT exchange_rate INTO deciLexchange_rate
      FROM
        ya_exchange_rate er
      WHERE
        er.source_currency_id = 5
        AND er.currency_id = 3;


      update ya_associate_link_orders alo
         set (credit_status, last_change_date, credit_amount, quantity, unit_price) =
         (select 2, sysdate, case
                                when alo.sku in (1004059979,1004076030) and alo.credit_amount=5 then 5
                                    else null
                             end,
                 ol.qnty, round(ol.unit_price / deciLexchange_rate, 2)
        from order_info o
            inner join order_line ol on (o.id = ol.order_info_id)
--            inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
            inner join ya_associate_link al on 1=1
            inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1 -- exclude b2c associate (regular)
            inner join billing_info bi on (bi.order_info_id = o.id and bi.method = 13)
       where alo.credit_status = 1
         and (a.shopper_id <> o.cust_id
         or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
         and a.associate_id <> 2779
         and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
         and ol.parent_line_id = ol.id
         and alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id
         and alo.link_id = al.link_id
         and exists (select 1 from order_line ol2 inner join order_line_dtl ld2 on ol2.id = ld2.order_line_id where ol2.parent_line_id = ol.id and ld2.sts = 6 and ol2.parent_line_id <> ol2.id) -- check if the parent poccesses children fullfilled
      ) WHERE EXISTS
      (SELECT 1 from order_info o
            inner join order_line ol on (o.id = ol.order_info_id)
--            inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
            inner join ya_associate_link al on 1=1
            inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1 -- exclude b2c associate (regular)
            inner join billing_info bi on (bi.order_info_id = o.id and bi.method = 13)
       where alo.credit_status = 1
         and (a.shopper_id <> o.cust_id
         or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
         and a.associate_id <> 2779
         and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
         and ol.parent_line_id = ol.id
         and alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id
         and alo.link_id = al.link_id
         and exists (select 1 from order_line ol2 inner join order_line_dtl ld2 on ol2.id = ld2.order_line_id where ol2.parent_line_id = ol.id and ld2.sts = 6 and ol2.parent_line_id <> ol2.id) -- check if the parent poccesses children fullfilled
      );


      /* check normal product line */
      update ya_associate_link_orders alo
         set (credit_status, last_change_date, credit_amount, quantity, unit_price) =
         (select 2, sysdate, case
                                when alo.sku in (1004059979,1004076030) and alo.credit_amount=5 then 5
                                    else null
                             end,
               ol.qnty, round(ol.unit_price / deciLexchange_rate, 2)
        from order_info o
            inner join order_line ol on (o.id = ol.order_info_id)
--            inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
            inner join ya_associate_link al on 1=1
            inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1 -- exclude b2c associate (regular)
            inner join order_line_dtl ld on (ol.id = ld.order_line_id and ld.sts = 6)
            inner join billing_info bi on (bi.order_info_id = o.id and bi.method = 13)
       where alo.credit_status = 1
         and (a.shopper_id <> o.cust_id
         or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
         and a.associate_id <> 2779
         and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
         and ol.parent_line_id  = -1 -- normal order
         and alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id
         and alo.link_id = al.link_id
       ) WHERE EXISTS
       (select 2, sysdate, case
                                when alo.sku in (1004059979,1004076030) and alo.credit_amount=5 then 5
                                    else null
                             end,
               ol.qnty, round(ol.unit_price / deciLexchange_rate, 2)
        from order_info o
            inner join order_line ol on (o.id = ol.order_info_id)
--            inner join ya_associate_link_orders alo on (alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id)
            inner join ya_associate_link al on 1=1
            inner join ya_associate a on al.associate_id = a.associate_id and a.type_id <> 1 -- exclude b2c associate (regular)
            inner join order_line_dtl ld on (ol.id = ld.order_line_id and ld.sts = 6)
            inner join billing_info bi on (bi.order_info_id = o.id and bi.method = 13)
       where alo.credit_status = 1
         and (a.shopper_id <> o.cust_id
         or a.associate_id in (7176, 7312, 5672, 6638, 8673, 8491))
         and a.associate_id <> 2779
         and o.cust_id <> 'M7GA5HTKWSET9LVQN9A9BBXUAD4Q4QU9'
         and ol.parent_line_id  = -1 -- normal order
         and alo.origin_order_id = o.origin_order_id and alo.sku = ol.prod_id
         and alo.link_id = al.link_id
       );

    COMMIT;
    
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

      EXCEPTION WHEN OTHERS THEN
      BEGIN
         cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
         RAISE;
      END;

      EXECUTE IMMEDIATE 'TRUNCATE TABLE ya_asso_link_orders_process';

  END approve_credit_rmb_payment;


  PROCEDURE pending_credit_cleanUp
  AS
    iLjob_id NUMBER;
    iLPackage VARCHAR2(100);
    iLProcedure VARCHAR2(100);
  BEGIN
  
    /*START package*/
    SELECT seq_dm_procedure_log.nextval INTO iLjob_id FROM dual;
    iLPackage := 'pkg_asso_credit';
    iLProcedure := 'pending_credit_cleanUp';
    cron_dm_procedure_log ('Insert', iLjob_id, iLPackage, iLProcedure, 'N');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE Temp_PendingItems';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE Temp_BundleChild';

    insert into Temp_PendingItems(linkid, feorderid, row_id, sku, orderdate, creditAmt, creditStatus)
    select link_id, origin_order_id, row_id, sku, order_date, credit_amount, credit_status
    from   ya_associate_link_orders
    where  credit_status = 1 and order_date < add_months (sysdate, -1);

   /****************************************************************/
   -- find the beOrderid and order status
   /***************************************************************/
    update Temp_PendingItems TP
    set    TP.beOrderid = (select id from order_info oi where oi.origin_order_id = TP.feorderid);

   /****************************************************************/
   -- find the orderlineid and item's status
   /****************************************************************/
   -- Problem here, asking alice...
    update  Temp_PendingItems TP
    set     (itemStatus, orderlineid) =
	    (select min(old.sts), min(old.order_line_id)
	     from   order_line_dtl old, order_line ol
	     where  old.order_line_id = ol.id
	     and    ol.order_info_id = tp.beorderid
	     and    ol.prod_id = tp.sku);
--	     group by old.order_line_id);

   /****************************************************************/
   -- remove items which are not bundle parent /  fulfilled / bogus / cancelled
   /****************************************************************/
    delete from Temp_PendingItems where itemStatus not in (-1, 6, 8, 9);

   /****************************************************************/
   -- handle bundles
   /****************************************************************/
    insert into Temp_BundleChild
    select b.beOrderid, b.sku, old.id, old.sts
    from   order_line_dtl old, order_line ol,
           (select beOrderid, sku, itemStatus from Temp_PendingItems where itemStatus = -1) b
    where old.order_line_id = ol.id
    and   old.sts <> -1
    and   ol.order_info_id = b.beorderid
    and   ol.parent_id = b.sku;

   /****************************************************************/
   -- update parent's status using child with smallest status
   /****************************************************************/
    update	Temp_PendingItems TP
    set     TP.itemStatus = (
      select  t.status
      from (select beorderid, parentSku, min(status) status from Temp_BundleChild group by beorderid, parentSku) t
      where tp.beorderid = t.beorderid
      and   tp.sku = t.parentSku)
    WHERE EXISTS
           (SELECT 1
            FROM (select beorderid, parentSku, min(status) status from Temp_BundleChild group by beorderid, parentSku) t
            where tp.beorderid = t.beorderid
            and   tp.sku = t.parentSku);

   /****************************************************************/
   -- final result
   /****************************************************************/
    update ya_associate_link_orders alo
    set    (credit_status, last_change_date) = (
      select (case when itemStatus = 6 then 2
				 when itemStatus in (8, 9) then 3 end), sysdate
      from   Temp_PendingItems tp
      where  tp.itemStatus in (6, 8, 9)
      and    alo.link_id = tp.linkid
	  and    alo.origin_order_id = tp.feorderid
	  and    alo.row_id = tp.row_id
	  and    alo.sku = tp.sku
	  and    alo.credit_status = 1
	)
	WHERE EXISTS (
      select 1
      from   Temp_PendingItems tp
      where  tp.itemStatus in (6, 8, 9)
      and    alo.link_id = tp.linkid
	  and    alo.origin_order_id = tp.feorderid
	  and    alo.row_id = tp.row_id
	  and    alo.sku = tp.sku
	  and    alo.credit_status = 1);

   /****************************************************************/
   -- commit
   /****************************************************************/
    COMMIT;
    
    /*END package*/
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'Y');

  EXCEPTION WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    cron_dm_procedure_log ('Update', iLjob_id, iLPackage, iLProcedure, 'N');
    RAISE;
  END;

  END pending_credit_cleanUp;


END PKG_ASSO_CREDIT;
/