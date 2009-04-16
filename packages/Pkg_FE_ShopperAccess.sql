
  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_SHOPPERACCESS" 
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_GetShopperBySessionID */
  PROCEDURE GetShopperDataBySessionId (
    cPsession_id IN CHAR,
    curPresult OUT refCur
  );
  
  PROCEDURE GetShopperDataByShopperIdYS (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
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
   PROCEDURE AddShopperRegisterSiteId (
    cPshopper_id IN CHAR,
    cPsiteId IN INT
  );
END Pkg_FE_ShopperAccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_SHOPPERACCESS" 
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
      )
    AND member_type <> 3;
    RETURN;
  END GetShopperDataBySessionId;


  PROCEDURE GetShopperDataByShopperIdYS (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
   iLHasRecord INT := 0;
  BEGIN
    select count(*) into iLHasRecord 
    from loyalty_customer c
	    inner join loyalty_membership m on c.loyalty_membership_id = m.id and m.membership_year = to_char(sysdate,'YYYY')
    where c.ya_shopper_id = cPshopper_id;

    If iLHasRecord>0 and iPsite_id=10 Then
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
	      NVL(anonymous, 'Y'),
	      membership_name,
	      discount_percentage/100

	    FROM ya_shopper
	    inner join loyalty_customer c on c.ya_shopper_id = shopper_id and c.site_id = iPsite_id
	    inner join loyalty_membership m on c.loyalty_membership_id = m.id and m.membership_year = to_char(sysdate,'YYYY')
	    WHERE shopper_id = cPshopper_id
	    AND member_type <> 3;

	Else
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
	      NVL(anonymous, 'Y'),
		  null,
		  0
	    FROM ya_shopper
	    WHERE shopper_id = cPshopper_id
	    AND member_type <> 3;
	End If;
    RETURN;
  END GetShopperDataByShopperIdYS;
  
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
    WHERE shopper_id = cPshopper_id
    AND member_type <> 3;
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
--    WHERE email = cPemail;
    WHERE lower(email) = lower(cPemail)
    AND member_type <> 3;
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
      SELECT 1 INTO iLtemp FROM ya_shopper WHERE lower(email) = lower(cPemail);
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
  PROCEDURE AddShopperRegisterSiteId (
    cPshopper_id IN CHAR,
    cPsiteId IN INT
  )
  AS
    iLtemp INT := 0;
  BEGIN
    BEGIN
      SELECT 1 INTO iLtemp FROM ya_customer_profile WHERE shopper_id = cPshopper_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLtemp := 0;
    END;

    IF iLtemp = 0 THEN -- Email Not Exist
      BEGIN
        INSERT INTO ya_customer_profile
          (
            shopper_id,
            register_site_id,
            created_datetime
          )
        VALUES
          (
            cPshopper_id,
            cPsiteId,
            SYSDATE
          );


        IF sqlcode = 0 THEN
          COMMIT;
        ELSE
          ROLLBACK;
        END IF;
      END;
    END IF;
  END AddShopperRegisterSiteId;
END Pkg_FE_ShopperAccess;
/
 