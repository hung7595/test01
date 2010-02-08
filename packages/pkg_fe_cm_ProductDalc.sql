
REM START SS_ADM PKG_FE_CM_PRODUCTDALC

  CREATE OR REPLACE PACKAGE "PKG_FE_CM_PRODUCTDALC"
AS 
  TYPE refCur IS ref CURSOR;

  PROCEDURE GetProductHighlightBySku
  (
    iPsku IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE IsSkuValid
  (
    iPsku IN INT,
    iPresult OUT INT
  );
  
  PROCEDURE GetProductNameByKeyword
  (
    cPkeyword IN VARCHAR2,
    iPstartRec IN INT,
    iPnumRec IN INT,
    curPresult1 OUT refCur
  );
  
  PROCEDURE GetDepartmentIdBySku
  (
    iPsku IN INT,
    iPdeptId OUT INT
  );
	
END Pkg_fe_cm_ProductDalc;
/
CREATE OR REPLACE PACKAGE BODY "PKG_FE_CM_PRODUCTDALC"
IS

  PROCEDURE GetProductHighlightBySku
  (
    iPsku IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT 
    pl.file_id,
    cf.path,
    pl.prod_lot_id,
    pl.lot_location,
    pl.priority,
    NVL(pll.lang_id,1) AS lang_id, 
    pl.sku,
    NVL(prl.prod_name,'') AS prod_name_u , 
    pl.dept_id,       
    NVL(pll.description,'') AS description,       
    NVL(pl.updated_user,'')  AS updated_user,    
    pl.updated_date    
    FROM ya_mirror_product_lot pl       
    LEFT JOIN ya_mirror_prod_lot_lang pll ON pl.prod_lot_id = pll.prod_lot_id     
    LEFT JOIN ya_prod_lang prl ON pl.sku=prl.sku AND pll.lang_id=prl.lang_id    
    LEFT JOIN ya_content_filename cf ON pl.file_id=cf.id    
    WHERE pl.sku = iPsku   
    ORDER BY pl.file_id,pl.lot_location, pl.prod_lot_id, pl.priority,pll.lang_id; 
  END GetProductHighlightBySku;

  PROCEDURE IsSkuValid
  (
    iPsku IN INT,
    iPresult OUT INT
  ) 
  AS
  BEGIN
    SELECT 1 INTO iPresult
    FROM ya_product 
    WHERE sku = iPsku;
    
    EXCEPTION WHEN no_data_found THEN
      iPresult := 0;
  END IsSkuValid;
  
  PROCEDURE GetProductNameByKeyword
  (
    cPkeyword IN VARCHAR2,
    iPstartRec IN INT,
    iPnumRec IN INT,
    curPresult1 OUT refCur
  )
  AS
    iLlastSku INT;
    iLlastLangId INT;
  BEGIN
    -- Get Start Record
    SELECT sku, lang_id INTO iLlastSku, iLlastLangId
    FROM
    (
      SELECT a.sku , a.lang_id
      FROM
      (
        SELECT sku,lang_id,prod_name 
        FROM ya_prod_lang 
        WHERE prod_name LIKE cPkeyword || '%'
      ) a
      ORDER BY a.sku, a.lang_id DESC
    )
    WHERE ROWNUM <= iPstartRec + 1;
    
    -- Get Final Result
    OPEN curPresult1 FOR
    SELECT DISTINCT a.sku,a.lang_id,a.prod_name
    FROM
    (
      SELECT sku,lang_id,prod_name 
      FROM ya_prod_lang 
      WHERE prod_name LIKE cPkeyword || '%'
    ) a
    WHERE
    (
      a.sku <= iLlastSku 
      OR 
      (a.sku = iLlastSku AND a.lang_id <= iLlastLangId)
    )
    AND
    ROWNUM <= iPnumRec
    ORDER BY a.sku, a.lang_id DESC;
  END GetProductNameByKeyword;
  
  PROCEDURE GetDepartmentIdBySku
  (
    iPsku IN INT,
    iPdeptId OUT INT
  )
  AS
    iLexist INT;
  BEGIN
    IF(iPsku) > 0 THEN
      BEGIN
        SELECT 1 INTO iLexist
        FROM ya_prod_dept WHERE sku = iPsku
        AND dept_id IN 
        (1, 2, 3, 4, 5, 7, 9, 10, 1344, 3588, 3923, 7153, 9280, 10714)
        AND rownum = 1;
        
        EXCEPTION WHEN no_data_found THEN
          iLexist := -1;
      END;
      IF(iLexist > 0) THEN
        SELECT dept_id INTO iPdeptId
        FROM ya_prod_dept WHERE sku = iPsku
        AND dept_id IN 
        (1, 2, 3, 4, 5, 7, 9, 10, 1344, 3588, 3923, 7153, 9280, 10714)
        AND rownum = 1;
      END IF;
    END IF;
  END GetDepartmentIdBySku;
	
END Pkg_fe_cm_ProductDalc;
/

REM END SS_ADM PKG_FE_CM_PRODUCTDALC