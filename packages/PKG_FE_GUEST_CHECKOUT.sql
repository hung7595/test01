CREATE OR REPLACE 
PACKAGE PKG_FE_GUEST_CHECKOUT AS 

  PROCEDURE Sp_send_gco_order_fulfill_edm (
    cPemail IN VARCHAR2,
    nPsiteId IN NUMBER,
    nPlangId IN NUMBER
  );

END PKG_FE_GUEST_CHECKOUT;
/

CREATE OR REPLACE
PACKAGE BODY PKG_FE_GUEST_CHECKOUT AS

  PROCEDURE Sp_send_gco_order_fulfill_edm (
    cPemail IN VARCHAR2,
    nPsiteId IN NUMBER,
    nPlangId IN NUMBER
  ) AS
  BEGIN
    INSERT INTO ya_new_visitor_subscription VALUES (SEQ_NEW_VISITOR_SUBSCRIPTION.NEXTVAL, cPemail, npsiteid, nplangid, 'N', sysdate, sysdate, 1, 524);
  END Sp_send_gco_order_fulfill_edm;

END PKG_FE_GUEST_CHECKOUT;
/
