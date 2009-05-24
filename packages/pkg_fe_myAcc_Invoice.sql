CREATE OR REPLACE PACKAGE PKG_FE_MYACC_INVOICE AS
TYPE cur_return IS REF CURSOR;

PROCEDURE GetInvoice
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return
);

PROCEDURE GetInvoiceLine
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  iPLangId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetBillingInfo
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout OUT cur_return
);

PROCEDURE GetOrderSiteId
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout OUT cur_return
);

PROCEDURE GetOrderShippingMethod
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout OUT cur_return
);
  
END PKG_FE_MYACC_INVOICE;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_INVOICE IS

PROCEDURE GetInvoice
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return
)
AS 
BEGIN
  OPEN curPout1 FOR
  SELECT
    i.invoice_dt, i.order_info_id, o.order_dt, ys.EMAIL, s.ID SHIPMENT_ID, sinfo.METHOD COURIER,
    s.TRACKING_NUM, b.METHOD PAYMENT_METHOD, o.origin_order_id
  FROM
    (select * from INVOICE where id = iPInvoiceId) i
  inner join 
    (select * from ORDER_INFO where CUST_ID = iPShopperId) o on o.ID = i.order_info_id
  inner join 
    YA_SHOPPER ys on ys.shopper_id = iPShopperId and o.CUST_ID = trim(ys.SHOPPER_ID)
  inner join
    SHIPPING_INFO sinfo on i.SHIPPING_INFO_ID = sinfo.ID
  inner join 
    SHIPMENT s on sinfo.SHIPMENT_ID = s.ID 
  inner join
    BILLING_INFO b on b.INVOICE_ID = i.ID;

  OPEN curPout2 FOR
  SELECT bi.* FROM BILLING_INFO bi WHERE bi.invoice_id = iPInvoiceId;
  
END GetInvoice;

PROCEDURE GetInvoiceLine
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  iPLangId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT
    cast(pl.sku as varchar2(10)), pl.prod_name as PRODUCT_NAME, SHIPMENT_UNIT, UNIT_PRICE, QNTY 
  FROM 
    invoice i
  INNER JOIN invoice_line il on i.ID = il.invoice_id 
  INNER JOIN (SELECT DISTINCT inv2.prod_id, inv2.sku FROM inventory inv2 WHERE inv2.sku in (SELECT il2.sku FROM invoice_line il2 WHERE il2.invoice_id = iPInvoiceId)) inv on il.sku = inv.sku
  INNER JOIN order_info o on i.order_info_id = o.ID
  INNER JOIN ya_prod_lang pl on inv.prod_id = pl.sku
  WHERE INVOICE_ID = iPInvoiceId AND pl.lang_id = iPLangId
  AND o.CUST_ID = iPShopperId
  ORDER BY il.SKU DESC;
END GetInvoiceLine;

PROCEDURE GetBillingInfo
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT
    bi.SHIPMENT_AMT,bi.TAX,bi.AMT 
  FROM 
    billing_info bi, invoice i, order_info o
  WHERE bi.INVOICE_ID = iPInvoiceId AND o.ID = i.order_info_id AND i.ID = bi.INVOICE_ID AND o.CUST_ID = iPShopperId;
END GetBillingInfo;

PROCEDURE GetOrderSiteId
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT oi.origin_id 
  FROM invoice iv
    INNER JOIN order_info oi ON iv.order_info_id = oi.id
  WHERE iv.id = iPInvoiceId
    AND oi.cust_id = iPShopperId;

END GetOrderSiteId;

PROCEDURE GetOrderShippingMethod
(
  iPInvoiceId IN INT,
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT
    sinfo.METHOD SHIPPING_METHOD
  FROM 
    (select * from INVOICE where id = iPInvoiceId) i
  inner join (select * from ORDER_INFO where CUST_ID = iPShopperId) o on o.ID = i.order_info_id
  inner join SHIPPING_INFO sinfo on o.id = sinfo.order_info_id
  inner join BILLING_INFO binfo on binfo.INVOICE_ID = i.ID;
END GetOrderShippingMethod;

END PKG_FE_MYACC_INVOICE;
/