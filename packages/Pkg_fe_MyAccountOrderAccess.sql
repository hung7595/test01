
  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_MYACCOUNTORDERACCESS" 
AS
  TYPE curGorder IS REF CURSOR;
  TYPE curGinvoice IS REF CURSOR;
  TYPE curGinvoice_id IS REF CURSOR;
  TYPE refCur IS REF CURSOR;

  FUNCTION GetOrderLineStatus (
    iLproduct_id INT,
    iLorder_id INT
  ) RETURN INT;

  PROCEDURE GetOrder (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    cPorder_id IN VARCHAR2,
    curPorder OUT curGorder
  );

  PROCEDURE GetShopperInvoiceId (
    cPshopper_id IN VARCHAR2,
    cPorder_id IN VARCHAR2,
    curPinvoice_id OUT curGinvoice_id
  );

  PROCEDURE GetInvoice (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    iLinvoice_id IN VARCHAR2,
    curPinvoice OUT curGinvoice
  );

  PROCEDURE GetItemShippingAmount (
    iLshipment_unit IN INT,
    iLcountry_id IN INT,
    iLship_method IN INT,
    nLshipment_amount OUT NUMBER
  );

  PROCEDURE GetOrderEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    cPorder_id IN VARCHAR2,
    curPorder OUT curGorder
  );

  PROCEDURE GetInvoiceEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    iLinvoice_id IN VARCHAR2,
    curPinvoice OUT curGinvoice
  );

  PROCEDURE GetOrderStylebucksDetail (
    cPshopper_id IN CHAR,
    iPorder_id IN CHAR,
    iLsite_id IN INT,	
    curPresult1 OUT refCur
  );

END Pkg_Fe_Myaccountorderaccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_MYACCOUNTORDERACCESS" 
AS
  FUNCTION GetOrderLineStatus(
    iLproduct_id INT,
    iLorder_id INT
  ) RETURN INT IS
    iLnew_status INT;
    iLstatus_count INT;
  BEGIN
    SELECT COUNT(DISTINCT sts) INTO iLstatus_count FROM order_line_dtl
    WHERE order_line_id IN (SELECT ol.id FROM order_line ol WHERE ol.order_info_id = iLorder_id AND ol.parent_id = iLproduct_id AND ol.parent_id <> ol.prod_id)
      AND sts NOT IN (8,9); -- 8: bogus, 9: cancelled

    IF iLstatus_count > 1 THEN
      iLnew_status := 2;
    ELSIF iLstatus_count = 0 THEN
      SELECT DISTINCT sts INTO iLnew_status FROM order_line_dtl
      WHERE order_line_id IN (SELECT ol.id FROM order_line ol WHERE ol.order_info_id = iLorder_id AND ol.parent_id = iLproduct_id AND ol.parent_id <> ol.prod_id);
    ELSE
      SELECT DISTINCT sts INTO iLnew_status FROM order_line_dtl
      WHERE order_line_id IN (SELECT ol.id FROM order_line ol WHERE ol.order_info_id = iLorder_id AND ol.parent_id = iLproduct_id AND ol.parent_id <> ol.prod_id)
        AND sts NOT IN (8,9);
    END IF;
    RETURN iLnew_status;
  END GetOrderLineStatus;

  PROCEDURE GetOrder (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    cPorder_id IN VARCHAR2,
    curPorder OUT curGorder
  )
  AS
  BEGIN
    OPEN curPorder FOR
    SELECT o.id, o.origin_order_id, o.order_dt, o.cust_cmt, ol.id AS lineId, o.origin_id AS siteId, ol.prod_id, ld.qnty AS openQty
      , ol.shipment_unit, ol.unit_price
      , CASE
         WHEN ol.parent_id = ol.prod_id THEN Pkg_fe_MyAccountOrderAccess.GetOrderLineStatus(ol.prod_id, o.id)
         ELSE ld.sts END AS lineStatus
      , ol.qnty AS quantity, b.coupon, b.coupon_amt, b.credit, b.credit_amt, b.shipment_amt
      , b.handling_amt, b.tax, b.amt, o.split_shipment, b.handling_amt, b.special_handling, b.cc_num, b.first_name AS b_firstname, b.last_name AS b_lastname
      , b.method AS paymentType, b.addr_1 AS b_address1, b.addr_2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone
      , s.first_name AS s_firstname, s.last_name AS s_lastname, s.email AS s_email, s.day_phone AS s_dayPhone, s.addr_1 AS s_address1, s.addr_2 AS s_address2
      , s.city AS s_city, s.state AS s_state, s.zip AS s_zip, s.method AS shipMethodId, s.country AS ship_country_id, pl.prod_name AS prod_name, pe.prod_name AS prod_ename
      , cast(ol.misc_info AS VARCHAR2(4000)) AS miscInfo, pr.is_preorder AS preorder, pr.preorder_start AS preorder_start, pr.preorder_end AS preorder_end
      , bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod
      , b.method, '' AS prod_name_img_loc, o.sts, o.hold, pd.account_id, pe.prod_subtitle_aka
    FROM order_info o
      INNER JOIN order_line ol ON o.id = ol.order_info_id AND (ol.parent_id = -1 OR ol.parent_id = ol.prod_id)
      INNER JOIN order_line_dtl ld ON ol.order_info_id = ld.order_info_id AND ol.id = ld.order_line_id
      INNER JOIN billing_info b ON o.id = b.order_info_id
      INNER JOIN shipping_info s ON o.id = s.order_info_id
      INNER JOIN lookup bpl ON b.method = bpl.code AND bpl.lang_type = -1 AND bpl.category = 'paymentMethod'
      LEFT OUTER JOIN lookup bbl ON b.cc_type = bbl.code AND bbl.lang_type = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN lookup bcl ON b.country = bcl.code AND bcl.lang_type = -1 AND bcl.category = 'country'
      INNER JOIN lookup sml ON s.method = sml.code AND sml.lang_type = -1 AND sml.category = 'shippingMethod'
      INNER JOIN lookup scl ON s.country = scl.code AND scl.lang_type = -1 AND scl.category = 'country'
      INNER JOIN YA_PRODUCT pd ON ol.prod_id = pd.sku
	  INNER JOIN prod_region pr ON ol.prod_id=pr.prod_id AND pr.region_id=1
      INNER JOIN YA_PROD_LANG pl ON ol.prod_id = pl.sku AND pl.lang_id = iLlang_id
      INNER JOIN YA_PROD_LANG pe ON ol.prod_id = pe.sku AND pe.lang_id = 1
    WHERE o.origin_order_id = cPorder_id
      AND o.cust_id = cPshopper_id
      AND o.parent_id = -1
    ORDER BY ol.prod_id;
  END GetOrder;

  PROCEDURE GetShopperInvoiceId (
    cPshopper_id IN VARCHAR2,
    cPorder_id IN VARCHAR2,
    curPinvoice_id OUT curGinvoice_id
  )
  AS
  BEGIN
    OPEN curPinvoice_id FOR
    SELECT i.id
    FROM invoice i
      INNER JOIN order_info o ON i.order_info_id = o.id
    WHERE o.origin_order_id = cPorder_id
      AND o.cust_id = cPshopper_id
      AND i.sts <> 4
      AND i.TYPE = 1;
  END GetShopperInvoiceId;

  PROCEDURE GetInvoice (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    iLinvoice_id IN VARCHAR2,
    curPinvoice OUT curGinvoice
  )
  AS
  BEGIN
    OPEN curPinvoice FOR
    SELECT i.id, i.invoice_dt, i.shipping_total, o.origin_order_id, o.order_dt, il.id AS lineId,
      il.sku, il.unit_price, il.shipment_unit, il.qnty, il.shipment_id, sp.tracking_num, sp.id AS shipmentId,
      b.coupon, b.coupon_amt, b.credit, b.credit_amt, b.shipment_amt, b.handling_amt, b.tax, b.amt,
      b.cc_num, b.first_name AS b_firstname, b.last_name AS b_lastname,
      b.addr_1 AS b_address1, b.addr_2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone,
      s.first_name AS s_firstname, s.last_name AS s_lastname, s.email AS s_email, s.day_phone AS s_dayPhone,
      s.addr_1 AS s_address1, s.addr_2 AS s_address2, s.city AS s_city, s.state AS s_state, s.zip AS s_zip,
      nvl(pl.prod_name, pe.prod_name) AS prod_name, pf.prod_name AS prod_name_english, pf.prod_name_img_loc, s.method AS shipMethodId, s.country AS ship_country_id,
      bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod, ol.prod_id, pf.prod_subtitle_aka
    FROM invoice i
      INNER JOIN invoice_line il ON i.id = il.invoice_id AND SUBSTR(il.sku,0,4)<>'MISC'
      INNER JOIN shipment sp ON il.shipment_id = sp.id
      INNER JOIN billing_info b ON b.invoice_id = i.id
      INNER JOIN shipping_info s ON i.shipping_info_id = s.Id
      INNER JOIN order_info o ON i.order_info_id = o.id
      INNER JOIN order_line ol ON il.order_line_id = ol.id
      LEFT OUTER JOIN lookup bbl ON b.cc_type = bbl.code AND bbl.lang_type = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN lookup bcl ON b.country = bcl.code AND bcl.lang_type = -1 AND bcl.category = 'country'
      INNER JOIN lookup bpl ON b.method = bpl.code AND bpl.lang_type = -1 AND bpl.category = 'paymentMethod'
      INNER JOIN lookup sml ON s.method = sml.code AND sml.lang_type = -1 AND sml.category = 'shippingMethod'
      INNER JOIN lookup scl ON s.country = scl.code AND scl.lang_type = -1 AND scl.category = 'country'
      INNER JOIN YA_PROD_LANG pf ON ol.prod_id = pf.sku AND pf.lang_id = 1
      LEFT OUTER JOIN YA_PROD_LANG pl ON ol.prod_id = pl.sku AND pl.lang_id = iLlang_id
	  INNER JOIN YA_PROD_LANG pe ON ol.prod_id = pe.sku AND pe.lang_id = 1
    WHERE i.id = iLinvoice_id
      AND i.sts <> 4
      AND i.TYPE = 1
    ORDER BY sp.id, il.sku;
  END GetInvoice;

  PROCEDURE GetItemShippingAmount (
    iLshipment_unit IN INT,
    iLcountry_id IN INT,
    iLship_method IN INT,
    nLshipment_amount OUT NUMBER
  )
  AS
    nLcal_value NUMBER;
  BEGIN
    IF iLship_method = 5 THEN
      nLshipment_amount := 0;
    ELSE
      SELECT per_unit_rate * iLshipment_unit INTO nLshipment_amount FROM ya_shipping_rate WHERE country_id = iLcountry_id AND shipping_method_id = iLship_method;
    END IF;
  END GetItemShippingAmount;

  PROCEDURE GetOrderEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    cPorder_id IN VARCHAR2,
    curPorder OUT curGorder
  )
  AS
  BEGIN
    OPEN curPorder FOR
    SELECT o.id, o.origin_order_id, o.order_dt, o.cust_cmt, ol.id AS lineId, o.origin_id AS siteId, ol.prod_id, ld.qnty AS openQty
      , ol.shipment_unit, ol.unit_price
      , CASE
         WHEN ol.parent_id = ol.prod_id THEN Pkg_Fe_Myaccountorderaccess.GetOrderLineStatus(ol.prod_id, o.id)
         ELSE ld.sts END AS lineStatus
      , ol.qnty AS quantity, b.coupon, b.coupon_amt, b.credit, b.credit_amt, b.shipment_amt
      , b.handling_amt, b.tax, b.amt, o.split_shipment, b.handling_amt, b.special_handling, b.cc_num, b.first_name AS b_firstname, b.last_name AS b_lastname
      , b.method AS paymentType, b.addr_1 AS b_address1, b.addr_2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone, b.currency AS currency
      , s.first_name AS s_firstname, s.last_name AS s_lastname, s.email AS s_email, s.day_phone AS s_dayPhone, s.addr_1 AS s_address1, s.addr_2 AS s_address2
      , s.city AS s_city, s.state AS s_state, s.zip AS s_zip, s.method AS shipMethodId, s.country AS ship_country_id, pl.prod_name AS prod_name, pe.prod_name AS prod_ename
      , cast(ol.misc_info AS VARCHAR2(4000)) AS miscInfo, pr.is_preorder AS preorder, pr.preorder_start AS preorder_start, pr.preorder_end AS preorder_end
      , bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod
      , b.method, '' AS prod_name_img_loc, o.sts, o.hold, pd.account_id, pe.prod_subtitle_aka,
	  b.cc_num_encrypted AS card_numberEncrypted, b.encryption_key
    FROM order_info o
      INNER JOIN order_line ol ON o.id = ol.order_info_id AND (ol.parent_id = -1 OR ol.parent_id = ol.prod_id)
      INNER JOIN order_line_dtl ld ON ol.order_info_id = ld.order_info_id AND ol.id = ld.order_line_id
      INNER JOIN billing_info b ON o.id = b.order_info_id
      INNER JOIN shipping_info s ON o.id = s.order_info_id
      INNER JOIN lookup bpl ON b.method = bpl.code AND bpl.lang_type = iLlang_id AND bpl.category = 'paymentMethod'
      LEFT OUTER JOIN lookup bbl ON b.cc_type = bbl.code AND bbl.lang_type = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN lookup bcl ON b.country = bcl.code AND bcl.lang_type = -1 AND bcl.category = 'country'
      INNER JOIN lookup sml ON s.method = sml.code AND sml.lang_type = iLlang_id AND sml.category = 'shippingMethod'
      INNER JOIN lookup scl ON s.country = scl.code AND scl.lang_type = -1 AND scl.category = 'country'
      INNER JOIN YA_PRODUCT pd ON ol.prod_id = pd.sku
	  INNER JOIN prod_region pr ON ol.prod_id=pr.prod_id AND pr.region_id=1
      INNER JOIN YA_PROD_LANG pl ON ol.prod_id = pl.sku AND pl.lang_id = iLlang_id
      INNER JOIN YA_PROD_LANG pe ON ol.prod_id = pe.sku AND pe.lang_id = 1
    WHERE o.origin_order_id = cPorder_id
      AND o.cust_id = cPshopper_id
      AND o.parent_id = -1
    ORDER BY ol.prod_id;
  END GetOrderEncrypted;

  PROCEDURE GetInvoiceEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id IN INT,
    iLinvoice_id IN VARCHAR2,
    curPinvoice OUT curGinvoice
  )
  AS
  BEGIN
    OPEN curPinvoice FOR
    SELECT i.id, i.invoice_dt, i.shipping_total, o.origin_order_id, o.order_dt, il.id AS lineId,
      il.sku, il.unit_price, il.shipment_unit, il.qnty, il.shipment_id, sp.tracking_num, sp.id AS shipmentId,
      b.coupon, b.coupon_amt, b.credit, b.credit_amt, b.shipment_amt, b.handling_amt, b.tax, b.amt,
      b.cc_num, b.first_name AS b_firstname, b.last_name AS b_lastname,
      b.addr_1 AS b_address1, b.addr_2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone, b.currency AS currency,
      s.first_name AS s_firstname, s.last_name AS s_lastname, s.email AS s_email, s.day_phone AS s_dayPhone,
      s.addr_1 AS s_address1, s.addr_2 AS s_address2, s.city AS s_city, s.state AS s_state, s.zip AS s_zip,
      pl.prod_name AS prod_name, pf.prod_name AS prod_name_english, pf.prod_name_img_loc, s.method AS shipMethodId, s.country AS ship_country_id,
      bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod, ol.prod_id, pf.prod_subtitle_aka,
	  b.cc_num_encrypted AS card_numberEncrypted, b.encryption_key
    FROM invoice i
      INNER JOIN invoice_line il ON i.id = il.invoice_id AND SUBSTR(il.sku,0,4)<>'MISC'
      INNER JOIN shipment sp ON il.shipment_id = sp.id
      INNER JOIN billing_info b ON b.invoice_id = i.id
      INNER JOIN shipping_info s ON i.shipping_info_id = s.Id
      INNER JOIN order_info o ON i.order_info_id = o.id
      INNER JOIN order_line ol ON il.order_line_id = ol.id
      LEFT OUTER JOIN lookup bbl ON b.cc_type = bbl.code AND bbl.lang_type = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN lookup bcl ON b.country = bcl.code AND bcl.lang_type = -1 AND bcl.category = 'country'
      INNER JOIN lookup bpl ON b.method = bpl.code AND bpl.lang_type = iLlang_id AND bpl.category = 'paymentMethod'
      INNER JOIN lookup sml ON s.method = sml.code AND sml.lang_type = iLlang_id AND sml.category = 'shippingMethod'
      INNER JOIN lookup scl ON s.country = scl.code AND scl.lang_type = -1 AND scl.category = 'country'
      INNER JOIN YA_PROD_LANG pf ON ol.prod_id = pf.sku AND pf.lang_id = 1
      LEFT OUTER JOIN YA_PROD_LANG pl ON ol.prod_id = pl.sku AND pl.lang_id = iLlang_id
    WHERE i.id = iLinvoice_id
      AND i.sts <> 4
      AND i.TYPE = 1
    ORDER BY sp.id, il.sku;
  END GetInvoiceEncrypted;

  PROCEDURE GetOrderStylebucksDetail (
    cPshopper_id IN CHAR,
    iPorder_id IN CHAR,
    iLsite_id IN INT,	
    curPresult1 OUT refCur
  )
  AS
   iLApprovalOrder INT;
   dtLApprovalDate DATE;
   dtLStartDate DATE;
  BEGIN

  
BEGIN
    SELECT 1 into iLApprovalOrder FROM  loyalty_order o, order_info i where i.ORIGIN_ORDER_ID = iPorder_id and i.id = o.order_info_id;
EXCEPTION WHEN NO_DATA_FOUND THEN
    iLApprovalOrder := 0;
END;
  IF iLApprovalOrder=0 THEN
BEGIN
    SELECT APPROVAL_DT into dtLApprovalDate FROM order_info where ORIGIN_ORDER_ID = iPorder_id;
EXCEPTION WHEN NO_DATA_FOUND THEN
    dtLApprovalDate := to_date('20050101','YYYYMMDD');
END; 
    SELECT to_date('20080101','YYYYMMDD') into dtLStartDate FROM dual;
    IF dtLApprovalDate > dtLStartDate Then
      OPEN curPresult1 FOR
	    select m.membership_name, c.accumulated_point, 0 as gained_point
		  from loyalty_customer c , loyalty_membership m
		  where c.loyalty_membership_id = m.id and c.ya_shopper_id = cPshopper_id
		   and c.site_id = iLsite_id and m.MEMBERSHIP_YEAR = to_char(sysdate,'YYYY');
    ELSE 
      OPEN curPresult1 FOR
	    select m.membership_name, c.accumulated_point, o.gained_point
		  from loyalty_customer c , loyalty_membership m, loyalty_order o, order_info i
		  where c.loyalty_membership_id = m.id and c.ya_shopper_id = cPshopper_id and i.ORIGIN_ORDER_ID = iPorder_id
		   and c.site_id = iLsite_id and m.MEMBERSHIP_YEAR = to_char(sysdate,'YYYY')
		   and i.CUST_ID = c.ya_shopper_id and o.order_info_id = i.id;
	END IF;  
  ELSE 
    OPEN curPresult1 FOR
	  select m.membership_name, c.accumulated_point, o.gained_point
		from loyalty_customer c , loyalty_membership m, loyalty_order o, order_info i
		where c.loyalty_membership_id = m.id and c.ya_shopper_id = cPshopper_id and i.ORIGIN_ORDER_ID = iPorder_id
		 and i.CUST_ID = c.ya_shopper_id and o.order_info_id = i.id
		 and c.site_id = iLsite_id and m.MEMBERSHIP_YEAR = to_char(sysdate,'YYYY');
  END IF;
  END GetOrderStylebucksDetail;

END Pkg_Fe_Myaccountorderaccess;
/
 