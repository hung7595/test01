--========================fe_create_nextpurchasecoupon======================================
-- input site id cannot be 10 YesStyle
-- Output iPreturn must be 2 = insert 2 coupons in ya_coupon
-- One coupon for YA, One coupon for YS
--==========================================================================================
CREATE OR REPLACE PACKAGE Pkg_FE_NextPurchaseCoupon
AS
  
  PROCEDURE CreateNextPurchaseCoupon (
	cPshopper_id IN CHAR,
	iPorder_id IN INT,
	iPsiteId IN INT,
    iPreturn OUT INT
  );
  
  END Pkg_FE_NextPurchaseCoupon;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_NextPurchaseCoupon
IS

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
				cLyaCampaignName := 'YA + YS US$5 Coupon Campaign 2007 (US Site)';
			WHEN 7 THEN -- GB
				cLyaCampaignName := 'YA + YS US$5 Coupon Campaign 2007 (GB Site)';
			ELSE
				cLyaCampaignName := 'YA + YS US$5 Coupon Campaign 2007';
			END CASE;
			
			SELECT ORIGIN_ORDER_ID INTO cLfrontendOrderNum FROM order_info WHERE id= iPorder_id;
			cLysCampaignName := 'YA + YS US$5 Coupon Campaign 2007 (YS Site)';
			cLyaCouponDescription := '(YA) YesAsia.com US$5 Next Purchase Coupon (OrderNum:' || cLfrontendOrderNum  || ')';
			cLysCouponDescription := '(YS) YesStyle.com US$5 Next Purchase Coupon (OrderNum:' || cLfrontendOrderNum || ')';
				
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
				SELECT cPshopper_id, cLcoupon_code_YA, cLyaCampaignName, cLyaCouponDescription, 5, add_months(SYSDATE, 2), 'N', 'N', 1, iPsiteId, NULL, 'next_purchase', SYSDATE
			FROM dual;
			--============================ Create YS coupon=========================================
			INSERT INTO ya_coupon
				(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers,
		  coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
				SELECT cPshopper_id, cLcoupon_code_YS, cLysCampaignName, cLysCouponDescription, 5, add_months(SYSDATE, 2), 'N', 'N', 1, 10, NULL, 'next_purchase', SYSDATE
			FROM dual;
			--============================ Keep record for sending email===============================
			INSERT INTO ya_next_purchase_coupon (coupon_code, order_id) 
				VALUES (cLcoupon_code_YS, iPorder_id);
			INSERT INTO ya_next_purchase_coupon (coupon_code, order_id) 
				VALUES (cLcoupon_code_YA, iPorder_id);
				
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