CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_ORDEROOSCOUPON"
AS
  PROCEDURE CreateOrderOosCoupon (
	  iPorderInfoId IN INT,
	  cPcouponCode OUT VARCHAR2
  );
END Pkg_FE_OrderOosCoupon;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_ORDEROOSCOUPON"
IS
  /*
    generate backend order oos coupon
    ref: http://hk-system-s01/content_bugzilla/show_bug.cgi?id=14700
    ref: http://hk-system-s01/content_bugzilla/show_bug.cgi?id=21874
  */
  PROCEDURE CreateOrderOosCoupon (
	  iPorderInfoId IN INT,
	  cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
    cLcurrency CHAR(3);
    cLorderNum VARCHAR2(150);
    cLshopperId CHAR(32);
    cLcampaignName VARCHAR2(50);
    cLdescription VARCHAR2(255);
    nLcouponAmt INT;
    nLtrigger INT;
    dtLexpire DATE;
    cLallShoppers CHAR(1);
    cLused CHAR(1);
    iLtype INT;
    cLcreateUser VARCHAR2(50);
    dtLcreateDate DATE;
    iLaccountType INT;
    iLcountCount INT;
    cLcodePrefix VARCHAR2(15);
    iLcount INT;
  BEGIN
    /*
      preload coupon setting from order
    */
    SELECT origin_id, origin_order_id, cust_id INTO iLsiteId, cLorderNum, cLshopperId
    FROM order_info oi
      INNER JOIN billing_info bi ON oi.id = bi.order_info_id
    WHERE oi.id = iPorderInfoId;

    CASE iLsiteId
      WHEN 10 THEN  --YSGB 
        nLcouponAmt := 5;
        nLtrigger := 50;
        cLcurrency := 'USD';
      WHEN 13 THEN  --YSAU 
        nLcouponAmt := 5;
        nLtrigger := 50;
        cLcurrency := 'AUD';
      WHEN 14 THEN  --YSHK 
        nLcouponAmt := 30;
        nLtrigger := 300;
        cLcurrency := 'HKD';
      WHEN 15 THEN  --YSUK 
        nLcouponAmt := 3;
        nLtrigger := 30;
        cLcurrency := 'GBP';
      WHEN 18 THEN  --YSCA 
        nLcouponAmt := 5;
        nLtrigger := 50;
        cLcurrency := 'CAD';
    END CASE;

    /*
      coupon setting
    */
    cLcreateUser := 'Backend OOS';
    dtLcreateDate := SYSDATE;
    cLcampaignName := 'HKCS Compensation';
    cLdescription := 'Goodwill coupon OOS items';
    dtLexpire := add_months(dtLcreateDate, 2);
    cLallShoppers := 'N';
    cLused := 'N';
    iLtype := 1;
    iLaccountType := 0;
    
    /*
      generate coupon code
    */
    SELECT cLorderNum || 'OOSCPN' INTO cPcouponCode FROM dual;
    
    SELECT COUNT(1) into iLcount FROM ya_coupon WHERE coupon_code = cPcouponCode;   
    IF (iLcount > 0) THEN
    BEGIN
      RETURN;
    END;
    END IF;

    /*
      create coupon
    */
		INSERT INTO ya_coupon	(coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
		                      , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
		                      , site_id, create_id, create_date, currency, account_type_id)
		               VALUES (cPcouponCode, cLcampaignName, cLdescription, nLcouponAmt, nLtrigger
		                      , dtLexpire, cLshopperId, cLallShoppers, cLused, iLtype
		                      , iLsiteId, cLcreateUser, dtLcreateDate, cLcurrency, iLaccountType);	

		INSERT INTO ya_coupon_site (coupon_code, site_id)
		                    VALUES (cPcouponCode, iLsiteId);
		COMMIT;
  END CreateOrderOosCoupon;
END Pkg_FE_OrderOosCoupon;
/