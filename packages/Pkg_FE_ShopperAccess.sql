CREATE OR REPLACE PACKAGE Pkg_FE_ShopperAccess
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_GetShopperBySessionID */
  PROCEDURE GetShopperDataBySessionId (
    cPsession_id IN CHAR,
    curPresult OUT refCur
  );

  /* proc_fe_GetShopperById */
  PROCEDURE GetShopperDataByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  );

  /* proc_fe_GetShopperByEmail */
  PROCEDURE GetShopperDataByEmail (
    cPemail IN VARCHAR2,
    curPresult OUT refCur
  );

  /* proc_fe_GetShopperByEmailAndPassword */
  PROCEDURE GetShopperDataByEnP (
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    curPresult OUT refCur
  );

  /* proc_fe_CreateAnonymousShopper */
  PROCEDURE CreateAnonymousShopper (
    cPguid IN CHAR
  );

  /* proc_fe_RegisterNewShopper */
  PROCEDURE RegisterNewShopper (
    cPguid IN CHAR,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    cPresult OUT CHAR
  );
END Pkg_FE_ShopperAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_ShopperAccess
AS
  PROCEDURE GetShopperDataBySessionId (
    cPsession_id IN CHAR,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      shopper_id,
      password,
      email,
      firstname,
      lastname,
      username,
      nickname,
      NVL(member_type, 1)
    FROM ya_shopper
    WHERE shopper_id IN
      (
        SELECT shopper_id
        FROM ya_session
        WHERE session_id = cPsession_id
      );
    RETURN;
  END GetShopperDataBySessionId;


  PROCEDURE GetShopperDataByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      shopper_id,
      password,
      email,
      firstname,
      lastname,
      username,
      nickname,
      member_type,
      NVL(anonymous, 'Y')
    FROM ya_shopper
    WHERE shopper_id = cPshopper_id;
    RETURN;
  END GetShopperDataByShopperId;



  PROCEDURE GetShopperDataByEmail (
    cPemail IN VARCHAR2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      shopper_id,
      password,
      email,
      firstname,
      lastname,
      username,
      nickname,
      NVL(member_type, 1)
    FROM ya_shopper
    WHERE email = cPemail;
    RETURN;
  END GetShopperDataByEmail;


  PROCEDURE GetShopperDataByEnP (
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      shopper_id,
      password,
      email,
      firstname,
      lastname,
      username,
      nickname,
      NVL(member_type, 1),
      NVL(anonymous, 'Y')
    FROM ya_shopper
    WHERE
      member_type <> 3
      AND lower(email) = lower(cPemail)
      AND password = cPpassword;
    RETURN;
  END GetShopperDataByEnP;


  PROCEDURE CreateAnonymousShopper (
    cPguid IN CHAR
  )
  AS
  BEGIN
    INSERT INTO ya_shopper
      (
        shopper_id,
        password,
        email,
        firstname,
        lastname,
        username,
        anonymous
      )
    VALUES
      (
        cPguid,
        cPguid,
        cPguid,
        'NEW',
        'USER',
        cPguid,
        'Y'
      );

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END CreateAnonymousShopper;


  PROCEDURE RegisterNewShopper (
    cPguid IN CHAR,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    cPresult OUT CHAR
  )
  AS
    iLtemp INT := 0;
  BEGIN
    BEGIN
      SELECT 1 INTO iLtemp FROM ya_shopper WHERE email = cPemail;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLtemp := 0;
    END;

    IF iLtemp = 0 THEN -- Email Not Exist
      BEGIN
        INSERT INTO ya_shopper
          (
            shopper_id,
            created_date,
            password,
            email,
            firstname,
            lastname,
            username,
            anonymous
          )
        VALUES
          (
            cPguid,
            SYSDATE,
            cPpassword,
            cPemail,
            cPfirst_name,
            cPlast_name,
            cPemail,
            'N'
          );

        cPresult := cPguid;
        IF sqlcode = 0 THEN
          COMMIT;
        ELSE
          ROLLBACK;
        END IF;
      END;
    END IF;
  END RegisterNewShopper;
END Pkg_FE_ShopperAccess;
/

