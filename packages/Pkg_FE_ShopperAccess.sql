
  CREATE OR REPLACE PACKAGE "PKG_FE_SHOPPERACCESS" 
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
    curPresult OUT refCur,
    iPtype_id IN INT DEFAULT 1
  );

  /* proc_fe_GetShopperByEmailAndPassword */
  PROCEDURE GetShopperDataByEnP (
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    curPresult OUT refCur,
    iPtype_id IN INT DEFAULT 1
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
    cPresult OUT CHAR,
    iPtype_id IN INT DEFAULT 1
  );
   
   PROCEDURE AddShopperRegisterSiteId (
    cPshopper_id IN CHAR,
    cPsiteId IN INT
  );
  
  PROCEDURE RegisterMarketingNewShopper (
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPemail IN VARCHAR2
  );
  
  PROCEDURE IsCompleteCustomerSurvey (
    cPshopper_id IN VARCHAR2,
    iPsurvey_year IN INT,
    curPresult OUT refCur
  );
END Pkg_FE_ShopperAccess;
/
CREATE OR REPLACE PACKAGE BODY "PKG_FE_SHOPPERACCESS" 
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
    IF iPsite_id = 12 THEN
      select count(*) into iLHasRecord 
      from loyalty_customer c
      where c.ya_shopper_id = cPshopper_id
        and c.site_id = iPsite_id
        and c.create_dt <= sysdate
        and c.membership_expiry_dt >= sysdate
        and c.site_id = 12;
        
      IF iLHasRecord > 0 THEN
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
	        FROM ya_shopper s
	          INNER JOIN loyalty_customer c ON c.ya_shopper_id = shopper_id AND c.site_id = iPsite_id
	          INNER JOIN loyalty_membership m ON c.loyalty_membership_id = m.id
	        WHERE s.shopper_id = cPshopper_id
	          AND s.member_type <> 3
            AND c.create_dt <= sysdate
            AND c.membership_expiry_dt >= sysdate;
      END IF;
    ELSIF iPsite_id = 10 OR iPsite_id = 13 OR iPsite_id = 14 OR iPsite_id = 15 THEN
      select count(*) into iLHasRecord 
      from loyalty_customer c
	      inner join loyalty_membership m on c.loyalty_membership_id = m.id and m.membership_year = to_char(sysdate,'YYYY')	      
      where c.ya_shopper_id = cPshopper_id
        and c.site_id = 10;  
      
      IF iLHasRecord > 0 THEN
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
	        inner join loyalty_customer c on c.ya_shopper_id = shopper_id and c.site_id = 10
	        inner join loyalty_membership m on c.loyalty_membership_id = m.id and m.membership_year = to_char(sysdate,'YYYY')
	      WHERE shopper_id = cPshopper_id
	      AND member_type <> 3;
	    END IF;
    END IF;
    
    IF iLHasRecord = 0 THEN
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
    END IF;
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
    curPresult OUT refCur,
    iPtype_id IN INT DEFAULT 1
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
    WHERE lower(email) = lower(cPemail)
      AND member_type <> 3
      AND type_id = iPtype_id;
    RETURN;
  END GetShopperDataByEmail;


  PROCEDURE GetShopperDataByEnP (
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    curPresult OUT refCur,
    iPtype_id IN INT DEFAULT 1
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
      AND password = cPpassword
      AND type_id = iPtype_id;
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
    cPresult OUT CHAR,
    iPtype_id IN INT DEFAULT 1
  )
  AS
    iLtemp INT := 0;
  BEGIN
    BEGIN
      SELECT 1 INTO iLtemp FROM ya_shopper WHERE lower(email) = lower(cPemail) AND type_id = iPtype_id;
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
            anonymous,
            type_id
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
            'N',
            iPtype_id
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

/*
    IF cPsiteId = 10 THEN
      BEGIN
        INSERT INTO ya_survey_customer_list (shopper_id, survey_code, email, completed, created_datetime, updated_datetime)
        SELECT shopper_id, 100, email, 'N', sysdate, sysdate FROM ya_shopper WHERE shopper_id = cPshopper_id;
      END;
    END IF;
*/    
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
  
  PROCEDURE RegisterMarketingNewShopper (
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPemail IN VARCHAR2
  )
  AS
    iLresult INT := 1;
    cLpassword VARCHAR2(8);
    cLresult VARCHAR2(32);
    cLshopper_id VARCHAR2(32);
  BEGIN
    BEGIN      
      SELECT shopper_id INTO cLshopper_id FROM ya_shopper WHERE email = cPemail and type_id = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLresult := 0;
    END;
    
    IF iLresult = 0 THEN
    BEGIN
      SELECT sys_guid() INTO cLshopper_id FROM dual;
      SELECT cast(dbms_random.string('U', 8) AS VARCHAR2(8)) INTO cLpassword FROM dual;
      
      Pkg_FE_ShopperAccess.RegisterNewShopper(cLshopper_id, cPfirst_name, cPlast_name, cPemail
        , cLpassword, cLresult, 1);
      Pkg_FE_ShopperAccess.AddShopperRegisterSiteId(cLshopper_id, 10);
    END;
    END IF;
    
    Pkg_FE_CouponAccess.CreateMarketingCoupon(cLshopper_id);
    
  END RegisterMarketingNewShopper;
  
  PROCEDURE IsCompleteCustomerSurvey (
    cPshopper_id IN VARCHAR2,
    iPsurvey_year IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT 1 
    FROM ya_survey s, ya_survey_customer c 
    WHERE s.year = iPsurvey_year 
      AND s.id = c.survey_id
      AND c.shopper_id = cPshopper_id
      AND c.answer_dt IS NOT NULL;
  END IsCompleteCustomerSurvey;  
END Pkg_FE_ShopperAccess;
/