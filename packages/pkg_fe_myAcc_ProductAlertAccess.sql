-- Temp tables
DROP TABLE temp_email_int_table;
CREATE TABLE temp_email_int_table(
  artist_id INT,
  pref_id INT
);
DROP TABLE temp_email_varchar_table;
CREATE TABLE temp_email_varchar_table(
  content VARCHAR2(50)
);

/* Reference to ss_adm package Pkg_Fe_Creditcardaccess */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_PRODALERTACCESS
AS
  TYPE refCur IS REF CURSOR;

/* GetShopperCreditCardEncrypted */
PROCEDURE GetProdAlertPref (
  cPshopper_id IN CHAR,    
  curPresult1 OUT refcur,
  curPresult2 OUT refcur,
  curPresult3 OUT refcur
);

PROCEDURE UpdateProdAlertPref (    
  cPshopper_id IN CHAR,
  iPsite_id IN INT,
  iPlang_id IN INT,
  iPpref_id IN INT,
  iPformat IN INT,
  iPsubtitle IN INT,    
  cPhistory_artist_id_csv IN VARCHAR2,
  cPmanaged_artist_id_csv IN VARCHAR2,
  cPtext_csv IN VARCHAR2,
  iProw_affacted OUT INT
);
  
END PKG_FE_MYACC_PRODALERTACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_PRODALERTACCESS
AS

  PROCEDURE GetProdAlertPref (
    cPshopper_id IN CHAR,
    curPresult1 OUT refcur,
    curPresult2 OUT refcur,
    curPresult3 OUT refcur
  )
  AS
  BEGIN  
    OPEN curPresult1 FOR
      SELECT shopper_id, site_id, lang_pref, choice_pref, format_pref, subtitle_pref 
      FROM ya_email_shopper_sub_pref essp WHERE shopper_id = cPshopper_id;
      
    OPEN curPresult2 FOR
      SELECT shopper_id, artist_id, pref_id 
      FROM ya_email_shopper_sub_artist essa WHERE shopper_id = cPshopper_id;
      
    OPEN curPresult3 FOR
      SELECT shopper_id, subscribe_text, lang_id 
      FROM ya_email_shopper_sub_text esst WHERE shopper_id = cPshopper_id;
        
    RETURN;
  END GetProdAlertPref;

  PROCEDURE UpdateProdAlertPref (    
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPpref_id IN INT,
    iPformat IN INT,
    iPsubtitle IN INT,    
    cPhistory_artist_id_csv IN VARCHAR2,
    cPmanaged_artist_id_csv IN VARCHAR2,
    cPtext_csv IN VARCHAR2,
    iProw_affacted OUT INT
  )
  AS
    iLrecord_found INT;
    iLstart_pos INT;
    iLend_pos INT;
    vcLartist_id_csv VARCHAR2(1000);
    vcLtext_csv VARCHAR2(1000);
    iLitem_length INT;
    cLtemp_varchar VARCHAR2(50);    
		iLcounter INT;
		iLtext_id INT;
		iLsub_pref_id INT;
		iLhas_history_artist INT;
		iLhas_managed_artist INT;
		
  BEGIN
    iProw_affacted := 0;
    iLhas_history_artist := 0;
    iLhas_managed_artist := 0;
        
    -- Load history artist id form csv
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_email_int_table';
    iLstart_pos := 1;
    iLend_pos := 1;
    vcLartist_id_csv := cPhistory_artist_id_csv;
    iLitem_length := NVL(LENGTH(RTRIM(vcLartist_id_csv)), 0);

    IF iLitem_length > 0 THEN
      BEGIN
        iLend_pos := INSTR(vcLartist_id_csv, ',');
        WHILE iLend_pos > 0 LOOP
          BEGIN
            INSERT INTO temp_email_int_table (artist_id, pref_id)
            VALUES (cast(substr(vcLartist_id_csv,1,iLend_pos-1) AS INT), 0);
            iLhas_history_artist := 1;

            vcLartist_id_csv := substr(vcLartist_id_csv, iLend_pos + 1);
            iLend_pos := instr(vcLartist_id_csv, ',');
          END;
        END LOOP;

				SELECT count(*) INTO iLcounter FROM temp_email_int_table WHERE artist_id = vcLartist_id_csv;
				IF (iLcounter = 0) THEN
	        INSERT INTO temp_email_int_table (artist_id, pref_id)
		      VALUES (cast(vcLartist_id_csv AS INT), 0);
		      iLhas_history_artist := 1;    
				END IF;
      END;
    END IF;
    
    -- Load managed artist id form csv
    iLstart_pos := 1;
    iLend_pos := 1;
    vcLartist_id_csv := cPmanaged_artist_id_csv;
    iLitem_length := NVL(LENGTH(RTRIM(vcLartist_id_csv)), 0);

    IF iLitem_length > 0 THEN
      BEGIN
        iLend_pos := INSTR(vcLartist_id_csv, ',');
        WHILE iLend_pos > 0 LOOP
          BEGIN
            INSERT INTO temp_email_int_table (artist_id, pref_id)
            VALUES (cast(substr(vcLartist_id_csv,1,iLend_pos-1) AS INT), 1);
            iLhas_managed_artist := 1;

            vcLartist_id_csv := substr(vcLartist_id_csv, iLend_pos + 1);
            iLend_pos := instr(vcLartist_id_csv, ',');
          END;
        END LOOP;

				SELECT count(*) INTO iLcounter FROM temp_email_int_table WHERE artist_id = vcLartist_id_csv;
				IF (iLcounter = 0) THEN
	        INSERT INTO temp_email_int_table (artist_id, pref_id)
		      VALUES (cast(vcLartist_id_csv AS INT), 1);
		      iLhas_managed_artist := 1;
				END IF;
      END;
    END IF;
    
    -- Load subscribed text form csv
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_email_varchar_table';
    iLstart_pos := 1;
    iLend_pos := 1;
    vcLtext_csv := cPtext_csv;
    iLitem_length := NVL(LENGTH(RTRIM(vcLtext_csv)), 0);

    IF iLitem_length > 0 THEN
      BEGIN
        iLend_pos := INSTR(vcLtext_csv, ',');
        WHILE iLend_pos > 0 LOOP
          BEGIN
            INSERT INTO temp_email_varchar_table (content)
            VALUES (substr(vcLtext_csv,1,iLend_pos-1));

            vcLtext_csv := substr(vcLtext_csv, iLend_pos + 1);
            iLend_pos := instr(vcLtext_csv, ',');
          END;
        END LOOP;

				SELECT count(*) INTO iLcounter FROM temp_email_varchar_table WHERE content = vcLtext_csv;
				IF (iLcounter = 0) THEN
	        INSERT INTO temp_email_varchar_table (content)
		      VALUES (vcLtext_csv);
				END IF;
      END;
    END IF;
        
    --## Content Update ----------------
        
    -- Update ya_email_shopper_sub_pref    
    SELECT count(1) INTO iLrecord_found FROM ya_email_shopper_sub_pref WHERE shopper_id = cPshopper_id;
    
    IF (iLrecord_found > 0) THEN     
      UPDATE ya_email_shopper_sub_pref SET
        site_id = iPsite_id,
        lang_pref = iPlang_id,
        choice_pref = iPpref_id,
        format_pref = iPformat,
        subtitle_pref = iPsubtitle
      WHERE shopper_id = cPshopper_id;
    ELSE
      SELECT seq_email_shopper_sub_pref.nextval INTO iLsub_pref_id FROM dual;
      INSERT INTO ya_email_shopper_sub_pref(shopper_subscribe_id, shopper_id, site_id, lang_pref, choice_pref, format_pref, subtitle_pref)      
      VALUES (iLsub_pref_id, cPshopper_id, iPsite_id, iPlang_id, iPpref_id, iPformat, iPsubtitle);
    END IF;
        
    -- Commit
    IF sqlcode = 0 THEN      
      iProw_affacted := SQL%ROWCOUNT;    
    ELSE        
      ROLLBACK;
    END IF;        
        
    -- Update ya_email_shopper_sub_artist
    DELETE FROM ya_email_shopper_sub_artist WHERE shopper_id = cPshopper_id AND pref_id = iPpref_id;
    
    INSERT INTO ya_email_shopper_sub_artist(shopper_id, artist_id, pref_id)
      SELECT cPshopper_id, artist_id, pref_id
      FROM temp_email_int_table;
      
    -- Commit
    IF sqlcode <> 0 THEN            
      ROLLBACK;
    END IF;      
    
    -- Update ya_email_shopper_sub_text
    DELETE FROM ya_email_shopper_sub_text WHERE shopper_id = cPshopper_id;    
    SELECT seq_email_shopper_sub_text.nextval INTO iLtext_id FROM dual;      
    INSERT INTO ya_email_shopper_sub_text(id, shopper_id, subscribe_text, lang_id)
      SELECT iLtext_id + rownum, cPshopper_id, content, iPlang_id
      FROM temp_email_varchar_table;
     
    -- Update ya_reminder_exclude_list    
    DELETE FROM ya_reminder_exclude_list 
    WHERE shopper_id = cPshopper_id 
    AND site_id = iPsite_id;
    
    IF (iPpref_id = 2) THEN    
      INSERT INTO ya_reminder_exclude_list (shopper_id, reminder_id, last_modified_datetime, site_id, rowguid)
      VALUES (cPshopper_id, 1, SYSDATE, iPsite_id, SYS_GUID());
    END IF;    

    -- Commit
    IF sqlcode = 0 THEN      
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
    
  END UpdateProdAlertPref;    

END PKG_FE_MYACC_PRODALERTACCESS;
/

