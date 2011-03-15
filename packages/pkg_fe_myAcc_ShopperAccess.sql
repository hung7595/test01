-- Temp tables
DROP TABLE temp_interest_int_table;
CREATE TABLE temp_interest_int_table(
  column1 INT
);

/* Reference to ss_adm package Pkg_FE_ShopperAccess */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_SHOPPERACCESS
AS
    TYPE refCur IS REF CURSOR;

/* GetShopperDataByShopperId */
PROCEDURE GetShopperByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur,
    curPresult_interest OUT refCur      
);

PROCEDURE GetShopperByEmail (
    cPemail IN VARCHAR2,
    curPresult OUT refCur,
    curPresult_interest OUT refCur    
);

/* GetShopperDataByEnP */
PROCEDURE GetShopperByEmailPassword (
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,
    curPresult OUT refCur,
    curPresult_interest OUT refCur    
);

/* RegisterNewShopper, CreateAnonymousShopper */
PROCEDURE CreateShopper (
    cPguid IN CHAR,
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,        
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPnick_name IN VARCHAR2,    
    cPcorrespondence_email IN VARCHAR2,    
    dtPdob IN DATE,
    iPname_display_mode IN INT,    
    cPinterest_csv IN VARCHAR2,
    cPAnonymous IN CHAR,    
    iProw_affacted OUT INT
);

/* RegisterNewShopper, CreateAnonymousShopper */
PROCEDURE UpdateShopper (
    cPshopper_id IN CHAR,
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,        
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPnick_name IN VARCHAR2,    
    cPcorrespondence_email IN VARCHAR2,    
    dtPdob IN DATE,
    iPname_display_mode IN INT,
    cPinterest_csv IN VARCHAR2,    
    iProw_affacted OUT INT    
);

/* Not delete, just disable the account */
PROCEDURE DeleteShopper (
    cPshopper_id IN CHAR,
    iProw_affacted OUT INT
);

END PKG_FE_MYACC_SHOPPERACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_SHOPPERACCESS
AS
  PROCEDURE GetShopperByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur,
    curPresult_interest OUT refCur    
  )
  AS
  BEGIN
    OPEN curPresult FOR
      SELECT
        s.shopper_id,
        s.username,      
        s.password,
        s.email,
        s.firstname,
        s.lastname,      
        s.nickname,
        s.correspondence_email,
        s.dob,
        s.member_type,
        NVL(s.anonymous, 'Y') as anonymous,
        nvl(ee.enable_en, 'N') as enable_en, 
        nvl(ee.enable_b5, 'N') as enable_b5, 
        nvl(ee.enable_jp, 'N') as enable_jp, 
        nvl(ee.enable_kr, 'N') as enable_kr, 
        nvl(ee.enable_gb, 'N') as enable_gb, 
        nvl(rrn.display_mode, 0) as display_mode
      FROM ya_shopper s
      LEFT JOIN ya_emag_editor ee ON s.shopper_id = ee.shopper_id
      LEFT JOIN ya_review_reviewerName rrn ON s.shopper_id = rrn.shopper_id
      WHERE s.shopper_id = cPshopper_id AND s.member_type <> 3;

    OPEN curPresult_interest FOR
      SELECT answer_id as interest_id
      FROM ya_shopper s
      INNER JOIN ya_shopper_interest si ON s.shopper_id = si.shopper_id
      WHERE s.shopper_id = cPshopper_id AND s.member_type <> 3;
      
    RETURN;    
  END GetShopperByShopperId;
    
  PROCEDURE GetShopperByEmail (
      cPemail IN VARCHAR2,
      curPresult OUT refCur,
      curPresult_interest OUT refCur    
  )
  AS
    cLshopper_id CHAR(32);
    iLshopper_count INT;
  BEGIN  
    
    SELECT COUNT(*) INTO iLshopper_count
    FROM ya_shopper
    WHERE lower(email) = lower(cPemail)
    AND member_type <> 3
    AND type_id = 1; 
        
    IF (iLshopper_count > 0) THEN    
      SELECT shopper_id INTO cLshopper_id
      FROM ya_shopper
      WHERE lower(email) = lower(cPemail)
      AND member_type <> 3
      AND type_id = 1
      AND ROWNUM=1;
      
      GetShopperByShopperId(cLshopper_id, curPresult, curPresult_interest);
    END IF;
      
    RETURN;    
  END GetShopperByEmail;  
  
  PROCEDURE GetShopperByEmailPassword (
      cPemail IN VARCHAR2,
      cPpassword IN VARCHAR2,
      curPresult OUT refCur,
      curPresult_interest OUT refCur    
  )
  AS
    cLshopper_id CHAR(32);
    iLshopper_count INT;
  BEGIN  
    
    SELECT COUNT(*) INTO iLshopper_count
    FROM ya_shopper
    WHERE lower(email) = lower(cPemail)
    AND password = cPpassword
    AND member_type <> 3
    AND type_id = 1; 
        
    IF (iLshopper_count > 0) THEN    
      SELECT shopper_id INTO cLshopper_id
      FROM ya_shopper
      WHERE lower(email) = lower(cPemail)
      AND password = cPpassword
      AND member_type <> 3
      AND type_id = 1
      AND ROWNUM=1;
      
      GetShopperByShopperId(cLshopper_id, curPresult, curPresult_interest);
    END IF;
      
    RETURN;    
  END GetShopperByEmailPassword;  
  
  PROCEDURE CreateShopper (
    cPguid IN CHAR,
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,        
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPnick_name IN VARCHAR2,    
    cPcorrespondence_email IN VARCHAR2,    
    dtPdob IN DATE,
    iPname_display_mode IN INT,    
    cPinterest_csv IN VARCHAR2,
    cPAnonymous IN CHAR,    
    iProw_affacted OUT INT
  )
  AS
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT := 0;
    cLinterest_csv VARCHAR2(100);    
  BEGIN
    iProw_affacted := 0;
    
    -- Load CSV into temp table
    iLstartpos := 1;
    cLinterest_csv := cPinterest_csv;    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_interest_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLinterest_csv)), 0);
    IF (iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLinterest_csv, ',');
        WHILE iLendpos  >  0
        LOOP
          BEGIN
            INSERT INTO temp_interest_int_table
              (
                column1 -- section Id
              )
            VALUES
              (
                CAST(SUBSTR(cLinterest_csv, 1, iLendpos-1) AS INT)
              );

            cLinterest_csv := SUBSTR(cLinterest_csv, iLendpos+1);
            iLendpos := INSTR(cLinterest_csv, ',');
          END;
        END LOOP;
        INSERT INTO temp_interest_int_table
          (
            column1 -- newsletter Id
          )
        VALUES
          (
            CAST(cLinterest_csv AS INT)
          );
      END;
    END IF;
    
    
    BEGIN
      SELECT nvl(SUM(1), 0) INTO iLtemp FROM ya_shopper WHERE lower(email) = lower(cPemail);      
    END;

    IF (iLtemp = 0 OR cPAnonymous = 'Y') THEN -- Email Not Exist
      BEGIN
        -- Insert ya_shopper
        INSERT INTO ya_shopper
          (
            shopper_id,
            created_date,
            username,
            password,
            email,
            firstname,
            lastname,   
            nickname,
            correspondence_email,
            dob,            
            anonymous,
            type_id,
			display_mode
          )
        VALUES
          (
            cPguid,
            SYSDATE,
            cPemail,
            cPpassword,
            cPemail,
            cPfirst_name,
            cPlast_name,
            cPnick_name,
            cPcorrespondence_email,
            dtPdob,            
            cPAnonymous,
            1,
			to_char(iPname_display_mode, '9')
          );
          
        iProw_affacted := SQL%ROWCOUNT;                    
          
        -- Name display mode
        INSERT INTO ya_review_reviewerName(shopper_id, display_mode, rowguid)
        VALUES(cPguid, iPname_display_mode, cPguid);

        iProw_affacted := iProw_affacted + SQL%ROWCOUNT;                  

        -- Interest        
        -- First Clear existing subscription
        DELETE FROM ya_shopper_interest WHERE shopper_id = cPguid;
        INSERT INTO ya_shopper_interest(SHOPPER_ID, QUESTION_ID, ANSWER_ID)
          SELECT cPguid, column1, column1 
          FROM temp_interest_int_table;
          
        iProw_affacted := iProw_affacted + SQL%ROWCOUNT;

        -- Commit        
        IF sqlcode = 0 THEN                    
          COMMIT;
        ELSE          
          iProw_affacted := 0;
          ROLLBACK;          
        END IF;
        
      END;
    END IF;
  END CreateShopper;
    
  PROCEDURE UpdateShopper (
    cPshopper_id IN CHAR,
    cPemail IN VARCHAR2,
    cPpassword IN VARCHAR2,        
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPnick_name IN VARCHAR2,    
    cPcorrespondence_email IN VARCHAR2,    
    dtPdob IN DATE,
    iPname_display_mode IN INT,
    cPinterest_csv IN VARCHAR2,
    iProw_affacted OUT INT    
  )
  AS
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT := 0;
    cLinterest_csv VARCHAR2(100);    
  BEGIN
    iProw_affacted := 0;
    
    -- Load CSV into temp table
    iLstartpos := 1;
    cLinterest_csv := cPinterest_csv;    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_interest_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLinterest_csv)), 0);
    IF (iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLinterest_csv, ',');
        WHILE iLendpos  >  0
        LOOP
          BEGIN
            INSERT INTO temp_interest_int_table
              (
                column1 -- section Id
              )
            VALUES
              (
                CAST(SUBSTR(cLinterest_csv, 1, iLendpos-1) AS INT)
              );

            cLinterest_csv := SUBSTR(cLinterest_csv, iLendpos+1);
            iLendpos := INSTR(cLinterest_csv, ',');
          END;
        END LOOP;
        INSERT INTO temp_interest_int_table
          (
            column1 -- newsletter Id
          )
        VALUES
          (
            CAST(cLinterest_csv AS INT)
          );
      END;
    END IF;
    
    -- Check Shopper Exists
    BEGIN
      SELECT SUM(1) INTO iLtemp FROM ya_shopper WHERE shopper_id = cPshopper_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLtemp := 0;
    END;

    IF (iLtemp > 0) THEN -- Shopper Exist
      BEGIN
        -- Insert ya_shopper
        UPDATE ya_shopper SET
          username = cPemail,
          password = cPpassword,
          email = cPemail,
          firstname = cPfirst_name,
          lastname = cPlast_name,   
          nickname = cPnick_name,
          correspondence_email = cPcorrespondence_email,
          dob = dtPdob,
		  display_mode = to_char(iPname_display_mode, '9')
        WHERE shopper_id = cPshopper_id;
        
        iProw_affacted := SQL%ROWCOUNT;
                    
        -- Name display mode
        SELECT SUM(1) INTO iLtemp FROM ya_review_reviewerName WHERE shopper_id = cPshopper_id;
        IF (iLtemp > 0) THEN -- Shopper Exist in Name Setting                    
          UPDATE ya_review_reviewerName
          SET display_mode = iPname_display_mode
          WHERE shopper_id = cPshopper_id;
        ELSE
          INSERT INTO ya_review_reviewerName(shopper_id, display_mode, rowguid)
          VALUES(cPshopper_id, iPname_display_mode, cPshopper_id);
        END IF;
        
        iProw_affacted := iProw_affacted + SQL%ROWCOUNT;                  
        
        -- Interest        
        -- First Clear existing subscription
        DELETE FROM ya_shopper_interest WHERE shopper_id = cPshopper_id;
        INSERT INTO ya_shopper_interest(SHOPPER_ID, QUESTION_ID, ANSWER_ID)
          SELECT cPshopper_id, column1, column1 
          FROM temp_interest_int_table;
          
        iProw_affacted := iProw_affacted + SQL%ROWCOUNT;
        
        -- Commit        
        IF sqlcode = 0 THEN          
          COMMIT;
        ELSE          
          iProw_affacted := 0;        
          ROLLBACK;          
        END IF;
        
      END;
    END IF;
    
  END UpdateShopper;

  /* Not delete, just disable the account */
  PROCEDURE DeleteShopper (
    cPshopper_id IN CHAR,
    iProw_affacted OUT INT
  )
  AS    
  BEGIN
    iProw_affacted := 0;
    
    UPDATE ya_shopper SET member_type = 3 WHERE shopper_id = cPshopper_id;  -- 3 :  Disabled Account
    
    -- Commit        
    IF sqlcode = 0 THEN      
      iProw_affacted := SQL%ROWCOUNT;    
      COMMIT;
    ELSE      
      ROLLBACK;          
    END IF;
  
  END DeleteShopper;

END PKG_FE_MYACC_SHOPPERACCESS;
/

