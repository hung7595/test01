CREATE OR REPLACE PACKAGE PKG_FE_MYACC_RMAACCESS AS
TYPE CUR_RETURN IS REF CURSOR;

PROCEDURE GetRmaByOrderId
(
  iPOrderId IN VARCHAR2,
  iPShopperId IN VARCHAR2,
  curPout OUT cur_return
);

PROCEDURE GetRmaLineByRmaId
(
  iPRmaId IN INT,
  iPLangId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetRmaLineByRmaRefNum
(
  iPRmaRefNum IN VARCHAR2,
  iPLangId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetRmaLineByOrderLineId
(
  iPOrderLineId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetOrderLineWarranty
(
  iPOrderLineId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetOrderLineMagSub
(
  iPOrderLineId IN INT,
  curPout OUT cur_return
);

END PKG_FE_MYACC_RMAACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_RMAACCESS IS

PROCEDURE GetRmaByOrderId
(
  iPOrderId IN VARCHAR2,
  iPShopperId IN VARCHAR2,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT r.id, r.ref_num, r.create_dt, r.sts 
  FROM rma r, order_info o, ya_shopper ys
  WHERE r.order_info_id = o.id 
  AND o.origin_order_id = iPOrderId
  AND o.cust_id = trim(ys.shopper_id) and ys.shopper_id = iPShopperId
  ORDER BY r.create_dt;
END GetRmaByOrderId;

PROCEDURE GetRmaLineByRmaId
(
  iPRmaId IN INT,
  iPLangId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT ypl.prod_name,rd.sku,ol.shipment_unit,ol.unit_price,rd.qnty, rd.sts
  FROM rma r, rma_dtl rd, ya_prod_lang ypl, order_info o, order_line ol
  WHERE rd.rma_id = iPRmaId
  AND ypl.lang_id = iPLangId
  AND ypl.sku = rd.sku 
  AND to_char(ol.prod_id) = rd.sku 
  AND ol.order_info_id = o.id
  AND r.order_info_id = o.id
  AND r.id = rd.rma_id
  ORDER BY rd.rma_id;
END GetRmaLineByRmaId;
	
PROCEDURE GetRmaLineByRmaRefNum
(
  iPRmaRefNum IN VARCHAR2,
  iPLangId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT ypl.prod_name,rd.sku,ol.shipment_unit,ol.unit_price,rd.qnty, rd.sts
  FROM rma r
  INNER JOIN rma_dtl rd ON r.id = rd.rma_id
  INNER JOIN ya_prod_lang ypl ON ypl.sku = rd.sku 
  INNER JOIN order_info o ON r.order_info_id = o.id
  INNER JOIN order_line ol ON ol.order_info_id = o.id AND to_char(ol.prod_id) = rd.sku 
  WHERE r.ref_num = iPRmaRefNum
  AND ypl.lang_id = iPLangId
  ORDER BY rd.rma_id;  

END GetRmaLineByRmaRefNum;
	
PROCEDURE GetRmaLineByOrderLineId
(
  iPOrderLineId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT r.create_dt, r.sts FROM rma r, rma_dtl rd, order_line ol
  WHERE ol.order_info_id = r.order_info_id
  AND to_char(ol.prod_id) = rd.sku
  AND r.id = rd.rma_id
  AND ol.id = iPOrderLineId;
END GetRmaLineByOrderLineId;

PROCEDURE GetOrderLineWarranty
(
  iPOrderLineId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT COUNT(*) FROM order_line_warranty WHERE order_line_id = iPOrderLineId;
END GetOrderLineWarranty;

PROCEDURE GetOrderLineMagSub
(
  iPOrderLineId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT COUNT(*) FROM order_line WHERE type = 1 AND id = iPOrderLineId;
END GetOrderLineMagSub;

END PKG_FE_MYACC_RMAACCESS;
/