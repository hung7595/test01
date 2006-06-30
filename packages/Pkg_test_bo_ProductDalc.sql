CREATE OR REPLACE package Pkg_test_bo_ProductDalc
AS
  TYPE refCur IS ref CURSOR;
  PROCEDURE GetProductTrailerRel (
    rc_result	OUT	refCur,
    iPsku IN INT
  );

  PROCEDURE GetMultiProductTrailerRel (
    rc_result	OUT	refCur,
    iPsku1 IN	INT DEFAULT null,
    iPsku2 IN	INT DEFAULT null,
    iPsku3 IN	INT DEFAULT null,
    iPsku4 IN	INT DEFAULT null,
    iPsku5 IN	INT DEFAULT null,
    iPsku6 IN	INT DEFAULT null,
    iPsku7 IN	INT DEFAULT null,
    iPsku8 IN	INT DEFAULT null,
    iPsku9 IN	INT DEFAULT null,
    iPsku10 IN	INT DEFAULT null,
    iPsku11 IN	INT DEFAULT null,
    iPsku12 IN	INT DEFAULT null,
    iPsku13 IN	INT DEFAULT null,
    iPsku14 IN	INT DEFAULT null,
    iPsku15 IN	INT DEFAULT null,
    iPsku16 IN	INT DEFAULT null,
    iPsku17 IN	INT DEFAULT null,
    iPsku18 IN	INT DEFAULT null,
    iPsku19 IN	INT DEFAULT null,
    iPsku20 IN	INT DEFAULT null,
    iPsku21 IN	INT DEFAULT null,
    iPsku22 IN	INT DEFAULT null,
    iPsku23 IN	INT DEFAULT null,
    iPsku24 IN	INT DEFAULT null,
    iPsku25 IN	INT DEFAULT null,
    iPsku26 IN	INT DEFAULT null,
    iPsku27 IN	INT DEFAULT null,
    iPsku28 IN	INT DEFAULT null,
    iPsku29 IN	INT DEFAULT null,
    iPsku30 IN	INT DEFAULT null,
    iPsku31 IN	INT DEFAULT null,
    iPsku32 IN	INT DEFAULT null,
    iPsku33 IN	INT DEFAULT null,
    iPsku34 IN	INT DEFAULT null,
    iPsku35 IN	INT DEFAULT null,
    iPsku36 IN	INT DEFAULT null,
    iPsku37 IN	INT DEFAULT null,
    iPsku38 IN	INT DEFAULT null,
    iPsku39 IN	INT DEFAULT null,
    iPsku40 IN	INT DEFAULT null,
    iPsku41 IN	INT DEFAULT null,
    iPsku42 IN	INT DEFAULT null,
    iPsku43 IN	INT DEFAULT null,
    iPsku44 IN	INT DEFAULT null,
    iPsku45 IN	INT DEFAULT null,
    iPsku46 IN	INT DEFAULT null,
    iPsku47 IN	INT DEFAULT null,
    iPsku48 IN	INT DEFAULT null,
    iPsku49 IN	INT DEFAULT null,
    iPsku50 IN	INT DEFAULT null,
    iPsku51 IN	INT DEFAULT null,
    iPsku52 IN	INT DEFAULT null,
    iPsku53 IN	INT DEFAULT null,
    iPsku54 IN	INT DEFAULT null,
    iPsku55 IN	INT DEFAULT null,
    iPsku56 IN	INT DEFAULT null,
    iPsku57 IN	INT DEFAULT null,
    iPsku58 IN	INT DEFAULT null,
    iPsku59 IN	INT DEFAULT null,
    iPsku60 IN	INT DEFAULT null,
    iPsku61 IN	INT DEFAULT null,
    iPsku62 IN	INT DEFAULT null,
    iPsku63 IN	INT DEFAULT null,
    iPsku64 IN	INT DEFAULT null
  );
END Pkg_test_bo_ProductDalc;
/

CREATE OR REPLACE package body Pkg_test_bo_ProductDalc
IS
  PROCEDURE GetProductTrailerRel (
    rc_result	OUT	refCur,
    iPsku IN INT
  )
  AS
  BEGIN
    OPEN rc_result FOR
    select
      sku,
      display_seq,
      lang_id,
      label1_value,
      label2_value
    from ya_prod_grid_lang
    where
      sku = iPsku
      AND grid_id = 9
      AND label1_value IS NOT NULL
      AND label2_value IS NOT NULL
      AND sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859)
    order by sku, display_seq, lang_id;
  END GetProductTrailerRel;

  /*
  * Game Project 21 Nov 2005
  * proc_bo_GetMultiProductTrailerRel
  */
  PROCEDURE GetMultiProductTrailerRel (
    rc_result	OUT	refCur,
    iPsku1 IN	INT DEFAULT null,
    iPsku2 IN	INT DEFAULT null,
    iPsku3 IN	INT DEFAULT null,
    iPsku4 IN	INT DEFAULT null,
    iPsku5 IN	INT DEFAULT null,
    iPsku6 IN	INT DEFAULT null,
    iPsku7 IN	INT DEFAULT null,
    iPsku8 IN	INT DEFAULT null,
    iPsku9 IN	INT DEFAULT null,
    iPsku10 IN	INT DEFAULT null,
    iPsku11 IN	INT DEFAULT null,
    iPsku12 IN	INT DEFAULT null,
    iPsku13 IN	INT DEFAULT null,
    iPsku14 IN	INT DEFAULT null,
    iPsku15 IN	INT DEFAULT null,
    iPsku16 IN	INT DEFAULT null,
    iPsku17 IN	INT DEFAULT null,
    iPsku18 IN	INT DEFAULT null,
    iPsku19 IN	INT DEFAULT null,
    iPsku20 IN	INT DEFAULT null,
    iPsku21 IN	INT DEFAULT null,
    iPsku22 IN	INT DEFAULT null,
    iPsku23 IN	INT DEFAULT null,
    iPsku24 IN	INT DEFAULT null,
    iPsku25 IN	INT DEFAULT null,
    iPsku26 IN	INT DEFAULT null,
    iPsku27 IN	INT DEFAULT null,
    iPsku28 IN	INT DEFAULT null,
    iPsku29 IN	INT DEFAULT null,
    iPsku30 IN	INT DEFAULT null,
    iPsku31 IN	INT DEFAULT null,
    iPsku32 IN	INT DEFAULT null,
    iPsku33 IN	INT DEFAULT null,
    iPsku34 IN	INT DEFAULT null,
    iPsku35 IN	INT DEFAULT null,
    iPsku36 IN	INT DEFAULT null,
    iPsku37 IN	INT DEFAULT null,
    iPsku38 IN	INT DEFAULT null,
    iPsku39 IN	INT DEFAULT null,
    iPsku40 IN	INT DEFAULT null,
    iPsku41 IN	INT DEFAULT null,
    iPsku42 IN	INT DEFAULT null,
    iPsku43 IN	INT DEFAULT null,
    iPsku44 IN	INT DEFAULT null,
    iPsku45 IN	INT DEFAULT null,
    iPsku46 IN	INT DEFAULT null,
    iPsku47 IN	INT DEFAULT null,
    iPsku48 IN	INT DEFAULT null,
    iPsku49 IN	INT DEFAULT null,
    iPsku50 IN	INT DEFAULT null,
    iPsku51 IN	INT DEFAULT null,
    iPsku52 IN	INT DEFAULT null,
    iPsku53 IN	INT DEFAULT null,
    iPsku54 IN	INT DEFAULT null,
    iPsku55 IN	INT DEFAULT null,
    iPsku56 IN	INT DEFAULT null,
    iPsku57 IN	INT DEFAULT null,
    iPsku58 IN	INT DEFAULT null,
    iPsku59 IN	INT DEFAULT null,
    iPsku60 IN	INT DEFAULT null,
    iPsku61 IN	INT DEFAULT null,
    iPsku62 IN	INT DEFAULT null,
    iPsku63 IN	INT DEFAULT null,
    iPsku64 IN	INT DEFAULT null
  )
  AS
  BEGIN
    OPEN rc_result FOR
    select
      sku,
      display_seq,
      lang_id,
      label1_value,
      label2_value
    from ya_prod_grid_lang
    where sku in
      (
        iPsku1,
        iPsku2,
        iPsku3,
        iPsku4,
        iPsku5,
        iPsku6,
        iPsku7,
        iPsku8,
        iPsku9,
        iPsku10,
        iPsku11,
        iPsku12,
        iPsku13,
        iPsku14,
        iPsku15,
        iPsku16,
        iPsku17,
        iPsku18,
        iPsku19,
        iPsku20,
        iPsku21,
        iPsku22,
        iPsku23,
        iPsku24,
        iPsku25,
        iPsku26,
        iPsku27,
        iPsku28,
        iPsku29,
        iPsku30,
        iPsku31,
        iPsku32,
        iPsku33,
        iPsku34,
        iPsku35,
        iPsku36,
        iPsku37,
        iPsku38,
        iPsku39,
        iPsku40,
        iPsku41,
        iPsku42,
        iPsku43,
        iPsku44,
        iPsku45,
        iPsku46,
        iPsku47,
        iPsku48,
        iPsku49,
        iPsku50,
        iPsku51,
        iPsku52,
        iPsku53,
        iPsku54,
        iPsku55,
        iPsku56,
        iPsku57,
        iPsku58,
        iPsku59,
        iPsku60,
        iPsku61,
        iPsku62,
        iPsku63,
        iPsku64
      )
      AND grid_id = 9
      AND label1_value IS NOT NULL
      AND label2_value IS NOT NULL
      AND sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859)
    ORDER BY sku, display_seq, lang_id;
  END;
END Pkg_test_bo_ProductDalc;
/

