CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_APPNOTIFICATION" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE IsShopperSubscribeOrderRelated
  (
    iPshopperId IN VARCHAR2,
    iPreturn OUT INT
  );

  PROCEDURE AddOrderRelatedAppNotification 
  (
    iPshopperId IN VARCHAR2,
    iPmessage IN VARCHAR2,
    iPreturn OUT INT
  );

END PKG_FE_APPNOTIFICATION;
/

CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_APPNOTIFICATION" AS

  PROCEDURE IsShopperSubscribeOrderRelated (
    iPshopperId IN VARCHAR2,
    iPreturn OUT INT
  )
  AS
    iLsubscriptionCount INT;
  BEGIN
    select count(rownum) into iLsubscriptionCount from ya_app_subscription yas , ya_app_subscription_type yast where yas.id = yast.subscription_id and yast.type = 3 and yast.subscribed = 'Y' and yas.shopper_id = iPshopperId;

    IF iLsubscriptionCount > 0 THEN
      iPreturn := 1;
    ELSE
      iPreturn := 0;
    END IF;

  END IsShopperSubscribeOrderRelated;


  PROCEDURE AddOrderRelatedAppNotification (
    iPshopperId IN VARCHAR2,
    iPmessage IN VARCHAR2,
    iPreturn OUT INT
  )
  AS
    iLsubscriptionId INT;
    curLSubscriptionInfo refCur;

  BEGIN
    OPEN curLSubscriptionInfo FOR
      select distinct(yast.subscription_id) as subscription_id from ya_app_subscription yas , ya_app_subscription_type yast where yas.id = yast.subscription_id and yast.type = 3 and yast.subscribed = 'Y' and yas.shopper_id = iPshopperId;
    FETCH curLSubscriptionInfo INTO iLsubscriptionId;
    WHILE curLSubscriptionInfo%FOUND LOOP
      BEGIN
        insert into ya_app_subscription_message values (SEQ_YA_APP_SUBSCRIPT_MSG.nextval, iLsubscriptionId, null, iPmessage, 2, 'N', sysdate, 3, null, null);
        FETCH curLSubscriptionInfo INTO iLsubscriptionId;
      END;
    END LOOP;

    IF sqlcode = 0 THEN
      iPreturn := 1;
    ELSE
      iPreturn := 0;
    END IF;

  END AddOrderRelatedAppNotification;

END PKG_FE_APPNOTIFICATION;
/
