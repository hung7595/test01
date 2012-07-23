CREATE OR REPLACE PACKAGE Pkg_FE_EditorAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetEditorsByLang (
    iPlang_id IN INT,
    curPresult OUT refCur
  );

  PROCEDURE IsEditor (
    cPshopper IN VARCHAR2,
    iPlang_id IN INT,
    iPresult OUT INT
  );
  
  PROCEDURE GetEditors (
    curPresult OUT refCur
  );
  
  PROCEDURE AddEditor (
    cPemail IN VARCHAR2,
    cPenable_en IN CHAR,
    cPenable_b5 IN CHAR,
    cPenable_jp IN CHAR,
    cPenable_kr IN CHAR,
    cPenable_gb IN CHAR,
    iPresult OUT INT
  );
  
  PROCEDURE DelEditor (
    cPshopper_id IN VARCHAR2,
    iPresult OUT INT
  );
  
  PROCEDURE UpdateEditor (
    cPshopper_id IN VARCHAR2,
    cPenable_en IN CHAR,
    cPenable_b5 IN CHAR,
    cPenable_jp IN CHAR,
    cPenable_kr IN CHAR,
    cPenable_gb IN CHAR,
    iPresult OUT INT
  );  
END Pkg_FE_EditorAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_EditorAccess
AS
  PROCEDURE GetEditorsByLang (
    iPlang_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    IF iPlang_id = 1 THEN
      OPEN curPresult FOR
      SELECT
        editor.shopper_id as shopper_id,
        shopper.email as email,
        editor.enable_en as enable, /* depend on different langId */
        NVL(shopper.firstname,'') as firstname,
        NVL(shopper.lastname,'') as lastname,
        NVL(shopper.nickname,'') as nickname,
        NVL(reviewerName.display_mode,'0') as display_mode
      FROM
        ya_emag_editor editor
      INNER JOIN
        ya_shopper shopper
      ON
        editor.shopper_id = shopper.shopper_id
      LEFT JOIN
        ya_review_reviewerName reviewerName
      ON
        editor.shopper_id = reviewerName.shopper_id
      WHERE
        editor.enable_en = 'Y'
      ;
    ELSIF iPlang_id = 2 THEN
      OPEN curPresult FOR
      SELECT
        editor.shopper_id as shopper_id,
        shopper.email as email,
        editor.enable_b5 as enable, /* depend on different langId */
        NVL(shopper.firstname,'') as firstname,
        NVL(shopper.lastname,'') as lastname,
        NVL(shopper.nickname,'') as nickname,
        NVL(reviewerName.display_mode,'0') as display_mode
      FROM
        ya_emag_editor editor
      INNER JOIN
        ya_shopper shopper
      ON
        editor.shopper_id = shopper.shopper_id
      LEFT JOIN
        ya_review_reviewerName reviewerName
      ON
        editor.shopper_id = reviewerName.shopper_id
      WHERE
        editor.enable_b5 = 'Y'
      ;
    ELSIF iPlang_id = 3 THEN
      OPEN curPresult FOR
      SELECT
        editor.shopper_id as shopper_id,
        shopper.email as email,
        editor.enable_jp as enable, /* depend on different langId */
        NVL(shopper.firstname,'') as firstname,
        NVL(shopper.lastname,'') as lastname,
        NVL(shopper.nickname,'') as nickname,
        NVL(reviewerName.display_mode,'0') as display_mode
      FROM
        ya_emag_editor editor
      INNER JOIN
        ya_shopper shopper
      ON
        editor.shopper_id = shopper.shopper_id
      LEFT JOIN
        ya_review_reviewerName reviewerName
      ON
        editor.shopper_id = reviewerName.shopper_id
      WHERE
        editor.enable_jp = 'Y'
      ;
    ELSIF iPlang_id = 4 THEN
      OPEN curPresult FOR
      SELECT
        editor.shopper_id as shopper_id,
        shopper.email as email,
        editor.enable_kr as enable, /* depend on different langId */
        NVL(shopper.firstname,'') as firstname,
        NVL(shopper.lastname,'') as lastname,
        NVL(shopper.nickname,'') as nickname,
        NVL(reviewerName.display_mode,'0') as display_mode
      FROM
        ya_emag_editor editor
      INNER JOIN
        ya_shopper shopper
      ON
        editor.shopper_id = shopper.shopper_id
      LEFT JOIN
        ya_review_reviewerName reviewerName
      ON
        editor.shopper_id = reviewerName.shopper_id
      WHERE
        editor.enable_kr = 'Y'
      ;
    ELSE
      OPEN curPresult FOR
      SELECT
        editor.shopper_id as shopper_id,
        shopper.email as email,
        editor.enable_gb as enable, /* depend on different langId */
        NVL(shopper.firstname,'') as firstname,
        NVL(shopper.lastname,'') as lastname,
        NVL(shopper.nickname,'') as nickname,
        NVL(reviewerName.display_mode,'0') as display_mode
      FROM
        ya_emag_editor editor
      INNER JOIN
        ya_shopper shopper
      ON
        editor.shopper_id = shopper.shopper_id
      LEFT JOIN
        ya_review_reviewerName reviewerName
      ON
        editor.shopper_id = reviewerName.shopper_id
      WHERE
        editor.enable_gb = 'Y'
      ;
    END IF;
    RETURN;
  END GetEditorsByLang;

  PROCEDURE IsEditor (
    cPshopper IN VARCHAR2,  
    iPlang_id IN INT,
    iPresult OUT INT
  )
  AS
  BEGIN
    iPresult := 0;
    IF iPlang_id = 1 THEN
      SELECT COUNT(*)
      INTO iPresult
      FROM ya_emag_editor
      WHERE shopper_id = cPshopper
      AND enable_en = 'Y' /* Depend in lang_id*/
      ;
      IF iPresult > 0 THEN
        iPresult := 1;
      END IF;
    ELSIF iPlang_id = 2 THEN
      SELECT COUNT(*)
      INTO iPresult
      FROM ya_emag_editor
      WHERE shopper_id = cPshopper
      AND enable_b5 = 'Y' /* Depend in lang_id*/
      ;
      IF iPresult > 0 THEN
        iPresult := 1;
      END IF;
    ELSIF iPlang_id = 3 THEN
      SELECT COUNT(*)
      INTO iPresult
      FROM ya_emag_editor
      WHERE shopper_id = cPshopper
      AND enable_jp = 'Y' /* Depend in lang_id*/
      ;
      IF iPresult > 0 THEN
        iPresult := 1;
      END IF;
    ELSIF iPlang_id = 4 THEN
      SELECT COUNT(*)
      INTO iPresult
      FROM ya_emag_editor
      WHERE shopper_id = cPshopper
      AND enable_kr= 'Y' /* Depend in lang_id*/
      ;
      IF iPresult > 0 THEN
        iPresult := 1;
      END IF;
    ELSE
      SELECT COUNT(*)
      INTO iPresult
      FROM ya_emag_editor
      WHERE shopper_id = cPshopper
      AND enable_gb = 'Y' /* Depend in lang_id*/
      ;
      IF iPresult > 0 THEN
        iPresult := 1;
      END IF;
    END IF;
    RETURN;
  END IsEditor;

  PROCEDURE GetEditors (
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR    
    SELECT ys.email, ye.shopper_id, ye.enable_en, ye.enable_b5, ye.enable_jp, ye.enable_kr, ye.enable_gb
    FROM ya_shopper ys
      INNER JOIN ya_emag_editor ye ON ys.shopper_id = ye.shopper_id
    ORDER BY ys.email;
    
    RETURN;
  END GetEditors;
  
  PROCEDURE AddEditor (
    cPemail IN VARCHAR2,
    cPenable_en IN CHAR,
    cPenable_b5 IN CHAR,
    cPenable_jp IN CHAR,
    cPenable_kr IN CHAR,
    cPenable_gb IN CHAR,
    iPresult OUT INT
  )
  AS
  BEGIN
    BEGIN
      SELECT 2 INTO iPresult FROM ya_emag_editor
      WHERE shopper_id = (select shopper_id from ya_shopper where email =  cPemail and type_id = 1);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPresult := 3;
        END;
    END;
    
    IF iPresult = 2 THEN
      BEGIN
        RETURN;
      END;
    END IF;
      
    INSERT INTO ya_emag_editor (shopper_id, enable_en, enable_b5, enable_jp, enable_kr, enable_gb)
    SELECT shopper_id, cPenable_en, cPenable_b5, cPenable_jp, cPenable_kr, cPenable_gb
    FROM ya_shopper WHERE email = cPemail AND type_id = 1;

    IF sql%rowcount = 0 THEN
      BEGIN
        iPresult := 1;
      END;
    ELSE
      BEGIN
        iPresult := 0;
      END;
    END IF;
  END AddEditor;

  PROCEDURE DelEditor (
    cPshopper_id IN VARCHAR2,
    iPresult OUT INT
  )
  AS
  BEGIN
    DELETE FROM ya_emag_editor WHERE shopper_id = cPshopper_id;

    iPresult := sql%rowcount;
  END DelEditor;
  
  PROCEDURE UpdateEditor (
    cPshopper_id IN VARCHAR2,
    cPenable_en IN CHAR,
    cPenable_b5 IN CHAR,
    cPenable_jp IN CHAR,
    cPenable_kr IN CHAR,
    cPenable_gb IN CHAR,
    iPresult OUT INT
  )
  AS
  BEGIN
    UPDATE ya_emag_editor 
      SET enable_en = cPenable_en, 
          enable_b5 = cPenable_b5,
          enable_jp = cPenable_jp, 
          enable_kr = cPenable_kr,
          enable_gb = cPenable_gb
    WHERE shopper_id = cPshopper_id;
    
    iPresult := sql%rowcount;
  END UpdateEditor;  
END Pkg_FE_EditorAccess;
/
