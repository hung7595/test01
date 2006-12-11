CREATE OR REPLACE PACKAGE Pkg_Fe_Myaccountorderaccess
AS
  TYPE curGorder IS REF CURSOR;
  TYPE curGinvoice IS REF CURSOR;
  TYPE curGinvoice_id IS REF CURSOR;

  FUNCTION GetOrderLineStatus (
    iLproduct_id INT,
    iLorder_id INT
  ) RETURN INT;

  PROCEDURE GetOrder (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    cPorder_id VARCHAR2,
    curPorder OUT curGorder
  );

  PROCEDURE GetShopperInvoiceId (
    cPshopper_id IN VARCHAR2,
    cPorder_id VARCHAR2,
    curPinvoice_id OUT curGinvoice_id
  );

  PROCEDURE GetInvoice (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    iLinvoice_id VARCHAR2,
    curPinvoice OUT curGinvoice
  );

  PROCEDURE GetItemShippingAmount (
    iLshipment_unit INT,
    iLcountry_id INT,
    iLship_method INT,
    nLshipment_amount OUT NUMBER
  );

  PROCEDURE GetOrderEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    cPorder_id VARCHAR2,
    curPorder OUT curGorder
  );

  PROCEDURE GetInvoiceEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    iLinvoice_id VARCHAR2,
    curPinvoice OUT curGinvoice
  );

END Pkg_Fe_Myaccountorderaccess;
/


CREATE OR REPLACE PACKAGE BODY Pkg_Fe_Myaccountorderaccess
AS
  FUNCTION GetOrderLineStatus(iLproduct_id INT, iLorder_id INT) RETURN INT IS
    iLnew_status INT;
    iLstatus_count INT;
  BEGIN
    SELECT COUNT(DISTINCT status) INTO iLstatus_count FROM OrderLineDetail
    WHERE orderLineId IN (SELECT ol.id FROM OrderLine ol WHERE ol.orderId = iLorder_id AND ol.parentId = iLproduct_id AND ol.parentId <> ol.productId)
      AND status NOT IN (8,9); -- 8: bogus, 9: cancelled

    IF iLstatus_count > 1 THEN
      iLnew_status := 2;
    ELSIF iLstatus_count = 0 THEN
      SELECT DISTINCT status INTO iLnew_status FROM OrderLineDetail
      WHERE orderLineId IN (SELECT ol.id FROM OrderLine ol WHERE ol.orderId = iLorder_id AND ol.parentId = iLproduct_id AND ol.parentId <> ol.productId);
    ELSE
      SELECT DISTINCT status INTO iLnew_status FROM OrderLineDetail
      WHERE orderLineId IN (SELECT ol.id FROM OrderLine ol WHERE ol.orderId = iLorder_id AND ol.parentId = iLproduct_id AND ol.parentId <> ol.productId)
        AND status NOT IN (8,9);
    END IF;
    RETURN iLnew_status;
  END GetOrderLineStatus;

  PROCEDURE GetOrder (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    cPorder_id VARCHAR2,
    curPorder OUT curGorder
  )
  AS
  BEGIN
    OPEN curPorder FOR
    SELECT o.id, o.originorderid, o.orderDate, o.customerComment, ol.id AS lineId, o.originid AS siteId, ol.productId, ld.quantity AS openQty
      , ol.shipmentUnit, ol.unitPrice
      , CASE
         WHEN ol.parentId = ol.productId THEN Pkg_fe_MyAccountOrderAccess.GetOrderLineStatus(ol.productId, o.id)
         ELSE ld.status END AS lineStatus
      , ol.quantity AS quantity, b.coupon, b.couponAmt, b.credit, b.creditAmt, b.shipmentAmt
      , b.handlingAmt, b.tax, b.amount, o.splitShipment, b.handlingAmt, specialHandling, b.ccNum, b.firstname AS b_firstname, b.lastname AS b_lastname
      , b.method AS paymentType, b.address1 AS b_address1, b.address2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone
      , s.firstname AS s_firstname, s.lastname AS s_lastname, s.email AS s_email, s.dayPhone AS s_dayPhone, s.address1 AS s_address1, s.address2 AS s_address2
      , s.city AS s_city, s.state AS s_state, s.zip AS s_zip, s.method AS shipMethodId, s.country AS ship_country_id, pl.prod_name AS prod_name, pe.prod_name AS prod_ename
      , cast(miscinfo AS VARCHAR2(4000)) AS miscInfo, pr.preorder AS preorder, pr.preorderstart AS preorder_start, pr.preorderend AS preorder_end
      , bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod
      , b.method, '' AS prod_name_img_loc, o.status, o.hold, pd.account_id, pe.prod_subtitle_aka
    FROM OrderInfo o
      INNER JOIN OrderLine ol ON o.id = ol.orderId AND (ol.parentId = -1 OR ol.parentId = productId)
      INNER JOIN OrderLineDetail ld ON ol.orderId = ld.orderId AND ol.id = ld.orderLineId
      INNER JOIN BillingInfo b ON o.id = b.orderId
      INNER JOIN ShippingInfo s ON o.id = s.orderId
      INNER JOIN Lookup bpl ON b.method = bpl.code AND bpl.langType = -1 AND bpl.category = 'paymentMethod'
      LEFT OUTER JOIN Lookup bbl ON b.ccType = bbl.code AND bbl.langType = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN Lookup bcl ON b.country = bcl.code AND bcl.langType = -1 AND bcl.category = 'country'
      INNER JOIN Lookup sml ON s.method = sml.code AND sml.langType = -1 AND sml.category = 'shippingMethod'
      INNER JOIN Lookup scl ON s.country = scl.code AND scl.langType = -1 AND scl.category = 'country'
      INNER JOIN YA_PRODUCT pd ON ol.productId = pd.sku
	  INNER JOIN productregion pr ON ol.productId=pr.productId AND pr.regionId=1
      INNER JOIN YA_PROD_LANG pl ON ol.productId = pl.sku AND pl.lang_id = iLlang_id
      INNER JOIN YA_PROD_LANG pe ON ol.productId = pe.sku AND pe.lang_id = 1
    WHERE o.originOrderId = cPorder_id
      AND o.customerId = cPshopper_id
      AND o.parentId = -1
    ORDER BY ol.productId;
  END GetOrder;

  PROCEDURE GetShopperInvoiceId (
    cPshopper_id IN VARCHAR2,
    cPorder_id VARCHAR2,
    curPinvoice_id OUT curGinvoice_id
  )
  AS
  BEGIN
    OPEN curPinvoice_id FOR
    SELECT i.id
    FROM Invoice i
      INNER JOIN orderInfo o ON i.orderId = o.id
    WHERE o.originorderid = cPorder_id
      AND o.customerid = cPshopper_id
      AND i.status <> 4
      AND i.TYPE = 1;
  END GetShopperInvoiceId;

  PROCEDURE GetInvoice (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    iLinvoice_id VARCHAR2,
    curPinvoice OUT curGinvoice
  )
  AS
  BEGIN
    OPEN curPinvoice FOR
    SELECT i.id, i.invoiceDate, i.shippingTotal, o.originorderid, o.orderDate, il.id AS lineId,
      il.skuCode, il.unitPrice, il.shipmentUnit, il.quantity, il.shipmentId, sp.trackingNumber, sp.id AS shipmentId,
      b.coupon, b.couponAmt, b.credit, b.creditAmt, b.shipmentAmt, b.handlingAmt, b.tax, b.amount,
      b.ccNum, b.firstname AS b_firstname, b.lastname AS b_lastname,
      b.address1 AS b_address1, b.address2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone,
      s.firstname AS s_firstname, s.lastname AS s_lastname, s.email AS s_email, s.dayPhone AS s_dayPhone,
      s.address1 AS s_address1, s.address2 AS s_address2, s.city AS s_city, s.state AS s_state, s.zip AS s_zip,
      pl.prod_name AS prod_name, pf.prod_name AS prod_name_english, pf.prod_name_img_loc, s.method AS shipMethodId, s.country AS ship_country_id,
      bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod, ol.productid, pf.prod_subtitle_aka
    FROM Invoice i
      INNER JOIN InvoiceLine il ON i.id = il.invoiceId AND SUBSTR(il.skuCode,0,4)<>'MISC'
      INNER JOIN Shipment sp ON il.shipmentId = sp.id
      INNER JOIN BillingInfo b ON b.invoiceId = i.id
      INNER JOIN ShippingInfo s ON i.shippingInfoId = s.Id
      INNER JOIN orderInfo o ON i.orderId = o.id
      INNER JOIN orderLine ol ON il.orderLineId = ol.id
      LEFT OUTER JOIN Lookup bbl ON b.ccType = bbl.code AND bbl.langType = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN Lookup bcl ON b.country = bcl.code AND bcl.langType = -1 AND bcl.category = 'country'
      INNER JOIN Lookup bpl ON b.method = bpl.code AND bpl.langType = -1 AND bpl.category = 'paymentMethod'
      INNER JOIN Lookup sml ON s.method = sml.code AND sml.langType = -1 AND sml.category = 'shippingMethod'
      INNER JOIN Lookup scl ON s.country = scl.code AND scl.langType = -1 AND scl.category = 'country'
      INNER JOIN YA_PROD_LANG pf ON ol.productId = pf.sku AND pf.lang_id = 1
      LEFT OUTER JOIN YA_PROD_LANG pl ON ol.productId = pl.sku AND pl.lang_id = iLlang_id
    WHERE i.id = iLinvoice_id
      AND i.status <> 4
      AND i.TYPE = 1
    ORDER BY sp.id, il.skuCode;
  END GetInvoice;

  PROCEDURE GetItemShippingAmount (
    iLshipment_unit INT,
    iLcountry_id INT,
    iLship_method INT,
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
    iLlang_id INT,
    cPorder_id VARCHAR2,
    curPorder OUT curGorder
  )
  AS
  BEGIN
    OPEN curPorder FOR
    SELECT o.id, o.originorderid, o.orderDate, o.customerComment, ol.id AS lineId, o.originid AS siteId, ol.productId, ld.quantity AS openQty
      , ol.shipmentUnit, ol.unitPrice
      , CASE
         WHEN ol.parentId = ol.productId THEN Pkg_Fe_Myaccountorderaccess.GetOrderLineStatus(ol.productId, o.id)
         ELSE ld.status END AS lineStatus
      , ol.quantity AS quantity, b.coupon, b.couponAmt, b.credit, b.creditAmt, b.shipmentAmt
      , b.handlingAmt, b.tax, b.amount, o.splitShipment, b.handlingAmt, specialHandling, b.ccNum, b.firstname AS b_firstname, b.lastname AS b_lastname
      , b.method AS paymentType, b.address1 AS b_address1, b.address2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone
      , s.firstname AS s_firstname, s.lastname AS s_lastname, s.email AS s_email, s.dayPhone AS s_dayPhone, s.address1 AS s_address1, s.address2 AS s_address2
      , s.city AS s_city, s.state AS s_state, s.zip AS s_zip, s.method AS shipMethodId, s.country AS ship_country_id, pl.prod_name AS prod_name, pe.prod_name AS prod_ename
      , cast(miscinfo AS VARCHAR2(4000)) AS miscInfo, pr.preorder AS preorder, pr.preorderstart AS preorder_start, pr.preorderend AS preorder_end
      , bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod
      , b.method, '' AS prod_name_img_loc, o.status, o.hold, pd.account_id, pe.prod_subtitle_aka,
	  b.ccNumEncrypted AS card_numberEncrypted, b.encryptionKey
    FROM OrderInfo o
      INNER JOIN OrderLine ol ON o.id = ol.orderId AND (ol.parentId = -1 OR ol.parentId = productId)
      INNER JOIN OrderLineDetail ld ON ol.orderId = ld.orderId AND ol.id = ld.orderLineId
      INNER JOIN BillingInfo b ON o.id = b.orderId
      INNER JOIN ShippingInfo s ON o.id = s.orderId
      INNER JOIN Lookup bpl ON b.method = bpl.code AND bpl.langType = -1 AND bpl.category = 'paymentMethod'
      LEFT OUTER JOIN Lookup bbl ON b.ccType = bbl.code AND bbl.langType = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN Lookup bcl ON b.country = bcl.code AND bcl.langType = -1 AND bcl.category = 'country'
      INNER JOIN Lookup sml ON s.method = sml.code AND sml.langType = -1 AND sml.category = 'shippingMethod'
      INNER JOIN Lookup scl ON s.country = scl.code AND scl.langType = -1 AND scl.category = 'country'
      INNER JOIN YA_PRODUCT pd ON ol.productId = pd.sku
	  INNER JOIN productregion pr ON ol.productId=pr.productId AND pr.regionId=1
      INNER JOIN YA_PROD_LANG pl ON ol.productId = pl.sku AND pl.lang_id = iLlang_id
      INNER JOIN YA_PROD_LANG pe ON ol.productId = pe.sku AND pe.lang_id = 1
    WHERE o.originOrderId = cPorder_id
      AND o.customerId = cPshopper_id
      AND o.parentId = -1
    ORDER BY ol.productId;
  END GetOrderEncrypted;

  PROCEDURE GetInvoiceEncrypted (
    cPshopper_id IN VARCHAR2,
    iLlang_id INT,
    iLinvoice_id VARCHAR2,
    curPinvoice OUT curGinvoice
  )
  AS
  BEGIN
    OPEN curPinvoice FOR
    SELECT i.id, i.invoiceDate, i.shippingTotal, o.originorderid, o.orderDate, il.id AS lineId,
      il.skuCode, il.unitPrice, il.shipmentUnit, il.quantity, il.shipmentId, sp.trackingNumber, sp.id AS shipmentId,
      b.coupon, b.couponAmt, b.credit, b.creditAmt, b.shipmentAmt, b.handlingAmt, b.tax, b.amount,
      b.ccNum, b.firstname AS b_firstname, b.lastname AS b_lastname,
      b.address1 AS b_address1, b.address2 AS b_address2, b.city AS b_city, b.state AS b_state, b.zip AS b_zip, b.phone AS b_phone,
      s.firstname AS s_firstname, s.lastname AS s_lastname, s.email AS s_email, s.dayPhone AS s_dayPhone,
      s.address1 AS s_address1, s.address2 AS s_address2, s.city AS s_city, s.state AS s_state, s.zip AS s_zip,
      pl.prod_name AS prod_name, pf.prod_name AS prod_name_english, pf.prod_name_img_loc, s.method AS shipMethodId, s.country AS ship_country_id,
      bbl.meaning AS cardType, bpl.meaning AS paymentMethod, bcl.meaning AS bill_country, scl.meaning AS ship_country, sml.meaning AS shipMethod, ol.productid, pf.prod_subtitle_aka,
	  b.ccNumEncrypted AS card_numberEncrypted, b.encryptionKey
    FROM Invoice i
      INNER JOIN InvoiceLine il ON i.id = il.invoiceId AND SUBSTR(il.skuCode,0,4)<>'MISC'
      INNER JOIN Shipment sp ON il.shipmentId = sp.id
      INNER JOIN BillingInfo b ON b.invoiceId = i.id
      INNER JOIN ShippingInfo s ON i.shippingInfoId = s.Id
      INNER JOIN orderInfo o ON i.orderId = o.id
      INNER JOIN orderLine ol ON il.orderLineId = ol.id
      LEFT OUTER JOIN Lookup bbl ON b.ccType = bbl.code AND bbl.langType = -1 AND bbl.category = 'creditCardType'
      LEFT OUTER JOIN Lookup bcl ON b.country = bcl.code AND bcl.langType = -1 AND bcl.category = 'country'
      INNER JOIN Lookup bpl ON b.method = bpl.code AND bpl.langType = -1 AND bpl.category = 'paymentMethod'
      INNER JOIN Lookup sml ON s.method = sml.code AND sml.langType = -1 AND sml.category = 'shippingMethod'
      INNER JOIN Lookup scl ON s.country = scl.code AND scl.langType = -1 AND scl.category = 'country'
      INNER JOIN YA_PROD_LANG pf ON ol.productId = pf.sku AND pf.lang_id = 1
      LEFT OUTER JOIN YA_PROD_LANG pl ON ol.productId = pl.sku AND pl.lang_id = iLlang_id
    WHERE i.id = iLinvoice_id
      AND i.status <> 4
      AND i.TYPE = 1
    ORDER BY sp.id, il.skuCode;
  END GetInvoiceEncrypted;

END Pkg_Fe_Myaccountorderaccess;
/

