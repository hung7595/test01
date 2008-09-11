-- Temp tables
DROP TABLE temp_news_int_table;
CREATE TABLE temp_news_int_table(
  column1 INT
);

/* Reference to ss_adm package PKG_FE_NEWSLETTERACCESS */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_NEWSLETTERACCESS
AS
  TYPE refCur IS REF CURSOR;
  
  PROCEDURE GetShopperNewsletter (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,    
    curPresult OUT refcur    
  );
  
  /* SubscribeNewsletter */
  PROCEDURE UpdateShopperNewsletter (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPnewsletter_csv IN VARCHAR2,
    iPstatus IN CHAR,    
    iProw_affacted OUT INT    
  );
  
END PKG_FE_MYACC_NEWSLETTERACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_NEWSLETTERACCESS
AS
  
  PROCEDURE GetShopperNewsletter (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refcur    
  )
  AS
  BEGIN  
    OPEN curPresult FOR
      SELECT a.shopper_id, a.newsletter_id, a.status, a.pending_status, a.downloaded_flag
      FROM ya_newsletter_subscriber a
      LEFT JOIN ya_shopper b ON a.email = b.email
      WHERE b.shopper_id = cPshopper_id
      AND a.site_id = iPsite_id
      ORDER BY newsletter_id;    
    RETURN;
    
  END GetShopperNewsletter;

  PROCEDURE UpdateShopperNewsletter (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPnewsletter_csv IN VARCHAR2,
    iPstatus IN CHAR,    
    iProw_affacted OUT INT
  )
  AS
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT := 0;
    cLnewsletter_csv VARCHAR2(100);
    cLemail VARCHAR2(255);
    cLshopper_count INT;
    cLguid CHAR(32);
  BEGIN
    iLstartpos := 1;
    cLnewsletter_csv := cPnewsletter_csv;
    
    -- Load CSV into temp table
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_news_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLnewsletter_csv)), 0);

    IF (iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLnewsletter_csv, ',');
        WHILE iLendpos  >  0
        LOOP
          BEGIN
            INSERT INTO temp_news_int_table
              (
                column1 -- newsletter Id
              )
            VALUES
              (
                CAST(SUBSTR(cLnewsletter_csv, 1, iLendpos-1) AS INT)
              );

            cLnewsletter_csv := SUBSTR(cLnewsletter_csv, iLendpos+1);
            iLendpos := INSTR(cLnewsletter_csv, ',');
          END;
        END LOOP;
        INSERT INTO temp_news_int_table
          (
            column1 -- newsletter Id
          )
        VALUES
          (
            CAST(cLnewsletter_csv AS INT)
          );
      END;
    END IF;

    cLguid := SYS_GUID();
    iProw_affacted := 0;
    SELECT count(*) INTO cLshopper_count FROM ya_shopper WHERE shopper_id = cPshopper_Id;
    IF (cLshopper_count > 0) THEN      
      SELECT email INTO cLemail FROM ya_shopper WHERE shopper_id = cPshopper_Id;
      
      -- First Clear existing subscription
      DELETE FROM ya_newsletter_subscriber WHERE email = cLemail;      
      
      -- Insert into ya_newsletter_subscriber
      -- download_flag = 'N' (deprecated column)
      INSERT INTO ya_newsletter_subscriber
      (
        guid,
        email,
        site_id,
        status,
        newsletter_id,
        last_modified_datetime,
        downloaded_flag
      )
      SELECT
      cLguid,
      cLemail,
      iPsite_id,
      iPstatus,
      column1,
      SYSDATE,
      'N' -- column1 => newsletter Id
      FROM temp_news_int_table
      WHERE column1 NOT IN -- newsletter Id
      (
        SELECT newsletter_id
        FROM ya_newsletter_subscriber
        WHERE email = cLemail
      ) 
      GROUP BY column1;
            
      -- Commit
      IF sqlcode = 0 THEN      
        iProw_affacted := SQL%ROWCOUNT;
        COMMIT;
      ELSE        
        ROLLBACK;          
      END IF;
      
    END IF;
    
  END UpdateShopperNewsletter;
  
END PKG_FE_MYACC_NEWSLETTERACCESS;
/

