CREATE OR REPLACE PACKAGE Pkg_Fe_EliteClubCoupon
AS

  PROCEDURE CreateMembershipCoupon
  (
    cPshopperId IN VARCHAR2,
    cPmembershipName IN VARCHAR2,
    cPmembershipYear IN VARCHAR2,
    nPcouponAmt IN NUMBER,
    nPorderAmountTrigger IN NUMBER,
    iPcouponEndDate IN DATE,
    cLmembershipUpgrade IN CHAR,  
    cPreturn OUT INT
  );
  
END Pkg_Fe_EliteClubCoupon;
/

CREATE OR REPLACE PACKAGE body Pkg_Fe_EliteClubCoupon
IS  
  PROCEDURE CreateMembershipCoupon
  (
    cPshopperId IN VARCHAR2,
    cPmembershipName IN VARCHAR2,
    cPmembershipYear IN VARCHAR2,
    nPcouponAmt IN NUMBER,
    nPorderAmountTrigger IN NUMBER,
    iPcouponEndDate IN DATE,
    cLmembershipUpgrade IN CHAR, 
    cPreturn OUT INT
  )
  AS
    cLcouponCode VARCHAR2(16);
    iLcount INT;
    cLcouponDescription VARCHAR2(255);
    cLcampaignName VARCHAR2(50);
  BEGIN
      
    IF upper(cLmembershipUpgrade) = 'Y' THEN 
    
      -- Set coupon name and description
        cLcouponDescription := 'Elite ' || cPmembershipYear || ' Coupon - ' || cPmembershipName || ' US' || nPcouponAmt;
        cLcampaignName := 'Elite Club ' || cPmembershipName || ' Upgrade ' || cPmembershipYear ;
      
        -- Generate the number of $10 coupon
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
        VALUES (cLcouponCode, cLcampaignName, cLcouponDescription, nPcouponAmt, nPorderAmountTrigger, iPcouponEndDate, cPshopperId, 'N', 'N', 1, 10, 'Backend elite club upgrade coupon', sysdate, 'USD') ;
        
        INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 10);
        IF sqlcode = 0 THEN
          cPreturn := 1;
        ELSE
          cPreturn := 0;
        END IF;
        
        RETURN;
        
    ELSIF upper(cLmembershipUpgrade) = 'N' THEN
        -- Set one off Coupon

        cLcouponDescription := 'Elite ' || cPmembershipYear || ' One Off Coupon - ' || cPmembershipName || ' US' || nPcouponAmt;
        cLcampaignName := 'Elite Club ' || cPmembershipName || ' One Off ' || cPmembershipYear ;
  
        -- Create One Off coupon code
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
        VALUES (cLcouponCode, cLcampaignName, cLcouponDescription, nPcouponAmt, nPorderAmountTrigger, iPcouponEndDate, cPshopperId, 'N', 'N', 1, 10, 'Backend elite club upgrade coupon', sysdate, 'USD') ;
        
        INSERT INTO ya_coupon_site (coupon_code, site_id) VALUES (cLcouponCode, 10);
        
        IF sqlcode = 0 THEN
          cPreturn := 1;
        ELSE
          cPreturn := 0;
        END IF;
        
        RETURN;
    ELSE
        cPreturn := 0;
        RETURN;
    END IF;
    
  END CreateMembershipCoupon;
    
END Pkg_Fe_EliteClubCoupon;
/
