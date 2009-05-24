create or replace PACKAGE Pkg_Fe_MyAcc_ShippingAccess AS
TYPE cur_return IS REF CURSOR;

procedure GetShippingSchemeInformation
(
  iPsiteId in int,
  iPcountryId in int,
  iPshippingMethod in int,
  curPout1 OUT cur_return
);

procedure GetShippingScheme
(
  iPsiteId in int,
  iPcountryId in int,
  curPout1 OUT cur_return
);

procedure GetOrderShipment
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return
);

procedure GetOrderShipmentInfomation
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return
);

procedure GetOrderReshipmentInfomation
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return
);

procedure GetOrderReshipment
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return
);

END Pkg_Fe_MyAcc_ShippingAccess;
/


create or replace
PACKAGE BODY Pkg_Fe_MyAcc_ShippingAccess AS

procedure GetShippingSchemeInformation
(
  iPsiteId in int,
  iPcountryId in int,
  iPshippingMethod in int,
  curPout1 OUT cur_return
)
AS
BEGIN
  open curPout1 for 
  select * from ya_shipping_rate where site_id = iPsiteId and country_id = iPcountryId and shipping_method_id = iPshippingMethod;
END GetShippingSchemeInformation;

procedure GetShippingScheme
(
  iPsiteId in int,
  iPcountryId in int,
  curPout1 OUT cur_return
)
AS
BEGIN
  open curPout1 for 
  select * from ya_shipping_rate where site_id = iPsiteId and country_id = iPcountryId;
END GetShippingScheme;

procedure GetOrderShipment
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return
)
AS
  cLoriginOrderId nvarchar2(32);
  iLorderInfoId int;
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  select id into iLorderInfoId from order_info where cust_id = cPshopperId and origin_order_id = cLoriginOrderId;
  
  open curPout1 for 
  select s.*, i.id as invoice_id from (select * from shipment where order_info_id = iLorderInfoId) s 
  inner join shipping_info si on s.id = si.shipment_id
  inner join invoice i on si.id = i.shipping_info_id
  order by s.id;

  open curPout2 for 
  SELECT si.*
  FROM SHIPPING_INFO si where si.shipment_id in (select s.id from shipment s where order_info_id = iLorderInfoId);
  
  open curPout3 for 
  select sl.id, sl.shipment_id, p.sku, sl.qnty, ol.unit_price, sl.sts, sl.shipment_unit, pl.prod_name, p.account_id, pa.avlb, ol.parent_id,
  p.release_date, pr.is_preorder, pr.preorder_start, pr.preorder_end, pe.prod_name as eng_prod_name
  from shipment s 
  inner join shipment_line sl on s.id = sl.shipment_id 
  inner join order_line ol on sl.order_line_id = ol.id
  inner join (select * from order_info where cust_id = cPshopperId and origin_order_id = cLoriginOrderId) oi on ol.order_info_id = oi.id
  inner join prod_avlb pa on ol.prod_id = pa.prod_id and pa.region_id = oi.origin_id
  inner join prod_region pr on ol.prod_id = pr.prod_id and pr.region_id = oi.origin_id
  inner join ya_product p on pa.prod_id = p.sku
  inner join (select * from ya_prod_lang where lang_id = iPlangId) pl on p.sku = pl.sku
  inner join ya_prod_lang pe on p.sku = pe.sku and pe.lang_id = 1
  order by sl.id;

  open curPout4 for 
  select s.id as shipment_id, bi.* 
  from shipment s 
  inner join shipping_info si on s.id = si.shipment_id
  inner join invoice i on si.id = i.shipping_info_id
  inner join billing_info bi on i.id = bi.invoice_id
  where s.order_info_id = iLorderInfoId
  order by bi.id;
END GetOrderShipment;

procedure GetOrderShipmentInfomation
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return
)
AS
  cLoriginOrderId nvarchar2(32);
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  open curPout1 for 
  select si.* from order_info oi 
  inner join shipping_info si on si.order_info_id = oi.id
  where oi.cust_id = cPshopperId and oi.origin_order_id = cLoriginOrderId;
END GetOrderShipmentInfomation;

procedure GetOrderReshipmentInfomation
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return
)
AS
  cLoriginOrderId nvarchar2(32);
  iLorderInfoId int;
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  select id into iLorderInfoId from order_info where cust_id = cPshopperId and origin_order_id = cLoriginOrderId;

  open curPout1 for 
  select si.* from 
  (
    select oi.* from order_info oi where oi.parent_id = iLorderInfoId
  ) oi 
  inner join shipping_info si on si.order_info_id = oi.id;
END GetOrderReshipmentInfomation;

procedure GetOrderReshipment
(
  iPorderNumber IN INT,
  cPshopperId IN nvarchar2,
  iPlangId in int,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return,
  curPout4 OUT cur_return
)
AS
  cLoriginOrderId nvarchar2(32);
  iLorderInfoId int;
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  select id into iLorderInfoId from order_info where cust_id = cPshopperId and origin_order_id = cLoriginOrderId;
  
  open curPout1 for
  select s.*, i.id as invoice_id 
  from (select sp.* from shipment sp
    inner join order_info oi on sp.order_info_id = oi.id and oi.parent_id = iLorderInfoId) s 
    inner join shipping_info si on s.id = si.shipment_id
    inner join invoice i on si.id = i.shipping_info_id
  order by s.id;

  open curPout2 for 
  SELECT si.*
  FROM SHIPPING_INFO si where si.shipment_id in (select s.id from shipment s where order_info_id = iLorderInfoId);

  open curPout3 for 
  select sl.id, sl.shipment_id, p.sku, sl.qnty, ol.unit_price, sl.sts, sl.shipment_unit, pl.prod_name, p.account_id, pa.avlb, ol.parent_id,
  p.release_date, pr.is_preorder, pr.preorder_start, pr.preorder_end, pe.prod_name as eng_prod_name
  from 
  (
    select s.* from shipment s
    inner join order_info oi on s.order_info_id = oi.id and oi.parent_id = iLorderInfoId
  ) s 
  inner join shipment_line sl on s.id = sl.shipment_id 
  inner join order_line ol on sl.order_line_id = ol.id
  inner join (select * from order_info where cust_id = cPshopperId and origin_order_id = cLoriginOrderId) oi on ol.order_info_id = oi.id
  inner join prod_avlb pa on ol.prod_id = pa.prod_id and pa.region_id = oi.origin_id
  inner join prod_region pr on ol.prod_id = pr.prod_id and pr.region_id = oi.origin_id
  inner join ya_product p on pa.prod_id = p.sku
  inner join (select * from ya_prod_lang where lang_id = iPlangId) pl on p.sku = pl.sku
  inner join ya_prod_lang pe on p.sku = pe.sku and pe.lang_id = 1
  order by sl.id;

  open curPout4 for 
  select s.id as shipment_id, bi.* 
  from 
  (
    select s.* from shipment s
    inner join order_info oi on s.order_info_id = oi.id and oi.parent_id = iLorderInfoId
  ) s 
  inner join shipping_info si on s.id = si.shipment_id
  inner join invoice i on si.id = i.shipping_info_id
  inner join billing_info bi on i.billing_info_id = bi.id
  order by bi.id;
END GetOrderReshipment;

END Pkg_Fe_MyAcc_ShippingAccess;
/

