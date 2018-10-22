CREATE OR REPLACE PACKAGE PKG_FE_GOODWILLCOUPON
AS
  PROCEDURE CreateGoodwillCoupon (
    iPorderInfoId IN INT,
    nPcouponAmt IN NUMBER,
    cPcouponCode OUT VARCHAR2
  );
  
  PROCEDURE CreateGoodwillCouponCurrency (
      iPorderInfoId IN INT,
      nPcouponAmt IN NUMBER,
      cLcurrency IN VARCHAR2,
      cPcouponCode OUT VARCHAR2
  );

  PROCEDURE CreateGoodwillCouponByOrderNum (
      iPorderNum IN INT,
      nPcouponAmt IN NUMBER,
      cPcurrency IN VARCHAR2,
      cPcouponCode OUT VARCHAR2
  );
  
  PROCEDURE CreateGWCouponByOrderNumNExpDt (
      iPorderNum IN INT,
      nPcouponAmt IN NUMBER,
      cPcurrency IN VARCHAR2,
      dtPexpireDate IN Date,
      cPcouponCode OUT VARCHAR2
  );
  
  PROCEDURE CreateInferiorGoodwillCoupon (
      iPorderNum IN INT,
      nPcouponAmt IN NUMBER,
      nPorderAmountTrigger IN NUMBER,
      cPcurrency IN VARCHAR2,
      cPcommit IN CHAR DEFAULT 'N',
      cPcouponCode OUT VARCHAR2
  );

  PROCEDURE CreateAbwFirstPurchaseCoupon (
      cPshopperId IN VARCHAR2,
      nPcouponDiscountAmt IN NUMBER,
      dtPexpireDate IN Date,
      cPcouponCode OUT VARCHAR2
  );
  
END PKG_FE_GOODWILLCOUPON;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_GOODWILLCOUPON
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
    cLcodePrefix VARCHAR2(15);
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
    dtLexpire := add_months(dtLcreateDate, 3);
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
    INSERT INTO ya_coupon (coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
                          , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
                          , site_id, create_id, create_date, currency, account_type_id)
                   VALUES (cPcouponCode, cLcampaignName, cLdescription, nPcouponAmt, nLtrigger
                          , dtLexpire, cLshopperId, cLallShoppers, cLused, iLtype
                          , iLsiteId, cLcreateUser, dtLcreateDate, cLcurrency, iLaccountType);  

    INSERT INTO ya_coupon_site (coupon_code, site_id)
                        VALUES (cPcouponCode, iLsiteId);
    COMMIT;
  END CreateGoodwillCoupon;
  
  PROCEDURE CreateGoodwillCouponCurrency (
      iPorderInfoId IN INT,
      nPcouponAmt IN NUMBER,
      cLcurrency VARCHAR2,
      cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
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
    cLcodePrefix VARCHAR2(15);
  BEGIN
    /*
      preload coupon setting from order
    */
    SELECT origin_id, origin_order_id, cust_id INTO iLsiteId, cLorderNum, cLshopperId
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
    dtLexpire := add_months(dtLcreateDate, 3);
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
        INSERT INTO ya_coupon   (coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
                              , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
                              , site_id, create_id, create_date, currency, account_type_id)
                       VALUES (cPcouponCode, cLcampaignName, cLdescription, nPcouponAmt, nLtrigger
                              , dtLexpire, cLshopperId, cLallShoppers, cLused, iLtype
                              , iLsiteId, cLcreateUser, dtLcreateDate, cLcurrency, iLaccountType);  

        INSERT INTO ya_coupon_site (coupon_code, site_id)
                            VALUES (cPcouponCode, iLsiteId);
        COMMIT;
  END CreateGoodwillCouponCurrency;

  PROCEDURE CreateGoodwillCouponByOrderNum (
      iPorderNum IN INT,
      nPcouponAmt IN NUMBER,
      cPcurrency VARCHAR2,
      cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
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
    cLcodePrefix VARCHAR2(15);
  BEGIN
    /*
      preload coupon setting from order
    */
    SELECT origin_id, cust_id INTO iLsiteId, cLshopperId
    FROM order_info oi
      INNER JOIN billing_info bi ON oi.id = bi.order_info_id
    WHERE oi.origin_order_id = CAST(iPorderNum as VARCHAR2(10))
      AND ROWNUM = 1;

    /*
      coupon setting
    */
    cLcreateUser := 'Backend Goodwill';
    dtLcreateDate := SYSDATE;
    cLcampaignName := 'HKCS Goodwill';
    cLdescription := 'Goodwill coupon';
    nLtrigger := 0;
    dtLexpire := add_months(dtLcreateDate, 3);
    cLallShoppers := 'N';
    cLused := 'N';
    iLtype := 1;
    iLaccountType := 0;
    
    /*
      generate coupon code
    */
    cLcodePrefix := 'GW' || iPorderNum;
    SELECT COUNT(1) INTO iLcountCount FROM ya_coupon WHERE coupon_code like (cLcodePrefix || '%');
    SELECT cLcodePrefix || '_' || CAST(iLcountCount + 1 as VARCHAR2(2)) INTO cPcouponCode FROM dual;

    /*
      create coupon
    */
    INSERT INTO ya_coupon   (coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
                          , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
                          , site_id, create_id, create_date, currency, account_type_id)
                    VALUES (cPcouponCode, cLcampaignName, cLdescription, nPcouponAmt, nLtrigger
                          , dtLexpire, cLshopperId, cLallShoppers, cLused, iLtype
                          , iLsiteId, cLcreateUser, dtLcreateDate, cPcurrency, iLaccountType);  

    INSERT INTO ya_coupon_site (coupon_code, site_id)
                        VALUES (cPcouponCode, iLsiteId);
  END CreateGoodwillCouponByOrderNum;
  
  PROCEDURE CreateGWCouponByOrderNumNExpDt (
      iPorderNum IN INT,
      nPcouponAmt IN NUMBER,
      cPcurrency IN VARCHAR2,
      dtPexpireDate IN Date,
      cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
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
    cLcodePrefix VARCHAR2(15);
  BEGIN
    /*
      preload coupon setting from order
    */
    SELECT origin_id, cust_id INTO iLsiteId, cLshopperId
    FROM order_info oi
      INNER JOIN billing_info bi ON oi.id = bi.order_info_id
    WHERE oi.origin_order_id = CAST(iPorderNum as VARCHAR2(10))
      AND ROWNUM = 1;

    /*
      coupon setting
    */
    cLcreateUser := 'Backend Goodwill';
    dtLcreateDate := SYSDATE;
    cLcampaignName := 'HKCS Goodwill';
    cLdescription := 'Goodwill coupon';
    nLtrigger := 0;
    cLallShoppers := 'N';
    cLused := 'N';
    iLtype := 1;
    iLaccountType := 0;
    
    /*
      generate coupon code
    */
    cLcodePrefix := 'GW' || iPorderNum;
    SELECT COUNT(1) INTO iLcountCount FROM ya_coupon WHERE coupon_code like (cLcodePrefix || '%');
    SELECT cLcodePrefix || '_' || CAST(iLcountCount + 1 as VARCHAR2(2)) INTO cPcouponCode FROM dual;

    /*
      create coupon
    */
    INSERT INTO ya_coupon   (coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
                          , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
                          , site_id, create_id, create_date, currency, account_type_id)
                    VALUES (cPcouponCode, cLcampaignName, cLdescription, nPcouponAmt, nLtrigger
                          , dtPexpireDate, cLshopperId, cLallShoppers, cLused, iLtype
                          , iLsiteId, cLcreateUser, dtLcreateDate, cPcurrency, iLaccountType);  

    INSERT INTO ya_coupon_site (coupon_code, site_id)
                        VALUES (cPcouponCode, iLsiteId);
  END CreateGWCouponByOrderNumNExpDt;
  
  /*
    generate inferior goodwill coupon
    ref: http://hk-system-s01/content_bugzilla/show_bug.cgi?id=24114
  */
  PROCEDURE CreateInferiorGoodwillCoupon (
      iPorderNum IN INT,
      nPcouponAmt IN NUMBER,
      nPorderAmountTrigger IN NUMBER,
      cPcurrency IN VARCHAR2,
      cPcommit IN CHAR DEFAULT 'N',
      cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
    cLshopperId CHAR(32);
    cLcampaignName VARCHAR2(50);
    cLdescription VARCHAR2(255);
    dtLexpire DATE;
    cLallShoppers CHAR(1);
    cLused CHAR(1);
    iLtype INT;
    cLcreateUser VARCHAR2(50);
    dtLcreateDate DATE;
    iLaccountType INT;
    iLcountCount INT;
    cLcodePrefix VARCHAR2(15);
  BEGIN
    /*
      preload coupon setting from order
    */
    SELECT origin_id, cust_id INTO iLsiteId, cLshopperId
    FROM order_info oi
      INNER JOIN billing_info bi ON oi.id = bi.order_info_id
    WHERE oi.origin_order_id = CAST(iPorderNum as VARCHAR2(10))
      AND ROWNUM = 1;

    /*
      coupon setting
    */
    cLcreateUser := 'Backend Inferior Goodwill';
    dtLcreateDate := SYSDATE;
    cLcampaignName := 'HKCS Inferior Goodwill';
    cLdescription := 'Inferior Goodwill coupon';
    dtLexpire := add_months(dtLcreateDate, 3);
    cLallShoppers := 'N';
    cLused := 'N';
    iLtype := 1;
    iLaccountType := 0;
    
    /*
      generate coupon code
    */
    cLcodePrefix := 'IGW' || iPorderNum;
    SELECT COUNT(1) INTO iLcountCount FROM ya_coupon WHERE coupon_code like (cLcodePrefix || '%');
    SELECT cLcodePrefix || '_' || CAST(iLcountCount + 1 as VARCHAR2(2)) INTO cPcouponCode FROM dual;

    /*
      create coupon
    */
    INSERT INTO ya_coupon   (coupon_code, campaign_name, coupon_description, dollar_coupon_value, order_amount_trigger
                          , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
                          , site_id, create_id, create_date, currency, account_type_id)
                   VALUES (cPcouponCode, cLcampaignName, cLdescription, nPcouponAmt, nPorderAmountTrigger
                          , dtLexpire, cLshopperId, cLallShoppers, cLused, iLtype
                          , iLsiteId, cLcreateUser, dtLcreateDate, cPcurrency, iLaccountType);  

    INSERT INTO ya_coupon_site (coupon_code, site_id)
                        VALUES (cPcouponCode, iLsiteId);
    IF cPcommit = 'Y' THEN
      COMMIT;
    END IF;
  END CreateInferiorGoodwillCoupon;

  /*
    generate ABW 1st purchase coupon - percentage coupon
    ref: http://hk-system-s01/content_bugzilla/show_bug.cgi?id=57275
  */
  PROCEDURE CreateAbwFirstPurchaseCoupon (
      cPshopperId IN VARCHAR2,
      nPcouponDiscountAmt IN NUMBER,
      dtPexpireDate IN Date,
      cPcouponCode OUT VARCHAR2
  )
  AS
    iLsiteId INT;
    cLcampaignName VARCHAR2(50);
    cLdescription VARCHAR2(255);
	cLcurrency VARCHAR2(3);
    nLtrigger INT;
    cLallShoppers CHAR(1);
    cLused CHAR(1);
    iLtype INT;
    cLcreateUser VARCHAR2(50);
    dtLcreateDate DATE;
    iLaccountType INT;
    iLcountCount INT;
    cLcouponCode VARCHAR2(12);

  BEGIN
    /*
      coupon setting
    */
    cLcreateUser := 'Backend Abw Discount Coupon';
    dtLcreateDate := SYSDATE;
    cLcampaignName := '1st Purchase Coupon';
    cLdescription := CONCAT(nPcouponDiscountAmt*100, '% discount for 1st order');
	cLcurrency:='USD';
    nLtrigger := 0;
    cLallShoppers := 'N';
    cLused := 'N';
    iLtype := 2;
    iLaccountType := 11;
	iLsiteId:= 28;

	/*
      Generate random coupon code
    */
    SELECT cast(dbms_random.string('U', 12) AS VARCHAR2(12)) INTO cLcouponCode FROM dual;

    -- Make sure unique coupon code
    SELECT count(1) INTO iLcountCount FROM ya_coupon WHERE coupon_code = cLcouponCode;
    WHILE (iLcountCount = 1)
        LOOP
                SELECT cast(dbms_random.string('U', 12) AS VARCHAR2(12)) INTO cLcouponCode FROM dual;
                SELECT count(1) INTO iLcountCount FROM ya_coupon WHERE coupon_code = cLcouponCode;
        END LOOP;

    /*
      create coupon
    */
    INSERT INTO ya_coupon (coupon_code, campaign_name, coupon_description, percentage_coupon_value, order_amount_trigger
                          , expiration_date, shopper_id, all_shoppers, coupon_used, coupon_type_id
                          , site_id, create_id, create_date, currency, account_type_id)
                   VALUES (cLcouponCode, cLcampaignName, cLdescription, nPcouponDiscountAmt, nLtrigger
                          , dtPexpireDate, cPshopperId, cLallShoppers, cLused, iLtype
                          , iLsiteId, cLcreateUser, dtLcreateDate, cLcurrency, iLaccountType);

    INSERT INTO ya_coupon_site (coupon_code, site_id)
                   VALUES (cLcouponCode, iLsiteId);

    cPcouponCode := cLcouponCode;

  END CreateAbwFirstPurchaseCoupon;

END Pkg_FE_GoodwillCoupon;
/