CREATE OR REPLACE PACKAGE Pkg_Fe_EliteClubCoupon
AS
  PROCEDURE CreateMembershipUpgradeCoupon
  (
	cPshopperId IN VARCHAR2,
	cPmembershipName IN VARCHAR2,
	iPmembershipExpiryDate IN DATE,
	cPreturn OUT INT
  );
  
END Pkg_Fe_EliteClubCoupon;
/

CREATE OR REPLACE PACKAGE body Pkg_Fe_EliteClubCoupon
IS
  PROCEDURE CreateMembershipUpgradeCoupon
  (
	cPshopperId IN VARCHAR2,
    cPmembershipName IN VARCHAR2,
	iPmembershipExpiryDate IN DATE,
	cPreturn OUT INT
  )
  AS
	iLnumOfCouponCreate INT;
	cPmembershipYear VARCHAR2(4);
	cLcouponCode VARCHAR2(16);
	iLcount INT;
	cLcouponDescription VARCHAR2(255);
	cLcampaignName VARCHAR2(50);
	
  BEGIN
	IF cPmembershipName = 'Bronze' THEN
		iLnumOfCouponCreate := 1;
	ELSIF cPmembershipName = 'Silver' THEN
		iLnumOfCouponCreate := 2;
	ELSIF cPmembershipName = 'Gold' THEN
		iLnumOfCouponCreate := 4;
	ELSE
		cPreturn := 0;
		RETURN;
	END IF;
	
	select to_char(iPmembershipExpiryDate, 'YYYY') into cPmembershipYear from dual;
	
	cLcouponDescription := 'Elite Coupon - ' || cPmembershipName || ' Member ' || cPmembershipYear;
	cLcampaignName := 'Elite Club ' || cPmembershipName || ' ' || cPmembershipYear;
	
	-- Generate the number of coupon
	FOR i in 1..iLnumOfCouponCreate LOOP
		-- Create coupon code
		SELECT cast(dbms_random.string('U', 16) AS VARCHAR2(16)) INTO cLcouponCode FROM dual;
		
		-- Make sure unique coupon code
		SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcouponCode;
		
		WHILE (iLcount = 1)
			LOOP
				SELECT cast(dbms_random.string('U', 16) AS VARCHAR2(16)) INTO cLcouponCode FROM dual;
				SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcouponCode;
			END LOOP;
			
		INSERT INTO ya_coupon
		(coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger, expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id, site_id, create_id, create_date, currency)
		VALUES (cLcouponCode, cLcampaignName, cLcouponDescription, 10, 80, iPmembershipExpiryDate, cPshopperId, 'N', 'N', 1, 10, 'Backend elite club upgrade coupon', sysdate, 'USD') ;
		
		INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 10);
		INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 13);
		INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 14);
		INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 15);
		INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 18);
	END LOOP;
	
	IF sqlcode = 0 THEN
	  cPreturn := 1;
    ELSE
	  cPreturn := 0;
    END IF;
  
  END CreateMembershipUpgradeCoupon;
END Pkg_Fe_EliteClubCoupon;
/

