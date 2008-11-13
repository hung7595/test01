
REM START SS_ADM PKG_FE_CM_KEYWORDMANDALC

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_CM_KEYWORDMANDALC"
AS
  TYPE refCur IS ref CURSOR;
	
  PROCEDURE GetKeywordsBySku
  (
    iPsku IN INT,
    iPgetMode IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetKeywordsByKeywordID
  (
    iPkeywordId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetKeywordsByKeyword
  (
    cPkeyword IN VARCHAR2,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );
  
	PROCEDURE DelKeywordByID
	(
		iPkeywordId IN INT,
		iPdeleted OUT INT
	);
  
  PROCEDURE AddKeyword
	(
		cPenKeyword IN NVARCHAR2,
		iPenEnable IN INT,
		cPenNote IN NVARCHAR2,
    cPb5Keyword IN NVARCHAR2,
		iPb5Enable IN INT,
		cPb5Note IN NVARCHAR2,
    cPjpKeyword IN NVARCHAR2,
		iPjpEnable IN INT,
		cPjpNote IN NVARCHAR2,
    cPkrKeyword IN NVARCHAR2,
		iPkrEnable IN INT,
		cPkrNote IN NVARCHAR2,
    cPgbKeyword IN NVARCHAR2,
		iPgbEnable IN INT,
		cPgbNote IN NVARCHAR2,
		cPupdateUser IN NVARCHAR2,
    dtPupdateDate IN DATE,
    iPkeywordId OUT INT
	);
  
  PROCEDURE UpdateKeyword
	(
		cPenKeyword IN NVARCHAR2,
		iPenEnable IN INT,
		cPenNote IN NVARCHAR2,
    cPb5Keyword IN NVARCHAR2,
		iPb5Enable IN INT,
		cPb5Note IN NVARCHAR2,
    cPjpKeyword IN NVARCHAR2,
		iPjpEnable IN INT,
		cPjpNote IN NVARCHAR2,
    cPkrKeyword IN NVARCHAR2,
		iPkrEnable IN INT,
		cPkrNote IN NVARCHAR2,
    cPgbKeyword IN NVARCHAR2,
		iPgbEnable IN INT,
		cPgbNote IN NVARCHAR2,
    iPkeywordId IN INT,
		cPupdateUser IN NVARCHAR2,
    dtPupdateDate IN DATE,
    iPupdateStatus OUT INT
	);
  
  PROCEDURE GetAssProdInfoByKeywordID
  (
    iPkeywordId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetHottestKeywords
  (
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetKeywordsTopWeek
  (
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetKeywordsTopMonth
  (
    curPresult1 OUT refCur
  );
	
END Pkg_fe_cm_KeywordManDalc;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_CM_KEYWORDMANDALC"
IS

  --This procedure used in SEO Keyword Management System and for the purpose 
  --to retrieve keywords associated with a specific sku      
      
  --Params      
  --iPsku : The SKU to check    
  --iPgetMode: Control the kind of records to retrieve    
  --                0 - Get Disabled Keywords Only    
  --                1 - Get Enabled Keywords Only    
  --                2 - Get both disable and enable keywords
  PROCEDURE GetKeywordsBySku
  (
    iPsku IN INT,
    iPgetMode IN INT,
    curPresult1 OUT refCur
  ) AS
  BEGIN
    IF(iPgetMode) = 0 OR (iPgetMode) = 1 THEN
      OPEN curPresult1 FOR
      SELECT id, text, lang_id, enable,  note, last_update, last_update_user      
      FROM ya_fe_seo_keyword      
      WHERE id      
      IN      
      (      
        SELECT DISTINCT keyword_id      
        FROM ya_fe_seo_keyword_product_rel      
        WHERE sku      
        IN      
        (      
            --Prepare the distinct keyword list from      
            --table ya_fe_seo_keyword_product_rel and      
            --table ya_review_share_group      
            SELECT DISTINCT sku      
            FROM ya_fe_seo_keyword_product_rel      
            WHERE sku = iPsku      
                  
            UNION      
                  
            SELECT DISTINCT sku      
            FROM ya_review_share_group      
            WHERE group_id      
            IN      
            (      
              SELECT group_id      
              FROM ya_review_share_group      
              WHERE sku = iPsku      
            )      
        )    
      )    
      AND enable = iPgetMode
      ORDER BY id,  lang_id; 
    ELSIF (iPgetMode) = 2 THEN
      OPEN curPresult1 FOR
      SELECT id, text, lang_id, enable,  note, last_update, last_update_user      
      FROM ya_fe_seo_keyword      
      WHERE id      
      IN      
      (      
        SELECT DISTINCT keyword_id      
        FROM ya_fe_seo_keyword_product_rel      
        WHERE sku      
        IN      
        (      
            --Prepare the distinct keyword list from      
            --table ya_fe_seo_keyword_product_rel and      
            --table ya_review_share_group      
            SELECT DISTINCT sku      
            FROM ya_fe_seo_keyword_product_rel      
            WHERE sku = iPsku      
                  
            UNION      
                  
            SELECT DISTINCT sku      
            FROM ya_review_share_group      
            WHERE group_id      
            IN      
            (      
              SELECT group_id      
              FROM ya_review_share_group      
              WHERE sku = iPsku      
            )      
        )        
      )    
      ORDER BY id,  lang_id;
    END IF;
  END GetKeywordsBySku;

  PROCEDURE GetKeywordsByKeywordID
  (
    iPkeywordId IN INT,
    curPresult1 OUT refCur
  ) AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT id, text, lang_id, enable, note, last_update, last_update_user      
    FROM ya_fe_seo_keyword      
    WHERE id = iPkeywordId
    ORDER BY id, lang_id;
  END GetKeywordsByKeywordID;

  PROCEDURE GetKeywordsByKeyword
  (
    cPkeyword IN VARCHAR2,
    iPlangId IN INT,
    curPresult1 OUT refCur
  ) AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT id, text, lang_id, enable, note, last_update, last_update_user    
    FROM ya_fe_seo_keyword    
    WHERE id in    
    (    
      SELECT id     
      FROM ya_fe_seo_keyword     
      WHERE ((text like '%'||cPkeyword||'%')    
      and (lang_id = iPlangId))    
    )    
    ORDER BY id, lang_id;
  END GetKeywordsByKeyword;

  PROCEDURE DelKeywordByID
	(
		iPkeywordId IN INT,
		iPdeleted OUT INT
	) AS
		iLdelIdValid INT := 1;
		iLdelKeywordIdValid INT := 1;
	BEGIN
		BEGIN
			DELETE FROM ya_fe_seo_keyword 
			WHERE id= iPkeywordId;
			
			EXCEPTION WHEN no_data_found THEN
				iLdelIdValid := -1;
		END;
		
		BEGIN
			DELETE FROM ya_fe_seo_keyword_product_rel 
			WHERE keyword_id= iPkeywordId;
			
			EXCEPTION WHEN no_data_found THEN
				iLdelKeywordIdValid := -1;
		END;
    
		IF iLdelIdValid = 1 AND iLdelKeywordIdValid = 1 THEN
			iPdeleted := 1;
		ELSE
			iPdeleted := -1;
		END IF;
  END DelKeywordByID;

  PROCEDURE AddKeyword
	(
		cPenKeyword IN NVARCHAR2,
		iPenEnable IN INT,
		cPenNote IN NVARCHAR2,
    cPb5Keyword IN NVARCHAR2,
		iPb5Enable IN INT,
		cPb5Note IN NVARCHAR2,
    cPjpKeyword IN NVARCHAR2,
		iPjpEnable IN INT,
		cPjpNote IN NVARCHAR2,
    cPkrKeyword IN NVARCHAR2,
		iPkrEnable IN INT,
		cPkrNote IN NVARCHAR2,
    cPgbKeyword IN NVARCHAR2,
		iPgbEnable IN INT,
		cPgbNote IN NVARCHAR2,
		cPupdateUser IN NVARCHAR2,
    dtPupdateDate IN DATE,
    iPkeywordId OUT INT
	) AS
	BEGIN	
    --Get the available keywordID
    SELECT seq_keywordId.nextval 
    INTO iPkeywordId 
    FROM DUAL;
  
		--Insert Eng Keyword
		IF(cPenKeyword) IS NOT NULL THEN
      BEGIN
        INSERT INTO ya_fe_seo_keyword      
          (id, text, lang_id, enable, note, last_update, last_update_user)      
          VALUES
          (iPkeywordId, cPenKeyword, 1, iPenEnable, cPenNote, dtPupdateDate, cPupdateUser);
          
        EXCEPTION WHEN OTHERS THEN
          BEGIN
            iPkeywordId := -1;
            ROLLBACK;
            RETURN;
          END;
      END;
		END IF;
    
    --Insert B5 Keyword
		IF(cPb5Keyword) IS NOT NULL THEN
      BEGIN
        INSERT INTO ya_fe_seo_keyword      
          (id, text, lang_id, enable, note, last_update, last_update_user)      
          VALUES
          (iPkeywordId, cPb5Keyword, 2, iPb5Enable, cPb5Note, dtPupdateDate, cPupdateUser);
          
        EXCEPTION WHEN OTHERS THEN
          BEGIN
            iPkeywordId := -1;
            ROLLBACK;
            RETURN;
          END;
      END;
		END IF;
    
    --Insert JP Keyword
		IF(cPjpKeyword) IS NOT NULL THEN
      BEGIN
        INSERT INTO ya_fe_seo_keyword      
          (id, text, lang_id, enable, note, last_update, last_update_user)      
          VALUES
          (iPkeywordId, cPjpKeyword, 3, iPjpEnable, cPjpNote, dtPupdateDate, cPupdateUser);
          
        EXCEPTION WHEN OTHERS THEN
          BEGIN
            iPkeywordId := -1;
            ROLLBACK;
            RETURN;
          END;
      END;
		END IF;
    
    --Insert KR Keyword
		IF(cPkrKeyword) IS NOT NULL THEN
      BEGIN
        INSERT INTO ya_fe_seo_keyword      
          (id, text, lang_id, enable, note, last_update, last_update_user)      
          VALUES
          (iPkeywordId, cPkrKeyword, 4, iPkrEnable, cPkrNote, dtPupdateDate, cPupdateUser);
          
        EXCEPTION WHEN OTHERS THEN
          BEGIN
            iPkeywordId := -1;
            ROLLBACK;
            RETURN;
          END;
      END;
		END IF;
    
    --Insert GB Keyword
		IF(cPgbKeyword) IS NOT NULL THEN
      BEGIN
        INSERT INTO ya_fe_seo_keyword      
          (id, text, lang_id, enable, note, last_update, last_update_user)      
          VALUES
          (iPkeywordId, cPgbKeyword, 5, iPgbEnable, cPgbNote, dtPupdateDate, cPupdateUser);
          
        EXCEPTION WHEN OTHERS THEN
          BEGIN
            iPkeywordId := -1;
            ROLLBACK;
            RETURN;
          END;
      END;
		END IF;
    COMMIT;
  END AddKeyword;

  --iPkeywordId : Keyword ID to update    
  --iPupdateStatus : -1 -> fails,  -3 -> keyword_id not exist in db,1 -> Success, 
  --Start check if keyword id exist in db  
  PROCEDURE UpdateKeyword
	(
		cPenKeyword IN NVARCHAR2,
		iPenEnable IN INT,
		cPenNote IN NVARCHAR2,
    cPb5Keyword IN NVARCHAR2,
		iPb5Enable IN INT,
		cPb5Note IN NVARCHAR2,
    cPjpKeyword IN NVARCHAR2,
		iPjpEnable IN INT,
		cPjpNote IN NVARCHAR2,
    cPkrKeyword IN NVARCHAR2,
		iPkrEnable IN INT,
		cPkrNote IN NVARCHAR2,
    cPgbKeyword IN NVARCHAR2,
		iPgbEnable IN INT,
		cPgbNote IN NVARCHAR2,
    iPkeywordId IN INT,
		cPupdateUser IN NVARCHAR2,
    dtPupdateDate IN DATE,
    iPupdateStatus OUT INT
	) AS
	BEGIN	
    BEGIN
      --Start check if keyword id exist in db 
      SELECT 1 INTO iPupdateStatus
      FROM  ya_fe_seo_keyword
      WHERE id = iPkeywordId
      AND ROWNUM < 2;
      
      EXCEPTION WHEN no_data_found THEN
        iPupdateStatus := -3;
      RETURN;
    END;
    --End check duplication    
    
    IF(iPkeywordId) > 0 THEN  
      BEGIN
        --Delete all the records and then insert all updated value to the DB    
        DELETE    
        FROM ya_fe_seo_keyword    
        WHERE id = iPkeywordId; 
        
        EXCEPTION WHEN OTHERS THEN       
          BEGIN   
            iPupdateStatus := -1;
            ROLLBACK;
            RETURN;
          END;
      END;
          
        --Insert Eng Keyword
        IF(cPenKeyword) IS NOT NULL THEN
          BEGIN
            INSERT INTO ya_fe_seo_keyword      
              (id, text, lang_id, enable, note, last_update, last_update_user)      
              VALUES
              (iPkeywordId, cPenKeyword, 1, iPenEnable, cPenNote, dtPupdateDate,cPupdateUser);
              
            EXCEPTION WHEN OTHERS THEN
              BEGIN
                iPupdateStatus := -1;
                ROLLBACK;
                RETURN;
              END;
          END;
        END IF;
        
        --Insert B5 Keyword
        IF(cPb5Keyword) IS NOT NULL THEN
          BEGIN
            INSERT INTO ya_fe_seo_keyword      
              (id, text, lang_id, enable, note, last_update, last_update_user)      
              VALUES
              (iPkeywordId, cPb5Keyword, 2, iPb5Enable, cPb5Note, dtPupdateDate,cPupdateUser);
              
            EXCEPTION WHEN OTHERS THEN
              BEGIN
                iPupdateStatus := -1;
                ROLLBACK;
                RETURN;
              END;
          END;
        END IF;
        
        --Insert JP Keyword
        IF(cPjpKeyword) IS NOT NULL THEN
          BEGIN
            INSERT INTO ya_fe_seo_keyword      
              (id, text, lang_id, enable, note, last_update, last_update_user)      
              VALUES
              (iPkeywordId, cPjpKeyword, 3, iPjpEnable, cPjpNote, dtPupdateDate,cPupdateUser);
              
            EXCEPTION WHEN OTHERS THEN
              BEGIN
                iPupdateStatus := -1;
                ROLLBACK;
                RETURN;
              END;
          END;
        END IF;
        
        --Insert KR Keyword
        IF(cPkrKeyword) IS NOT NULL THEN
          BEGIN
            INSERT INTO ya_fe_seo_keyword      
              (id, text, lang_id, enable, note, last_update, last_update_user)      
              VALUES
              (iPkeywordId, cPkrKeyword, 4, iPkrEnable, cPkrNote, dtPupdateDate,cPupdateUser);
              
            EXCEPTION WHEN OTHERS THEN
              BEGIN
                iPupdateStatus := -1;
                ROLLBACK;
                RETURN;
              END;
          END;
        END IF;
        
        --Insert GB Keyword
        IF(cPgbKeyword) IS NOT NULL THEN
          BEGIN
            INSERT INTO ya_fe_seo_keyword      
              (id, text, lang_id, enable, note, last_update, last_update_user)      
              VALUES
              (iPkeywordId, cPgbKeyword, 5, iPgbEnable, cPgbNote, dtPupdateDate ,cPupdateUser);
              
            EXCEPTION WHEN OTHERS THEN
              BEGIN
                iPupdateStatus := -1;
                ROLLBACK;
                RETURN;
              END;
          END;
        END IF;
    END IF; 
    COMMIT;
  END UpdateKeyword;

  PROCEDURE GetAssProdInfoByKeywordID
  (
    iPkeywordId IN INT,
    curPresult1 OUT refCur
  ) AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT sku_list.sku, review_share.group_id, ya_prod_lang.prod_name  
    FROM ((  
      SELECT rel.sku as sku  
      FROM ya_fe_seo_keyword_product_rel rel  
      WHERE rel.keyword_id = iPkeywordId  
      )  
      UNION  
      (  
      SELECT sku as sku  
      FROM ya_review_share_group  
      WHERE group_id  
      IN  
      (  
        SELECT group_id  
        FROM ya_review_share_group  
        WHERE sku  
        IN  
        (  
           SELECT sku  
           FROM ya_fe_seo_keyword_product_rel  
           WHERE keyword_id = iPkeywordId  
        )  
      )  
    )) sku_list  
    LEFT JOIN ya_review_share_group review_share  
    ON sku_list.sku = review_share.sku  
    LEFT JOIN ya_prod_lang  
    ON sku_list.sku = ya_prod_lang.sku  
    WHERE ya_prod_lang.lang_Id = 1  
    ORDER BY review_share.group_id ;
  END GetAssProdInfoByKeywordID;

  PROCEDURE GetHottestKeywords
  (
    curPresult1 OUT refCur
  ) AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT k.id, k.text, k.lang_id, k.enable, k.note, k.last_update, k.last_update_user        
    FROM ya_fe_seo_keyword k,  
    (  
      SELECT *
      FROM
      (
        SELECT keyword_id  
        FROM ya_fe_seo_keyword_product_rel 
        GROUP BY keyword_id  
        ORDER BY count(keyword_id) DESC  
      )
      WHERE ROWNUM < 11
    ) rel  
    WHERE  
    rel.keyword_id = k.id;
  END GetHottestKeywords;

  PROCEDURE GetKeywordsTopWeek
  (
    curPresult1 OUT refCur
  ) AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT id, text, lang_id, enable, note, last_update, last_update_user        
    FROM ya_fe_seo_keyword        
    WHERE last_update BETWEEN (sysdate -7) and sysdate
    ORDER BY id, lang_id;
  END GetKeywordsTopWeek;

  PROCEDURE GetKeywordsTopMonth
  (
    curPresult1 OUT refCur
  ) AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT id, text, lang_id, enable, note, last_update, last_update_user          
    FROM ya_fe_seo_keyword          
    WHERE last_update BETWEEN (sysdate - 30) and sysdate
    ORDER BY id, lang_id;
  END GetKeywordsTopMonth;
	
END Pkg_fe_cm_KeywordManDalc;
/

REM END SS_ADM PKG_FE_CM_KEYWORDMANDALC