CREATE OR REPLACE PACKAGE Pkg_FE_EmailReferralAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE InsertReferEmail (
	cShopperId IN CHAR,
    cReferName IN VARCHAR2,
    cReferEmail IN VARCHAR2,
    cShopperName IN VARCHAR2,
    iPreturn OUT INT
  );

  PROCEDURE GetExistingYAYSShopper (
    cShopperId IN CHAR,
    curPresult1 OUT curG
  );
  
  PROCEDURE GetExistingEmailFmTblReferral (
    cShopperId IN CHAR,
    cReferEmail1 IN VARCHAR2,
    cReferEmail2 IN VARCHAR2,
    cReferEmail3 IN VARCHAR2,
    cReferEmail4 IN VARCHAR2,
    cReferEmail5 IN VARCHAR2,
    curPresult1 OUT curG
  );
  PROCEDURE GetExistingEmailFmTblShopper (
    cReferEmail1 IN VARCHAR2,
    cReferEmail2 IN VARCHAR2,
    cReferEmail3 IN VARCHAR2,
    cReferEmail4 IN VARCHAR2,
    cReferEmail5 IN VARCHAR2,
    curPresult1 OUT curG
  );
END Pkg_FE_EmailReferralAccess;
/


CREATE OR REPLACE PACKAGE body Pkg_FE_EmailReferralAccess
IS
  PROCEDURE InsertReferEmail (
    cShopperId IN CHAR,
    cReferName IN VARCHAR2,
    cReferEmail IN VARCHAR2,
    cShopperName IN VARCHAR2,
    iPreturn OUT INT
  )
  AS
  BEGIN
    INSERT INTO ya_email_referral (shopper_id, refer_email, refer_name, shopper_name)
    VALUES (cShopperId, cReferEmail, cReferName, cShopperName);
    iPreturn := SQL%ROWCOUNT;
    COMMIT;
  END InsertReferEmail;

  PROCEDURE GetExistingYAYSShopper (
    cShopperId IN CHAR,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
		SELECT cust_id 
			FROM order_info o, ya_customer_profile c 
			WHERE o.cust_id = cShopperId
				AND o.order_dt < to_date('2007/09/01', 'YYYY/MM/DD') AND o.cust_id = c.shopper_id
				AND c.register_site_id = 1 AND c.created_datetime < to_date('2007/09/01', 'YYYY/MM/DD')
		UNION 
		SELECT cast( shopper_id AS NVARCHAR2(150) ) 
			FROM ya_customer_profile 
			WHERE created_datetime < to_date('2007/09/01', 'YYYY/MM/DD') 
				AND shopper_id = cShopperId AND register_site_id = 10;
    RETURN;
   END GetExistingYAYSShopper;
   
  PROCEDURE GetExistingEmailFmTblReferral (
    cShopperId IN CHAR,
    cReferEmail1 IN VARCHAR2,
    cReferEmail2 IN VARCHAR2,
    cReferEmail3 IN VARCHAR2,
    cReferEmail4 IN VARCHAR2,
    cReferEmail5 IN VARCHAR2,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT refer_email
    FROM ya_email_referral
    WHERE shopper_id = cShopperId AND refer_email IN (cReferEmail1, cReferEmail2, cReferEmail3, cReferEmail4, cReferEmail5);
    RETURN;
   END GetExistingEmailFmTblReferral;

   PROCEDURE GetExistingEmailFmTblShopper (
    cReferEmail1 IN VARCHAR2,
    cReferEmail2 IN VARCHAR2,
    cReferEmail3 IN VARCHAR2,
    cReferEmail4 IN VARCHAR2,
    cReferEmail5 IN VARCHAR2,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT email
    FROM ya_shopper
    WHERE email IN (cReferEmail1, cReferEmail2, cReferEmail3, cReferEmail4, cReferEmail5);
    RETURN;
   END GetExistingEmailFmTblShopper;
END Pkg_FE_EmailReferralAccess;
/
