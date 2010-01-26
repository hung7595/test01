CREATE OR REPLACE PACKAGE          "PKG_FE_COUPONACCESS"
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_GetCoupon */
  PROCEDURE GetCoupon (
    cPcode IN VARCHAR2,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur,
	curPresult5 OUT refCur
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
  /*2007 email referral  program for check the shopper get existing 3 or more coupon*/
  PROCEDURE checkReferralCoupon (
    cPshopper_id IN CHAR,
    iPreturn OUT INT
  );
  
  /* proc_fe_CreateNewShopperCoupon */
  PROCEDURE CreateNewShopperCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  );

  PROCEDURE CreateYSCNewShopperCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  );
  
  PROCEDURE AddShopperToCouponUserGroup (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  );

  PROCEDURE CreateHallmarkWelcomeCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code OUT VARCHAR2
  );

  PROCEDURE CreateNewShopperCoupon_woCode (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  );

	/**/
  PROCEDURE GetShopperCoupon (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refCur
  );
  PROCEDURE CreateYSSurveyCoupon (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  );
  /* 2007 email referral */
  PROCEDURE CreateCouponForEmailRefer (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  );
  
  PROCEDURE CreateHallmarkBirthdayCoupon (
    cPshopper_id IN CHAR
  );
END Pkg_FE_CouponAccess;
/


create or replace PACKAGE BODY          "PKG_FE_COUPONACCESS"
AS
  PROCEDURE GetCoupon (
    cPcode IN VARCHAR2,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur,
	  curPresult5 OUT refCur
  )
  AS
	iLcoupon_code VARCHAR2(32);
  BEGIN
	Begin
		SELECT COUPON_CODE into iLcoupon_code
		FROM YA_COUPON 
		WHERE COUPON_CODE = UPPER( cPcode );
      EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        iLcoupon_code := NULL;
      END;
    END;
	
    OPEN curPresult1 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = iLcoupon_code
      AND constraint_type = 1;

    OPEN curPresult2 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = iLcoupon_code
      AND constraint_type = 2;

    OPEN curPresult3 FOR
    SELECT constraint_value
	FROM ya_coupon_constraint
    WHERE 
	  coupon_code = iLcoupon_code 
	  AND constraint_type = 3;
	
	OPEN curPresult4 FOR
	SELECT constraint_value
	FROM ya_coupon_constraint
    WHERE 
	  coupon_code = iLcoupon_code 
	  AND constraint_type = 4;
	
    OPEN curPresult5 FOR
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
      case when cs2.site = 8 then 99
           when cs2.site = 23 then 98
           else cs2.site end,
      corporate_domain,
      currency
    FROM
      ya_coupon c
      INNER JOIN (select sum(cs.site_id) site, cs.coupon_code from ya_coupon_site cs where cs.coupon_code = iLcoupon_code group by cs.coupon_code) cs2 ON
        cs2.coupon_code = c.coupon_code
      LEFT OUTER JOIN ya_coupon_corporate cc ON
        c.coupon_code = cc.coupon_code
    WHERE
      c.coupon_code = iLcoupon_code;

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
                          billing_info b,
                          order_info o
                        WHERE
                          b.order_info_id = o.id
                          AND o.cust_id = cPshopper_id
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

  PROCEDURE checkReferralCoupon (
    cPshopper_id IN CHAR,
    iPreturn OUT INT
  )
  AS
  BEGIN
    SELECT count(*)
    INTO iPreturn
    FROM ya_coupon
    WHERE
      campaign_name = 'YesStyle.com Referral'
      AND shopper_id = cPshopper_id;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    iPreturn := -1;
  END checkReferralCoupon;

  PROCEDURE CreateNewShopperCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  )
  AS
    cLcoupon_code VARCHAR2(8);
    iLcount INT;
  BEGIN
    IF cPcoupon_code IS NULL THEN
      -- Generate Coupon
      SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;

      -- Make sure unique coupon code
      SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
      WHILE (iLcount = 1)
      LOOP
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
      END LOOP;
    ELSE
      cLcoupon_code := cPcoupon_code;
    END IF;

    INSERT INTO ya_coupon
      (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger)
    VALUES
      (cPshopper_id, cLcoupon_code, 'YS New Customer Coupon 060711', 'YesStyle New Customer US$5 Coupon', 5, add_months(SYSDATE, 1), 'O', 'N', 1, 10, 5);
      
    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (cLcoupon_code, 10);

    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (cLcoupon_code, 13);

    COMMIT;
  END CreateNewShopperCoupon;

  PROCEDURE CreateYSCNewShopperCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  )
  AS
    cLcoupon_code VARCHAR2(8);
    iLcount INT;
  BEGIN
    IF cPcoupon_code IS NULL THEN
      -- Generate Coupon
      SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;

      -- Make sure unique coupon code
      SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
      WHILE (iLcount = 1)
      LOOP
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
      END LOOP;
    ELSE
      cLcoupon_code := cPcoupon_code;
    END IF;

    INSERT INTO ya_coupon
      (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger)
    VALUES
      (cPshopper_id, cLcoupon_code, 'YSC New Customer Coupon 080820', 'YesStyle New Customer RMB 10 Coupon', 1.3, add_months(SYSDATE, 1), 'O', 'N', 1, 11, 5);

    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (cLcoupon_code, 11);

    COMMIT;    
  END CreateYSCNewShopperCoupon;

  PROCEDURE AddShopperToCouponUserGroup (
    cPshopper_id IN CHAR,
    cPcoupon_code IN VARCHAR2
  )
  AS
  BEGIN
    INSERT INTO ya_coupon_user
      (coupon_code, shopper_id, created_datetime)
    VALUES
      (cPcoupon_code, cPshopper_id, sysdate);
    COMMIT;
  END AddShopperToCouponUserGroup;

  PROCEDURE CreateHallmarkWelcomeCoupon (
    cPshopper_id IN CHAR,
    cPcoupon_code OUT VARCHAR2
  )
  AS
		iLcount INT;
  BEGIN
  /*
		-- Generate Coupon
		SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cPcoupon_code FROM dual;

		-- Make sure unique coupon code
		SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cPcoupon_code;
		WHILE (iLcount = 1)
			LOOP
					SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cPcoupon_code FROM dual;
					SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cPcoupon_code;
			END LOOP;

		-- Insert data into table

		INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date)
		VALUES
			(cPshopper_id, cPcoupon_code, 'RMB50', 'RMB50', 7.352, add_months(SYSDATE, 1), 'O', 'N', 1, 12, 73.52, 'frontend', SYSDATE);
	*/
	  INSERT INTO ya_hallmark_member_gift (id, shopper_id, created_date) VALUES (SEQ_YA_HALLMARK_MEMBER_GIFT.nextval, cPshopper_id, sysdate);

		RETURN;
  END CreateHallmarkWelcomeCoupon;

  PROCEDURE CreateNewShopperCoupon_woCode (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  )
  AS
		iLcount INT;
		iLcoupon_code VARCHAR2(8);
  BEGIN
		-- Generate Coupon
		SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		-- Make sure unique coupon code
		SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		WHILE (iLcount = 1)
			LOOP
					SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
					SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			END LOOP;

		-- Insert data into table

		INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date)
		VALUES
			(cPshopper_id, iLcoupon_code, 'YS New Customer Coupon 060711', 'YesStyle New Customer US$5 Coupon', 5, add_months(SYSDATE, 1), 'O', 'N', 1, 10, 5, 'frontend', SYSDATE);

    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iLcoupon_code, 10);
    
    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iLcoupon_code, 13);
    
		-- Retur Result
		OPEN curPresult FOR
	    SELECT iLcoupon_code as coupon_code FROM dual;

		COMMIT;
		RETURN;
  END CreateNewShopperCoupon_woCode;

  PROCEDURE GetShopperCoupon (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refCur
	)
  AS
  BEGIN
		OPEN curPresult FOR
		SELECT c.coupon_code, c.coupon_description, c.expiration_date, c.currency
		FROM ya_coupon c
		LEFT JOIN ya_coupon_user u ON c.coupon_code = u.coupon_code AND u.shopper_id = cPshopper_id
		INNER JOIN ya_coupon_site cs ON c.coupon_code = cs.coupon_code
		WHERE coupon_used <> 'Y'
		AND c.expiration_date >= SYSDATE
		AND (
			c.shopper_id = cPshopper_id
			OR
			(
				c.all_shoppers = 'G' 
				AND u.shopper_id is not null 
				AND NOT EXISTS (
					SELECT 1 FROM order_info o INNER JOIN billing_info b ON o.id = b.order_info_id WHERE b.coupon = u.coupon_code AND o.cust_id = cPshopper_id
				)
			)
		)
		AND cs.site_id = iPsite_id;
	END GetShopperCoupon;

	PROCEDURE CreateYSSurveyCoupon (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  )
  AS
		iLcount INT;
		iLcoupon_code VARCHAR2(13);
  BEGIN
		-- Generate Coupon
		SELECT 'YSPOLL_' || cast(dbms_random.string('U', 6) AS VARCHAR2(6)) INTO iLcoupon_code FROM dual;

		-- Make sure unique coupon code
		SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		WHILE (iLcount = 1)
			LOOP
					SELECT 'YSPOLL_' || cast(dbms_random.string('U', 6) AS VARCHAR2(6)) INTO iLcoupon_code FROM dual;
					SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			END LOOP;

		-- Insert data into table

		INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date)
		VALUES
			(cPshopper_id, iLcoupon_code, 'YesStyle.com Survey Coupon 2009', 'YesStyle.com Survey US$5 Coupon', 5, sysdate +30, 'N', 'N', 1, 10, 5, 'frontend', SYSDATE);

    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iLcoupon_code, 10);
    
    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iLcoupon_code, 13);

		-- Retur Result
		OPEN curPresult FOR
	    SELECT iLcoupon_code as coupon_code FROM dual;

		COMMIT;
		RETURN;
  END CreateYSSurveyCoupon;

  PROCEDURE CreateCouponForEmailRefer (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  )
  AS
		iLcount INT;
		iLcoupon_code VARCHAR2(8);
  BEGIN
		-- Generate Coupon
		SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		-- Make sure unique coupon code
		SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		WHILE (iLcount = 1)
			LOOP
					SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
					SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			END LOOP;

		 INSERT INTO ya_coupon
      (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers,
      coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
	  SELECT cPshopper_id, iLcoupon_code, 'YesStyle.com Referral', '2007 Referral $5 Coupon', 5, add_months(SYSDATE, 3), 'N', 'N', 1, 10, 5, 'ys_email_referral', SYSDATE	  	  
		FROM
		 dual;
		 
    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iLcoupon_code, 10);
    
    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iLcoupon_code, 13);
		 
		OPEN curPresult FOR
			SELECT iLcoupon_code as coupon_code FROM dual;
		COMMIT;
		RETURN;
  END CreateCouponForEmailRefer;

  PROCEDURE CreateHallmarkBirthdayCoupon (
    cPshopper_id IN CHAR
  )
  AS
		iLcount INT;
		iLcoupon_code VARCHAR2(8);
  BEGIN
    -- Generate Coupon
		SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		-- Make sure unique coupon code
		SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		WHILE (iLcount = 1)
			LOOP
					SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
					SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			END LOOP;

		INSERT INTO ya_coupon
      (shopper_id, coupon_code, campaign_name, coupon_description
      , percentage_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
	  SELECT cPshopper_id, iLcoupon_code, 'Birthday Coupon', '&#20061;&#20116;&#25240;&#29983;&#26085;&#20248;&#24800;&#21048;(&#21487;&#29992;&#20110;&#36141;&#20080;&#27491;&#20215;&#21450;&#29305;&#20215;&#20135;&#21697;&#65289;'
	    , 0.05, add_months(SYSDATE, 2), 'N', 'N', 2, 12, 0, 'hallmark_cron', SYSDATE
		FROM dual;
		
		INSERT INTO ya_coupon_site (coupon_code, site_id)
		VALUES (iLcoupon_code, 12);
	  COMMIT;

		RETURN;  
  END CreateHallmarkBirthdayCoupon;

END Pkg_FE_CouponAccess;
/
