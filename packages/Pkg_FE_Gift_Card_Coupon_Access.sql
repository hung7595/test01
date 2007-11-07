--========================Pkg_FE_GiftCardCoupon======================================
-- gift card promotion 
--1. generate a email in hksql and then import into a table 'temp_gift_card_email_list'
--2.create a unique coupon for selected user

--CREATE TABLE temp_gift_card_email_list
--(email VARCHAR2(255))
--==========================================================================================
CREATE OR REPLACE PACKAGE Pkg_FE_GiftCardCoupon
AS
  TYPE refCur IS REF CURSOR;
  PROCEDURE CreateGiftCardCoupon (
	cursor_shopper out refCur
  );  
  END Pkg_FE_GiftCardCoupon;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_GiftCardCoupon
IS
PROCEDURE CreateGiftCardCoupon (
	cursor_shopper out refCur
  )
  AS
    iLcount INT;
	cLcoupon_code_YS VARCHAR2(8);
	cshopper_id VARCHAR(255);	
	exdate date;
  BEGIN
		select to_date('2007/12/02', 'yyyy/mm/dd') into exdate from dual;
		open cursor_shopper for
		    SELECT distinct shopper_id from ya_shopper s, temp_gift_card_email_list t where s.email=t.email;

		fetch cursor_shopper into cshopper_id;
		WHILE (cursor_shopper%FOUND) loop
		BEGIN			
			--============================ Generate Coupon_YS=========================================
			SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YS FROM dual;

			-- Make sure unique coupon code
			SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YS;
			WHILE (iLcount = 1)
				LOOP
					SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YS FROM dual;
					SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YS;
				END LOOP;
			--============================ Create YS coupon=========================================
			INSERT INTO ya_coupon
				(shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
			SELECT cshopper_id, cLcoupon_code_YS, 'Gift Card Promotion', 'Holiday gift shopping $5 gift coupon', 5, exdate, 'N', 'N', 1, 10, 30, 'Gift Card Promotion', SYSDATE
			FROM dual;
		fetch cursor_shopper into cshopper_id;
		END;
		end loop;
	COMMIT;
	EXCEPTION WHEN OTHERS THEN
		ROLLBACK;
	RETURN;
  END CreateGiftCardCoupon;

END Pkg_FE_GiftCardCoupon;
/