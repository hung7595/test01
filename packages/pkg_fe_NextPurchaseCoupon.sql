CREATE OR REPLACE PACKAGE Pkg_FE_NextPurchaseCoupon
AS

  PROCEDURE CreateYsukPayPalNPCoupon (
	iPorderInfoId IN INT,
	iPreturn OUT INT
  );
  
  PROCEDURE CreateNextPurchaseCoupon (
	cPshopper_id IN CHAR,
	iPorder_id IN INT,
	iPsiteId IN INT,
    iPreturn OUT INT
  );
  
  END Pkg_FE_NextPurchaseCoupon;
/

create or replace
PACKAGE BODY Pkg_FE_NextPurchaseCoupon
IS

PROCEDURE CreateYsukPayPalNPCoupon (
	iPorderInfoId IN INT,
	iPreturn OUT INT
  )
  AS
	iLcount INT;
	iLcountCouponCode INT;
	cLshopperId VARCHAR2(100);
	cLcoupon_code VARCHAR2(8);
	iLfrontendOrderNum INT;
	cLCouponDescription VARCHAR2(150);
	
  BEGIN
  select cust_id into cLshopperId from order_info where id = iPorderInfoId;
  select count(n.coupon_code) into iLcountCouponCode from ya_next_purchase_coupon n, order_info o where o.cust_id = cLshopperId and n.order_id = o.id and n.type =2;
	IF (iLcountCouponCode > 0) THEN
	    iPreturn := 0;
	    RETURN;
	END IF;
	
	select cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;
	select count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
		WHILE (iLcount = 1)
			LOOP
				SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
			END LOOP;
			
	select origin_order_id into iLfrontendOrderNum from order_info where id = iPorderInfoId;
	cLCouponDescription := 'YesStyle.co.uk GBP20 Next Purchase Coupon (OrderNum:' || iLfrontendOrderNum || ')';
	select cust_id into cLshopperId from order_info where id = iPorderInfoId;
			
	insert into ya_coupon (coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger, expiration_date, SHOPPER_ID, COUPON_TYPE_ID, SITE_ID, CREATE_ID, CREATE_DATE, CURRENCY)
	values (cLcoupon_code, 'YSUK PayPal next purchase coupon', cLCouponDescription, 20, 80, add_months(SYSDATE, 3), cLshopperId, 1, 15, 'next_purchase', SYSDATE, 'GBP');
	
	INSERT INTO ya_coupon_site (coupon_code, site_id)
	VALUES (cLcoupon_code, 15);
	
	INSERT INTO ya_next_purchase_coupon (coupon_code, order_id, type)
	VALUES (cLcoupon_code, iPorderInfoId, 2);
	
	IF sqlcode = 0 THEN
	  iPreturn := 1;
      COMMIT;
    ELSE
	  iPreturn := 0;
      ROLLBACK;
    END IF;
	
  END CreateYsukPayPalNPCoupon;

PROCEDURE CreateNextPurchaseCoupon (
	cPshopper_id IN CHAR,
	iPorder_id IN INT,
	iPsiteId IN INT,
    iPreturn OUT INT
  )
  AS
    iLcount INT;
    iLcountOrder INT;
	  cLcoupon_code_YA VARCHAR2(8);
	  cLcoupon_code_YS VARCHAR2(8);
	  cLyaCampaignName VARCHAR2(50);
	  cLysCampaignName VARCHAR2(50);
	  cLyaCouponDescription VARCHAR2(80);
	  cLysCouponDescription VARCHAR2(80);
	  cLfrontendOrderNum INT;
  BEGIN
	-- To check coupons created before
	SELECT COUNT(*) INTO iLcountOrder FROM ya_next_purchase_coupon WHERE order_id = iPorder_id;
	IF iLcountOrder = 0 THEN
		IF iPsiteId <=7 THEN
			CASE iPsiteId
			WHEN 1 THEN -- US
				cLyaCampaignName := 'next purchase coupon';
			WHEN 7 THEN -- GB
				cLyaCampaignName := 'next purchase coupon';
			ELSE
				cLyaCampaignName := 'next purchase coupon';
			END CASE;

			SELECT ORIGIN_ORDER_ID INTO cLfrontendOrderNum FROM order_info WHERE id= iPorder_id;
			cLysCampaignName := 'next purchase coupon';
			cLyaCouponDescription := 'YesAsia.com US$5 Next Purchase Coupon (OrderNum:' || cLfrontendOrderNum  || ')';
			cLysCouponDescription := 'YesStyle.com US$5 Next Purchase Coupon (OrderNum:' || cLfrontendOrderNum || ')';

			--============================ Generate Coupon_YA=========================================
			SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YA FROM dual;

			-- Make sure unique coupon code
			SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YA;
			WHILE (iLcount = 1)
				LOOP
						SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YA FROM dual;
						SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YA;
				END LOOP;
			--============================ Generate Coupon_YS=========================================
			SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YS FROM dual;

			-- Make sure unique coupon code
			SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YS;
			WHILE (iLcount = 1)
				LOOP
						SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YS FROM dual;
						SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YS;
				END LOOP;
			--============================ Create YA coupon=========================================
			INSERT INTO ya_coupon
				(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers,
		  coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
				SELECT cPshopper_id, cLcoupon_code_YA, cLyaCampaignName, cLyaCouponDescription, 5, add_months(SYSDATE, 2), 'N', 'N', 1, 99, NULL, 'next_purchase', SYSDATE
			FROM dual;
			
			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YA, 1);

			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YA, 7);

			--============================ Create YS coupon=========================================
			INSERT INTO ya_coupon
				(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers,
		  coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
				SELECT cPshopper_id, cLcoupon_code_YS, cLysCampaignName, cLysCouponDescription, 5, add_months(SYSDATE, 2), 'N', 'N', 1, 10, NULL, 'next_purchase', SYSDATE
			FROM dual;

			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YS, 10);

			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YS, 13);
			
			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YS, 14);

			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YS, 15);
			
			INSERT INTO ya_coupon_site (coupon_code, site_id)
			VALUES (cLcoupon_code_YS, 18);

			--============================ Keep record for sending email===============================
			INSERT INTO ya_next_purchase_coupon (coupon_code, order_id, type)
				VALUES (cLcoupon_code_YS, iPorder_id, 1);
			INSERT INTO ya_next_purchase_coupon (coupon_code, order_id, type)
				VALUES (cLcoupon_code_YA, iPorder_id, 1);

			SELECT count(*) INTO iPreturn FROM ya_coupon WHERE coupon_code = cLcoupon_code_YS OR coupon_code = cLcoupon_code_YA;
		ELSE
			SELECT 0 INTO iPreturn FROM dual;
		END IF;
	ELSE
		SELECT 0 INTO iPreturn FROM dual;
	END IF;
	COMMIT;
	EXCEPTION WHEN OTHERS THEN
		ROLLBACK;
  END CreateNextPurchaseCoupon;


END Pkg_FE_NextPurchaseCoupon;
/