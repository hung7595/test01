CREATE OR REPLACE PACKAGE PKG_FE_YwkBogoCouponCreation
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE CreateBOGOCoupon (
    iPshopperId IN VARCHAR2,
    iPcouponCode IN VARCHAR2,
    iPcampaignName IN VARCHAR2,
    iPcouponDescription IN VARCHAR2,
    iPexpiredDate IN DATE,
    iPcouponCurrency IN VARCHAR2,
    iPcouponAmount IN NUMBER
  );

END PKG_FE_YwkBogoCouponCreation;
/


CREATE OR REPLACE PACKAGE body PKG_FE_YwkBogoCouponCreation
AS
  PROCEDURE CreateBOGOCoupon (
    iPshopperId IN VARCHAR2,
    iPcouponCode IN VARCHAR2,
    iPcampaignName IN VARCHAR2,
    iPcouponDescription IN VARCHAR2,
    iPexpiredDate IN DATE,
    iPcouponCurrency IN VARCHAR2,
    iPcouponAmount IN NUMBER
  )
  AS
  BEGIN

    INSERT INTO ya_coupon (COUPON_CODE,CAMPAIGN_NAME,COUPON_DESCRIPTION,DOLLAR_COUPON_VALUE,PERCENTAGE_COUPON_VALUE,
                            ORDER_AMOUNT_TRIGGER,ORDER_QTY_TRIGGER,ITEM_SKU_TRIGGER,ITEM_QTY_TRIGGER,EXPIRATION_DATE,
                            SHOPPER_ID,ALL_SHOPPERS,COUPON_USED,COUPON_TYPE_ID,SITE_ID,
                            ROWGUID,CREATE_ID,CREATE_DATE,CURRENCY,UPDATE_ID,UPDATE_DATE)
    VALUES (iPcouponCode, iPcampaignName, iPcouponDescription, iPcouponAmount, null,
              0, null, null, null, iPexpiredDate,
              iPshopperId, 'N', 'N', 1, 22,
              sys_guid(), 'Backend BOGO promotion coupon', sysdate, ipcouponcurrency, null, null);

    INSERT INTO ya_coupon_site (coupon_code, site_id)
    VALUES (iPcouponCode, 22);

    RETURN;

  END CreateBOGOCoupon;

END PKG_FE_YwkBogoCouponCreation;
/
