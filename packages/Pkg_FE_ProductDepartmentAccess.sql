CREATE OR REPLACE PACKAGE Pkg_FE_ProductDepartmentAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetDeptDisplayTree (
    iPdept_id IN INT,
    iPparent_dept_id IN INT,
    iPsite_id IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetSingleDeptInfo (
    iPdept_id IN INT,
    iPlang_id IN INT DEFAULT 1,
    curPresult OUT refCur
  );

  PROCEDURE GetMultiDeptInfo (
    iPlang_id IN INT DEFAULT 1,
    curPresult OUT refCur,
    iPdept_id1 IN INT DEFAULT NULL,
    iPdept_id2 IN INT DEFAULT NULL,
    iPdept_id3 IN INT DEFAULT NULL,
    iPdept_id4 IN INT DEFAULT NULL,
    iPdept_id5 IN INT DEFAULT NULL,
    iPdept_id6 IN INT DEFAULT NULL,
    iPdept_id7 IN INT DEFAULT NULL,
    iPdept_id8 IN INT DEFAULT NULL,
    iPdept_id9 IN INT DEFAULT NULL,
    iPdept_id10 IN INT DEFAULT NULL,
    iPdept_id11 IN INT DEFAULT NULL,
    iPdept_id12 IN INT DEFAULT NULL,
    iPdept_id13 IN INT DEFAULT NULL,
    iPdept_id14 IN INT DEFAULT NULL,
    iPdept_id15 IN INT DEFAULT NULL,
    iPdept_id16 IN INT DEFAULT NULL,
    iPdept_id17 IN INT DEFAULT NULL,
    iPdept_id18 IN INT DEFAULT NULL,
    iPdept_id19 IN INT DEFAULT NULL,
    iPdept_id20 IN INT DEFAULT NULL
  );

  PROCEDURE GetRealParentDeptId (
    iPdept_id		IN	INT,
    iPparent_dept_id OUT	INT
  );
END Pkg_FE_ProductDepartmentAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_ProductDepartmentAccess
IS
  PROCEDURE GetDeptDisplayTree (
    iPdept_id IN INT,
    iPparent_dept_id IN INT,
    iPsite_id IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLparent_dept_id INT;
  BEGIN
    IF iPparent_dept_id = -1 THEN
      BEGIN
        SELECT parent_dept_id
        INTO iLparent_dept_id
        FROM ya_dept_rel
        WHERE dept_id = iPdept_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          iLparent_dept_id := -1;
      END;
    ELSE
      BEGIN
        iLparent_dept_id := iPparent_dept_id;
      END;
    END IF;


    IF iPsite_id = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          dr.parent_dept_id,
          dr.dept_id,
          drc.constraint_type,
          drc.constraint_value
        FROM
          ya_dept_rel dr--parent, current
          INNER JOIN ya_dept d ON
            (
              d.dept_id = dr.parent_dept_id
              AND d.us_enabled = 'Y'
            ) --make sure the parent is enabled
          LEFT OUTER JOIN ya_dept_rel_constraint drc ON
            (
              drc.dept_id = dr.dept_id
              AND drc.parent_dept_id = dr.parent_dept_id
            ) -- look for any constaint
        WHERE
          dr.dept_id = iPdept_id
          AND dr.parent_dept_id = iLparent_dept_id
        ORDER BY d.us_disp_seq; --parent's order


        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          drs.parent_dept_id,
          drs.dept_id,
          drc.constraint_type,
          drc.constraint_value
        FROM
          ya_dept_rel dr --parent, current
          INNER JOIN ya_dept_rel drs ON
            (
              drs.parent_dept_id = dr.parent_dept_id
            )--parent, sibling
          INNER JOIN ya_dept d ON
            (
              d.dept_id = drs.dept_id
              AND d.us_enabled = 'Y'
            )
          LEFT OUTER JOIN ya_dept_rel_constraint drc ON
            (
              drc.dept_id = drs.dept_id
              AND drc.parent_dept_id = drs.parent_dept_id
            )
        WHERE
          dr.dept_id = iPdept_id
          AND dr.parent_dept_id = iLparent_dept_id
        ORDER BY d.us_disp_seq; -- siblings's order


        /* Child */
        OPEN curPchild FOR
        SELECT
          dr.parent_dept_id,
          dr.dept_id,
          drc.constraint_type,
          drc.constraint_value
        FROM
          ya_dept_rel dr --child, current
          INNER JOIN ya_dept d ON
            (
              d.dept_id = dr.dept_id
              AND d.us_enabled = 'Y'
            )
          LEFT OUTER JOIN ya_dept_rel_constraint drc ON
            (
              drc.dept_id = dr.dept_id
              AND drc.parent_dept_id = dr.parent_dept_id
            )
        WHERE
          dr.parent_dept_id = iPdept_id
        ORDER BY d.us_disp_seq; -- siblings's order
      END;
    ELSE
      IF iPsite_id = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            dr.parent_dept_id,
            dr.dept_id,
            drc.constraint_type,
            drc.constraint_value
          FROM
            ya_dept_rel dr--parent, current
            INNER JOIN ya_dept d ON
              (
                d.dept_id = dr.parent_dept_id
                AND d.tw_enabled = 'Y'
              ) --make sure the parent is enabled
            LEFT OUTER JOIN ya_dept_rel_constraint drc ON
              (
                drc.dept_id = dr.dept_id
                AND drc.parent_dept_id = dr.parent_dept_id
              ) -- look for any constaint
          WHERE
            dr.dept_id = iPdept_id
            AND dr.parent_dept_id = iLparent_dept_id
          ORDER BY d.tw_disp_seq; --parent's order


          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            drs.parent_dept_id,
            drs.dept_id,
            drc.constraint_type,
            drc.constraint_value
          FROM
            ya_dept_rel dr --parent, current
            INNER JOIN ya_dept_rel drs ON
              (
                drs.parent_dept_id = dr.parent_dept_id
              )--parent, sibling
            INNER JOIN ya_dept d ON
              (
                d.dept_id = drs.dept_id
                AND d.tw_enabled = 'Y'
              )
            LEFT OUTER JOIN ya_dept_rel_constraint drc ON
              (
                drc.dept_id = drs.dept_id
                AND drc.parent_dept_id = drs.parent_dept_id
              )
          WHERE
            dr.dept_id = iPdept_id
            AND dr.parent_dept_id = iLparent_dept_id
          ORDER BY d.tw_disp_seq; -- siblings's order


          /* Child */
          OPEN curPchild FOR
          SELECT
            dr.parent_dept_id,
            dr.dept_id,
            drc.constraint_type,
            drc.constraint_value
          FROM
            ya_dept_rel dr --child, current
            INNER JOIN ya_dept d ON
              (
                d.dept_id = dr.dept_id
                AND d.tw_enabled = 'Y'
              )
            LEFT OUTER JOIN ya_dept_rel_constraint drc ON
              (
                drc.dept_id = dr.dept_id
                AND drc.parent_dept_id = dr.parent_dept_id
              )
          WHERE
            dr.parent_dept_id = iPdept_id
          ORDER BY d.tw_disp_seq; -- siblings's order
        END;
      END IF;
    END IF;
    RETURN;
  END GetDeptDisplayTree;



  PROCEDURE GetSingleDeptInfo (
    iPdept_id IN INT,
    iPlang_id IN INT DEFAULT 1,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      d.dept_id,
      d.page_location,
      d.us_enabled,
      d.tw_enabled,
      CASE
        WHEN df.dept_id IS NULL THEN 'N'
        ELSE 'Y'
      END,
      NVL(df.filter_id, -1),
      dl1.dept_name
    FROM
      ya_dept d
      LEFT OUTER JOIN ya_dept_lang dl1 ON
        dl1.dept_id = d.dept_id
        AND dl1.lang_id = iPlang_id
      LEFT OUTER JOIN ya_dept_filter df ON
        df.dept_id = d.dept_id
    WHERE
      d.dept_id = iPdept_id;

    RETURN;
  END GetSingleDeptInfo;



  PROCEDURE GetMultiDeptInfo (
    iPlang_id IN INT DEFAULT 1,
    curPresult OUT refCur,
    iPdept_id1 IN INT DEFAULT NULL,
    iPdept_id2 IN INT DEFAULT NULL,
    iPdept_id3 IN INT DEFAULT NULL,
    iPdept_id4 IN INT DEFAULT NULL,
    iPdept_id5 IN INT DEFAULT NULL,
    iPdept_id6 IN INT DEFAULT NULL,
    iPdept_id7 IN INT DEFAULT NULL,
    iPdept_id8 IN INT DEFAULT NULL,
    iPdept_id9 IN INT DEFAULT NULL,
    iPdept_id10 IN INT DEFAULT NULL,
    iPdept_id11 IN INT DEFAULT NULL,
    iPdept_id12 IN INT DEFAULT NULL,
    iPdept_id13 IN INT DEFAULT NULL,
    iPdept_id14 IN INT DEFAULT NULL,
    iPdept_id15 IN INT DEFAULT NULL,
    iPdept_id16 IN INT DEFAULT NULL,
    iPdept_id17 IN INT DEFAULT NULL,
    iPdept_id18 IN INT DEFAULT NULL,
    iPdept_id19 IN INT DEFAULT NULL,
    iPdept_id20 IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      d.dept_id,
      d.page_location,
      d.us_enabled,
      d.tw_enabled,
      CASE
        WHEN df.dept_id IS NULL THEN 'N'
        ELSE 'Y'
      END,
      NVL(df.filter_id, -1),
      dl1.dept_name
    FROM
      ya_dept d
      LEFT OUTER JOIN ya_dept_lang dl1 ON
        dl1.lang_id = iPlang_id
        AND dl1.dept_id = d.dept_id
      LEFT OUTER JOIN ya_dept_filter df ON
        df.dept_id = d.dept_id
    WHERE
      d.dept_id IN
        (
          iPdept_id1,
          iPdept_id2,
          iPdept_id3,
          iPdept_id4,
          iPdept_id5,
          iPdept_id6,
          iPdept_id7,
          iPdept_id8,
          iPdept_id9,
          iPdept_id10,
          iPdept_id11,
          iPdept_id12,
          iPdept_id13,
          iPdept_id14,
          iPdept_id15,
          iPdept_id16,
          iPdept_id17,
          iPdept_id18,
          iPdept_id19,
          iPdept_id20
        )
    ORDER BY d.dept_id;
    RETURN;
  END GetMultiDeptInfo;

  PROCEDURE GetRealParentDeptId (
    iPdept_id		IN	INT,
    iPparent_dept_id OUT	INT
  )
  AS
  BEGIN
    SELECT parent_dept_id INTO iPparent_dept_id
      FROM ya_dept_rel
     WHERE dept_id = iPdept_id;

    EXCEPTION WHEN no_data_found THEN
      iPparent_dept_id := NULL;
  END GetRealParentDeptId;
END Pkg_FE_ProductDepartmentAccess;
/

