create or replace PACKAGE Pkg_fe_MyAcc_OrderAccess AS
TYPE cur_return IS REF CURSOR;

PROCEDURE GetOrder
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return,
  curPout5 OUT cur_return,
  iPtotalShipment out int
);

PROCEDURE GetOrderByShopperId
(
  cPshopperId IN nvarchar2,
  iPpageNumber IN INT,
  iPpageSize IN INT,
  curPout1 OUT cur_return
);

PROCEDURE GetOrderCountByShopperId
(
  cPshopperId IN nvarchar2,
  iPtotalOrder OUT INT
);

PROCEDURE GetOrderHistory
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return,
  curPout5 OUT cur_return
);

PROCEDURE GetNeighborOrderNumber
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPorderNumberPrev OUT INT,
  iPorderNumberNext OUT INT
);

PROCEDURE GetBackendOrderId
(
  iPorderNumber IN INT,
  oPorderInfoId OUT INT
);

PROCEDURE AddOrderChange
(
  iPorderNumber IN INT,
  iPactionId IN INT,
  iPorderChangeId OUT INT
);

PROCEDURE AddOrderChangeLine
(
  iPorderChangeId IN INT,
  iPactionId IN INT,
  iPorderChangeLineId OUT INT
);

PROCEDURE AddOrderChangeLineContent
(
  iPorderChangeLineId IN INT,
  cPkey IN NVARCHAR2,
  cPcontent IN NCLOB
);

PROCEDURE GetPendingOrder
(
  cPshopperId IN nvarchar2,
  curPout OUT cur_return
);

END Pkg_fe_MyAcc_OrderAccess;
/



create or replace PACKAGE BODY Pkg_fe_MyAcc_OrderAccess AS

PROCEDURE GetOrder
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return,
  curPout5 OUT cur_return,
  iPtotalShipment out int
)
IS
  cLoriginOrderId nvarchar2(32);
  iLorderInfoId int;
  iLshipmentunitconst int;
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  select id into iLorderInfoId from order_info where cust_id = cPshopperId and origin_order_id = cLoriginOrderId;
  iLshipmentunitconst := 200;

  OPEN curPout1 FOR
  SELECT oi.*
  FROM ORDER_INFO oi
  where oi.cust_id = cPshopperId and oi.id = iLorderInfoId;

  OPEN curPout2 FOR
  SELECT si.*, lu.meaning
  FROM SHIPPING_INFO si INNER JOIN LOOKUP lu ON si.country = lu.code AND lu.lang_type = iPlangId AND lu.category = 'country' where si.order_info_id = iLorderInfoId;
  
  OPEN curPout3 FOR
  SELECT bi.*, lu.meaning
  FROM BILLING_INFO bi LEFT OUTER JOIN LOOKUP lu ON bi.country = lu.code AND lu.lang_type = iPlangId AND lu.category = 'country' where bi.order_info_id = iLorderInfoId;

  OPEN curPout4 FOR
  SELECT 
    ol.id as order_line_id, ol.prod_id as sku, p.account_id as account_id, pl.prod_name_u as product_name, old.qnty as quantity, ol.unit_price as unit_price, old.sts as status, 
    CAST(
      CASE 
        WHEN su.shipment_unit IS NOT NULL THEN su.shipment_unit
        ELSE CEIL(NVL(
          CASE 
            WHEN dimension_weight IS NOT NULL AND weight IS NOT NULL THEN
              CASE 
                WHEN dimension_weight > weight THEN dimension_weight
                ELSE weight
              END
            ELSE weight
          END, iLshipmentunitconst) / iLshipmentunitconst)
        END AS INT
    ) as shipment_unit, 
    ol.promotion_id as promotion_id, ol.original_unit_price as original_unit_price, pa.avlb as avlb, ol.parent_id, ol.misc_info
  FROM (select * from order_info where cust_id = cPshopperId and id = iLorderInfoId) oi
  inner join order_line ol on oi.id = ol.order_info_id
  inner join order_line_dtl old on ol.id = old.order_line_id
  inner join prod_avlb pa on ol.prod_id = pa.prod_id and pa.region_id = oi.origin_id
  inner join ya_product p on pa.prod_id = p.sku
  inner join (select * from ya_prod_lang where lang_id = iPlangId) pl on p.sku = pl.sku
  inner join ya_prod_lang pe on p.sku = pe.sku and pe.lang_id = 1
  left outer join ya_shipping_unit su on su.site_id = oi.origin_id and p.sku = su.sku;
  
  OPEN curPout5 FOR
  SELECT ogm.*
  FROM ORDER_GREETING_MSG ogm WHERE ogm.order_info_id = iLorderInfoId AND MSG_TYPE = 2;
  
  select count(1) into iPtotalShipment 
  FROM SHIPMENT s where s.order_info_id = iLorderInfoId;
END GetOrder;

PROCEDURE GetOrderByShopperId
(
  cPshopperId IN nvarchar2,
  iPpageNumber IN INT,
  iPpageSize IN INT,
  curPout1 OUT cur_return
)
IS
  iLstartRowNumber INT;
  iLendRowNumber INT;
BEGIN
  iLendRowNumber := iPpageNumber*iPpageSize;
  iLstartRowNumber := iLendRowNumber-iPpageSize+1;
  
  OPEN curPout1 FOR
  select oi1.*, nvl(rma.total_rma,0) as total_rma from
  (select * from 
  (SELECT *
  FROM ORDER_INFO oi
  WHERE oi.cust_id = cPshopperId AND oi.origin_id in (1,7)
  ORDER BY oi.ID DESC) oi
  WHERE rownum <= iLendRowNumber) oi1
  left outer join 
  (select * from 
  (SELECT *
  FROM ORDER_INFO oi
  WHERE oi.cust_id = cPshopperId AND oi.origin_id in (1,7)
  ORDER BY oi.ID DESC) oi
  WHERE rownum < iLstartRowNumber) oi2
  on oi1.id=oi2.id
  left outer join (select order_info_id as order_num, count(1) as total_rma from rma group by order_info_id) rma
  on oi1.origin_order_id = rma.order_num
  where oi2.id is null and oi1.parent_id < 0
  ORDER BY oi1.ID DESC;
END GetOrderByShopperId;

PROCEDURE GetOrderCountByShopperId
(
  cPshopperId IN nvarchar2,
  iPtotalOrder OUT INT
)
IS
BEGIN
  SELECT COUNT(1) INTO iPtotalOrder FROM ORDER_INFO oi WHERE oi.cust_id = cPshopperId AND oi.origin_id in (1,7);
END;

PROCEDURE GetOrderHistory
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return,
  curPout5 OUT cur_return
)
IS
  cLoriginOrderId nvarchar2(32);
BEGIN
  select to_char(iPorderNumber) into cLoriginOrderId from dual;

  OPEN curPout1 FOR
  select oc.* from order_info oi 
  inner join ya_order_chg oc on oi.origin_order_id = cLoriginOrderId 
  where oc.order_number = iPorderNumber and cust_id = cPshopperId;

  OPEN curPout2 FOR
  select oc.id as change_id, oca.* from order_info oi 
  inner join ya_order_chg oc on oi.origin_order_id = cLoriginOrderId 
  inner join ya_order_chg_act oca on oc.action_id = oca.id 
  where oc.order_number = iPorderNumber and cust_id = cPshopperId;
  
  OPEN curPout3 FOR
  select oc.id as change_id, ocl.* from order_info oi 
  inner join ya_order_chg oc on oi.origin_order_id = cLoriginOrderId 
  inner join ya_order_chg_ln ocl on oc.id = ocl.order_change_id 
  where oc.order_number = iPorderNumber and cust_id = cPshopperId;
  
  OPEN curPout4 FOR
  select oc.id as change_id, ocl.id as change_line_id, ocla.* from order_info oi 
  inner join ya_order_chg oc on oi.origin_order_id = cLoriginOrderId 
  inner join ya_order_chg_ln ocl on oc.id = ocl.order_change_id 
  inner join ya_order_chg_ln_act ocla on ocl.action_id = ocla.id 
  where oc.order_number = iPorderNumber and cust_id = cPshopperId;
  
  OPEN curPout5 FOR
  select oc.id as change_id, ocl.id as change_line_id, oclc.* from order_info oi 
  inner join ya_order_chg oc on oi.origin_order_id = cLoriginOrderId 
  inner join ya_order_chg_ln ocl on oc.id = ocl.order_change_id 
  inner join ya_order_chg_ln_content oclc on ocl.id = oclc.order_chg_ln_id
  where oc.order_number = iPorderNumber and cust_id = cPshopperId;
END GetOrderHistory;

PROCEDURE GetNeighborOrderNumber
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPorderNumberPrev OUT INT,
  iPorderNumberNext OUT INT
)
IS 
  iLcount INT;
  cLoriginOrderId nvarchar2(32);
  iLorderInfoId INT;
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  select id into iLorderInfoId from order_info where origin_order_id = cLoriginOrderId;
  
  select count(1) into iLcount from order_info where cust_id = cPshopperId and id < iLorderInfoId and parent_id < 0;
  if (iLcount>0) then
    select to_number(origin_order_id) into iPorderNumberPrev 
    from (select origin_order_id from order_info where cust_id = cPshopperId and id < iLorderInfoId and parent_id < 0 order by id desc)
    where rownum = 1;
  else
    iPorderNumberPrev := -1;
  end if;

  select count(1) into iLcount from order_info where cust_id = cPshopperId and id > iLorderInfoId and parent_id < 0;
  if (iLcount>0) then
    select to_number(origin_order_id) into iPorderNumberNext 
    from (select origin_order_id from order_info where cust_id = cPshopperId and id > iLorderInfoId and parent_id < 0 order by id)
    where rownum = 1;
  else
    iPorderNumberNext := -1;
  end if;
END GetNeighborOrderNumber;

PROCEDURE GetBackendOrderId
(
  iPorderNumber IN INT,
  oPorderInfoId OUT INT
)
IS
  iLcount INT;  
BEGIN

  oPorderInfoId := -1;  
  SELECT count(1) INTO iLcount FROM order_info WHERE origin_order_id = to_char(iPorderNumber);
  
  IF (iLcount > 0) THEN
    SELECT id INTO oPorderInfoId FROM order_info WHERE origin_order_id = to_char(iPorderNumber);
  END IF;
  
END GetBackendOrderId;

PROCEDURE AddOrderChange
(
  iPorderNumber IN INT,
  iPactionId IN INT,
  iPorderChangeId OUT INT
)
IS
BEGIN
  select SEQ_YA_ORDER_CHG.nextval into iPorderChangeId from dual;
  insert into ya_order_chg(id, order_number, action_id, change_date) 
  values(iPorderChangeId, iPorderNumber, iPactionId, sysdate);
END AddOrderChange;

PROCEDURE AddOrderChangeLine
(
  iPorderChangeId IN INT,
  iPactionId IN INT,
  iPorderChangeLineId OUT INT
)
IS
BEGIN
  select SEQ_YA_ORDER_CHG_LN.nextval into iPorderChangeLineId from dual;
  insert into ya_order_chg_ln(id, order_change_id, action_id) 
  values(iPorderChangeLineId, iPorderChangeId, iPactionId);
END AddOrderChangeLine;

PROCEDURE AddOrderChangeLineContent
(
  iPorderChangeLineId IN INT,
  cPkey IN NVARCHAR2,
  cPcontent IN NCLOB
)
IS
BEGIN
  insert into ya_order_chg_ln_content(order_chg_ln_id, key, content) 
  values(iPorderChangeLineId, cPkey, cPcontent);
END AddOrderChangeLineContent;

PROCEDURE GetPendingOrder
(
  cPshopperId IN nvarchar2,
  curPout OUT cur_return
)
IS
BEGIN
  OPEN curPout FOR
  SELECT yo.order_num 
  FROM ya_order yo
    LEFT OUTER JOIN order_info oi ON TO_CHAR(order_num) = origin_order_id AND oi.cust_id = cPshopperId 
  WHERE 1=0 and yo.shopper_id = cPshopperId 
    AND oi.origin_id IS NULL;

    
END GetPendingOrder;

END Pkg_fe_MyAcc_OrderAccess;
/