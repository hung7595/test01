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
        TYPE shopperTab IS TABLE OF VARCHAR(255) INDEX BY BINARY_INTEGER; 
        aShopper shopperTab;
        TYPE couponTab IS TABLE OF VARCHAR2(8) INDEX BY BINARY_INTEGER; 
        aCoupon couponTab;
        coupon_index BINARY_INTEGER;       
  BEGIN
		select to_date('2007/12/26', 'yyyy/mm/dd') into exdate from dual;
                /*
		open cursor_shopper for
		    SELECT shopper_id from ya_shopper s, temp_gift_card_email_list t where s.email=t.email;
                
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
			SELECT cshopper_id, cLcoupon_code_YS, 'YS Gift eDM ', 'YS Gift eDM  $5 gift coupon', 5, exdate, 'N', 'N', 1, 10, 30, 'YS Gift eDM', SYSDATE
			FROM dual;
                        --DBMS_OUTPUT.PUT_LINE( cshopper_id || ',' || cemail || ',' || cLcoupon_code_YS );
		fetch cursor_shopper into cshopper_id;
		END;
		end loop;
                */
                SELECT shopper_id, '' bulk collect into aShopper, aCoupon from ya_shopper s, temp_gift_card_email_list t where s.email=t.email;

                coupon_index := aCoupon.first;
                LOOP
                        --============================ Generate Coupon_YS=========================================
			-- Make sure unique coupon code
                        LOOP
                                SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLcoupon_code_YS FROM dual;
                                aCoupon(coupon_index) := cLcoupon_code_YS;
                                SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code_YS;
                                EXIT WHEN iLcount != 1;
                        END LOOP;
                        exit when coupon_index = aCoupon.last;
                        coupon_index := aCoupon.next(coupon_index);
                END LOOP;
                        
			--============================ Create YS coupon=========================================
                forall i in 1 .. aShopper.count
                  INSERT INTO ya_coupon (shopper_id, coupon_code, campaign_name, coupon_description, dollar_coupon_value,expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, CREATE_DATE)
                  SELECT aShopper(i), aCoupon(i), 'YesStyle.com X''mas''07 eDM', 'YesStyle.com X''mas''07 $5 coupon', 5, exdate, 'N', 'N', 1, 10, 30, 'YS eDM', SYSDATE
                  FROM dual;
	COMMIT;
        --DBMS_OUTPUT.PUT_LINE( 'Process commit.' );
	EXCEPTION WHEN OTHERS THEN
		ROLLBACK;
	RETURN;
  END CreateGiftCardCoupon;

END Pkg_FE_GiftCardCoupon;
/

