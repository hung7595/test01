CREATE OR REPLACE PACKAGE Pkg_fe_MyAccountShopperAccess
AS
/*
  PROCEDURE AddShopper (
    cPshopper_id OUT CHAR
  );
*/
  PROCEDURE CreateShopper (
    cPshopper_id OUT CHAR
  );
  PROCEDURE AddShopperInfo (
    cPemail IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPpassword IN VARCHAR2,
    cPnickname IN VARCHAR2,
    dtDOB IN DATE,
    cPshopper_id IN OUT VARCHAR2
  );
  PROCEDURE UpdateShopperInfo (
    cPshopper_id IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPpassword IN VARCHAR2,
    cPnickname IN VARCHAR2,
    dtDOB IN DATE
  );
END Pkg_fe_MyAccountShopperAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_fe_MyAccountShopperAccess
IS
/*
  PROCEDURE AddShopper (
    cPshopper_id OUT CHAR
  )
  AS
    cPnew_shopper_id CHAR(32) := SYS_GUID();
  BEGIN
    INSERT INTO ya_shopper (shopper_id, created_date, password, email, firstname, lastname, username, anonymous)
    VALUES (cPnew_shopper_id, SYSDATE, '', cPnew_shopper_id, 'New', 'User', cPnew_shopper_id, 'Y');
    COMMIT;
    cPshopper_id := cPnew_shopper_id;
  END AddShopper;
*/
  PROCEDURE CreateShopper (
    cPshopper_id OUT CHAR
  )
  AS
    cPnew_shopper_id CHAR(32) := SYS_GUID();
  BEGIN
    cPshopper_id := SYS_GUID();
  END CreateShopper;

  PROCEDURE UpdateShopperInfo(
    cPshopper_id IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPpassword IN VARCHAR2,
    cPnickname IN VARCHAR2,
    dtDOB IN DATE
  )
  AS
  BEGIN
    UPDATE ya_shopper SET email = cPemail, lastname = cPlastname, firstname = cPfirstname,
      username = cPemail, password = cPpassword, nickname = cPnickname, dob = dtDOB
    WHERE shopper_id = cPshopper_id;
    COMMIT;
  END UpdateShopperInfo;

  PROCEDURE AddShopperInfo(
    cPemail IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPpassword IN VARCHAR2,
    cPnickname IN VARCHAR2,
    dtDOB IN DATE,
    cPshopper_id IN OUT VARCHAR2
  )
  AS
    iLmember_type INT := 1;
    iLduplicate_account INT := 1;
  BEGIN
    BEGIN
      SELECT 1 INTO iLduplicate_account FROM ya_shopper WHERE lower(email) = lower(cPemail);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            iLduplicate_account := -1;
    END;
  
    IF iLduplicate_account = -1 THEN
      BEGIN
        IF cPshopper_id IS NULL OR
          length(cPshopper_id) = 0 then
          BEGIN
            cPshopper_id := SYS_GUID();
          END;
        END IF;

        INSERT INTO ya_shopper
          (shopper_id, created_date, email, lastname, firstname, username,
          password, nickname, dob, member_type, anonymous)
        VALUES (cPshopper_id, SYSDATE, cPemail, cPlastname, cPfirstname, cPemail,
          cPpassword, cPnickname, dtDOB, iLmember_type, 'N');
        COMMIT;      
      END;
    END IF;
  END AddShopperInfo;
END Pkg_fe_MyAccountShopperAccess;
/