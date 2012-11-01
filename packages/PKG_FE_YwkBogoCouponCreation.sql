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

    INSERT INTO ya_coupon VALUES (iPcouponCode, iPcampaignName, iPcouponDescription, iPcouponAmount, null, 0, null, null, null, iPexpiredDate, iPshopperId, 'N', 'N', 1, 22, sys_guid(), 'Backend BOGO promotion coupon', sysdate, ipcouponcurrency, null, null);

    insert into ya_coupon_site values (iPcouponCode, 22);

    RETURN;

  END CreateBOGOCoupon;

END PKG_FE_YwkBogoCouponCreation;
/
