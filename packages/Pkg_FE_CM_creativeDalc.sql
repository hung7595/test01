
REM START SS_ADM PKG_FE_CM_CREATIVEDALC

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_CM_CREATIVEDALC"
AS
  TYPE refCur IS ref CURSOR;
	
  PROCEDURE AddCreativeGroup
  (
    cPtitle IN VARCHAR2,
    cPdescription IN VARCHAR2,
    iPdeptId IN INT,
    cPenable IN CHAR,
    iPcreativeGroupId OUT INT
  );
  
  PROCEDURE UpdateCreativeGroup
  (
    iPcreativeGroupId IN INT,
    cPtitle IN VARCHAR2,
    cPdescription IN VARCHAR2,
    iPdeptId IN INT,
    cPenable IN CHAR,
    iProw_affected OUT INT
  );
  
  PROCEDURE GetCreativeGroup
  (
    iPcreativeGroupId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeGroupByTitle
  (
    cPcreativeGroupName IN VARCHAR2,
    iPstartRecord IN INT,
    iPtotalRecord IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeGroupCountByTitle
  (
    cPtitle IN VARCHAR2,
    iPcount OUT INT
  );
  
  PROCEDURE GetCreativeGroupByDeptId
  (
    iPdeptId IN INT,
    iPstartRecord IN INT,
    iPtotalRecord IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeGroupCountByDeptId
  (
    iPdeptId IN INT,
    iPcount OUT INT
  );
  
  PROCEDURE PubCreativeGroup
  (
    iPcreativeGroupId IN INT,
    iPpublished OUT INT
  );
  
  PROCEDURE PubCreative
  (
    iPcreativeId IN INT
  );
  
  PROCEDURE PubCreativeTextContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT
  );
  
  PROCEDURE PubCreativeButtonContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT
  );
  
  PROCEDURE PubCreativeLocation
  (
    iPcreativeId IN INT
  );
  
  PROCEDURE GetCreativeGroupForPublish
  (
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetAllCreativeGroupCount
  (
    iPcount OUT INT
  );
  
  PROCEDURE GetAllCreativeGroup
  (
    iPstartRecord IN INT,
    iPtotalRecord IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeByFileId
  (
    iPfileId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE AddCreative
  (
    iPcreativeGroupId	IN INT,
    iPtype IN INT,
    iPstatus IN INT,
    cPenable IN CHAR,
    cPname IN VARCHAR2,
    iPcreativeId OUT INT
  );
  
  PROCEDURE UpdateCreative
  (
    iPcreativeId IN INT,
    iPstatus IN INT,
    cPenable IN CHAR,
    cPname IN VARCHAR2,
    iProw_affected OUT INT
  );
  
  PROCEDURE DeleteCreative
  (
    iPcreativeId IN INT,
    iProw_affected OUT INT
  );
  
  PROCEDURE GetCreativeByCreativeGroupId
  (
    iPcreativeGroupId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE UpdateCreativeTextContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT,
    cPcontent IN CLOB,
    iProw_affected OUT INT
  );
  
  PROCEDURE UpdateCreativeButtonContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT,
    cPimageLocation IN VARCHAR2,
    iPimageWidth IN INT,
    iPimageHeight IN INT,
    cPalt IN VARCHAR2,
    cPlinkUrl IN VARCHAR2,
    iProw_affected OUT INT
  );
  
  PROCEDURE GetCreativeTxtConByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeBtnConByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeLocatByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetCreativeLocationByLocation
  (
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetOneCreativeLocaByCreativeId
  (
    iPcreativeID IN INT,
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    iPpriority IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE AddCreativeLocation
  (
    iPcreativeID IN INT,
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    iPpriority IN INT,
    iProw_affected OUT INT
  );
  
  PROCEDURE DelCreativeLocation
  (
    iPcreativeId IN INT,
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    iPpriority IN INT,
    iProw_affected OUT INT
  );
  
  PROCEDURE GetAllCreativeLocation
  (
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetAllCreative
  (
    curPresult1 OUT refCur
  );
	
END Pkg_fe_cm_CreativeDalc;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_CM_CREATIVEDALC"
IS

  PROCEDURE AddCreativeGroup
  (
    cPtitle IN VARCHAR2,
    cPdescription IN VARCHAR2,
    iPdeptId IN INT,
    cPenable IN CHAR,
    iPcreativeGroupId OUT INT
  )
  AS
  BEGIN  
    BEGIN
      SELECT seq_creativeGroupId.nextval INTO iPcreativeGroupId
      FROM DUAL;
      
      EXCEPTION WHEN no_data_found THEN
        iPcreativeGroupId := -1;
    END;
    
    INSERT INTO 
    ya_cm_mirror_creative_group
    (creative_group_id, title, description, dept_id, enable)
    VALUES (iPcreativeGroupId, cPtitle, cPdescription, iPdeptId, cPenable);
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END AddCreativeGroup;
  
  PROCEDURE UpdateCreativeGroup
  (
    iPcreativeGroupId IN INT,
    cPtitle IN VARCHAR2,
    cPdescription IN VARCHAR2,
    iPdeptId IN INT,
    cPenable IN CHAR,
    iProw_affected OUT INT
  )
  AS
  BEGIN
    iProw_affected := 0;
  
    UPDATE ya_cm_mirror_creative_group
    SET title = cPtitle, 
    description = cPdescription, 
    dept_id = iPdeptId, 
    enable = cPenable
    WHERE creative_group_id  = iPcreativeGroupId;
    
    iProw_affected := SQL%ROWCOUNT;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END UpdateCreativeGroup;
  
  PROCEDURE GetCreativeGroup
  (
    iPcreativeGroupId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * 
    FROM ya_cm_mirror_creative_group 
    WHERE creative_group_id = iPcreativeGroupId;
  END GetCreativeGroup;
  
  PROCEDURE GetCreativeGroupByTitle
  (
    cPcreativeGroupName IN VARCHAR2,
    iPstartRecord IN INT,
    iPtotalRecord IN INT,
    curPresult1 OUT refCur
  )
  AS
    iLstartCreativeGroupId INT;
  BEGIN
    SELECT creative_group_id INTO iLstartCreativeGroupId
    FROM
    (
      SELECT ROWNUM num, creative_group_id
      FROM
      (
        SELECT cg.creative_group_id
        FROM ya_cm_mirror_creative_group cg 
        WHERE cg.title LIKE cPcreativeGroupName || '%'
        AND 
        (
          cg.creative_group_id 
          IN 
          (
            SELECT DISTINCT creative_group_id 
            FROM ya_cm_mirror_creative 
            WHERE status <> 3
          )
          OR NOT EXISTS
          (
            SELECT 1 
            FROM ya_cm_mirror_creative 
            WHERE creative_group_id = cg.creative_group_id
          )
        )
        ORDER BY cg.creative_group_id DESC
      )
      WHERE ROWNUM <= iPstartRecord + 1
    )
    WHERE num > iPstartRecord;
    
    OPEN curPresult1 FOR
    SELECT *
    FROM
    (
      SELECT * 
      FROM ya_cm_mirror_creative_group cg
      WHERE cg.creative_group_id <= iLstartCreativeGroupId 
      AND cg.title LIKE cPcreativeGroupName || '%'
      AND 
      (
        cg.creative_group_id IN 
        (
          SELECT DISTINCT creative_group_id 
          FROM ya_cm_mirror_creative 
          WHERE status <> 3
        )
        OR NOT EXISTS
        (
          SELECT 1 FROM ya_cm_mirror_creative 
          WHERE creative_group_id = cg.creative_group_id
        )
      )
      ORDER BY cg.creative_group_id DESC
    )
    WHERE ROWNUM <=iPtotalRecord;
  END GetCreativeGroupByTitle;
  
  PROCEDURE GetCreativeGroupCountByTitle
  (
    cPtitle IN VARCHAR2,
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT count(1) INTO iPcount
    FROM ya_cm_mirror_creative_group cg 
    WHERE title LIKE cPtitle || '%'
    AND
    (
      cg.creative_group_id 
      IN
      (
        SELECT DISTINCT creative_group_id 
        FROM ya_cm_mirror_creative 
        WHERE status <> 3
      )
      OR NOT EXISTS
      (
        SELECT 1 
        FROM ya_cm_mirror_creative 
        WHERE creative_group_id = cg.creative_group_id
      )
    );
  END GetCreativeGroupCountByTitle;
  
  PROCEDURE GetCreativeGroupByDeptId
  (
    iPdeptId IN INT,
    iPstartRecord IN INT,
    iPtotalRecord IN INT,
    curPresult1 OUT refCur
  )
  AS
    iLstartCreativeGroupId INT;
  BEGIN
    SELECT creative_group_id INTO iLstartCreativeGroupId
    FROM
    (
      SELECT creative_group_id
      FROM ya_cm_mirror_creative_group cg 
      WHERE dept_id = iPdeptId
      ORDER BY cg.creative_group_id DESC
    )
    WHERE ROWNUM <= iPstartRecord + 1;
    
    OPEN curPresult1 FOR
    SELECT *
    FROM
    (
      SELECT * 
      FROM ya_cm_mirror_creative_group cg
      WHERE cg.creative_group_id <= iLstartCreativeGroupId 
      AND dept_id = iPdeptId 
      ORDER BY cg.creative_group_id DESC
    )
    WHERE ROWNUM <= iPtotalRecord;
  END GetCreativeGroupByDeptId;
  
  PROCEDURE GetCreativeGroupCountByDeptId
  (
    iPdeptId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT count(1) INTO iPcount
    FROM ya_cm_mirror_creative_group cg 
    WHERE dept_id = iPdeptId
    AND 
    (
      cg.creative_group_id 
      IN 
      (
        SELECT DISTINCT creative_group_id 
        FROM ya_cm_mirror_creative 
        WHERE status <> 3
      )
      OR NOT EXISTS
      (
        SELECT 1 
        FROM ya_cm_mirror_creative 
        WHERE creative_group_id = cg.creative_group_id
      )
    );
  END GetCreativeGroupCountByDeptId;
  
  PROCEDURE PubCreativeGroup
  (
    iPcreativeGroupId IN INT,
    iPpublished OUT INT
  )
  AS
    curLfirstCursor refCur;
    iLcreativeId INT;
    iLstatus INT;
    curLsecondCursor refCur;
    iLtempCreativeGroupId INT;
    cLtitle VARCHAR2(100);
    cLdescription VARCHAR2(255);
    iLdeptId INT;
    cLenable CHAR;
    iLexist INT;
  BEGIN
    iPpublished := 0;
    BEGIN
      OPEN curLfirstCursor FOR
        SELECT creative_id, status
        FROM ya_cm_mirror_creative 
        WHERE creative_group_id = iPcreativeGroupId;
      
      FETCH curLfirstCursor INTO iLcreativeId, iLstatus;
        WHILE (curLfirstCursor%FOUND) LOOP
          BEGIN           
            PubCreative(iLcreativeId);
            FETCH curLfirstCursor INTO iLcreativeId, iLstatus;
          END;
        END LOOP;
      CLOSE curLfirstCursor;
    END;
    
    BEGIN
      OPEN curLsecondCursor FOR
        SELECT creative_group_id, title, description, dept_id, enable
        FROM ya_cm_mirror_creative_group
        WHERE creative_group_id = iPcreativeGroupId;
      
      FETCH curLsecondCursor 
      INTO iLtempCreativeGroupId, cLtitle, cLdescription, iLdeptId, cLenable;
        WHILE (curLsecondCursor%FOUND) LOOP
          BEGIN
            UPDATE ya_cm_creative_group 
            SET 
            title = cLtitle, 
            description = cLdescription, 
            dept_id = iLdeptId, 
            enable = cLenable 
            WHERE creative_group_id = iPcreativeGroupId;
          END;
          FETCH curLsecondCursor 
          INTO iLtempCreativeGroupId, cLtitle, cLdescription, iLdeptId, cLenable;
        END LOOP;
      CLOSE curLsecondCursor;
    END;
    
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_creative_group 
      WHERE creative_group_id = iPcreativeGroupId;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    BEGIN
      SELECT creative_group_id, title, description, dept_id, enable
      INTO iLtempCreativeGroupId, cLtitle, cLdescription, iLdeptId, cLenable
      FROM ya_cm_mirror_creative_group
      WHERE creative_group_id = iPcreativeGroupId;
    END;
      
    IF(iLexist) < 1 THEN
      INSERT INTO ya_cm_creative_group 
      (creative_group_id, title, description, dept_id, enable)
      VALUES
      (iLtempCreativeGroupId, cLtitle, cLdescription, iLdeptId, cLenable);
    ELSE
      UPDATE ya_cm_creative_group
      SET 
      title = cLtitle, 
      description = cLdescription, 
      dept_id = iLdeptId, 
      enable = cLenable
      WHERE 
      creative_group_id = iLtempCreativeGroupId 
      AND creative_group_id = iPcreativeGroupId;
    END IF;
    
    IF SQLCODE = 0 THEN
      iPpublished := 1;
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END PubCreativeGroup;
  
  PROCEDURE PubCreative
  (
    iPcreativeId IN INT
  )
  AS
  iLtempCreativeId INT;
  iLcreativeGroupId INT;
  iLtype INT;
  iLstatus INT;
  cLenable CHAR;
  cLname VARCHAR(100);
  curLfirstCursor refCur;
  iLexist INT;
  curLsecondCursor refCur;
  iLvalid INT;
  BEGIN
    BEGIN
      OPEN curLfirstCursor FOR
        SELECT creative_id, creative_group_id, type, status, enable, name
        FROM ya_cm_mirror_creative 
        WHERE creative_id = iPcreativeId;
      FETCH curLfirstCursor 
      INTO iLtempCreativeId, iLcreativeGroupId, iLtype, iLstatus, cLenable, cLname;
        WHILE (curLfirstCursor%FOUND) LOOP
          IF (iLtype=1 OR iLtype=102 OR iLtype=101 OR iLtype=104 OR iLtype=105) 
          THEN
            PubCreativeTextContent(iPcreativeId, 1);
            PubCreativeTextContent(iPcreativeId, 2);
            PubCreativeTextContent(iPcreativeId, 3);
            PubCreativeTextContent(iPcreativeId, 4);
            PubCreativeTextContent(iPcreativeId, 5);
          END IF;
          
          IF (iLtype = 2 or iLtype=3 OR iLtype=103) THEN    
            PubCreativeButtonContent(iPcreativeId, 1);
            PubCreativeButtonContent(iPcreativeId, 2);
            PubCreativeButtonContent(iPcreativeId, 3);
            PubCreativeButtonContent(iPcreativeId, 4);
            PubCreativeButtonContent(iPcreativeId, 5);
          END IF;
          
          IF (iLstatus = 2) THEN
            UPDATE ya_cm_creative 
            SET 
            creative_group_id = iLcreativeGroupId, 
            type = iLtype, 
            status = iLstatus, 
            enable = cLenable, 
            name = cLname
            where creative_id = iPcreativeId;
      
            UPDATE ya_cm_mirror_creative 
            SET status = 1
            WHERE creative_id = iPcreativeId;
          END IF;
          
          IF (iLstatus = 3) THEN
            DELETE ya_cm_creative_text_lang where creative_id = iPcreativeId;
            DELETE ya_cm_creative_button_lang where creative_id = iPcreativeId;
            DELETE ya_cm_creative where creative_id = iPcreativeId;
            
            DELETE ya_cm_mirror_creative_txt_lang where creative_id = iPcreativeId;
            DELETE ya_cm_mirror_creative_btn_lang where creative_id = iPcreativeId;
            DELETE ya_cm_mirror_creative where creative_id = iPcreativeId;
          END IF;
          
          FETCH curLfirstCursor 
          INTO iLtempCreativeId, iLcreativeGroupId, iLtype, iLstatus, cLenable, cLname;
        END LOOP;
      CLOSE curLfirstCursor;
    END;
      
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_creative 
      WHERE creative_id = iPcreativeId;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    BEGIN
      SELECT 1 INTO iLvalid
      FROM ya_cm_mirror_creative 
      WHERE creative_id = iPcreativeId;
      
      EXCEPTION WHEN no_data_found THEN
        iLvalid := -1;
    END;
      
    IF (iLvalid) > 0 THEN
      SELECT creative_id, creative_group_id, type, status, enable, name 
      INTO iLtempCreativeId, iLcreativeGroupId, iLtype, iLstatus, cLenable, cLname
      FROM ya_cm_mirror_creative 
      WHERE creative_id = iPcreativeId;
      
      IF (iLexist) < 1 THEN
        INSERT INTO ya_cm_creative 
        (creative_id, creative_group_id, type, status, enable, name)
        VALUES
        (iLtempCreativeId, iLcreativeGroupId, iLtype, iLstatus, cLenable, cLname);
      ELSE
        IF (iLstatus = 2) THEN
          UPDATE ya_cm_creative 
          SET 
          creative_group_id = iLcreativeGroupId, 
          type = iLtype, 
          status = iLstatus, 
          enable = cLenable, 
          name = cLenable
          where creative_id = iLtempCreativeId and creative_id = iPcreativeId;
            
          UPDATE ya_cm_mirror_creative 
          SET status = 1
          WHERE creative_id = iPcreativeId;
        END IF;
          
        IF (iLstatus = 3) THEN
          DELETE ya_cm_creative_text_lang WHERE creative_id = iPcreativeId;
          DELETE ya_cm_creative_button_lang WHERE creative_id = iPcreativeId;
          DELETE ya_cm_creative WHERE creative_id = iPcreativeId;
            
          DELETE ya_cm_mirror_creative_txt_lang WHERE creative_id = iPcreativeId;
          DELETE ya_cm_mirror_creative_btn_lang WHERE creative_id = iPcreativeId;
          DELETE ya_cm_mirror_creative WHERE creative_id = iPcreativeId;
        END IF;
      END IF;
    END IF;
    
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_mirror_creative_location 
      WHERE creative_id = iPcreativeId
      AND ROWNUM<2;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    IF (iLexist) > 0 THEN
      PubCreativeLocation(iPcreativeId);
    END IF;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END PubCreative;
  
  PROCEDURE PubCreativeTextContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT
  )
  AS
    iLhaveContent INT;
    iLexist INT;
    iLcreativeId INT;
    iLlangId INT;
    iLcontent CLOB;
  BEGIN
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_creative_text_lang   
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    BEGIN
      SELECT 1 INTO iLhaveContent
      FROM ya_cm_mirror_creative_txt_lang   
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
      
      EXCEPTION WHEN no_data_found THEN
        iLhaveContent := -1;
    END;
    
    IF (iLhaveContent) > 0 THEN
      SELECT creative_id, lang_id, content
      INTO iLcreativeId, iLlangId, iLcontent
      FROM ya_cm_mirror_creative_txt_lang   
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
    
      IF (iLexist) < 1 THEN
        INSERT INTO ya_cm_creative_text_lang 
        (creative_id, lang_id, content)  
        VALUES
        (iLcreativeId, iLlangId, iLcontent);
      ELSE
        UPDATE ya_cm_creative_text_lang  
        SET 
        content = iLcontent
        WHERE creative_id = iLcreativeId 
        AND lang_id = iLlangId
        AND creative_id = iPcreativeId;
      END IF;
    END IF;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END PubCreativeTextContent;
  
  PROCEDURE PubCreativeButtonContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT
  )
  AS
    iLexist INT;
    iLhaveContent INT;
    iLcreativeId INT;
    iLlangId INT;
    iLimageLoc VARCHAR2(100);
    iLimageWidth INT;
    iLimageHeight INT;
    iLalt VARCHAR2(100);
    iLlinkUrl VARCHAR2(200);
  BEGIN
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_creative_button_lang  
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    BEGIN
      SELECT 1 INTO iLhaveContent
      FROM ya_cm_mirror_creative_btn_lang   
      WHERE creative_id = iPcreativeId 
      AND lang_id = iLlangId; 
      
      EXCEPTION WHEN no_data_found THEN
        iLhaveContent := -1;
    END;
    
    IF (iLhaveContent) > 0 THEN
      SELECT creative_id, lang_id, image_loc, image_width, image_height, alt, link_url
      INTO iLcreativeId, iLlangId, iLimageLoc, iLimageWidth, iLimageHeight, iLalt, iLlinkUrl
      FROM ya_cm_mirror_creative_btn_lang   
      WHERE creative_id = iPcreativeId 
      AND lang_id = iLlangId; 
    
      IF (iLexist) < 1 THEN
        INSERT INTO ya_cm_creative_button_lang 
        (creative_id, lang_id, image_loc, image_width, image_height, alt, link_url)  
        VALUES
        (iLcreativeId, iLlangId, iLimageLoc, iLimageWidth, iLimageHeight, iLalt, iLlinkUrl);
      ELSE
        UPDATE ya_cm_creative_button_lang  
        SET 
        image_loc = iLimageLoc, 
        image_width = iLimageWidth, 
        image_height = iLimageHeight, 
        alt = iLalt, 
        link_url = iLlinkUrl
        WHERE creative_id = iPcreativeId 
        AND lang_id = iPlangId;
      END IF;
    END IF;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END PubCreativeButtonContent;
  
  PROCEDURE PubCreativeLocation
  (
    iPcreativeId IN INT
  )
  AS
    iLcreativeId INT;
    iLfileId INT;
    iLsiteId INT;
    iLlocation INT;
    iLpriority INT;
    curPfirstCursor refCur;
  BEGIN
    DELETE ya_cm_creative_location 
    WHERE creative_id = iPcreativeId;
    
    OPEN curPfirstCursor FOR
      SELECT creative_id, file_id, site_id, location, priority
      FROM ya_cm_mirror_creative_location 
      WHERE creative_id = iPcreativeId;
    FETCH curPfirstCursor 
    INTO iLcreativeId, iLfileId, iLsiteId, iLlocation, iLpriority;
      WHILE (curPfirstCursor%FOUND) LOOP
        BEGIN
          INSERT INTO ya_cm_creative_location 
          (creative_id, file_id, site_id, location, priority)
          VALUES
          (iLcreativeId, iLfileId, iLsiteId, iLlocation, iLpriority);
          
          FETCH curPfirstCursor 
          INTO iLcreativeId, iLfileId, iLsiteId, iLlocation, iLpriority;
        END;
      END LOOP;
    CLOSE curPfirstCursor;  
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;  
  
  END PubCreativeLocation;
  
  PROCEDURE GetCreativeGroupForPublish
  (
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * 
    FROM ya_cm_mirror_creative_group cg 
    WHERE creative_group_id 
    IN
    (
      SELECT creative_group_id 
      FROM ya_cm_mirror_creative 
      WHERE status <> 1
    );
  END GetCreativeGroupForPublish;
  
  PROCEDURE GetAllCreativeGroupCount
  (
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT count(1) INTO iPcount
    FROM ya_cm_mirror_creative_group cg
    WHERE 
    cg.creative_group_id IN 
    (
      SELECT DISTINCT creative_group_id 
      FROM ya_cm_mirror_creative 
      WHERE status <> 3
    )
    OR NOT EXISTS
    (
      SELECT 1 
      FROM ya_cm_mirror_creative 
      WHERE creative_group_id = cg.creative_group_id
    );
    
    EXCEPTION WHEN no_data_found THEN
      iPcount := -1;
  END GetAllCreativeGroupCount;
  
  PROCEDURE GetAllCreativeGroup         
  (
    iPstartRecord IN INT,
    iPtotalRecord IN INT,
    curPresult1 OUT refCur
  )
  AS
    iLstartCreativeGroupId INT;
  BEGIN
    SELECT creative_group_id INTO iLstartCreativeGroupId
    FROM
    (
      SELECT rownum num, creative_group_id
      FROM
      (
        SELECT creative_group_id
        FROM ya_cm_mirror_creative_group cg 
        WHERE 
        (
          cg.creative_group_id 
          IN 
          (
            SELECT DISTINCT creative_group_id 
            FROM ya_cm_mirror_creative 
            WHERE status <> 3
          )
          OR NOT EXISTS
          (
            SELECT 1 
            FROM ya_cm_mirror_creative 
            WHERE creative_group_id = cg.creative_group_id
          )
        )
        ORDER BY cg.creative_group_id DESC
      )
      WHERE ROWNUM <= iPstartRecord + 1
    )
    WHERE num > iPstartRecord;
    
    OPEN curPresult1 FOR
    SELECT * 
    FROM
    (
      SELECT * FROM ya_cm_mirror_creative_group cg
      WHERE cg.creative_group_id <= iLstartCreativeGroupId 
      AND 
      (
        cg.creative_group_id IN 
        (
          SELECT DISTINCT creative_group_id 
          FROM ya_cm_mirror_creative 
          WHERE status <> 3
        )
        OR NOT EXISTS
        (
          SELECT 1 
          FROM ya_cm_mirror_creative 
          WHERE creative_group_id = cg.creative_group_id
        )
      )
      ORDER BY cg.creative_group_id DESC
    )
    WHERE ROWNUM <= iPtotalRecord;
  END GetAllCreativeGroup;
  
  PROCEDURE GetCreativeByFileId
  (
    iPfileId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
      SELECT * 
      FROM ya_cm_mirror_creative c 
      WHERE creative_id IN 
      (
        SELECT creative_id 
        FROM ya_cm_mirror_creative_location cl 
        WHERE cl.file_id = iPfileId
      );
  END GetCreativeByFileId;
  
  PROCEDURE AddCreative
  (
    iPcreativeGroupId	IN INT,
    iPtype IN INT,
    iPstatus IN INT,
    cPenable IN CHAR,
    cPname IN VARCHAR2,
    iPcreativeId OUT INT
  )
  AS
  BEGIN
    iPcreativeId := -1;
    
    SELECT seq_creativeId.nextval INTO iPcreativeId
    FROM DUAL;
    
    INSERT INTO ya_cm_mirror_creative
    (creative_id, creative_group_id, type, status, enable, name)
    VALUES 
    (iPcreativeId, iPcreativeGroupId, iPtype, iPstatus, cPenable, cPname);
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END AddCreative;
  
  PROCEDURE UpdateCreative
  (
    iPcreativeId IN INT,
    iPstatus IN INT,
    cPenable IN CHAR,
    cPname IN VARCHAR2,
    iProw_affected OUT INT
  )
  AS
  BEGIN
    iProw_affected := 0;
    UPDATE ya_cm_mirror_creative 
    SET status = iPstatus, 
    enable = cPenable, 
    name = cPname 
    WHERE creative_id = iPcreativeId;
    iProw_affected := SQL%ROWCOUNT;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      iProw_affected := 0;
      ROLLBACK;
    END IF;
  END UpdateCreative;
  
  PROCEDURE DeleteCreative
  (
    iPcreativeId IN INT,
    iProw_affected OUT INT
  )
  AS
  BEGIN
    iProw_affected := 0;
    
    UPDATE ya_cm_mirror_creative 
    SET status = 3 
    WHERE creative_id = iPcreativeId;
    iProw_affected := SQL%ROWCOUNT;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      iProw_affected := 0;
      ROLLBACK;
    END IF;
  END DeleteCreative;
  
  PROCEDURE GetCreativeByCreativeGroupId
  (
    iPcreativeGroupId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * 
    FROM ya_cm_mirror_creative 
    WHERE creative_group_id = iPcreativeGroupId;
  END GetCreativeByCreativeGroupId;
  
  PROCEDURE GetCreativeByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * 
    FROM ya_cm_mirror_creative 
    WHERE creative_id = iPcreativeId;
  END GetCreativeByCreativeId;
  
  PROCEDURE UpdateCreativeTextContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT,
    cPcontent IN CLOB,
    iProw_affected OUT INT
  )
  AS
    iLexist INT;
  BEGIN
    iProw_affected := 0;
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_mirror_creative_txt_lang 
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    IF (iLexist) < 0 THEN
      INSERT INTO ya_cm_mirror_creative_txt_lang 
      (creative_id, lang_id, content) 
      VALUES 
      (iPcreativeId, iPlangId, cPcontent);
    ELSE
      UPDATE ya_cm_mirror_creative_txt_lang 
      SET 
      content = cPcontent 
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
    END IF;
    
    IF SQLCODE = 0 THEN
      iProw_affected := SQL%ROWCOUNT;
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END UpdateCreativeTextContent;
  
  PROCEDURE UpdateCreativeButtonContent
  (
    iPcreativeId IN INT,
    iPlangId IN INT,
    cPimageLocation IN VARCHAR2,
    iPimageWidth IN INT,
    iPimageHeight IN INT,
    cPalt IN VARCHAR2,
    cPlinkUrl IN VARCHAR2,
    iProw_affected OUT INT
  )
  AS
    iLexist INT;
  BEGIN
    iProw_affected := 0;
    BEGIN
      SELECT 1 INTO iLexist
      FROM ya_cm_mirror_creative_btn_lang
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
      
      EXCEPTION WHEN no_data_found THEN
        iLexist := -1;
    END;
    
    IF (iLexist) < 0 THEN
      INSERT INTO ya_cm_mirror_creative_btn_lang 
      (creative_id, lang_id, image_loc, image_width, image_height, alt, link_url) 
      VALUES
      (iPcreativeId, iPlangId, cPimageLocation, iPimageWidth, iPimageHeight, cPalt, cPlinkUrl);
    ELSE
      UPDATE ya_cm_mirror_creative_btn_lang 
      SET 
      image_loc = cPimageLocation, 
      image_width = iPimageWidth, 
      image_height = iPimageHeight, 
      alt = cPalt, 
      link_url = cPlinkUrl
      WHERE creative_id = iPcreativeId 
      AND lang_id = iPlangId;
    END IF;
    
    IF SQLCODE = 0 THEN
      iProw_affected := SQL%ROWCOUNT;
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END UpdateCreativeButtonContent;
  
  PROCEDURE GetCreativeTxtConByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
      SELECT * 
      FROM ya_cm_mirror_creative_txt_lang 
      where creative_id = iPcreativeId;
  END GetCreativeTxtConByCreativeId;
  
  PROCEDURE GetCreativeBtnConByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * 
    FROM ya_cm_mirror_creative_btn_lang 
    WHERE creative_id = iPcreativeId;
  END GetCreativeBtnConByCreativeId;
  
  PROCEDURE GetCreativeLocatByCreativeId
  (
    iPcreativeId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT creative_id,file_id,site_id,location,priority,path 
    FROM ya_cm_mirror_creative_location c 
    INNER JOIN ya_content_filename f on c.file_id=f.id 
    WHERE creative_id = iPcreativeId;
  END GetCreativeLocatByCreativeId;
  
  PROCEDURE GetCreativeLocationByLocation
  (
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * 
    FROM ya_cm_mirror_creative_location 
    WHERE file_id = iPfileId 
    AND site_id = iPsiteId 
    AND location = iPlocation;
  END GetCreativeLocationByLocation;
  
  PROCEDURE GetOneCreativeLocaByCreativeId
  (
    iPcreativeID IN INT,
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    iPpriority IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
    *
    FROM
      ya_cm_mirror_creative_location
    WHERE
      creative_id = iPcreativeId
      AND file_id = iPfileId
      AND site_id = iPsiteId
      AND location = iPlocation
      AND priority = iPpriority;
  END GetOneCreativeLocaByCreativeId;
  
  PROCEDURE AddCreativeLocation
  (
    iPcreativeID IN INT,
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    iPpriority IN INT,
    iProw_affected OUT INT
  )
  AS
    iLhavePriority INT;
  BEGIN
    iProw_affected := 0;
    IF (iPpriority = -1) THEN
      BEGIN
        SELECT max(priority) + 1 INTO iLhavePriority
        FROM ya_cm_mirror_creative_location
        WHERE file_id = iPfileId
        AND site_id = iPsiteId
        AND location = iPlocation;
        
        EXCEPTION WHEN no_data_found THEN
          iLhavePriority := 0;
      END;
    END IF;
    
    IF(iLhavePriority = 0) THEN
      INSERT INTO ya_cm_mirror_creative_location
      (creative_id, file_id, site_id, location, priority) 
      VALUES 
      (iPcreativeId, iPfileId, iPsiteId, iPlocation, iLhavePriority);
    ELSE
      INSERT INTO ya_cm_mirror_creative_location
      (creative_id, file_id, site_id, location, priority) 
      VALUES 
      (iPcreativeId, iPfileId, iPsiteId, iPlocation, iPpriority);
    END IF;
    
    IF SQLCODE = 0 THEN
      iProw_affected := SQL%ROWCOUNT;
      COMMIT;
    ELSE
      iProw_affected := 0;
      ROLLBACK;
    END IF;
  END AddCreativeLocation;
  
  PROCEDURE DelCreativeLocation
  (
    iPcreativeID IN INT,
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlocation IN INT,
    iPpriority IN INT,
    iProw_affected OUT INT
  )
  AS
  BEGIN
    DELETE ya_cm_mirror_creative_location 
    WHERE file_id = iPfileId 
    AND site_id = iPsiteId 
    AND location = iPlocation 
    AND creative_id = iPcreativeId 
    AND priority = iPpriority;
    
    IF SQLCODE = 0 THEN
      iProw_affected := SQL%ROWCOUNT;
      COMMIT;
    ELSE
      iProw_affected := 0;
      ROLLBACK;
    END IF;
  END DelCreativeLocation;
  
  PROCEDURE GetAllCreativeLocation
  (
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * FROM ya_cm_mirror_creative_location;
  END GetAllCreativeLocation;
  
  PROCEDURE GetAllCreative
  (
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT * FROM ya_cm_mirror_creative 
    WHERE enable = 'Y' ORDER BY creative_id DESC;
  END GetAllCreative;
	
END Pkg_fe_cm_CreativeDalc;
/

REM END SS_ADM PKG_FE_CM_CREATIVEDALC