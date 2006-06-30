CREATE OR REPLACE package Pkg_test_bo_ProductListDalc
AS
  TYPE refCur IS ref CURSOR;

  PROCEDURE GetTrailerProdByDept (
    iPdept_id IN INT,
    iPlang_id IN INT,
    rcPresult_1 OUT refCur,
    rcPresult_2 OUT refCur
  );
END Pkg_test_bo_ProductListDalc;
/

CREATE OR REPLACE package body Pkg_test_bo_ProductListDalc
IS
  /*
  * Game Project 21 Nov 2005
  * proc_bo_GetTrailerProductByDepartment
  */
  PROCEDURE GetTrailerProdByDept (
    iPdept_id IN INT,
    iPlang_id IN INT,
    rcPresult_1 OUT refCur,
    rcPresult_2 OUT refCur
  )
  AS
    iLtemp INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp
    FROM ya_dept_attr
    WHERE dept_id = iPdept_id
    AND attribute_id in (84, 79982);

    IF iLtemp > 0 THEN
      OPEN rcPresult_1 FOR
      SELECT DISTINCT
        pd.sku
      FROM
        ya_prod_dept pd
        INNER JOIN ya_prod_grid pg ON
          pd.sku = pg.sku
          AND pg.grid_id = 9
        INNER JOIN ya_prod_grid_lang pgl ON
          pg.sku = pgl.sku
          AND pgl.grid_id = 9
      WHERE
        pd.dept_id = iPdept_id
        AND pgl.lang_id = iPlang_id
        AND length(pgl.label1_value) > 0
        AND length(pgl.label2_value) > 0
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude)
	AND pd.sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859);
    ELSE
      OPEN rcPresult_1 FOR
      SELECT DISTINCT
        pd.sku
      FROM
        ya_prod_dept pd
        INNER JOIN ya_prod_grid pg ON
          pd.sku = pg.sku
          AND pg.grid_id = 9
        INNER JOIN ya_prod_grid_lang pgl ON
          pg.sku = pgl.sku
          AND pgl.grid_id = 9
        left OUTER JOIN ya_adult_product yap ON
          pd.sku = yap.sku
      WHERE
        pd.dept_id = iPdept_id
        AND pgl.lang_id = iPlang_id
        AND length(pgl.label1_value) > 0
        AND length(pgl.label2_value) > 0
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude)
	AND pd.sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859)
        AND yap.sku IS NULL;
    END IF;


    SELECT COUNT(0)
    INTO iLtemp
    FROM ya_dept_attr
    WHERE dept_id = iPdept_id
    AND attribute_id = 125;

    IF iLtemp > 0 THEN
      OPEN rcPresult_2 FOR
      SELECT
        c.sku,
        c.related_sku
      FROM
        ya_cross_selling c
        INNER JOIN ya_prod_dept pd ON
          c.sku = pd.sku
      WHERE
        c.type_id = 3
        AND pd.dept_id = iPdept_id
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
    END IF;
  END GetTrailerProdByDept;
END Pkg_test_bo_ProductListDalc;
/

