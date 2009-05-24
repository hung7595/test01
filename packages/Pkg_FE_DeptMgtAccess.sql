CREATE OR REPLACE PACKAGE Pkg_FE_DeptMgtAccess
AS
  TYPE refCur IS REF CURSOR;
  PROCEDURE AddAttribute (
  cPattrNameEn IN VARCHAR2,
  cPattrNameB5 IN VARCHAR2,
  cPattrNameJp IN VARCHAR2,
  cPattrNameKr IN VARCHAR2,
  cPattrNameGb IN VARCHAR2,
  iPattrType in int,
  iPattributeId out int
  );
  
  PROCEDURE AddDeptStep1 (
  iPdispSeq IN INT,
  cPuser IN VARCHAR2,
  cPdeptDescription IN VARCHAR2,
  iPparentDeptId IN INT,
  cPdeptNameEn IN VARCHAR2,
  cPdeptNameB5 IN VARCHAR2,
  cPdeptNameJp IN VARCHAR2,
  cPdeptNameKr IN VARCHAR2,
  cPdeptNameGb IN VARCHAR2,
  cPdeptNameEnU IN NVARCHAR2,
  cPdeptNameB5U IN NVARCHAR2,
  cPdeptNameJpU IN NVARCHAR2,
  cPdeptNameKrU IN NVARCHAR2,
  cPdeptNameGbU IN NVARCHAR2,
  cPusEnabled IN CHAR,
  cPtwEnabled IN CHAR,
  cPysEnabled IN CHAR,
  iPdeptId out int
  );
  
  PROCEDURE AddDeptStep2 (  
  iPdeptId IN INT,
  iPattributeId IN INT,
  iProw_affacted OUT INT
  );
    
  PROCEDURE GetAttributeName (  
  iPattributeId IN INT,
  curPresult1 out refCur
  );
  
  PROCEDURE GetDeptAttr (  
  iPdeptId IN INT,
  curPresult1 out refCur
  );
  
  PROCEDURE GetDeptNameByDeptID (  
  iPdeptId IN INT,
  curPresult1 out refCur
  );
  
  PROCEDURE GetPagedDeptList (  
  iPdeptId IN INT,
  cPdeptName IN VARCHAR2,
  iPpageNo IN INT,
  iPpageSize IN INT,
  curPresult1 out refCur
  );
  PROCEDURE GetRecordCount (  
  iPdeptId IN INT,
  cPdeptName IN VARCHAR2,
  iPpageNo IN INT,
  iPpageSize IN INT,
  iPrecordCount OUT INT
  );
  PROCEDURE UpdateAttribute (  
  iPattributeId IN INT,
  cPattrNameEn IN VARCHAR2,
  cPattrNameB5 IN VARCHAR2,
  cPattrNameJp IN VARCHAR2,
  cPattrNameKr IN VARCHAR2,
  cPattrNameGb IN VARCHAR2,
  iProw_affacted OUT INT
  );
  
  PROCEDURE UpdateDeptName (
  iPdeptId IN INT,
  cPdeptNameEn IN VARCHAR2,
  cPdeptNameB5 IN VARCHAR2,
  cPdeptNameJp IN VARCHAR2,
  cPdeptNameKr IN VARCHAR2,
  cPdeptNameGb IN VARCHAR2,
  cPdeptNameEnU IN NVARCHAR2,
  cPdeptNameB5U IN NVARCHAR2,
  cPdeptNameJpU IN NVARCHAR2,
  cPdeptNameKrU IN NVARCHAR2,
  cPdeptNameGbU IN NVARCHAR2,
  iProw_affacted OUT INT
  );
    	
  PROCEDURE GetBrowsePath (  
  iPdeptId IN INT,
  iPlangId IN INT,
  curPresult1 out refCur
  );
    
  PROCEDURE GetAttributeType ( 
  curPresult1 out refCur
  );
  
   END Pkg_FE_DeptMgtAccess;

/


CREATE OR REPLACE PACKAGE BODY PKG_FE_DEPTMGTACCESS AS

  PROCEDURE AddAttribute (
  cPattrNameEn IN VARCHAR2,
  cPattrNameB5 IN VARCHAR2,
  cPattrNameJp IN VARCHAR2,
  cPattrNameKr IN VARCHAR2,
  cPattrNameGb IN VARCHAR2,
  iPattrType in int,
  iPattributeId out int
  ) 
  AS  
    iLAttrId int;
    iLexistValue int;
  BEGIN	
	--select seq_dept_id from DB
        iLexistValue := 1;
        
	WHILE (iLexistValue > 0)
	LOOP
            iLexistValue := 0;
		SELECT seq_attribute_id.nextval INTO iLAttrId FROM dual;	
                select count(*) into iLexistValue from ya_attribute where ATTRIBUTE_ID = iLAttrId;
	END LOOP;
	
	INSERT INTO ya_attribute(ATTRIBUTE_ID, attribute_type_id) values (iLAttrId,iPattrType); 
	iPattributeId := iLAttrId;

	--insert into ya_attribute lang  
	INSERT INTO ya_attribute_lang(attribute_id,lang_id,attribute_name) values (iLAttrId,1,cPattrNameEn);
	INSERT INTO ya_attribute_lang(attribute_id,lang_id,attribute_name) values (iLAttrId,2,cPattrNameB5);
	INSERT INTO ya_attribute_lang(attribute_id,lang_id,attribute_name) values (iLAttrId,3,cPattrNameJp);
	INSERT INTO ya_attribute_lang(attribute_id,lang_id,attribute_name) values (iLAttrId,4,cPattrNameKr);
	INSERT INTO ya_attribute_lang(attribute_id,lang_id,attribute_name) values (iLAttrId,5,cPattrNameGb);
	INSERT INTO ya_attribute_lang(attribute_id,lang_id,attribute_name) values (iLAttrId,6,cPattrNameEn);

	--add to preferred attribute list 
	--no this table in oracle problem
	INSERT INTO ya_preferred_attr_list(prod_line_id,attribute_id) values (1,iLAttrId);
	
    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;

  END AddAttribute;

  PROCEDURE AddDeptStep1 (
  iPdispSeq IN INT,
  cPuser IN VARCHAR2,
  cPdeptDescription IN VARCHAR2,
  iPparentDeptId IN INT,
  cPdeptNameEn IN VARCHAR2,
  cPdeptNameB5 IN VARCHAR2,
  cPdeptNameJp IN VARCHAR2,
  cPdeptNameKr IN VARCHAR2,
  cPdeptNameGb IN VARCHAR2,
  cPdeptNameEnU IN NVARCHAR2,
  cPdeptNameB5U IN NVARCHAR2,
  cPdeptNameJpU IN NVARCHAR2,
  cPdeptNameKrU IN NVARCHAR2,
  cPdeptNameGbU IN NVARCHAR2,
  cPusEnabled IN CHAR,
  cPtwEnabled IN CHAR,
  cPysEnabled IN CHAR,
  iPdeptId out int
  ) 
  AS
    iLDeptId int;
    iLexistValue int;
  BEGIN


    --select seq_dept_id from DB
        iLexistValue := 1;
        
	WHILE (iLexistValue > 0)
	LOOP
            iLexistValue := 0;
		SELECT seq_dept_id.nextval INTO iLDeptId FROM dual;	
                select count(*) into iLexistValue from ya_dept where dept_id = iLDeptId;
	END LOOP;
		
--/****STEP 2 : CREATE DEPARTMENT*****/  
    INSERT INTO ya_dept(dept_id, created_date, updated_date, created_user, updated_user)
	  VALUES(iLDeptId, sysdate, sysdate, cPuser, cPuser);
	  
	  /* update department-site setting */
	  INSERT INTO ya_dept_site (dept_id, site_id, is_enabled)
	  VALUES (iLDeptId, 1, cPusEnabled);
	  INSERT INTO ya_dept_site (dept_id, site_id, is_enabled)
	  VALUES (iLDeptId, 7, cPtwEnabled);
	  INSERT INTO ya_dept_site (dept_id, site_id, is_enabled)
	  VALUES (iLDeptId, 10, cPysEnabled);
	  INSERT INTO ya_dept_site (dept_id, site_id, is_enabled)
	  VALUES (iLDeptId, 11, cPysEnabled);	  
	  	  		
    iPdeptId :=iLDeptId;
--/****STEP 3 : DEPARTMENT LANGUAGE, NEED TO MODIFY THIS PART*****/
	--1.1.1 prepare language translation of 5 languages, it also need in the part 1.6
	--1.1.2 insert department language in ya_dept_lang
	  INSERT INTO ya_dept_lang(dept_id,lang_id,dept_name,dept_name_u,dept_description)
	  VALUES(iLDeptId, 1, cPdeptNameEn, cPdeptNameEnU, cPdeptDescription);
	  INSERT INTO ya_dept_lang(dept_id,lang_id,dept_name,dept_name_u,dept_description)
	  VALUES(iLDeptId, 2, cPdeptNameB5, cPdeptNameB5U, cPdeptDescription);
	  INSERT INTO ya_dept_lang(dept_id,lang_id,dept_name,dept_name_u,dept_description)
	  VALUES(iLDeptId, 3, cPdeptNameJp, cPdeptNameJpU, cPdeptDescription);
	  INSERT INTO ya_dept_lang(dept_id,lang_id,dept_name,dept_name_u,dept_description)
	  VALUES(iLDeptId, 4, cPdeptNameKr, cPdeptNameKrU, cPdeptDescription);
	  INSERT INTO ya_dept_lang(dept_id,lang_id,dept_name,dept_name_u,dept_description)
	  VALUES(iLDeptId, 5, cPdeptNameGb, cPdeptNameGbU, cPdeptDescription);

--/****STEP 4 : CREATE DEPARTMENT RELATIONSHIP*****/
	IF iPparentDeptId>0 THEN
		INSERT INTO ya_dept_rel(dept_id, parent_dept_id)
		VALUES(iLDeptId, iPparentDeptId);
--/****STEP 5 : ADD PARENT DEPARTMENT ATTRIBUTE*****/
		INSERT INTO ya_dept_attr(dept_id, attribute_id)
		SELECT iLDeptId, attribute_id 
			FROM ya_dept_attr WHERE dept_id = iPparentDeptId;
	END IF;

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;

  END AddDeptStep1;

  PROCEDURE AddDeptStep2 (  
  iPdeptId IN INT,
  iPattributeId IN INT,
  iProw_affacted OUT INT
  )   AS
    iLnodeSequenceId int;
    iLtempNodeId int;
    iLexistValue int;
    iLterminalDeptId int;
  BEGIN
	--/****STEP 6 : ADD DEPARTMENT ATTRIBUTE, NEED TO MODIFY THIS PART*****/
	INSERT INTO ya_dept_attr(dept_id, attribute_id)
	VALUES(iPdeptId,iPattributeId);

--/****STEP 7 : GENERATE BROWSING TREE*****/

    iLexistValue :=0;
    iLnodeSequenceId :=1;
    iLterminalDeptId := iPdeptId;
    iLtempNodeId := iPdeptId;
      SELECT count(*) INTO iLexistValue FROM ya_browse_dept_path WHERE terminal_dept_id = iLterminalDeptId;
      IF (iLexistValue>0) THEN
	DELETE ya_browse_dept_path
	  WHERE terminal_dept_id = iLterminalDeptId;
      END IF;
          
      SELECT count(*) INTO iLexistValue FROM ya_dept_rel WHERE dept_id = iLtempNodeId;

	WHILE (iLexistValue>0) LOOP
	  INSERT INTO ya_browse_dept_path
	    (terminal_dept_id, node_sequence_id, dept_id, last_updated_datetime)
	    SELECT iLterminalDeptId, iLnodeSequenceId, dl.dept_id, sysdate
	    FROM ya_dept_lang dl
	    WHERE dept_id = iLtempNodeId 
	    AND dl.lang_id = 1;

	    SELECT parent_dept_id into iLtempNodeId 
	    FROM ya_dept_rel
	    WHERE dept_id = iLtempNodeId and rownum<2;

	    iLnodeSequenceId := iLnodeSequenceId + 1;
            iLexistValue := 0;
            SELECT count(*) INTO iLexistValue FROM ya_dept_rel WHERE dept_id = iLtempNodeId;
	END LOOP;

	INSERT INTO ya_browse_dept_path
	(terminal_dept_id, node_sequence_id, dept_id, last_updated_datetime)
	SELECT iLterminalDeptId, iLnodeSequenceId, dl.dept_id, sysdate
	FROM ya_dept_lang dl
	WHERE dept_id = iLtempNodeId 
	AND dl.lang_id = 1 AND dept_id not in (0);


    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;

  END AddDeptStep2;

  PROCEDURE GetAttributeName (  
  iPattributeId IN INT,
  curPresult1 out refCur
  ) 
  AS
  BEGIN
    OPEN curPresult1 FOR
	  select * from ya_attribute_lang where attribute_id=iPattributeId;
	RETURN;

  END GetAttributeName;

  PROCEDURE GetDeptAttr (  
  iPdeptId IN INT,
  curPresult1 out refCur
  )AS
  BEGIN
    OPEN curPresult1 FOR
	  select da.dept_id,al.attribute_id,lang_id,attribute_name
	from ya_dept_attr da 
	inner join ya_attribute_lang al on da.attribute_id=al.attribute_id 
	where dept_id=iPdeptId and al.lang_id=1;
	RETURN;

  END GetDeptAttr;

  PROCEDURE GetDeptNameByDeptID (  
  iPdeptId IN INT,
  curPresult1 out refCur
  )  AS
  BEGIN
    OPEN curPresult1 FOR	  
		select lang_id,dept_name_u
		from ya_dept_lang al 
		where dept_id=iPdeptId;
	RETURN;

  END GetDeptNameByDeptID;

  PROCEDURE GetPagedDeptList (  
  iPdeptId IN INT,
  cPdeptName IN VARCHAR2,
  iPpageNo IN INT,
  iPpageSize IN INT,
  curPresult1 out refCur
  ) AS
    iLStartRow int;
    iLlastDeptId int;
    iLlastLangId int;
    cLword VARCHAR2(100);
  BEGIN
   -- OPEN curPresult1 FOR	  
	--	select lang_id,dept_name_u
	--	from ya_dept_lang al 
	--	where dept_id=iPdeptId;
	--RETURN;
	cLword :='%'||cPdeptName||'%';
	IF iPdeptId >0 THEN
    OPEN curPresult1 FOR	
		-- search by dept ID
		SELECT dept_id, lang_id,dept_name,dept_name_u 
		FROM ya_dept_lang
	     WHERE
		     dept_id = iPdeptId and lang_id=1
			ORDER BY dept_id;
	ELSE
		--search by keyword
		iLStartRow:=(iPpageNo -1) * iPpageSize +1;
	--	SELECT count(d.dept_id) From ya_dept d 
	--		inner join ya_dept_lang dl on d.dept_id=dl.dept_id 
	--		where dept_name_u like '%' + cPdeptName + '%';

--SELECT iLlastDeptId = dept_id,iLlastLangId=lang_id FROM ya_dept_lang where dept_name_u like '%' + cPdeptName + '%' ORDER BY dept_id,lang_id

            OPEN curPresult1 FOR	
                SELECT dept_id, lang_id,dept_name,dept_name_u 
		FROM 
                (select dept_id, lang_id,dept_name,dept_name_u,rownum as rnum 
                  from ya_dept_lang 
                  WHERE dept_name_u like cLword and rownum < iLStartRow+iPpageSize)
                  WHERE rnum >= iLStartRow
		ORDER BY dept_id,lang_id;

	END IF;

  END GetPagedDeptList;


  PROCEDURE GetRecordCount (  
  iPdeptId IN INT,
  cPdeptName IN VARCHAR2,
  iPpageNo IN INT,
  iPpageSize IN INT,
  iPrecordCount OUT INT
  ) AS
    iLStartRow int;
    iLlastDeptId int;
    iLlastLangId int;
    cLword VARCHAR2(100);
  BEGIN
	cLword :='%'||cPdeptName||'%';
	IF iPdeptId >0 THEN	
		-- search by dept ID
		SELECT count(*) INTO  iPrecordCount
		FROM ya_dept_lang
	     WHERE
		     dept_id = iPdeptId and lang_id=1
			ORDER BY dept_id;
	ELSE


                SELECT count(*) INTO  iPrecordCount
		FROM ya_dept_lang 
		WHERE dept_name_u like cLword
		ORDER BY dept_id,lang_id;

	END IF;

  END GetRecordCount;

  PROCEDURE UpdateAttribute (  
  iPattributeId IN INT,
  cPattrNameEn IN VARCHAR2,
  cPattrNameB5 IN VARCHAR2,
  cPattrNameJp IN VARCHAR2,
  cPattrNameKr IN VARCHAR2,
  cPattrNameGb IN VARCHAR2,
  iProw_affacted OUT INT
  ) AS
  BEGIN
   
	UPDATE ya_attribute_lang
	SET attribute_name = cPattrNameEn
	WHERE attribute_id = iPattributeId and lang_id = 1;

	UPDATE ya_attribute_lang
	SET attribute_name = cPattrNameB5
	WHERE attribute_id = iPattributeId and lang_id = 2;

	UPDATE ya_attribute_lang
	SET attribute_name = cPattrNameJp
	WHERE attribute_id = iPattributeId and lang_id = 3;

	UPDATE ya_attribute_lang
	SET attribute_name = cPattrNameKr
	WHERE attribute_id = iPattributeId and lang_id = 4;

	UPDATE ya_attribute_lang
	SET attribute_name = cPattrNameGb
	WHERE attribute_id = iPattributeId and lang_id = 5;
	
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdateAttribute;

  PROCEDURE UpdateDeptName (
  iPdeptId IN INT,
  cPdeptNameEn IN VARCHAR2,
  cPdeptNameB5 IN VARCHAR2,
  cPdeptNameJp IN VARCHAR2,
  cPdeptNameKr IN VARCHAR2,
  cPdeptNameGb IN VARCHAR2,
  cPdeptNameEnU IN NVARCHAR2,
  cPdeptNameB5U IN NVARCHAR2,
  cPdeptNameJpU IN NVARCHAR2,
  cPdeptNameKrU IN NVARCHAR2,
  cPdeptNameGbU IN NVARCHAR2,
  iProw_affacted OUT INT
  ) AS
  BEGIN
    	
	UPDATE ya_dept_lang
	SET dept_name = cPdeptNameEn,
	dept_name_u=cPdeptNameEnU
	WHERE dept_id=iPdeptId and lang_id=1;

	UPDATE ya_dept_lang
	SET dept_name = cPdeptNameB5,
	dept_name_u=cPdeptNameB5U
	WHERE dept_id=iPdeptId and lang_id=2;

	UPDATE ya_dept_lang
	SET dept_name = cPdeptNameJp,
	dept_name_u=cPdeptNameJpU
	WHERE dept_id=iPdeptId and lang_id=3;

	UPDATE ya_dept_lang
	SET dept_name = cPdeptNameKr,
	dept_name_u=cPdeptNameKrU
	WHERE dept_id=iPdeptId and lang_id=4;

	UPDATE ya_dept_lang
	SET dept_name = cPdeptNameGb,
	dept_name_u=cPdeptNameGbU
	WHERE dept_id=iPdeptId and lang_id=5;
	
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;

  END UpdateDeptName;

  PROCEDURE GetBrowsePath (  
  iPdeptId IN INT,
  iPlangId IN INT,
  curPresult1 out refCur
  ) AS
  BEGIN
    
    OPEN curPresult1 FOR	  
		 SELECT dp.dept_id, CASE 
		                      WHEN dl.dept_name IS NULL THEN dle.dept_name 
		                      WHEN dl.dept_name IS NOT NULL THEN dl.dept_name 
		                    END as dept_name, null as page_location
      FROM ya_browse_dept_path dp,
           ya_dept dpt,
           ya_dept_lang dle,
           ya_dept_lang dl
     WHERE dp.terminal_dept_id = iPdeptId
       AND dl.lang_id = iPlangId
       AND dle.lang_id = 1 
       AND dp.dept_id = dle.dept_id
       AND dp.dept_id = dl.dept_id
       AND dp.dept_id = dpt.dept_id
    ORDER BY dp.node_sequence_id desc;
	RETURN;

  END GetBrowsePath;
  
  PROCEDURE GetAttributeType (  
  curPresult1 out refCur
  ) AS
  BEGIN
    
    OPEN curPresult1 FOR	  
		 select attribute_type_id, attribute_type_name from ya_attribute_type where lang_id = 1;
	RETURN;

  END GetAttributeType;
END PKG_FE_DEPTMGTACCESS;

/
