create or replace
PACKAGE PKG_FE_HALLMARKPROMOTIONCOUPON AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE CreateHallmarkPromotionCoupon (
    iPorderAmount IN INT,
    iPorderStartDate IN DATE,
    iPorderEndDate IN DATE,
    iPreturn OUT INT
  );

END PKG_FE_HALLMARKPROMOTIONCOUPON;
/

create or replace
PACKAGE BODY PKG_FE_HALLMARKPROMOTIONCOUPON AS

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
	  select oi.id, round(sum(ol.unit_price * old.qnty)/iPorderAmount, 0) as couponCount
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
	        SELECT cLshopperId, iLcoupon_code, 'Get RMB50 E-shop coupon with purchase of RMB488 or more', 'Hallmak Babies RMB50 E-shop Coupon', 50, add_months(SYSDATE, 2), 'N', 'N', 1, 12, 250, 'hallmark_promotion', SYSDATE, 'RMB' FROM dual;
			
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

END PKG_FE_HALLMARKPROMOTIONCOUPON;
/
