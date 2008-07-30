create or replace PACKAGE Pkg_FE_DepartmentAccess
AS
  TYPE refCur IS REF CURSOR;
  PROCEDURE GetArtPubDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetPublisherDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPpublisherId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE IsLeaf (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPchildrenCount OUT INT
  );

  PROCEDURE GetDeptName (
    iPdeptId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetCampaignDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPcampaignCode IN INT DEFAULT -1,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetNonAdultDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );


  PROCEDURE GetDeptAttrTree (
    iPdeptId IN INT,
    iPattrId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetNonAdultDeptAttrTree (
    iPdeptId IN INT,
    iPattrId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetSkuDeptTree (
    iPdeptId IN INT,
    iPpid IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    cPhasAdult IN CHAR,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetArtistDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPartistId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetNonAdultArtistDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPartistId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetGroupDeptTree (
    iPsku IN INT,
    iPdept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPtree OUT refCur
  );

  PROCEDURE GetPublisherGroupDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPpublisherGroupId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetProductLangDetptTree (
    iPchineseDept IN INT,
    iPjapaneseDept IN INT,
    iPkoreanDept IN INT,
    iPwesternDept IN INT,
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPtree OUT refCur
  );

  PROCEDURE GetUpcommingDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  PROCEDURE GetUpcommingLangDeptTree (
    iPchineseDept IN INT,
    iPjapaneseDept IN INT,
    iPkoreanDept IN INT,
    iPwesternDept IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPtree OUT refCur
  );

  PROCEDURE GetTopSellersDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );

  /* proc_fe_get_bargain_dept_tree */
  PROCEDURE GetBargainDeptTree (
    iPdept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  );


  PROCEDURE GetBargainLangDeptTree (
    iPchineseDept IN INT,
    iPjapaneseDept IN INT,
    iPkoreanDept IN INT,
    iPwesternDept IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPtree OUT refCur
  );

  PROCEDURE GetParentDeptId (
    iPdept_id IN INT,
    iPparentDeptId OUT INT
  );

  PROCEDURE GetArtistDeptTree2 (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  PROCEDURE GetBrowseEngBookSeriesDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPgroup_sku IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  PROCEDURE GetBrowseCampaignTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPcc IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  PROCEDURE GetBrowseGrpDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  PROCEDURE GetBrowseDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  PROCEDURE GetProductListDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPtypeId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );


  PROCEDURE GetSupplierDeptTree (
    iPdeptId IN INT,
    iPsupplierId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );


  PROCEDURE GetPublisherGroupDeptTree2 (
    iPdeptId IN INT,
    iPpublisherGroupId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );


  PROCEDURE IsLeafGroupDept (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPreturn OUT INT
  );


  PROCEDURE IsLeafProductListDept (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPtypeId IN INT,
    iPreturn OUT INT
  );

  PROCEDURE IsLeafArtistDept (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN INT,
    iPreturn OUT INT
  );

  PROCEDURE IsLeafSupplierDept (
    iPdeptId IN INT,
    iPsupplierId IN INT,
    iPsiteId IN INT,
    iPreturn OUT INT
  );

  PROCEDURE IsLeafPublisherGroupDept (
    iPdeptId IN INT,
    iPpublisherGroupId IN INT,
    iPsiteId IN INT,
    iPreturn OUT INT
  );

  /* proc_fe_GetBargainRootDepartment */
  PROCEDURE GetBargainRootDept (
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_GetBargainRootLangDepartment */
  PROCEDURE GetBargainRootLangDept (
    iPbargain_attribute IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_GetBargainDepartment */
  PROCEDURE GetBargainDept (
    iPdept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  );
END Pkg_FE_DepartmentAccess;
/
create or replace PACKAGE BODY Pkg_FE_DepartmentAccess
IS
  PROCEDURE IsLeaf (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPchildrenCount OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPchildrenCount
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.dept_id = d.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y';
      END;
    ELSIF iPsiteId = 7 Then
      BEGIN
        SELECT COUNT(1)
        INTO iPchildrenCount
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.dept_id = d.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y';
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 Then
      BEGIN
        SELECT COUNT(1)
        INTO iPchildrenCount
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.dept_id = d.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y';
      END;
    END IF;
    RETURN;
  END IsLeaf;


  PROCEDURE GetDeptName (
    iPdeptId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT nvl(dl.dept_name, dl2.dept_name)
    FROM
      ya_dept_lang dl
      LEFT OUTER JOIN ya_dept_lang dl2 ON
        dl2.dept_id = iPdeptId AND dl2.lang_id = 1
    WHERE
      dl.dept_id = iPdeptId
      AND dl.lang_id = iPlangId;
    RETURN;
  END GetDeptName;


  PROCEDURE GetCampaignDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPcampaignCode IN INT DEFAULT -1,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          SELECT NULL INTO iLparentDeptId FROM dual;
    END;

    BEGIN
      SELECT dg.parent_dept_id
      INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
         SELECT null INTO iLgrantDeptId FROM dual;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iLgrantDeptId
        AND dl.lang_id = iPlangId
        AND d.us_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iLparentDeptId
        AND dl.lang_id = iPlangId
        AND d.us_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iPdeptId
        AND dl.lang_id = iPlangId
        AND d.us_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iLgrantDeptId
        AND dl.lang_id = iPlangId
        AND d.tw_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY tw_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iLparentDeptId
        AND dl.lang_id = iPlangId
        AND d.tw_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY tw_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iPdeptId
        AND dl.lang_id = iPlangId
        AND d.tw_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY tw_disp_seq;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iLgrantDeptId
        AND dl.lang_id = iPlangId
        AND d.ys_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY hk_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iLparentDeptId
        AND dl.lang_id = iPlangId
        AND d.ys_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY hk_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE d.dept_id = dr.dept_id
        AND d.dept_id = dl.dept_id
        AND dr.parent_dept_id = iPdeptId
        AND dl.lang_id = iPlangId
        AND d.ys_enabled = 'Y'
        AND EXISTS (
                   SELECT 1
                   FROM
                     ya_prod_dept pd,
                     ya_campaign c
                   WHERE pd.sku = c.sku
                   AND c.campaign_code = iPcampaignCode
                   AND pd.dept_id = d.dept_id
                   )
        ORDER BY hk_disp_seq;
      END;
    END IF;
    RETURN;
  END GetCampaignDeptTree;


  PROCEDURE GetDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetDeptTree;


  PROCEDURE GetNonAdultDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
    iLtypeId INT := 1;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetNonAdultDeptTree;



  PROCEDURE GetDeptAttrTree (
    iPdeptId IN INT,
    iPattrId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_attr pa,
                ya_prod_dept pd
              WHERE
                pa.sku = pd.sku
                AND pd.dept_id = d.dept_id
                AND pa.attribute_id = iPattrId
            )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_attr pa,
                ya_prod_dept pd
              WHERE
                pa.sku = pd.sku
                AND pd.dept_id = d.dept_id
                AND pa.attribute_id = iPattrId
            )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_attr pa,
                ya_prod_dept pd
              WHERE
                pa.sku = pd.sku
                AND pd.dept_id = d.dept_id
                AND pa.attribute_id = iPattrId
            )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetDeptAttrTree;



  PROCEDURE GetNonAdultDeptAttrTree (
    iPdeptId IN INT,
    iPattrId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
    iLtypeId INT := 1;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_attr pa,
                ya_prod_dept pd
              WHERE
                pa.sku = pd.sku
                AND pd.dept_id = d.dept_id
                AND pa.attribute_id = iPattrId
            )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND EXISTS
          (
            SELECT 1
            FROM
              ya_prod_attr pa,
              ya_prod_dept pd
            WHERE
              pa.sku = pd.sku
              AND pd.dept_id = d.dept_id
              AND pa.attribute_id = iPattrId
          )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?', 'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_attr pa,
                ya_prod_dept pd
              WHERE
                pa.sku = pd.sku
                AND pd.dept_id = d.dept_id
                AND pa.attribute_id = iPattrId
            )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?', 'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?', 'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND EXISTS
              (
                SELECT 1
                FROM
                  ya_prod_attr pa,
                  ya_prod_dept pd
                WHERE
                  pa.sku = pd.sku
                  AND pd.dept_id = d.dept_id
                  AND pa.attribute_id = iPattrId
              )
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetNonAdultDeptAttrTree;



  PROCEDURE GetSkuDeptTree (
    iPdeptId IN INT,
    iPpid IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    cPhasAdult IN CHAR,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE
                cPhasAdult = 'N'
                AND attribute_id = 84
            ) /* adult attribute */
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_prod_rel pr
              WHERE
                pr.sku = pd.sku
                AND parent_sku = iPpid
              GROUP BY pd.dept_id
            )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE
                cPhasAdult = 'N'
                AND attribute_id = 84
            ) /* adult attribute */
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_prod_rel pr
              WHERE
                pr.sku = pd.sku
                AND parent_sku = iPpid
              GROUP BY pd.dept_id
            )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPrdDept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE
                cPhasAdult = 'N'
                AND attribute_id = 84
            ) /* adult attribute */
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_prod_rel pr
              WHERE
                pr.sku = pd.sku
                AND parent_sku = iPpid
              GROUP BY pd.dept_id
            )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE
                  cPhasAdult = 'N'
                  AND attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_prod_rel pr
                WHERE
                  pr.sku = pd.sku
                  AND parent_sku = iPpid
                GROUP BY pd.dept_id
              )
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE
                  cPhasAdult = 'N'
                  AND attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_prod_rel pr
                WHERE
                  pr.sku = pd.sku
                  AND parent_sku = iPpid
                GROUP BY pd.dept_id
              )
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE
                  cPhasAdult = 'N'
                  AND attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_prod_rel pr
                WHERE
                  pr.sku = pd.sku
                  AND parent_sku = iPpid
                GROUP BY pd.dept_id
              )
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE
                  cPhasAdult = 'N'
                  AND attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_prod_rel pr
                WHERE
                  pr.sku = pd.sku
                  AND parent_sku = iPpid
                GROUP BY pd.dept_id
              )
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE
                  cPhasAdult = 'N'
                  AND attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_prod_rel pr
                WHERE
                  pr.sku = pd.sku
                  AND parent_sku = iPpid
                GROUP BY pd.dept_id
              )
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brPrdDept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE
                  cPhasAdult = 'N'
                  AND attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_prod_rel pr
                WHERE
                  pr.sku = pd.sku
                  AND parent_sku = iPpid
                  AND pd.tw_enabled = 'Y'
                GROUP BY pd.dept_id
              )
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetSkuDeptTree;



  PROCEDURE GetArtistDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPartistId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
    iLtypeId INT DEFAULT 1;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
         'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
         CASE
           WHEN d.dept_id  = iLparentDeptId THEN 'Y'
           ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetArtistDeptTree;


  PROCEDURE GetNonAdultArtistDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPartistId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
    iLtypeId INT := 1;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN (SELECT dept_id FROM ya_dept_attr WHERE attribute_id = 84) /* adult attribute */
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id NOT IN
            (
              SELECT dept_id
              FROM ya_dept_attr
              WHERE attribute_id = 84
            ) /* adult attribute */
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) ||'&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) ||'&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
            )
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || CAST(iPartistId AS varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id NOT IN
              (
                SELECT dept_id
                FROM ya_dept_attr
                WHERE attribute_id = 84
              ) /* adult attribute */
            AND d.dept_id IN
              (
                SELECT pd.dept_id
                FROM
                  ya_prod_dept pd,
                  ya_product_artist pa
                WHERE
                  pd.sku = pa.sku
                  AND pa.artist_id = iPartistId
              )
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetNonAdultArtistDeptTree;



  PROCEDURE GetGroupDeptTree (
    iPsku IN INT,
    iPdept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPtree OUT refCur
  )
  AS
    cLsite_prefix VARCHAR2(10);
  BEGIN
    cLsite_prefix :=
      CASE iPsite_id
        WHEN 1 THEN 'us'
        WHEN 7 THEN 'tw'
        ELSE 'us'
      END;

    OPEN curPtree FOR
    SELECT
      DISTINCT pd.dept_id,
      NVL(dl.dept_name, dl2.dept_name)
    FROM
      ya_prod_dept pd
      INNER JOIN ya_dept_rel dr ON
        dr.dept_id = pd.dept_id
        AND parent_dept_id = iPdept_id
      INNER JOIN ya_dept_lang dl ON
        dl.lang_id = iPlang_id
        AND dl.dept_id = dr.dept_id
      LEFT OUTER JOIN ya_dept_lang dl2 ON
        dl2.dept_id = dl.dept_id
        AND dl2.lang_id = 1
    WHERE
      sku IN
        (
          SELECT sku
          FROM ya_prod_rel
          WHERE parent_sku = iPsku
        )
      AND pd.dept_id <> 0
      AND
        (
          (
            CASE cLsite_prefix
              WHEN 'us' THEN us_enabled
              WHEN 'tw' THEN tw_enabled
              ELSE 'Y'  END
          )='Y'
        )
    ORDER BY pd.dept_id;
    RETURN;
  END GetGroupDeptTree;



  PROCEDURE GetPublisherGroupDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPpublisherGroupId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
    iLtypeId INT :=1;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.tw_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY tw_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.tw_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY tw_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.tw_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY tw_disp_seq;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.ys_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY hk_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.ys_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY hk_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brPubDept.aspx?gid=' || CAST(iPpublisherGroupId AS varchar2 (10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.ys_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel pg
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = pg.publisher_id
                AND pg.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY hk_disp_seq;
      END;
    END IF;
    RETURN;
  END GetPublisherGroupDeptTree;


  PROCEDURE GetProductLangDetptTree (
    iPchineseDept IN INT,
    iPjapaneseDept IN INT,
    iPkoreanDept IN INT,
    iPwesternDept IN INT,
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPtree OUT refCur
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPtree FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'brprddept.aspx?',
          'N' as IsVein
        FROM
         ya_dept d,
          ya_dept_lang dl
        WHERE
          d.dept_id = dl.dept_id
          AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        UNION
        SELECT
          0,
          dl.dept_name,
          'brprddept.aspx?',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_bargain db,
          ya_dept_lang dl
        WHERE
          d.dept_id = db.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND db.site_id = iPsiteId
          AND db.enabled = 'Y';
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          OPEN curPtree FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brprddept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_lang dl
          WHERE
            d.dept_id = dl.dept_id
            AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          UNION
          SELECT
            0,
            dl.dept_name,
            'brprddept.aspx?',
            'N' as IsVein
          FROM
            ya_dept d,
            ya_dept_bargain db,
            ya_dept_lang dl
          WHERE
            d.dept_id = db.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND db.site_id = iPsiteId
            AND db.enabled = 'Y';
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          OPEN curPtree FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'brprddept.aspx?',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_lang dl
          WHERE
            d.dept_id = dl.dept_id
            AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          UNION
          SELECT
            0,
            dl.dept_name,
            'brprddept.aspx?',
            'N' as IsVein
          FROM
            ya_dept d,
            ya_dept_bargain db,
            ya_dept_lang dl
          WHERE
            d.dept_id = db.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND db.site_id = iPsiteId
            AND db.enabled = 'Y';
        END;
    END IF;
    RETURN;
  END GetProductLangDetptTree;



  PROCEDURE GetUpcommingDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLtypeId INT :=1;
  BEGIN
    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = (SELECT dp.parent_dept_id FROM ya_dept_rel dp WHERE dp.dept_id = iPdeptId);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl,
          ya_dept_upcoming du
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = du.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl,
          ya_dept_upcoming du
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = du.dept_id
          AND dr.parent_dept_id = (SELECT dp.parent_dept_id FROM ya_dept_rel dp WHERE dp.dept_id = iPdeptId)
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl,
          ya_dept_upcoming du
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = du.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;

        /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND dr.parent_dept_id = (SELECT dp.parent_dept_id FROM ya_dept_rel dp WHERE dp.dept_id = iPdeptId)
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;

        /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND dr.parent_dept_id = (SELECT dp.parent_dept_id FROM ya_dept_rel dp WHERE dp.dept_id = iPdeptId)
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetUpcommingDeptTree;


  PROCEDURE GetUpcommingLangDeptTree (
    iPchineseDept IN INT,
    iPjapaneseDept IN INT,
    iPkoreanDept IN INT,
    iPwesternDept IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPtree OUT refCur
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPtree FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_lang dl,
          ya_dept_upcoming du
        WHERE
          d.dept_id = dl.dept_id
          AND d.dept_id = du.dept_id
          AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          OPEN curPtree FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          OPEN curPtree FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_lang dl,
            ya_dept_upcoming du
          WHERE
            d.dept_id = dl.dept_id
            AND d.dept_id = du.dept_id
            AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetUpcommingLangDeptTree;



  PROCEDURE GetTopSellersDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLtypeId INT :=1;
  BEGIN
    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id =
        (
          SELECT dp.parent_dept_id
          FROM ya_dept_rel dp
          WHERE dp.dept_id = iPdeptId
        );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT dept_id
              FROM ya_product_ranking
              WHERE
                site_id = iPsiteId
                AND type_id = iLtypeId
            )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id =
            (
              SELECT dp.parent_dept_id
              FROM ya_dept_rel dp
              WHERE dp.dept_id = iPdeptId
            )
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT dept_id
              FROM ya_product_ranking
              WHERE
                site_id = iPsiteId
                AND type_id = iLtypeId
            )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND d.dept_id IN
            (
              SELECT dept_id
              FROM ya_product_ranking
              WHERE
                site_id = iPsiteId
                AND type_id = iLtypeId
            )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT dept_id
                FROM ya_product_ranking
                WHERE
                  site_id = iPsiteId
                  AND type_id = iLtypeId
              )
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = (SELECT dp.parent_dept_id FROM ya_dept_rel dp WHERE dp.dept_id = iPdeptId)
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT dept_id
                FROM ya_product_ranking
                WHERE
                  site_id = iPsiteId
                  AND type_id = iLtypeId
              )
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT dept_id
                FROM ya_product_ranking
                WHERE
                  site_id = iPsiteId
                  AND type_id = iLtypeId
              )
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT dept_id
                FROM ya_product_ranking
                WHERE
                  site_id = iPsiteId
                  AND type_id = iLtypeId
              )
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = (SELECT dp.parent_dept_id FROM ya_dept_rel dp WHERE dp.dept_id = iPdeptId)
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT dept_id
                FROM ya_product_ranking
                WHERE
                  site_id = iPsiteId
                  AND type_id = iLtypeId
              )
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND d.dept_id IN
              (
                SELECT dept_id
                FROM ya_product_ranking
                WHERE
                  site_id = iPsiteId
                  AND type_id = iLtypeId
              )
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetTopSellersDeptTree;



  /* proc_fe_get_bargain_dept_tree */
  PROCEDURE GetBargainDeptTree (
    iPdept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLtypeId INT := 1;
  BEGIN
    BEGIN
      SELECT dg.parent_dept_id
      INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id =
        (
          SELECT dp.parent_dept_id
          FROM ya_dept_rel dp
          WHERE
            dp.dept_id = iPdept_Id
            AND ROWNUM = 1
        );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsite_Id = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d
          INNER JOIN ya_dept_rel dr ON
            d.dept_id = dr.dept_id
          INNER JOIN ya_dept_lang dl ON
            d.dept_id = dl.dept_id
          INNER JOIN ya_dept_bargain db ON
            d.dept_id = db.dept_id
        WHERE
          dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlang_Id
          AND d.us_enabled = 'Y'
          AND db.site_id = iPsite_Id
          AND db.enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d
          INNER JOIN ya_dept_rel dr ON
            d.dept_id = dr.dept_id
          INNER JOIN ya_dept_lang dl ON
            d.dept_id = dl.dept_id
          INNER JOIN ya_dept_bargain db ON
            d.dept_id = db.dept_id
        WHERE
          dr.parent_dept_id =
            (
              SELECT dp.parent_dept_id
              FROM ya_dept_rel dp
              WHERE dp.dept_id = iPdept_Id
            )
          AND dl.lang_id = iPlang_Id
          AND d.us_enabled = 'Y'
          AND db.site_id = iPsite_Id
          AND db.enabled = 'Y'
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d
          INNER JOIN ya_dept_rel dr ON
            d.dept_id = dr.dept_id
          INNER JOIN ya_dept_lang dl ON
            d.dept_id = dl.dept_id
          INNER JOIN ya_dept_bargain db ON
            d.dept_id = db.dept_id
        WHERE
          dr.parent_dept_id = iPdept_Id
          AND dl.lang_id = iPlang_Id
          AND d.us_enabled = 'Y'
          AND db.site_id = iPsite_Id
          AND db.enabled = 'Y'
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsite_Id = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d
            INNER JOIN ya_dept_rel dr ON
              d.dept_id = dr.dept_id
            INNER JOIN ya_dept_lang dl ON
              d.dept_id = dl.dept_id
            INNER JOIN ya_dept_bargain db ON
              d.dept_id = db.dept_id
          WHERE
            dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlang_Id
            AND d.tw_enabled = 'Y'
            AND db.site_id = iPsite_Id
            AND db.enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d
            INNER JOIN ya_dept_rel dr ON
              d.dept_id = dr.dept_id
            INNER JOIN ya_dept_lang dl ON
              d.dept_id = dl.dept_id
            INNER JOIN ya_dept_bargain db ON
              d.dept_id = db.dept_id
          WHERE
            dr.parent_dept_id =
              (
                SELECT dp.parent_dept_id
                FROM ya_dept_rel dp
                WHERE dp.dept_id = iPdept_Id
              )
            AND dl.lang_id = iPlang_Id
            AND d.tw_enabled = 'Y'
            AND db.site_id = iPsite_Id
            AND db.enabled = 'Y'
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d
            INNER JOIN ya_dept_rel dr ON
              d.dept_id = dr.dept_id
            INNER JOIN ya_dept_lang dl ON
              d.dept_id = dl.dept_id
            INNER JOIN ya_dept_bargain db ON
              d.dept_id = db.dept_id
          WHERE
            dr.parent_dept_id = iPdept_Id
            AND dl.lang_id = iPlang_Id
            AND d.tw_enabled = 'Y'
            AND db.site_id = iPsite_Id
            AND db.enabled = 'Y'
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsite_Id = 10 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d
            INNER JOIN ya_dept_rel dr ON
              d.dept_id = dr.dept_id
            INNER JOIN ya_dept_lang dl ON
              d.dept_id = dl.dept_id
            INNER JOIN ya_dept_bargain db ON
              d.dept_id = db.dept_id
          WHERE
            dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlang_Id
            AND d.ys_enabled = 'Y'
            AND db.site_id = iPsite_Id
            AND db.enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d
            INNER JOIN ya_dept_rel dr ON
              d.dept_id = dr.dept_id
            INNER JOIN ya_dept_lang dl ON
              d.dept_id = dl.dept_id
            INNER JOIN ya_dept_bargain db ON
              d.dept_id = db.dept_id
          WHERE
            dr.parent_dept_id =
              (
                SELECT dp.parent_dept_id
                FROM ya_dept_rel dp
                WHERE dp.dept_id = iPdept_Id
              )
            AND dl.lang_id = iPlang_Id
            AND d.ys_enabled = 'Y'
            AND db.site_id = iPsite_Id
            AND db.enabled = 'Y'
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            d.page_location,
            'N'
          FROM
            ya_dept d
            INNER JOIN ya_dept_rel dr ON
              d.dept_id = dr.dept_id
            INNER JOIN ya_dept_lang dl ON
              d.dept_id = dl.dept_id
            INNER JOIN ya_dept_bargain db ON
              d.dept_id = db.dept_id
          WHERE
            dr.parent_dept_id = iPdept_Id
            AND dl.lang_id = iPlang_Id
            AND d.ys_enabled = 'Y'
            AND db.site_id = iPsite_Id
            AND db.enabled = 'Y'
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetBargainDeptTree;



  PROCEDURE GetBargainLangDeptTree (
    iPchineseDept IN INT,
    iPjapaneseDept IN INT,
    iPkoreanDept IN INT,
    iPwesternDept IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPtree OUT refCur
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPtree FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_lang dl,
          ya_dept_bargain db
        WHERE
          d.dept_id = dl.dept_id
          AND d.dept_id = db.dept_id
          AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND db.site_id = iPsiteId
          AND db.enabled = 'Y'
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        OPEN curPtree FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl,
          ya_dept_bargain db
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = db.dept_id
          AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
          AND dl.lang_id = iPlangId
          AND d.tw_enabled = 'Y'
          AND db.site_id = iPsiteId
          AND db.enabled = 'Y'
        ORDER BY tw_disp_seq;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        OPEN curPtree FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          d.page_location,
          'N'
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl,
          ya_dept_bargain db
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = db.dept_id
          AND d.dept_id IN (iPchineseDept, iPjapaneseDept, iPkoreanDept, iPwesternDept)
          AND dl.lang_id = iPlangId
          AND d.ys_enabled = 'Y'
          AND db.site_id = iPsiteId
          AND db.enabled = 'Y'
        ORDER BY hk_disp_seq;
      END;
    END IF;
    RETURN;
  END GetBargainLangDeptTree;


  PROCEDURE GetParentDeptId (
    iPdept_id IN INT,
    iPparentDeptId OUT INT
  )
  AS
  BEGIN
    SELECT parent_dept_id
    INTO iPparentDeptId
    FROM ya_dept_rel
    WHERE dept_id = iPdept_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iPparentDeptId := 0;
  END GetParentDeptId;


  PROCEDURE GetArtistDeptTree2 (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE
        dept_id = iPdeptId
        AND ROWNUM = 1;
      EXCEPTION when no_data_found THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY
          d.us_disp_seq,
          d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
                AND ROWNUM = 1
            )
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY
          d.us_disp_seq,
          d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
                AND ROWNUM = 1
            )
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 Then
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND exists
          (
            SELECT 1
            FROM
              ya_prod_dept pd,
              ya_product_artist pa
            WHERE
              pd.sku = pa.sku
              AND pa.artist_id = iPartistId
              AND pd.dept_id = d.dept_id
              AND ROWNUM = 1
          )
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
                AND ROWNUM = 1
            )
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 Then
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND exists
          (
            SELECT 1
            FROM
              ya_prod_dept pd,
              ya_product_artist pa
            WHERE
              pd.sku = pa.sku
              AND pa.artist_id = iPartistId
              AND pd.dept_id = d.dept_id
              AND ROWNUM = 1
          )
          AND dr.parent_dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
                AND ROWNUM = 1
            )
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
    RETURN;
  END GetArtistDeptTree2;



  PROCEDURE GetBrowseEngBookSeriesDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPgroup_sku IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          dl.lang_id,
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_rel pr,
                ya_product p,
                ya_prod_dept pd
              WHERE
                p.sku=pr.sku
                AND pd.sku = p.sku
                AND pd.dept_id = dr.dept_id
                AND pr.parent_sku=iPgroup_sku
                AND ROWNUM = 1
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_rel pr,
                ya_product p,
                ya_prod_dept pd
              WHERE
                p.sku=pr.sku
                AND pd.sku = p.sku
                AND pd.dept_id = dr.dept_id
                AND pr.parent_sku=iPgroup_sku
                AND ROWNUM = 1
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_rel pr,
                ya_product p,
                ya_prod_dept pd
              WHERE
                p.sku=pr.sku
                AND pd.sku = p.sku
                AND pd.dept_id = dr.dept_id
                AND pr.parent_sku=iPgroup_sku
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_rel pr,
                ya_product p,
                ya_prod_dept pd
              WHERE
                p.sku=pr.sku
                AND pd.sku = p.sku
                AND pd.dept_id = dr.dept_id
                AND pr.parent_sku=iPgroup_sku
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_rel pr,
                ya_product p,
                ya_prod_dept pd
              WHERE
                p.sku=pr.sku
                AND pd.sku = p.sku
                AND pd.dept_id = dr.dept_id
                AND pr.parent_sku=iPgroup_sku
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_rel pr,
                ya_product p,
                ya_prod_dept pd
              WHERE
                p.sku=pr.sku
                AND pd.sku = p.sku
                AND pd.dept_id = dr.dept_id
                AND pr.parent_sku=iPgroup_sku
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
    RETURN;
  END GetBrowseEngBookSeriesDeptTree;



  PROCEDURE GetBrowseCampaignTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPcc IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM ya_prod_dept d1
              WHERE d1.sku IN
                (
                  SELECT c.sku
                  FROM ya_campaign c
                  WHERE c.campaign_code = iPcc
                )
              AND d1.dept_id = d.dept_id
           )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM ya_prod_dept d1
              WHERE d1.sku in
                (
                  SELECT c.sku
                  FROM ya_campaign c
                  WHERE c.campaign_code = iPcc
                )
              and d1.dept_id = d.dept_id
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 Then
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM ya_prod_dept d1
              WHERE d1.sku in
                (
                  SELECT c.sku
                  FROM ya_campaign c
                  WHERE c.campaign_code = iPcc
                )
              and d1.dept_id = d.dept_id
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM ya_prod_dept d1
              WHERE d1.sku in
                (
                  SELECT c.sku
                  FROM ya_campaign c
                  WHERE c.campaign_code = iPcc
                )
              and d1.dept_id = d.dept_id
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 Then
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM ya_prod_dept d1
              WHERE d1.sku in
                (
                  SELECT c.sku
                  FROM ya_campaign c
                  WHERE c.campaign_code = iPcc
                )
              and d1.dept_id = d.dept_id
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          CAST(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM ya_prod_dept d1
              WHERE d1.sku in
                (
                  SELECT c.sku
                  FROM ya_campaign c
                  WHERE c.campaign_code = iPcc
                )
              and d1.dept_id = d.dept_id
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
    RETURN;
  END GetBrowseCampaignTree;


  PROCEDURE GetBrowseGrpDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) lang_id,
          dl.dept_name,
          d.page_location,
          d.us_disp_seq
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl,
          ya_prod_dept pd,
          ya_product p3
        WHERE 1 = 1
          AND d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND d.dept_id = pd.dept_id
          AND pd.sku = p3.sku
          AND p3.is_parent = 'Y'
        GROUP BY
        d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) ,
          dl.dept_name,
          d.page_location,
          d.us_disp_seq
       ORDER BY d.us_disp_seq, d.dept_id, lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) lang_id,
          dl.dept_name,
          d.page_location,
          d.us_disp_seq
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl,
          ya_prod_dept pd,
          ya_product p3
        WHERE 1 = 1
          AND d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND d.dept_id = pd.dept_id
          AND pd.sku = p3.sku
          AND p3.is_parent = 'Y'
        GROUP BY
        d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) ,
          dl.dept_name,
          d.page_location,
          d.us_disp_seq
       ORDER BY d.us_disp_seq, d.dept_id, lang_id;

      END;
    ELSIF iPsiteId = 7 Then
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) lang_id,
          dl.dept_name,
          d.page_location,
          d.tw_disp_seq
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl,
          ya_prod_dept pd,
          ya_product p3
        WHERE 1 = 1
          AND d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND d.dept_id = pd.dept_id
          AND pd.sku = p3.sku
          AND p3.is_parent = 'Y'
        GROUP BY
        d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) ,
          dl.dept_name,
          d.page_location,
          d.tw_disp_seq
       ORDER BY d.tw_disp_seq, d.dept_id, lang_id;


        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) lang_id,
          dl.dept_name,
          d.page_location,
          d.tw_disp_seq
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl,
          ya_prod_dept pd,
          ya_product p3
        WHERE 1 = 1
          AND d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND d.dept_id = pd.dept_id
          AND pd.sku = p3.sku
          AND p3.is_parent = 'Y'
        GROUP BY
        d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) ,
          dl.dept_name,
          d.page_location,
          d.tw_disp_seq
       ORDER BY d.tw_disp_seq, d.dept_id, lang_id;

      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 Then
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) lang_id,
          dl.dept_name,
          d.page_location,
          d.hk_disp_seq
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl,
          ya_prod_dept pd,
          ya_product p3
        WHERE 1 = 1
          AND d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND d.dept_id = pd.dept_id
          AND pd.sku = p3.sku
          AND p3.is_parent = 'Y'
        GROUP BY
        d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) ,
          dl.dept_name,
          d.page_location,
          d.hk_disp_seq
       ORDER BY d.hk_disp_seq, d.dept_id, lang_id;


        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) lang_id,
          dl.dept_name,
          d.page_location,
          d.tw_disp_seq
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl,
          ya_prod_dept pd,
          ya_product p3
        WHERE 1 = 1
          AND d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND d.dept_id = pd.dept_id
          AND pd.sku = p3.sku
          AND p3.is_parent = 'Y'
        GROUP BY
        d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int) ,
          dl.dept_name,
          d.page_location,
          d.tw_disp_seq
       ORDER BY d.hk_disp_seq, d.dept_id, lang_id;

      END;
    END IF;
    RETURN;
  END GetBrowseGrpDeptTree;


  PROCEDURE GetBrowseDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          (
          SELECT COUNT(1)
          FROM ya_dept_rel dr2,
               ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = (SELECT parent_dept_id FROM ya_dept_rel WHERE dept_id = iPdeptId)
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          (
          SELECT COUNT(*)
          FROM ya_dept_rel dr2,
               ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = (SELECT parent_dept_id FROM ya_dept_rel WHERE dept_id = iPdeptId)
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = (SELECT parent_dept_id FROM ya_dept_rel WHERE dept_id = iPdeptId)
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = (SELECT parent_dept_id FROM ya_dept_rel WHERE dept_id = iPdeptId)
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = (SELECT parent_dept_id FROM ya_dept_rel WHERE dept_id = iPdeptId)
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = (SELECT parent_dept_id FROM ya_dept_rel WHERE dept_id = iPdeptId)
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          (
          SELECT COUNT(*)
          FROM
            ya_dept_rel dr2,
            ya_dept d2
          WHERE dr2.dept_id = d2.dept_id
          AND dr2.parent_dept_id = d.dept_id
          ),
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
  RETURN;
  END GetBrowseDeptTree;



  PROCEDURE GetProductListDeptTree (
    iPdeptId IN INT,
    iPsiteId IN INT,
    iPtypeId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          NVL(dr.parent_dept_id, -1),
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          dr.dept_id (+) = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list p3
              WHERE
                pd.sku = p3.sku
                AND pd.dept_id = d.dept_id
                AND p3.type_id = iPtypeId
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
          (
            SELECT 1
            FROM
              ya_prod_dept pd,
              ya_product_list p3
            WHERE
              pd.sku = p3.sku
              AND pd.dept_id = d.dept_id
              AND p3.type_id = iPtypeId
          )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list p3
              WHERE
                pd.sku = p3.sku
                AND pd.dept_id = d.dept_id
                AND p3.type_id = iPtypeId
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list p3
              WHERE
                pd.sku = p3.sku
                AND pd.dept_id = d.dept_id
                AND p3.type_id = iPtypeId
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list p3
              WHERE
                pd.sku = p3.sku
                AND pd.dept_id = d.dept_id
                AND p3.type_id = iPtypeId
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          d.page_location
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list p3
              WHERE
                pd.sku = p3.sku
                AND pd.dept_id = d.dept_id
                AND p3.type_id = iPtypeId
                AND pd.tw_enabled = 'Y'
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
  RETURN;
  END GetProductListDeptTree;



  PROCEDURE GetSupplierDeptTree (
    iPdeptId IN INT,
    iPsupplierId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product p
              WHERE
                pd.sku = p.sku
                AND pd.dept_id IN
                  (
                    select dept_id
                    from ya_dept_rel
                    where parent_dept_id =iLparentId
                  )
                AND pd.dept_id = d.dept_id
                AND p.us_supplier_id = iPsupplierId
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product p
              WHERE
                pd.sku = p.sku
                AND pd.dept_id = d.dept_id
                AND p.us_supplier_id = iPsupplierId
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product p
              WHERE
                pd.sku = p.sku
                AND pd.dept_id IN
                  (
                    select dept_id
                    from ya_dept_rel
                    where parent_dept_id = iLparentId
                  )
                AND pd.dept_id = d.dept_id
                AND p.tw_supplier_id = iPsupplierId
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product p
              WHERE
                pd.sku = p.sku
                AND pd.dept_id = d.dept_id
                AND p.tw_supplier_id = iPsupplierId
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product p
              WHERE
                pd.sku = p.sku
                AND p.tw_enabled = 'Y'
                AND pd.dept_id IN
                  (
                    select dept_id
                    from ya_dept_rel
                    where parent_dept_id = iLparentId
                  )
                AND pd.dept_id = d.dept_id
                AND p.tw_supplier_id = iPsupplierId
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product p
              WHERE
                pd.sku = p.sku
                AND pd.dept_id = d.dept_id
                AND p.tw_supplier_id = iPsupplierId
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
  RETURN;
  END GetSupplierDeptTree;



  PROCEDURE GetPublisherGroupDeptTree2 (
    iPdeptId IN INT,
    iPpublisherGroupId IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLparentId INT;
  BEGIN
    BEGIN
      SELECT parent_dept_id INTO iLparentId
      FROM ya_dept_rel
      WHERE dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = gr.publisher_id
                AND pd.dept_id = d.dept_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = gr.publisher_id
                AND pd.dept_id = d.dept_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY d.us_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = gr.publisher_id
                AND pd.dept_id = d.dept_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = gr.publisher_id
                AND pd.dept_id = d.dept_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY d.tw_disp_seq, d.dept_id, dl.lang_id;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult2 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = gr.publisher_id
                AND pd.dept_id = d.dept_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult3 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND d.dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;

        OPEN curPresult4 FOR
        SELECT
          d.dept_id,
          dr.parent_dept_id,
          0,
          cast(dl.lang_id as int),
          dl.dept_name,
          ''
        FROM
          ya_dept_rel dr,
          ya_dept d,
          ya_dept_lang dl
        WHERE
          dr.dept_id = d.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dl.lang_id <= 5
          AND exists
            (
              SELECT pd.dept_id
              FROM
                ya_prod_dept pd,
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                pd.sku = p.sku
                AND p.publisher_id = gr.publisher_id
                AND pd.dept_id = d.dept_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
        ORDER BY d.hk_disp_seq, d.dept_id, dl.lang_id;
      END;
    END IF;
  RETURN;
  END GetPublisherGroupDeptTree2;



  PROCEDURE IsLeafGroupDept (
    iPdeptId IN INT,
    iPsiteId IN  INT,
    iPreturn OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM ya_product p
              WHERE
                p.is_parent = 'Y'
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM ya_product p
              WHERE
                p.is_parent = 'Y'
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM ya_product p
              WHERE
                p.is_parent = 'Y'
            )
          AND ROWNUM = 1;
      END;
    END IF;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('no row return');
    RETURN;
  END IsLeafGroupDept;



  PROCEDURE IsLeafProductListDept (
    iPdeptId IN INT,
    iPsiteId IN  INT,
    iPtypeId IN INT,
    iPreturn OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.dept_id = d.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list pl
              WHERE
                pd.sku = pl.sku
                AND pl.type_id = iPtypeId
                AND pd.dept_id = d.dept_id
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.dept_id = d.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list pl
              WHERE
                pd.sku = pl.sku
                AND pl.type_id = iPtypeId
                AND pd.dept_id = d.dept_id
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.dept_id = d.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_list pl
              WHERE
                pd.sku = pl.sku
                AND pl.type_id = iPtypeId
                AND pd.dept_id = d.dept_id
            )
          AND ROWNUM = 1;
      END;
    END IF;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iPreturn := -1;
    RETURN;
  END IsLeafProductListDept;



  PROCEDURE IsLeafArtistDept (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN  INT,
    iPreturn OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_prod_dept pd,
                ya_product_artist pa
              WHERE
                pd.sku = pa.sku
                AND pa.artist_id = iPartistId
                AND pd.dept_id = d.dept_id
            )
          AND ROWNUM = 1;
      END;
    END IF;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('no row return');
    RETURN;
  END IsLeafArtistDept;



  PROCEDURE IsLeafSupplierDept (
    iPdeptId IN INT,
    iPsupplierId IN INT,
    iPsiteId IN INT,
    iPreturn OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM ya_product p
              WHERE
                p.us_supplier_id = iPsupplierId
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM ya_product p
              WHERE
                p.tw_supplier_id = iPsupplierId
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM ya_product p
              WHERE
                p.tw_supplier_id = iPsupplierId
            )
          AND ROWNUM = 1;
      END;
    END IF;

    EXCEPTION WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('no row return');
    RETURN;
  END IsLeafSupplierDept;



  PROCEDURE IsLeafPublisherGroupDept (
    iPdeptId IN INT,
    iPpublisherGroupId IN INT,
    iPsiteId IN INT,
    iPreturn OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.us_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                p.publisher_id = gr.publisher_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 7 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.tw_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                p.publisher_id = gr.publisher_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
          AND ROWNUM = 1;
      END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
      BEGIN
        SELECT COUNT(1)
        INTO iPreturn
        FROM
          ya_dept_rel dr,
          ya_dept d
        WHERE
          dr.parent_dept_id = iPdeptId
          AND d.ys_enabled = 'Y'
          AND dr.dept_id = d.dept_id
          AND EXISTS
            (
              SELECT 1
              FROM
                ya_product p,
                ya_publisher_group_rel gr
              WHERE
                p.publisher_id = gr.publisher_id
                AND gr.publisher_group_id = iPpublisherGroupId
            )
          AND ROWNUM = 1;
      END;
    END IF;

    EXCEPTION WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('no row return');
    RETURN;
  END IsLeafPublisherGroupDept;



  PROCEDURE GetBargainRootDept (
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      bc.dept_id,
      dl.dept_name_u
    FROM
      ya_bargain_category bc
      INNER JOIN ya_dept_lang dl ON
        bc.dept_id = dl.dept_id
    WHERE
      dl.lang_id = iPlang_id
      AND EXISTS
        (
          SELECT 1
          FROM ya_prod_attr pa
          WHERE
            pa.attribute_id = bc.category_attribute_id
            AND EXISTS
              (
                SELECT 1
                FROM ya_bargain_product bp
                WHERE
                  bp.sku = pa.sku
                  AND bp.site_id = iPsite_id
                  AND bp.sale_start <= SYSDATE()
                  AND bp.sale_end >= SYSDATE()
              )
        )
    ORDER BY bc.priority;
  END GetBargainRootDept;



  PROCEDURE GetBargainRootLangDept (
    iPbargain_attribute IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      bg.dept_id,
      gl.group_name_u
    FROM
      ya_bargain_line bl
      INNER JOIN ya_bargain_group bg ON
        bl.bargain_line_id = bg.bargain_line_id
      INNER JOIN ya_bargain_group_lang gl ON
        bg.group_id = gl.group_id
    WHERE
      bl.attribute_id = iPbargain_attribute
      AND gl.lang_id = iPlang_id
      AND EXISTS
        (
          SELECT 1
          FROM ya_prod_dept pd
          WHERE
            pd.dept_id = bg.dept_id
            --AND EXISTS
            AND pd.sku in
              (
                SELECT bp.sku
                FROM ya_bargain_product bp
                WHERE 1=1
                  --bp.sku = pd.sku
                  AND bp.site_id = iPsite_id
                  AND bp.sale_start <= SYSDATE()
                  AND bp.sale_end >= SYSDATE()
              )
        )
    ORDER BY bg.group_id;
    RETURN;
  END GetBargainRootLangDept;



  PROCEDURE GetBargainDept (
    iPdept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    IF iPsite_id = 1 THEN
      OPEN curPresult FOR
      SELECT
        dl.dept_id,
        dl.dept_name_u
      FROM
        ya_dept_rel dr
        INNER JOIN ya_dept d ON
          dr.dept_id = d.dept_id
        INNER JOIN ya_dept_lang dl ON
          dr.dept_id = dl.dept_id
      WHERE
        dr.parent_dept_id = iPdept_id
        AND d.us_enabled = 'Y'
        AND dl.lang_id = iPlang_id
        AND EXISTS
          (
            SELECT 1
            FROM ya_prod_dept pd
            WHERE
              pd.dept_id = dr.dept_id
              AND EXISTS
                (
                  SELECT 1
                  FROM ya_bargain_product bp
                  WHERE
                    bp.sku = pd.sku
                    AND bp.site_id = iPsite_id
                    AND bp.sale_start <= SYSDATE()
                    AND bp.sale_end >= SYSDATE()
                )
          )
      ORDER BY d.us_disp_seq;
    ELSIF iPsite_id = 7 THEN
      OPEN curPresult FOR
      SELECT
        dl.dept_id,
        dl.dept_name_u
      FROM
        ya_dept_rel dr
        INNER JOIN ya_dept d ON
          dr.dept_id = d.dept_id
        INNER JOIN ya_dept_lang dl ON
          dr.dept_id = dl.dept_id
      WHERE
        dr.parent_dept_id = iPdept_id
        AND d.tw_enabled = 'Y'
        AND dl.lang_id = iPlang_id
        AND EXISTS
          (
            SELECT 1
            FROM ya_prod_dept pd
            WHERE
              pd.dept_id = dr.dept_id
              AND EXISTS
                (
                  select 1
                  FROM ya_bargain_product bp
                  WHERE
                    bp.sku = pd.sku
                    AND bp.site_id = iPsite_id
                    AND bp.sale_start <= SYSDATE()
                    AND bp.sale_end >= SYSDATE()
                )
          )
      ORDER BY d.tw_disp_seq;
    ELSIF iPsite_id = 10 THEN
      OPEN curPresult FOR
      SELECT
        dl.dept_id,
        dl.dept_name_u
      FROM
        ya_dept_rel dr
        INNER JOIN ya_dept d ON
          dr.dept_id = d.dept_id
        INNER JOIN ya_dept_lang dl ON
          dr.dept_id = dl.dept_id
      WHERE
        dr.parent_dept_id = iPdept_id
        AND d.ys_enabled = 'Y'
        AND dl.lang_id = iPlang_id
        AND EXISTS
          (
            SELECT 1
            FROM ya_prod_dept pd
            WHERE
              pd.dept_id = dr.dept_id
              AND EXISTS
                (
                  select 1
                  FROM ya_bargain_product bp
                  WHERE
                    bp.sku = pd.sku
                    AND bp.site_id = iPsite_id
                    AND bp.sale_start <= SYSDATE()
                    AND bp.sale_end >= SYSDATE()
                )
          )
      ORDER BY d.hk_disp_seq;      
    END IF;
  END GetBargainDept;

  PROCEDURE GetPublisherDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPpublisherId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid='|| cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND exists (
            SELECT 1
            FROM ya_publisher_dept pd
            WHERE pd.publisher_id = iPpublisherId
            AND d.dept_id = pd.dept_id
          )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid='|| cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND exists (
            SELECT 1
            FROM ya_publisher_dept pd
            WHERE pd.publisher_id = iPpublisherId
            AND d.dept_id = pd.dept_id
          )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
          'artIdxDept.aspx?aid='|| cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND exists (
            SELECT 1
            FROM ya_publisher_dept pd
            WHERE pd.publisher_id = iPpublisherId
            AND d.dept_id = pd.dept_id
          )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd
              WHERE pd.publisher_id = iPpublisherId
              AND d.dept_id = pd.dept_id
            )
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd
              WHERE pd.publisher_id = iPpublisherId
              AND d.dept_id = pd.dept_id
            )
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd
              WHERE pd.publisher_id = iPpublisherId
              AND d.dept_id = pd.dept_id
            )
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd
              WHERE pd.publisher_id = iPpublisherId
              AND d.dept_id = pd.dept_id
            )
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd
              WHERE pd.publisher_id = iPpublisherId
              AND d.dept_id = pd.dept_id
            )
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPpublisherId as varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd
              WHERE pd.publisher_id = iPpublisherId
              AND d.dept_id = pd.dept_id
            )
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetPublisherDeptTree;

   PROCEDURE GetArtPubDeptTree (
    iPdeptId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    curPparent OUT refCur,
    curPsibling OUT refCur,
    curPchild OUT refCur
  )
  AS
    iLgrantDeptId INT;
    iLparentDeptId INT;
  BEGIN
    BEGIN
      SELECT dp.parent_dept_id INTO iLparentDeptId
      FROM ya_dept_rel dp
      WHERE dp.dept_id = iPdeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLparentDeptId := -1;
    END;

    BEGIN
      SELECT dg.parent_dept_id INTO iLgrantDeptId
      FROM ya_dept_rel dg
      WHERE dg.dept_id = iLparentDeptId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLgrantDeptId := -1;
    END;

    IF iPsiteId = 1 THEN
      BEGIN
        /* Parent */
        OPEN curPparent FOR
        SELECT
          d.dept_id,
          dl.dept_name,
         'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iLparentDeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLgrantDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND exists (
            SELECT 1
            FROM ya_publisher_dept pd, ya_artist_dept ad
            WHERE pd.dept_id = ad.dept_id
            AND d.dept_id = pd.dept_id
            AND pd.publisher_id = iPpublisherId
            AND ad.artist_id = iPartistId
          )
        ORDER BY us_disp_seq;

        /* Sibling */
        OPEN curPsibling FOR
        SELECT
          d.dept_id,
          dl.dept_name,
         'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
          CASE
            WHEN d.dept_id = iPdeptId THEN 'Y'
            ELSE 'N'
          END AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iLparentDeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND exists (
            SELECT 1
            FROM ya_publisher_dept pd, ya_artist_dept ad
            WHERE pd.dept_id = ad.dept_id
            AND d.dept_id = pd.dept_id
            AND pd.publisher_id = iPpublisherId
            AND ad.artist_id = iPartistId
          )
        ORDER BY us_disp_seq;

        /* Child */
        OPEN curPchild FOR
        SELECT
          d.dept_id,
          dl.dept_name,
         'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
          'N' AS IsVein
        FROM
          ya_dept d,
          ya_dept_rel dr,
          ya_dept_lang dl
        WHERE
          d.dept_id = dr.dept_id
          AND d.dept_id = dl.dept_id
          AND dr.parent_dept_id = iPdeptId
          AND dl.lang_id = iPlangId
          AND d.us_enabled = 'Y'
          AND exists (
            SELECT 1
            FROM ya_publisher_dept pd, ya_artist_dept ad
            WHERE pd.dept_id = ad.dept_id
            AND d.dept_id = pd.dept_id
            AND pd.publisher_id = iPpublisherId
            AND ad.artist_id = iPartistId
          )
        ORDER BY us_disp_seq;
      END;
    ELSIF iPsiteId = 7 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd, ya_artist_dept ad
              WHERE pd.dept_id = ad.dept_id
              AND d.dept_id = pd.dept_id
              AND pd.publisher_id = iPpublisherId
              AND ad.artist_id = iPartistId
            )
          ORDER BY tw_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd, ya_artist_dept ad
              WHERE pd.dept_id = ad.dept_id
              AND d.dept_id = pd.dept_id
              AND pd.publisher_id = iPpublisherId
              AND ad.artist_id = iPartistId
            )
          ORDER BY tw_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.tw_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd, ya_artist_dept ad
              WHERE pd.dept_id = ad.dept_id
              AND d.dept_id = pd.dept_id
              AND pd.publisher_id = iPpublisherId
              AND ad.artist_id = iPartistId
            )
          ORDER BY tw_disp_seq;
        END;
    ELSIF iPsiteId = 10 OR iPsiteId = 11 THEN
        BEGIN
          /* Parent */
          OPEN curPparent FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iLparentDeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLgrantDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd, ya_artist_dept ad
              WHERE pd.dept_id = ad.dept_id
              AND d.dept_id = pd.dept_id
              AND pd.publisher_id = iPpublisherId
              AND ad.artist_id = iPartistId
            )
          ORDER BY hk_disp_seq;

          /* Sibling */
          OPEN curPsibling FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
            CASE
              WHEN d.dept_id = iPdeptId THEN 'Y'
              ELSE 'N'
            END AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iLparentDeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd, ya_artist_dept ad
              WHERE pd.dept_id = ad.dept_id
              AND d.dept_id = pd.dept_id
              AND pd.publisher_id = iPpublisherId
              AND ad.artist_id = iPartistId
            )
          ORDER BY hk_disp_seq;

          /* Child */
          OPEN curPchild FOR
          SELECT
            d.dept_id,
            dl.dept_name,
            'artIdxDept.aspx?aid=' || cast(iPartistId as varchar2(10)) || '&' || 'amp;',
            'N' AS IsVein
          FROM
            ya_dept d,
            ya_dept_rel dr,
            ya_dept_lang dl
          WHERE
            d.dept_id = dr.dept_id
            AND d.dept_id = dl.dept_id
            AND dr.parent_dept_id = iPdeptId
            AND dl.lang_id = iPlangId
            AND d.ys_enabled = 'Y'
            AND exists (
              SELECT 1
              FROM ya_publisher_dept pd, ya_artist_dept ad
              WHERE pd.dept_id = ad.dept_id
              AND d.dept_id = pd.dept_id
              AND pd.publisher_id = iPpublisherId
              AND ad.artist_id = iPartistId
            )
          ORDER BY hk_disp_seq;
        END;
    END IF;
    RETURN;
  END GetArtPubDeptTree;
END Pkg_FE_DepartmentAccess;
/