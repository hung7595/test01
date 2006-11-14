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

	/**/
  PROCEDURE GetShopperCoupon (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refCur
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
      (cPshopper_id, cPcoupon_code, 'YS New Customer Coupon 060711', 'YesStyle New Customer US$5 Coupon', 5, to_date('2007/09/30', 'yyyy/mm/dd'), 'O', 'N', 1, 10, 5);
   COMMIT;
  END CreateNewShopperCoupon;

  PROCEDURE GetShopperCoupon (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refCur
	)
  AS
  BEGIN
		OPEN curPresult FOR
		SELECT c.coupon_code, c.coupon_description, c.expiration_date
		FROM ya_coupon c
		LEFT JOIN ya_coupon_user u ON c.coupon_code = u.coupon_code AND u.shopper_id = cPshopper_id
		WHERE coupon_used <> 'Y'
		AND c.expiration_date >= SYSDATE
		AND (
			c.shopper_id = cPshopper_id
			OR
			(
				c.all_shoppers = 'G' AND u.shopper_id is not null AND NOT EXISTS (
					SELECT 1 FROM OrderInfo o INNER JOIN BillingInfo b ON o.id = b.orderid WHERE b.coupon = u.coupon_code AND o.customerid = cPshopper_id
				)
			)
		)
		AND (((site_id = iPsite_id or site_id=99) and iPsite_id not in (10)) or site_id = iPsite_id)
		union
		select c.coupon_code, c.coupon_description, c.expiration_date from ya_coupon c where coupon_code = 'EKDWROGCKL' and 1 = (
			select 1 from ya_shopper s
			where shopper_id = cPshopper_id
			and created_date <= to_date('2006/11/10', 'yyyy/mm/dd')
			and iPsite_id = 10
			and c.coupon_used = 'N'
			and not exists (select 1 from OrderInfo oi inner join BillingInfo bo on oi.id = bo.orderid where oi.customerid = s.shopper_id and bo.coupon = 'EKDWROGCKL')
		)
		union
		select c.coupon_code, c.coupon_description, c.expiration_date from ya_coupon c where coupon_code = 'CTCZHGOKPZ' and 1 = (
			select 1 from ya_shopper s
			where shopper_id = cPshopper_id
			and created_date <= to_date('2006/10/11', 'yyyy/mm/dd')
			and iPsite_id = 10
			and c.coupon_used = 'N'
			and not exists (select 1 from OrderInfo oi inner join BillingInfo bo on oi.id = bo.orderid where oi.customerid = s.shopper_id and bo.coupon = 'CTCZHGOKPZ')
		)		ORDER BY expiration_date;
	END GetShopperCoupon;

END Pkg_FE_CouponAccess;
/