CREATE OR REPLACE PACKAGE Pkg_BO_ProdSpecificationDALC
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE FillProductSpecification (
    iPsku IN INT,
    rcPresult OUT refCur
  );

  PROCEDURE GetProdSpecificationGridRel(
    rcPresult1 OUT refCur
  );

END Pkg_BO_ProdSpecificationDALC;
/


CREATE OR REPLACE PACKAGE BODY Pkg_BO_ProdSpecificationDALC
IS
  PROCEDURE FillProductSpecification (
    iPsku INT,
    rcPresult OUT refCur
    )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT
      pgl.grid_id,
      pgl.lang_id,
      pgl.label1_value,
      pgl.label2_value,
      pgl.label3_value,
      pgl.label4_value,
      pgl.label5_value,
      pgl.label6_value,
      pgl.label7_value,
      pgl.label8_value
    FROM
      YA_PROD_GRID_LANG pgl
    WHERE
      pgl.sku = iPsku
    ORDER BY pgl.grid_id ASC, pgl.lang_id;

  END FillProductSpecification;

  PROCEDURE GetProdSpecificationGridRel(
    rcPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult1 FOR
    SELECT
      specification_id,
      (grid_id * 10 + col_num) AS grid_key
    FROM
      YA_PROD_SPECIFICATION_GRID_REL
    ORDER BY specification_id ASC, grid_id ASC, col_num ASC;
    RETURN;
  END GetProdSpecificationGridRel;
END Pkg_BO_ProdSpecificationDALC;
/
