create or replace PACKAGE Pkg_FE_CouponAccess
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_GetCoupon */
  PROCEDURE GetCoupon (
    cPcode IN VARCHAR2,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  /* proc_fe_GetCorporateCoupon */
  PROCEDURE GetCorporateCoupon (
    cPdomain IN VARCHAR2,
    cPshopper_id IN CHAR,
    cPcoupon_code OUT VARCHAR2
  );

  /* proc_fe_GetCouponGetValisShopperId */
  PROCEDURE GetValidShopperId (
    cPcoupon_code IN VARCHAR2,
    curPresult OUT refCur
  );

  /* proc_fe_CheckCouponUserValid */
  PROCEDURE ValidateShopperId (
    cPcoupon_code IN VARCHAR2,
    cPshopper_id IN CHAR,
    iPreturn OUT INT
  );

  /* proc_fe_CreateNewShopperCoupon */
  PROCEDURE CreateNewShopperCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  );
END Pkg_FE_CouponAccess;
/
create or replace PACKAGE BODY Pkg_FE_CouponAccess
AS
  PROCEDURE GetCoupon (
    cPcode IN VARCHAR2,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = cPcode
      AND constraint_type = 1;

    OPEN curPresult2 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = cPcode
      AND constraint_type = 2;

    OPEN curPresult3 FOR
    SELECT constraint_value FROM ya_coupon_constraint
    WHERE coupon_code = cPcode AND constraint_type = 3;

    OPEN curPresult4 FOR
    SELECT
      c.coupon_code,
      coupon_description,
      dollar_coupon_value,
      percentage_coupon_value,
      order_amount_trigger,
      item_sku_trigger,
      expiration_date,
      shopper_id,
      all_shoppers,
      coupon_used,
      coupon_type_id,
      site_id,
      corporate_domain
    FROM
      ya_coupon c
      LEFT OUTER JOIN ya_coupon_corporate cc ON
        c.coupon_code = cc.coupon_code
    WHERE
      c.coupon_code = cPcode;

    RETURN;
  END GetCoupon;

  PROCEDURE GetCorporateCoupon (
    cPdomain IN VARCHAR2,
    cPshopper_id IN CHAR,
    cPcoupon_code OUT VARCHAR2
  )
  AS
  BEGIN
    SELECT r.coupon_code INTO cPcoupon_code
    FROM
    (
      SELECT c.coupon_code
      FROM
        ya_coupon_corporate cc,
        ya_coupon c
      WHERE
        cc.coupon_code = c.coupon_code
        AND corporate_domain = cPdomain
        AND c.expiration_date >= SYSDATE
        AND
          (
            c.all_shoppers <> 'U'
            OR
              (
                c.all_shoppers = 'U'
                AND
                  (
                    NOT EXISTS
                      (
                        SELECT 1
                        FROM ya_order
                        WHERE
                          coupon_code = c.coupon_code
                          AND shopper_id = cPshopper_id
                      )
                    OR NOT EXISTS
                      (
                        SELECT 1
                        FROM
                          billinginfo b,
                          orderinfo o
                        WHERE
                          b.orderid = o.id
                          AND o.customerId = cPshopper_id
                          AND b.coupon = c.coupon_code
                      )
                  )
              )
          )
      ORDER BY priority
    ) r
    WHERE
      ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      cPcoupon_code := '';
  END GetCorporateCoupon;

  PROCEDURE GetValidShopperId (
    cPcoupon_code IN VARCHAR2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT shopper_id
    FROM ya_coupon_user
    WHERE coupon_code = cPcoupon_code;
    RETURN;
  END GetValidShopperId;

  PROCEDURE ValidateShopperId (
    cPcoupon_code IN VARCHAR2,
    cPshopper_id IN CHAR,
    iPreturn OUT INT
  )
  AS
  BEGIN
    SELECT 1
    INTO iPreturn
    FROM ya_coupon_user
    WHERE
      coupon_code = cPcoupon_code
      AND shopper_id = cPshopper_id;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    iPreturn := -1;
  END ValidateShopperId;

  PROCEDURE CreateNewShopperCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  )
  AS
  BEGIN
   INSERT INTO ya_coupon  
      (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger)  
   VALUES  
      (cPshopper_id, cPcoupon_code, 'YS New Customer Coupon 060711', 'YesStyle New Customer Coupon', 5, to_date('2006/09/30', 'yyyy/mm/dd'), 'O', 'N', 1, 10, 5);

  END CreateNewShopperCoupon;
END Pkg_FE_CouponAccess;
/