CREATE OR REPLACE FORCE VIEW SS_ADM.VIEWASSOLINKORDERLANG (LINK_ID, ORDER_NUM, ORDER_DATE, SKU, PRODUCT_NAME, CREDIT_STATUS, LAST_CHANGE_DATE, QUANTITY, UNIT_PRICE, COMMISSION) AS 
  SELECT
    alo.link_id,
    alo.order_num,
    alo.order_date,
    alo.sku,
    pl.prod_name AS product_name,
    alo.credit_status,
    alo.last_change_date,
    alo.quantity,
    alo.unit_price,
    NVL(alo.credit_amount, alo.unit_price*alo.quantity*ach.comm_rate) AS commission
FROM YA_ASSOCIATE_LINK_ORDERS alo
inner join YA_ASSOCIATE_LINK l
ON alo.link_id = l.link_id
inner join YA_ASSOCIATE_COMMISSION_HIST ach
ON ach.associate_id = l.associate_id AND TO_CHAR(alo.order_date, 'yyyy') = TO_CHAR(ach.valid_date, 'yyyy') AND TO_CHAR(alo.order_date, 'mm') = TO_CHAR(ach.valid_date, 'mm')
inner join YA_PROD_LANG pl
ON alo.sku = pl.sku AND pl.lang_id = 1;