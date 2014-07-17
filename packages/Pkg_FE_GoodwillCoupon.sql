CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_GOODWILLCOUPON"
AS
  PROCEDURE CreateGoodwillCoupon (
	  iPorderInfoId IN INT,
	  nPcouponAmt IN NUMBER,
	  cPcouponCode OUT VARCHAR2
  );
END Pkg_FE_GoodwillCoupon;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_GOODWILLCOUPON"
IS
  /*
    generate goodwill coupon
    ref: http://hk-system-s01/content_bugzilla/show_bug.cgi?id=14768
  */
  PROCEDURE CreateGoodwillCoupon (
	  iPorderInfoId IN INT,
	  nPcouponAmt IN NUMBER,
	  cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
    cLcurrency CHAR(3);
    cLorderNum VARCHAR2(150);
    cLshopperId CHAR(32);
    cLcampaignName VARCHAR2(50);
    cLdescription VARCHAR2(255);
    nLtrigger INT;
    dtLexpire DATE;
    cLallShoppers CHAR(1);
    cLused CHAR(1);
    iLtype INT;
    cLcreateUser VARCHAR2(50);
    dtLcreateDate DATE;
    iLaccountType INT;
    iLcountCount INT;
    cLcodePrefix VARCHAR2(200);
  BEGIN
    /*
      preload coupon setting from order
    */
    SELECT origin_id, currency, origin_order_id, cust_id INTO iLsiteId, cLcurrency, cLorderNum, cLshopperId
    FROM order_info oi
      INNER JOIN billing_info bi ON oi.id = bi.order_info_id
    WHERE oi.id = iPorderInfoId;

    /*
      coupon setting
    */
    cLcreateUser := 'Backend Goodwill';
    dtLcreateDate := SYSDATE;
    cLcampaignName := 'HKCS Goodwill';
    cLdescription := 'Goodwill coupon';
    nLtrigger := 0;
    dtLexpire := add_months(dtLcreateDate, 2);
    cLallShoppers := 'N';
    cLused := 'N';
    iLtype := 1;
    iLaccountType := 0;
    
    /*
      generate coupon code
    */
    cLcodePrefix := 'GW' || cLorderNum;
    SELECT COUNT(1) INTO iLcountCount FROM ya_coupon WHERE coupon_code like (cLcodePrefix || '%');
    SELECT cLcodePrefix || '_' || CAST(iLcountCount + 1 as VARCHAR2(2)) INTO cPcouponCode FROM dual;

    /*
      create coupon
    */
		INSERT INTO ya_coupon	(coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
		                      , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
		                      , site_id, create_id, create_date, currency, account_type_id)
		               VALUES (cPcouponCode, cLcampaignName, cLdescription, nPcouponAmt, nLtrigger
		                      , dtLexpire, cLshopperId, cLallShoppers, cLused, iLtype
		                      , iLsiteId, cLcreateUser, dtLcreateDate, cLcurrency, iLaccountType);	

		INSERT INTO ya_coupon_site (coupon_code, site_id)
		                    VALUES (cPcouponCode, iLsiteId);
		COMMIT;
  END CreateGoodwillCoupon;
END Pkg_FE_GoodwillCoupon;
/