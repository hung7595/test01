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

END Pkg_FE_EditorAccess;
/
