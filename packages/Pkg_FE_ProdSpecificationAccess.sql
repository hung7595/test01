CREATE OR REPLACE PACKAGE Pkg_FE_ProdSpecificationAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetProdSpecificationInfo(
    rcPresult1 OUT refCur,
    rcPresult2 OUT refCur
  );

END Pkg_FE_ProdSpecificationAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_ProdSpecificationAccess
IS
  PROCEDURE GetProdSpecificationInfo(
    rcPresult1 OUT refCur,
    rcPresult2 OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult1 FOR
    SELECT
      psl.specification_id,
      psl.lang_id,
      psl.name
    FROM ya_prod_specification_lang psl
    INNER JOIN
      (
        SELECT DISTINCT psgl.account_id, psgl.specification_id
        FROM ya_prod_specification_grid_rel psgl
      ) psgl2 ON
      psl.specification_id = psgl2.specification_id
    ORDER BY psl.specification_id ASC, psl.lang_id ASC;


    OPEN rcPresult2 FOR
    SELECT
      psg.dept_id,
      psg.specification_group_id,
      psg.specification_id,
      psgl.lang_id, psgl.name
    FROM ya_prod_specification_group psg
    INNER JOIN ya_prod_specification_gp_lang psgl ON
      psg.specification_group_id = psgl.specification_group_id
    ORDER BY
      psg.dept_id ASC,
      psg.specification_group_id ASC,
      psg.display_order ASC;

    RETURN;
  END GetProdSpecificationInfo;
END Pkg_FE_ProdSpecificationAccess;
/

