CREATE OR REPLACE PACKAGE "PKG_FE_HALLMARKPROMOTIONCOUPON" AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE CreateHallmarkPromotionCoupon (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  );

  PROCEDURE CreateHmCouponForBug2921 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPfreeGiftSku IN INT,
    iPreturn OUT INT
  );

	PROCEDURE CreateHm50CouponForBug10604 (
		iMinPorderAmount IN INT,
		iMaxPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  );

	PROCEDURE CreateHm80CouponForBug10604 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  );
  
  PROCEDURE CreateCouponForBug15092 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  );
  
  PROCEDURE CreateCouponForBug20868 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  );

END PKG_FE_HALLMARKPROMOTIONCOUPON;
/


CREATE OR REPLACE PACKAGE BODY "PKG_FE_HALLMARKPROMOTIONCOUPON" AS

  PROCEDURE CreateHallmarkPromotionCoupon (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  )
  AS
	iLmaxCoupon INT;
	iLcouponCount INT;
	curLorderInfo refCur;
	iLorderInfoId INT;
	cLshopperId VARCHAR2(32);
	iLcoupon_code VARCHAR2(8);
	iLcount INT;
  BEGIN
  	OPEN curLorderInfo FOR
	  select oi.id, floor(sum(ol.unit_price * old.qnty)/iPorderAmount) as couponCount
		  from order_info oi, order_line ol, order_line_dtl old
		 where oi.origin_id = 12 and oi.category = 1
			   and oi.order_dt between iPorderStartDate and iPorderEndDate
			   and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
			   and ol.prod_id <> 1020665700
			   and oi.sts = 11
			   and old.sts < 8
		 group by oi.id
		having sum(ol.unit_price * old.qnty) >= iPorderAmount;

	FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	  WHILE curLorderInfo%FOUND LOOP
	    BEGIN
		  select cust_id into cLshopperId from order_info where id = iLorderInfoId;
		  -- Generate the number of coupon
		  FOR i in 1..iLcouponCount LOOP
		    -- Create coupon code
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		    -- Make sure unique coupon code
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		    WHILE (iLcount = 1)
			  LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			  END LOOP;

			INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value, expiration_date,
			all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date, currency)
	        SELECT cLshopperId, iLcoupon_code, 'RMB50 coupon with purchase RMB498 more 2013Oct', 'Hallmak Babies RMB50 E-shop Coupon', 50, add_months(SYSDATE, 2), 'N', 'N', 1, 12, 250, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;

		    INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (iLcoupon_code, 12);

          END LOOP;
		END;
	    FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
  END LOOP;
  	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;

  END CreateHallmarkPromotionCoupon;

  PROCEDURE CreateHmCouponForBug2921 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPfreeGiftSku IN INT,
    iPreturn OUT INT
  )
  AS

  iLmaxCoupon INT;
  iLcouponCount INT;
  curLorderInfo refCur;
  iLorderInfoId INT;
  cLshopperId VARCHAR2(32);
  iLcoupon_code VARCHAR2(8);
  iLcount INT;

  BEGIN
  	OPEN curLorderInfo FOR
    select * from
      (select oi.id, floor(sum(ol.unit_price * old.qnty)/iPorderAmount) as couponCount
        from order_info oi, order_line ol, order_line_dtl old
       where oi.origin_id = 12 and oi.category = 1
           and oi.order_dt between iPorderStartDate and iPorderEndDate
           and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
           and ol.prod_id <> 1020665700
           and oi.sts = 11
           and old.sts < 8
           and oi.id not in (select order_info_id from order_line where prod_id = iPfreeGiftSku)
       group by oi.id
      having sum(ol.unit_price * old.qnty) >= iPorderAmount)
    union
      (select oi.id, floor(sum(ol.unit_price * old.qnty)/iPorderAmount) - 1 as couponCount
        from order_info oi, order_line ol, order_line_dtl old
       where oi.origin_id = 12 and oi.category = 1
           and oi.order_dt between iPorderStartDate and iPorderEndDate
           and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
           and ol.prod_id <> 1020665700
           and oi.sts = 11
           and old.sts < 8
           and oi.id in (select order_info_id from order_line where prod_id = iPfreeGiftSku)
       group by oi.id
      having sum(ol.unit_price * old.qnty) >= iPorderAmount * 2);

	FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	  WHILE curLorderInfo%FOUND LOOP
	    BEGIN
		  select cust_id into cLshopperId from order_info where id = iLorderInfoId;
		  -- Generate the number of coupon
		  FOR i in 1..iLcouponCount LOOP
		    -- Create coupon code
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		    -- Make sure unique coupon code
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		    WHILE (iLcount = 1)
			  LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			  END LOOP;

			INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value, expiration_date,
			all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date, currency)
	        SELECT cLshopperId, iLcoupon_code, 'Get RMB50 coupon with purchase RMB549 more 2013', 'Hallmak Babies RMB50 E-shop Coupon', 50, add_months(SYSDATE, 2), 'N', 'N', 1, 12, 250, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;

		    INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (iLcoupon_code, 12);

          END LOOP;
		END;
	    FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
  END LOOP;
  	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;

  END CreateHmCouponForBug2921;

  PROCEDURE CreateHm50CouponForBug10604 (
		iMinPorderAmount IN INT,
		iMaxPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  )
  AS

  iLmaxCoupon INT;
  iLcouponCount INT;
  curLorderInfo refCur;
  iLorderInfoId INT;
  cLshopperId VARCHAR2(32);
  iLcoupon_code VARCHAR2(8);
  iLcount INT;

	BEGIN
  	OPEN curLorderInfo FOR
	  select oi.id, 1 as couponCount
		  from order_info oi, order_line ol, order_line_dtl old
		 where oi.origin_id = 12 and oi.category = 1
			   and oi.order_dt between iPorderStartDate and iPorderEndDate
			   and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
				 and ol.prod_id <> 1020665700
			   and oi.sts = 11
			   and old.sts < 8
		 group by oi.id
		having sum(ol.unit_price * old.qnty) >= iMinPorderAmount and sum(ol.unit_price * old.qnty) <= iMaxPorderAmount;

	FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	  WHILE curLorderInfo%FOUND LOOP
	    BEGIN
		  select cust_id into cLshopperId from order_info where id = iLorderInfoId;
		  -- Generate the number of coupon
		  FOR i in 1..iLcouponCount LOOP
		    -- Create coupon code
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		    -- Make sure unique coupon code
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		    WHILE (iLcount = 1)
			  LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			  END LOOP;

			INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value, expiration_date,
			all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date, currency)
	        SELECT cLshopperId, iLcoupon_code, 'RMB50 coupon with purchase RMB588 more 2013dec', 'Hallmak Babies RMB50 E-shop Coupon', 50, add_months(SYSDATE, 2), 'N', 'N', 1, 12, 250, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;

		    INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (iLcoupon_code, 12);

          END LOOP;
		END;
	    FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
  END LOOP;
  	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;

  END CreateHm50CouponForBug10604;

  PROCEDURE CreateHm80CouponForBug10604 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  )
	AS

	iLmaxCoupon INT;
  iLcouponCount INT;
  curLorderInfo refCur;
  iLorderInfoId INT;
  cLshopperId VARCHAR2(32);
  iLcoupon_code VARCHAR2(8);
  iLcount INT;

	BEGIN
  	OPEN curLorderInfo FOR
	  select oi.id, 1 as couponCount
		  from order_info oi, order_line ol, order_line_dtl old
		 where oi.origin_id = 12 and oi.category = 1
			   and oi.order_dt between iPorderStartDate and iPorderEndDate
			   and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
				 and ol.prod_id <> 1020665700
			   and oi.sts = 11
			   and old.sts < 8
		 group by oi.id
		having sum(ol.unit_price * old.qnty) >= iPorderAmount;

	FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	  WHILE curLorderInfo%FOUND LOOP
	    BEGIN
		  select cust_id into cLshopperId from order_info where id = iLorderInfoId;
		  -- Generate the number of coupon
		  FOR i in 1..iLcouponCount LOOP
		    -- Create coupon code
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		    -- Make sure unique coupon code
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		    WHILE (iLcount = 1)
			  LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			  END LOOP;

			INSERT INTO ya_coupon
			(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value, expiration_date,
			all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date, currency)
	        SELECT cLshopperId, iLcoupon_code, 'RMB80 coupon with purchase RMB788 more 2013dec', 'Hallmak Babies RMB80 E-shop Coupon', 80, add_months(SYSDATE, 2), 'N', 'N', 1, 12, 400, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;

		    INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (iLcoupon_code, 12);

          END LOOP;
		END;
	    FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
  END LOOP;
  	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;

  END CreateHm80CouponForBug10604;

  PROCEDURE CreateCouponForBug15092 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  )
  AS
	iLcouponCount INT;
	curLorderInfo refCur;
	iLorderInfoId INT;
	cLshopperId VARCHAR2(32);
	iLcoupon_code VARCHAR2(8);
	iLcount INT;
  BEGIN
  	OPEN curLorderInfo FOR
	  select oi.id, floor(sum(ol.unit_price * old.qnty)/iPorderAmount) as couponCount
		 from order_info oi, order_line ol, order_line_dtl old
		 where oi.origin_id = 12 and oi.category = 1
			and oi.order_dt between iPorderStartDate and iPorderEndDate
			and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
			and ol.prod_id <> 1020665700
			and oi.sts = 11
			and old.sts < 8
		 group by oi.id
		 having sum(ol.unit_price * old.qnty) >= iPorderAmount;

	FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	  WHILE curLorderInfo%FOUND LOOP
	    BEGIN
		  select cust_id into cLshopperId from order_info where id = iLorderInfoId;
		  -- Generate the number of coupon
		  FOR i in 1..iLcouponCount LOOP
		    -- Create coupon code
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		    -- Make sure unique coupon code
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		    WHILE (iLcount = 1) LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			END LOOP;

			INSERT INTO ya_coupon
			  (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value, expiration_date,
			  all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date, currency)
				SELECT cLshopperId, iLcoupon_code, 'RMB50 coupon with purchase RMB479 more 2014Jul', 'Hallmak Babies RMB50 E-shop Coupon', 50, add_months(SYSDATE, 2), 'N', 'N', 1, 12, 250, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;

		    INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (iLcoupon_code, 12);
			-- Set constraint
			INSERT INTO ya_coupon_constraint (coupon_code, constraint_type, constraint_value, created_datetime) values (iLcoupon_code, 11, 86059, sysdate);

          END LOOP;
		END;
	    FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	 END LOOP;
  	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;

  END CreateCouponForBug15092;

  PROCEDURE CreateCouponForBug20868 (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  )
  AS
	iLcouponCount INT;
	curLorderInfo refCur;
	iLorderInfoId INT;
	cLshopperId VARCHAR2(32);
	iLcoupon_code VARCHAR2(8);
	iLcount INT;
  BEGIN
  	OPEN curLorderInfo FOR
	  select oi.id, floor(sum(ol.unit_price * old.qnty)/iPorderAmount) as couponCount
		 from order_info oi, order_line ol, order_line_dtl old
		 where oi.origin_id = 12 and oi.category = 1
			and oi.order_dt between iPorderStartDate and iPorderEndDate
			and oi.id = ol.order_info_id and ol.id = old.order_line_id and oi.id = old.order_info_id
			and ol.prod_id <> 1020665700
			and oi.sts = 11
			and old.sts < 8
		 group by oi.id
		 having sum(ol.unit_price * old.qnty) >= iPorderAmount;

	FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	  WHILE curLorderInfo%FOUND LOOP
	    BEGIN
		  select cust_id into cLshopperId from order_info where id = iLorderInfoId;
		  -- Generate the number of coupon
		  FOR i in 1..iLcouponCount LOOP
		    -- Create coupon code
		    SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;

		    -- Make sure unique coupon code
		    SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
		    WHILE (iLcount = 1) LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO iLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = iLcoupon_code;
			END LOOP;

			INSERT INTO ya_coupon
			  (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value, expiration_date,
			  all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date, currency)
				SELECT cLshopperId, iLcoupon_code, 'RMB50 coupon with purchase RMB538 more 2015Feb', 'Hallmak Babies RMB50 E-shop Coupon', 50, TO_DATE('2015-04-20T23:59:59Z',  'YYYY-MM-DD"T"HH24:MI:SS"Z"'), 'N', 'N', 1, 12, 450, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;

		    INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (iLcoupon_code, 12);
			-- Set constraint
			INSERT INTO ya_coupon_constraint (coupon_code, constraint_type, constraint_value, created_datetime) values (iLcoupon_code, 11, 85743, sysdate);

          END LOOP;
		END;
	    FETCH curLorderInfo INTO iLorderInfoId, iLcouponCount;
	 END LOOP;
  	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;

  END CreateCouponForBug20868;
  
END PKG_FE_HALLMARKPROMOTIONCOUPON;
/
