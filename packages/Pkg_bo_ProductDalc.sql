
REM START SS_ADM PKG_BO_PRODUCTDALC

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_BO_PRODUCTDALC" 
AS
  TYPE refCur IS ref CURSOR;
  -- --- cross selling 2005 ---+
  PROCEDURE GetCrossSellingInfo
  (
    iPsku IN INT,
    curPresult1 OUT refcur,
    curPresult2 OUT refcur,
    curPresult3 OUT refcur,
    curPresult4 OUT refcur
  );

  PROCEDURE GetProductAwardsRawInfos (
    cPgetProdAward OUT refCur,
    iPsku_1 IN INT DEFAULT NULL,
    iPsku_2 IN INT DEFAULT NULL,
    iPsku_3 IN INT DEFAULT NULL,
    iPsku_4 IN INT DEFAULT NULL,
    iPsku_5 IN INT DEFAULT NULL,
    iPsku_6 IN INT DEFAULT NULL,
    iPsku_7 IN INT DEFAULT NULL,
    iPsku_8 IN INT DEFAULT NULL,
    iPsku_9 IN INT DEFAULT NULL,
    iPsku_10 IN INT DEFAULT NULL,
    iPsku_11 IN INT DEFAULT NULL,
    iPsku_12 IN INT DEFAULT NULL,
    iPsku_13 IN INT DEFAULT NULL,
    iPsku_14 IN INT DEFAULT NULL,
    iPsku_15 IN INT DEFAULT NULL,
    iPsku_16 IN INT DEFAULT NULL,
    iPsku_17 IN INT DEFAULT NULL,
    iPsku_18 IN INT DEFAULT NULL,
    iPsku_19 IN INT DEFAULT NULL,
    iPsku_20 IN INT DEFAULT NULL,
    iPsku_21 IN INT DEFAULT NULL,
    iPsku_22 IN INT DEFAULT NULL,
    iPsku_23 IN INT DEFAULT NULL,
    iPsku_24 IN INT DEFAULT NULL,
    iPsku_25 IN INT DEFAULT NULL,
    iPsku_26 IN INT DEFAULT NULL,
    iPsku_27 IN INT DEFAULT NULL,
    iPsku_28 IN INT DEFAULT NULL,
    iPsku_29 IN INT DEFAULT NULL,
    iPsku_30 IN INT DEFAULT NULL,
    iPsku_31 IN INT DEFAULT NULL,
    iPsku_32 IN INT DEFAULT NULL,
    iPsku_33 IN INT DEFAULT NULL,
    iPsku_34 IN INT DEFAULT NULL,
    iPsku_35 IN INT DEFAULT NULL,
    iPsku_36 IN INT DEFAULT NULL,
    iPsku_37 IN INT DEFAULT NULL,
    iPsku_38 IN INT DEFAULT NULL,
    iPsku_39 IN INT DEFAULT NULL,
    iPsku_40 IN INT DEFAULT NULL,
    iPsku_41 IN INT DEFAULT NULL,
    iPsku_42 IN INT DEFAULT NULL,
    iPsku_43 IN INT DEFAULT NULL,
    iPsku_44 IN INT DEFAULT NULL,
    iPsku_45 IN INT DEFAULT NULL,
    iPsku_46 IN INT DEFAULT NULL,
    iPsku_47 IN INT DEFAULT NULL,
    iPsku_48 IN INT DEFAULT NULL,
    iPsku_49 IN INT DEFAULT NULL,
    iPsku_50 IN INT DEFAULT NULL,
    iPsku_51 IN INT DEFAULT NULL,
    iPsku_52 IN INT DEFAULT NULL,
    iPsku_53 IN INT DEFAULT NULL,
    iPsku_54 IN INT DEFAULT NULL,
    iPsku_55 IN INT DEFAULT NULL,
    iPsku_56 IN INT DEFAULT NULL,
    iPsku_57 IN INT DEFAULT NULL,
    iPsku_58 IN INT DEFAULT NULL,
    iPsku_59 IN INT DEFAULT NULL,
    iPsku_60 IN INT DEFAULT NULL,
    iPsku_61 IN INT DEFAULT NULL,
    iPsku_62 IN INT DEFAULT NULL,
    iPsku_63 IN INT DEFAULT NULL,
    iPsku_64 IN INT DEFAULT NULL
  );

  PROCEDURE GetProductAwardsRawInfo (
    cPgetProdAward OUT refCur,
    iPsku IN INT DEFAULT NULL
  );

  PROCEDURE GetProducts (
    curPgetProd1         OUT 	refCur,
    curPgetProd2         OUT 	refCur,
    curPgetProd3         OUT 	refCur,
    curPgetProd4         OUT 	refCur,
    curPgetProd5         OUT 	refCur,
    curPgetProd6         OUT 	refCur,
    curPgetProd7         OUT 	refCur,
    curPgetProd8         OUT 	refCur,
    curPgetProd9         OUT 	refCur,
    curPgetProd10        OUT 	refCur,
    curPgetProd11        OUT 	refCur,
    curPgetProd12        OUT 	refCur,
    curPgetProd13        OUT 	refCur,
    curPgetProd14        OUT 	refCur,
    curPgetProd15        OUT 	refCur,
    curPgetProd16        OUT 	refCur,
    curPgetProd17        OUT 	refCur,
    curPgetProd18        OUT 	refCur,
    curPgetProd19        OUT 	refCur,
    curPgetProd20        OUT 	refCur,
    curPgetProd21        OUT 	refCur,
    curPgetProd22        OUT 	refCur,
    curPgetProd23        OUT 	refCur,
    curPgetProd24        OUT 	refCur,
    curPgetProd25        OUT 	refCur,
    curPgetProd26        OUT 	refCur,
    curPgetProd27        OUT 	refCur,
    curPgetProd28        OUT 	refCur,
    iPsku1               IN   INT DEFAULT null,
    iPsku2               IN   INT DEFAULT null,
    iPsku3               IN   INT DEFAULT null,
    iPsku4               IN   INT DEFAULT null,
    iPsku5               IN   INT DEFAULT null,
    iPsku6               IN   INT DEFAULT null,
    iPsku7               IN   INT DEFAULT null,
    iPsku8               IN   INT DEFAULT null,
    iPsku9               IN   INT DEFAULT null,
    iPsku10              IN   INT DEFAULT null,
    iPsku11              IN   INT DEFAULT null,
    iPsku12              IN   INT DEFAULT null,
    iPsku13              IN   INT DEFAULT null,
    iPsku14              IN   INT DEFAULT null,
    iPsku15              IN   INT DEFAULT null,
    iPsku16              IN   INT DEFAULT null,
    iPsku17              IN   INT DEFAULT null,
    iPsku18              IN   INT DEFAULT null,
    iPsku19              IN   INT DEFAULT null,
    iPsku20              IN   INT DEFAULT null
	);

  PROCEDURE GetProduct (
    iPsku		IN      	INT,
    curPgetProd1        OUT		refCur,
    curPgetProd2        OUT		refCur,
    curPgetProd3        OUT		refCur,
    curPgetProd4        OUT		refCur,
    curPgetProd5        OUT		refCur,
    curPgetProd6        OUT		refCur,
    curPgetProd7        OUT		refCur,
    curPgetProd8        OUT		refCur,
    curPgetProd9        OUT		refCur,
    curPgetProd10       OUT		refCur,
    curPgetProd11       OUT		refCur,
    curPgetProd12       OUT		refCur,
    curPgetProd13       OUT		refCur,
    curPgetProd14       OUT		refCur,
    curPgetProd15       OUT		refCur,
    curPgetProd16       OUT		refCur,
    curPgetProd17       OUT		refCur,
    curPgetProd18       OUT		refCur,
    curPgetProd19       OUT		refCur,
    curPgetProd20       OUT		refCur,
    curPgetProd21       OUT		refCur,
    curPgetProd22       OUT		refCur,
    curPgetProd23       OUT		refCur,
    curPgetProd24       OUT		refCur,
    curPgetProd25       OUT		refCur,
    curPgetProd26       OUT		refCur,
    curPgetProd27       OUT		refCur,
    curPgetProd28       OUT		refCur
  );

  PROCEDURE GetBookInfos (
    curPgetBook1	OUT	refCur,
    curPgetBook2	OUT	refCur,
    curPgetBook3	OUT	refCur,
    curPgetBook4	OUT	refCur,
    iPsku1		IN	INT DEFAULT NULL,
    iPsku2		IN	INT DEFAULT NULL,
    iPsku3		IN	INT DEFAULT NULL,
    iPsku4		IN	INT DEFAULT NULL,
    iPsku5		IN	INT DEFAULT NULL,
    iPsku6		IN	INT DEFAULT NULL,
    iPsku7		IN	INT DEFAULT NULL,
    iPsku8		IN	INT DEFAULT NULL,
    iPsku9		IN	INT DEFAULT NULL,
    iPsku10		IN	INT DEFAULT NULL,
    iPsku11		IN	INT DEFAULT NULL,
    iPsku12		IN	INT DEFAULT NULL,
    iPsku13		IN	INT DEFAULT NULL,
    iPsku14		IN	INT DEFAULT NULL,
    iPsku15		IN	INT DEFAULT NULL,
    iPsku16		IN	INT DEFAULT NULL,
    iPsku17		IN	INT DEFAULT NULL,
    iPsku18		IN	INT DEFAULT NULL,
    iPsku19		IN	INT DEFAULT NULL,
    iPsku20		IN	INT DEFAULT NULL
  );

  PROCEDURE GetBookInfo (
    iPsku		IN 	INT,
    curPgetInfo1	OUT	refCur,
    curPgetInfo2	OUT	refCur,
    curPgetInfo3	OUT	refCur,
    curPgetInfo4	OUT	refCur
  );

  PROCEDURE GetCrossSelling (
    iPsku		IN	INT,
    curPgetCross1      	OUT 	refCur,
    curPgetCross2	OUT	refCur
  );

  PROCEDURE GetCrossSellingDifferentFormat (
    iPsku			IN 	INT,
    iPdifferent_format_type1	IN	INT DEFAULT 1,
    iPdifferent_format_type2	IN	INT DEFAULT 3,
    curPgetCross1		OUT	refCur,
    curPgetCross2		OUT	refCur
  );

  PROCEDURE GetCrossDifferentFormats (
    curPgetCrossSelling1		OUT	refCur,
    curPgetCrossSelling2		OUT	refCur,
    iPdifferent_format_type1	IN	INT DEFAULT 1,
    iPdifferent_format_type2	IN	INT DEFAULT 3,
    iPsku1			IN	INT DEFAULT NULL,
    iPsku2			IN	INT DEFAULT NULL,
    iPsku3			IN	INT DEFAULT NULL,
    iPsku4			IN	INT DEFAULT NULL,
    iPsku5			IN	INT DEFAULT NULL,
    iPsku6			IN	INT DEFAULT NULL,
    iPsku7			IN	INT DEFAULT NULL,
    iPsku8			IN	INT DEFAULT NULL,
    iPsku9			IN	INT DEFAULT NULL,
    iPsku10			IN	INT DEFAULT NULL,
    iPsku11			IN	INT DEFAULT NULL,
    iPsku12			IN	INT DEFAULT NULL,
    iPsku13			IN	INT DEFAULT NULL,
    iPsku14			IN	INT DEFAULT NULL,
    iPsku15			IN	INT DEFAULT NULL,
    iPsku16			IN	INT DEFAULT NULL,
    iPsku17			IN	INT DEFAULT NULL,
    iPsku18			IN	INT DEFAULT NULL,
    iPsku19			IN	INT DEFAULT NULL,
    iPsku20			IN	INT DEFAULT NULL
  );

  PROCEDURE GetPromtionBundleInfo (
    iPsku IN INT,
    cPgetPromoBundle1 OUT refCur,
    cPgetPromoBundle2 OUT refCur
  );

  PROCEDURE GetReview (
    iPsku		IN	INT,
    curPgetproduct1	OUT	refCur,
    curPgetproduct2	OUT	refCur,
    curPgetproduct3	OUT	refCur
  );

  PROCEDURE GetReviews (
    curPgetMulti1	OUT	refCur,
    curPgetMulti2	OUT	refCur,
    curPgetMulti3	OUT	refCur,
    iPsku1 		IN	INT DEFAULT null,
    iPsku2 		IN	INT DEFAULT null,
    iPsku3 		IN	INT DEFAULT null,
    iPsku4 		IN	INT DEFAULT null,
    iPsku5 		IN	INT DEFAULT null,
    iPsku6 		IN	INT DEFAULT null,
    iPsku7 		IN	INT DEFAULT null,
    iPsku8 		IN	INT DEFAULT null,
    iPsku9 		IN	INT DEFAULT null,
    iPsku10		IN	INT DEFAULT null,
    iPsku11		IN	INT DEFAULT null,
    iPsku12		IN	INT DEFAULT null,
    iPsku13		IN	INT DEFAULT null,
    iPsku14		IN	INT DEFAULT null,
    iPsku15		IN	INT DEFAULT null,
    iPsku16		IN	INT DEFAULT null,
    iPsku17		IN	INT DEFAULT null,
    iPsku18		IN	INT DEFAULT null,
    iPsku19		IN	INT DEFAULT null,
    iPsku20		IN	INT DEFAULT null
  );


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
  );

  /*
  * Game Project 21 Nov 2005
  * proc_bo_GetProductTrailerRel
  */
  PROCEDURE GetProductTrailerRel (
    rc_result	OUT	refCur,
    iPsku IN INT
  );
END Pkg_bo_ProductDalc;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_BO_PRODUCTDALC" 
IS

  PROCEDURE GetProductAwardsRawInfos (
    cPgetProdAward OUT refCur,
    iPsku_1 IN INT DEFAULT NULL,
    iPsku_2 IN INT DEFAULT NULL,
    iPsku_3 IN INT DEFAULT NULL,
    iPsku_4 IN INT DEFAULT NULL,
    iPsku_5 IN INT DEFAULT NULL,
    iPsku_6 IN INT DEFAULT NULL,
    iPsku_7 IN INT DEFAULT NULL,
    iPsku_8 IN INT DEFAULT NULL,
    iPsku_9 IN INT DEFAULT NULL,
    iPsku_10 IN INT DEFAULT NULL,
    iPsku_11 IN INT DEFAULT NULL,
    iPsku_12 IN INT DEFAULT NULL,
    iPsku_13 IN INT DEFAULT NULL,
    iPsku_14 IN INT DEFAULT NULL,
    iPsku_15 IN INT DEFAULT NULL,
    iPsku_16 IN INT DEFAULT NULL,
    iPsku_17 IN INT DEFAULT NULL,
    iPsku_18 IN INT DEFAULT NULL,
    iPsku_19 IN INT DEFAULT NULL,
    iPsku_20 IN INT DEFAULT NULL,
    iPsku_21 IN INT DEFAULT NULL,
    iPsku_22 IN INT DEFAULT NULL,
    iPsku_23 IN INT DEFAULT NULL,
    iPsku_24 IN INT DEFAULT NULL,
    iPsku_25 IN INT DEFAULT NULL,
    iPsku_26 IN INT DEFAULT NULL,
    iPsku_27 IN INT DEFAULT NULL,
    iPsku_28 IN INT DEFAULT NULL,
    iPsku_29 IN INT DEFAULT NULL,
    iPsku_30 IN INT DEFAULT NULL,
    iPsku_31 IN INT DEFAULT NULL,
    iPsku_32 IN INT DEFAULT NULL,
    iPsku_33 IN INT DEFAULT NULL,
    iPsku_34 IN INT DEFAULT NULL,
    iPsku_35 IN INT DEFAULT NULL,
    iPsku_36 IN INT DEFAULT NULL,
    iPsku_37 IN INT DEFAULT NULL,
    iPsku_38 IN INT DEFAULT NULL,
    iPsku_39 IN INT DEFAULT NULL,
    iPsku_40 IN INT DEFAULT NULL,
    iPsku_41 IN INT DEFAULT NULL,
    iPsku_42 IN INT DEFAULT NULL,
    iPsku_43 IN INT DEFAULT NULL,
    iPsku_44 IN INT DEFAULT NULL,
    iPsku_45 IN INT DEFAULT NULL,
    iPsku_46 IN INT DEFAULT NULL,
    iPsku_47 IN INT DEFAULT NULL,
    iPsku_48 IN INT DEFAULT NULL,
    iPsku_49 IN INT DEFAULT NULL,
    iPsku_50 IN INT DEFAULT NULL,
    iPsku_51 IN INT DEFAULT NULL,
    iPsku_52 IN INT DEFAULT NULL,
    iPsku_53 IN INT DEFAULT NULL,
    iPsku_54 IN INT DEFAULT NULL,
    iPsku_55 IN INT DEFAULT NULL,
    iPsku_56 IN INT DEFAULT NULL,
    iPsku_57 IN INT DEFAULT NULL,
    iPsku_58 IN INT DEFAULT NULL,
    iPsku_59 IN INT DEFAULT NULL,
    iPsku_60 IN INT DEFAULT NULL,
    iPsku_61 IN INT DEFAULT NULL,
    iPsku_62 IN INT DEFAULT NULL,
    iPsku_63 IN INT DEFAULT NULL,
    iPsku_64 IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN cPgetProdAward FOR
    SELECT
      ad.event_id,
      ad.title_id,
      NVL(paa.status_type_id, pa.status_type_id),
      ad.year,
      paa.artist_id,
      pa.priority,
      pa.sku
    FROM
      ya_product_award pa,
      ya_award_definition ad,
      ya_award_event ae,
      ya_award_lookup award_title,
      ya_product_award_artist paa
    WHERE
      pa.sku IN
      (
        iPsku_1, iPsku_2, iPsku_3, iPsku_4,
        iPsku_5, iPsku_6, iPsku_7, iPsku_8,
        iPsku_9, iPsku_10, iPsku_11, iPsku_12,
        iPsku_13, iPsku_14, iPsku_15, iPsku_16,
        iPsku_17, iPsku_18, iPsku_19, iPsku_20,
        iPsku_21, iPsku_22, iPsku_23, iPsku_24,
        iPsku_25, iPsku_26, iPsku_27, iPsku_28,
        iPsku_29, iPsku_30, iPsku_31, iPsku_32,
        iPsku_33, iPsku_34, iPsku_35, iPsku_36,
        iPsku_37, iPsku_38, iPsku_39, iPsku_40,
        iPsku_41, iPsku_42, iPsku_43, iPsku_44,
        iPsku_45, iPsku_46, iPsku_47, iPsku_48,
        iPsku_49, iPsku_50, iPsku_51, iPsku_52,
        iPsku_53, iPsku_54, iPsku_55, iPsku_56,
        iPsku_57, iPsku_58, iPsku_59, iPsku_60,
        iPsku_61, iPsku_62, iPsku_63, iPsku_64
      )
      AND ad.award_definition_id = pa.award_definition_id
      AND ae.award_event_id = ad.event_id
      AND award_title.award_lookup_id = ad.title_id
      AND (
        pa.award_definition_id = paa.award_definition_id (+)
        AND pa.sku = paa.sku (+)
        AND pa.status_type_id = paa.status_type_id (+)
        )
    ORDER BY
      pa.sku ASC, ad.year DESC, ae.priority ASC, award_title.priority ASC, award_title.award_lookup_id ASC;
  END GetProductAwardsRawInfos;

  PROCEDURE GetProductAwardsRawInfo (
    cPgetProdAward OUT refCur,
    iPsku IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN cPgetProdAward FOR
    SELECT
      ad.event_id,
      ad.title_id,
      NVL(paa.status_type_id, pa.status_type_id),
      ad.year,
      paa.artist_id,
      pa.priority,
      pa.sku
    FROM
      ya_product_award pa,
      ya_award_definition ad,
      ya_award_event ae,
      ya_award_lookup award_title,
      ya_product_award_artist paa
    WHERE
      pa.sku = iPsku
      AND ad.award_definition_id = pa.award_definition_id
      AND ae.award_event_id = ad.event_id
      AND award_title.award_lookup_id = ad.title_id
      AND (
        pa.award_definition_id = paa.award_definition_id (+)
        AND pa.sku = paa.sku (+)
        AND pa.status_type_id = paa.status_type_id (+)
        )
    ORDER BY
      ad.year DESC, ae.priority ASC, award_title.priority ASC, award_title.award_lookup_id ASC, paa.priority ASC;
  END GetProductAwardsRawInfo;

  PROCEDURE GetProducts (
    curPgetProd1                OUT 	refCur,
    curPgetProd2                OUT 	refCur,
    curPgetProd3                OUT 	refCur,
    curPgetProd4                OUT 	refCur,
    curPgetProd5                OUT 	refCur,
    curPgetProd6                OUT 	refCur,
    curPgetProd7                OUT 	refCur,
    curPgetProd8                OUT 	refCur,
    curPgetProd9                OUT 	refCur,
    curPgetProd10               OUT 	refCur,
    curPgetProd11               OUT 	refCur,
    curPgetProd12               OUT 	refCur,
    curPgetProd13               OUT 	refCur,
    curPgetProd14               OUT 	refCur,
    curPgetProd15               OUT 	refCur,
    curPgetProd16               OUT 	refCur,
    curPgetProd17               OUT 	refCur,
    curPgetProd18               OUT 	refCur,
    curPgetProd19               OUT 	refCur,
    curPgetProd20               OUT 	refCur,
    curPgetProd21               OUT 	refCur,
    curPgetProd22               OUT 	refCur,
    curPgetProd23               OUT 	refCur,
    curPgetProd24               OUT 	refCur,
    curPgetProd25               OUT 	refCur,
    curPgetProd26               OUT 	refCur,
    curPgetProd27               OUT 	refCur,
    curPgetProd28               OUT 	refCur,
    iPsku1                       IN   INT DEFAULT null,
    iPsku2                       IN   INT DEFAULT null,
    iPsku3                       IN   INT DEFAULT null,
    iPsku4                       IN   INT DEFAULT null,
    iPsku5                       IN   INT DEFAULT null,
    iPsku6                       IN   INT DEFAULT null,
    iPsku7                       IN   INT DEFAULT null,
    iPsku8                       IN   INT DEFAULT null,
    iPsku9                       IN   INT DEFAULT null,
    iPsku10                      IN   INT DEFAULT null,
    iPsku11                      IN   INT DEFAULT null,
    iPsku12                      IN   INT DEFAULT null,
    iPsku13                      IN   INT DEFAULT null,
    iPsku14                      IN   INT DEFAULT null,
    iPsku15                      IN   INT DEFAULT null,
    iPsku16                      IN   INT DEFAULT null,
    iPsku17                      IN   INT DEFAULT null,
    iPsku18                      IN   INT DEFAULT null,
    iPsku19                      IN   INT DEFAULT null,
    iPsku20                      IN   INT DEFAULT null
	)
  AS
    iLstartpos                   INT;
    iLendpos                     INT;
    dtLnullDate                  DATE;
    iLshipmentunitconst          INT;
  BEGIN

    SELECT TO_DATE('01-01-1900','DD-MM-YYYY') INTO dtLnullDate FROM DUAL;

  /* basic info */

    OPEN curPgetProd1 FOR
      SELECT
        NVL(p.account_id, -1),
        NVL(p.is_parent, 'N') AS is_parent,
        --0, --NVL(rating_id, -1) AS EDITORIAL_review_id,
        Fn_GetRatingID(p.sku),
        NVL(p.country_release_id, -1),
        p.cover_img_loc AS cover_img_loc,
        NVL(p.cover_img_width, 0) AS cover_img_width,
        NVL(p.cover_img_height, 0) AS cover_img_height,
        p.preorder_buffer_day,
        p.product_version AS product_version,
        round(TO_NUMBER(NVL(p.weight, 9999)),2) AS weight,
        NVL(p.width, 0) AS width,
        NVL(p.height, 0) AS height,
        NVL(p.length, 0) AS length,
        c.content_img_loc AS content_img_loc,
        CAST(NVL(c.content_img_width, 0) AS int) AS content_img_width,
        CAST(NVL(c.content_img_height, 0) AS int) AS content_img_height,
        c.content AS content,
        pl.prod_name_img_loc,
        NVL(pl.name_img_width, -1),
        NVL(pl.name_img_height, -1),
        NVL(p.publisher_id, -1),
        NVL(cast(p.num_children AS INT), 0),
        p.sku
      FROM
        ya_product p
        LEFT JOIN ya_content c on (p.content_id = c.content_id)
--        LEFT JOIN ya_prod_lang pl ON p.sku = pl.sku AND pl.lang_id IN (SELECT lang_id FROM ya_prod_lang WHERE sku=pl.sku AND preferred_flag='Y' AND ROWNUM = 1)
        INNER JOIN ya_prod_lang pl ON p.sku = pl.sku AND pl.lang_id = 1
--        left outer join
--        (
--          SELECT sku, pr.rating_id
--          FROM
--            ya_product_rating pr
--            inner join ya_prod_rating_lang rl on pr.rating_id = rl.rating_id
--            inner join ya_review r on rl.us_review_id = r.review_id
--            WHERE
--              review is not null
--              AND ROWNUM = 1
--              AND pr.sku IN
--                (
--iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
--                )
--              AND pr.shopper_id = 'EDITORIAL'
--          ) pr on pr.sku = p.sku
      WHERE
        p.sku IN
        (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        );

    /* parent info  */

    OPEN curPgetProd2 FOR
      SELECT
        ps.parent_sku,
        pl1.prod_name_u AS en_name,
        pl2.prod_name_u AS b5_name,
        pl3.prod_name_u AS jp_name,
        pl4.prod_name_u AS kr_name,
        pl5.prod_name_u AS gb_name,
        ps.sku
      FROM
        ya_prod_rel ps,
        (
          SELECT * FROM ya_prod_lang pl1
          WHERE pl1.lang_id = 1
        ) pl1,
        (
          SELECT * FROM ya_prod_lang pl2
          WHERE pl2.lang_id = 2
        ) pl2,
        (
          SELECT * FROM ya_prod_lang pl3
          WHERE pl3.lang_id = 3
        ) pl3,
        (
          SELECT * FROM ya_prod_lang pl4
          WHERE pl4.lang_id = 4
        ) pl4,
        (
          SELECT * FROM ya_prod_lang pl5
          WHERE	 pl5.lang_id  = 5
        ) pl5
      WHERE
        pl1.sku (+) = ps.parent_sku
        AND pl2.sku (+) = ps.parent_sku
        AND pl3.sku (+) = ps.parent_sku
        AND pl4.sku (+) = ps.parent_sku
        AND pl5.sku (+) = ps.parent_sku
        AND ps.sku IN
        (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        );


    /* parent group circle info */

    OPEN curPgetProd3 FOR
      SELECT
        gc.group_sku,
        pl1.prod_name_u AS en_name,
        pl2.prod_name_u AS b5_name,
        pl3.prod_name_u AS jp_name,
        pl4.prod_name_u AS kr_name,
        pl5.prod_name_u AS gb_name,
        ps.parent_sku
      FROM (
        SELECT
    pr.sku,
    MAX(NVL(pr.parent_sku, -1)) parent_sku
        FROM ya_prod_rel pr
        WHERE pr.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
           )
    GROUP BY  pr.sku
    ) ps,
    ya_prod_group_detail gd,
    ya_prod_group_circle gc,
    (
    SELECT * FROM ya_prod_lang pl1
    WHERE pl1.lang_id = 1
    ) pl1,
    (
    SELECT * FROM ya_prod_lang pl2
    WHERE pl2.lang_id = 2
    ) pl2,
    (
    SELECT * FROM ya_prod_lang pl3
    WHERE pl3.lang_id = 3
    ) pl3,
    (
    SELECT * FROM ya_prod_lang pl4
    WHERE pl4.lang_id = 4
    ) pl4,
    (
    SELECT * FROM ya_prod_lang pl5
    WHERE pl5.lang_id = 5
    ) pl5
    WHERE ps.parent_sku = gd.sku
    AND gc.group_circle_id = gd.group_circle_id
    AND pl1.sku (+) = gc.group_sku
    AND pl2.sku (+) = gc.group_sku
    AND pl3.sku (+) = gc.group_sku
    AND pl4.sku (+) = gc.group_sku
    AND pl5.sku (+) = gc.group_sku
    AND gc.group_sku <> gd.sku;


  /* artist info */
  /* return the roles of a artist for a product  */
  /* get artist info by proc_bo_GetArtistAttributeInfo  */

    OPEN curPgetProd4 FOR
      SELECT
        pa.artist_id,
        pa.show_in_browse,
        ar1.description,
        ar2.description,
        ar3.description,
        ar4.description,
        ar5.description,
        pa.rel_id,
        pa.sku
      FROM ya_product_artist pa,
    (
    SELECT * FROM ya_artist_rel ar1
    WHERE ar1.lang_id = 1
    ) ar1,
    (
    SELECT * FROM ya_artist_rel ar2
    WHERE ar2.lang_id = 2
    ) ar2,
    (
    SELECT * FROM ya_artist_rel ar3
    WHERE ar3.lang_id = 3
    ) ar3,
    (
    SELECT * FROM ya_artist_rel ar4
    WHERE ar4.lang_id = 4
    ) ar4,
    (
    SELECT * FROM ya_artist_rel ar5
    WHERE ar5.lang_id = 5
    ) ar5
    WHERE pa.rel_id = ar1.rel_id (+)
    AND pa.rel_id = ar2.rel_id (+)
    AND pa.rel_id = ar3.rel_id (+)
    AND pa.rel_id = ar4.rel_id (+)
    AND pa.rel_id = ar5.rel_id (+)
    AND pa.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
      )
    ORDER BY pa.rel_ranking;


  /* attribute info */

    OPEN curPgetProd5 FOR
    SELECT
      CAST(pa.attribute_id AS int) AS attribute_id,
      pa.sku
    FROM ya_prod_attr pa, ya_attribute a
    WHERE	a.attribute_id  = pa.attribute_id
    AND pa.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
      )
    ORDER BY a.attribute_type_id;


  /* book info  */
  /* stored IN another sp -- proc_bo_GetBookInfo  */
  /* video info */

    OPEN curPgetProd6 FOR
      SELECT
        NVL(duration, 0),
        sample_loc,
        sku
      FROM ya_prod_video
      WHERE sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
         );

  /* product name, subtitles, prod_name_aka, prod_subtitle_aka
    */


    OPEN curPgetProd7 FOR
      SELECT
        pl1.prod_name_u AS en_product_name,
        pl2.prod_name_u AS b5_product_name,
        pl3.prod_name_u AS jp_product_name,
        pl4.prod_name_u AS kr_product_name,
        pl5.prod_name_u AS gb_product_name,
        pl1.prod_subtitle AS en_product_subtitle,
        pl2.prod_subtitle AS b5_product_subtitle,
        pl3.prod_subtitle AS jp_product_subtitle,
        pl4.prod_subtitle AS kr_product_subtitle,
        pl5.prod_subtitle AS gb_product_subtitle,
        pl1.prod_name_aka AS en_product_name_aka,
        pl2.prod_name_aka AS b5_product_name_aka,
        pl3.prod_name_aka AS jp_product_name_aka,
        pl4.prod_name_aka AS kr_product_name_aka,
        pl5.prod_name_aka AS gb_product_name_aka,
        pl1.prod_subtitle_aka AS en_product_subtitle_aka,
        pl2.prod_subtitle_aka AS b5_product_subtitle_aka,
        pl3.prod_subtitle_aka AS jp_product_subtitle_aka,
        pl4.prod_subtitle_aka AS kr_product_subtitle_aka,
        pl5.prod_subtitle_aka AS gb_product_subtitle_aka,
        pl1.prod_series_title AS en_product_series_title,
        pl2.prod_series_title AS b5_product_series_title,
        pl3.prod_series_title AS jp_product_series_title,
        pl4.prod_series_title AS kr_product_series_title,
        pl5.prod_series_title AS gb_product_series_title,
        pl1.prod_series_volume AS en_product_series_volume,
        pl2.prod_series_volume AS b5_product_series_volume,
        pl3.prod_series_volume AS jp_product_series_volume,
        pl4.prod_series_volume AS kr_product_series_volume,
        pl5.prod_series_volume AS gb_product_series_volume,
        pl1.prod_title_volume AS en_product_title_volume,
        pl2.prod_title_volume AS b5_product_title_volume,
        pl3.prod_title_volume AS jp_product_title_volume,
        pl4.prod_title_volume AS kr_product_title_volume,
        pl5.prod_title_volume AS gb_product_title_volume,

        p.sku
      FROM ya_product p,
      (
      SELECT * FROM ya_prod_lang pl1
      WHERE pl1.lang_id = 1
      ) pl1,
      (
      SELECT * FROM ya_prod_lang pl2
      WHERE pl2.lang_id = 2
      ) pl2,
      (
      SELECT * FROM ya_prod_lang pl3
      WHERE pl3.lang_id = 3
      ) pl3,
      (
      SELECT * FROM ya_prod_lang pl4
      WHERE pl4.lang_id = 4
      ) pl4,
      (
      SELECT * FROM ya_prod_lang pl5
      WHERE pl5.lang_id = 5
      ) pl5
      WHERE pl1.sku (+) = p.sku
      AND	pl2.sku (+) = p.sku
      AND	pl3.sku (+) = p.sku
      AND	pl4.sku (+) = p.sku
      AND	pl5.sku (+) = p.sku
      AND	p.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        );


  /* product article  */

    OPEN curPgetProd8 FOR
    SELECT
      NVL(rel.article_id, 0) article_id,
      NVL(lang.lang_id, 0) lang_id,
      lang.title title,
      article.in_tracking_no in_tracking_no,
      article.out_tracking_no out_tracking_no,
      rel.rel_id
    FROM ya_article_rel rel,
         ya_article_lang lang,
         ya_article article
    WHERE rel.article_id = lang.article_id
    AND rel.lang_id = lang.lang_id
    AND rel.article_id = article.article_id
    AND (rel.rel_type = 1
    AND rel.rel_id IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
    AND rel.enable = 'Y'
    AND article.status = 8
    AND article.enable = 'Y')
    ORDER BY rel.priority ASC;


  /* us info  */

    OPEN curPgetProd9 FOR
    SELECT
      NVL(p.release_date, dtLnullDate),
      NVL(rs.actual_count, 0) AS review_count,
      NVL(p.us_launch_date, dtLnullDate) AS launch_date,
      --CAST(ROUND(NVL(average_rating, -1) + 0.5, 0) AS int) as average_rating,
      CAST(ROUND(NVL(average_rating, 0) / NVL(weighted_count,1),0) AS INT) AS average_rating,
      p.sku
    FROM ya_product p,
      (
      SELECT
        SUM(actual_count) AS actual_count,
        SUM(weighted_count) as weighted_count,
        SUM(weighted_count * average_rating) as average_rating,
        sku
      FROM ya_review_summary rs
      WHERE rs.site_id  = 1
      AND	rs.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
          )
      GROUP BY  rs.sku
    ) rs
      WHERE rs.sku (+) = p.sku
      AND	(p.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
          )
        );

  /* promotion info  */

    OPEN curPgetProd10 FOR
    SELECT
      c.campaign_code,
      p.sku
    FROM ya_product p,
         ya_campaign c
    WHERE	p.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
      )
    AND p.sku = c.sku
    ORDER BY p.sku, c.campaign_code;


  /* limited quantity  */

    OPEN curPgetProd11 FOR
    SELECT
      lq.frontend_quantity,
      lq.sku
    FROM ya_limited_quantity lq
    WHERE	lq.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
     AND lq.site_id IN (99, 1)
     AND lq.frontend_quantity > 0
     ORDER BY lq.sku;


  /* IN grams */
     SELECT 200 INTO iLshipmentunitconst FROM DUAL;

    OPEN curPgetProd12 FOR
    SELECT
      CAST(
        CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit

        ELSE CEIL(NVL(CASE WHEN dimension_weight IS NOT NULL
        AND weight IS NOT NULL THEN
        CASE WHEN dimension_weight > weight THEN dimension_weight
        ELSE weight
        END
        ELSE weight
        END, iLshipmentunitconst) / iLshipmentunitconst)
        END AS INT) AS shipment_unit, t1.sku
        FROM ya_product t1, ya_shipping_unit t2
        WHERE t1.sku = t2.sku (+)
        AND 1 = t2.site_id (+)
        AND t1.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
            );

  /* description lang_id = 1 (en)  */

    OPEN curPgetProd13 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.us_description_id = d.description_id (+)
    AND (pl.lang_id  = 1
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );


  /* description lang_id = 2 (b5)  */

    OPEN curPgetProd14 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.us_description_id = d.description_id (+)
    AND (pl.lang_id = 2
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );

  /* description lang_id = 3 (jp)  */

    OPEN curPgetProd15 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl, ya_description d
    WHERE pl.us_description_id = d.description_id (+)
    AND (pl.lang_id = 3
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );


  /* description lang_id = 4 (kr)  */

    OPEN curPgetProd16 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.us_description_id = d.description_id (+)
    AND (pl.lang_id = 4
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );

  /* description lang_id = 5 (gb)  */

    OPEN curPgetProd17 FOR
    SELECT

      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.us_description_id = d.description_id (+)
    AND (pl.lang_id = 5
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );

/* region info */
  OPEN curPgetProd18 FOR
    SELECT
      r.region_id,
      r.can_sell,
      r.enable,
      r.supplier_id,
      r.list_price,
      r.sale_price,
      r.sale_start,
      r.sale_end,
      r.preorder,
      r.preorder_start,
      r.preorder_end,
      r.preorder_buffer_day,
      r.preorder_date,
      NVL(o.availability_id, r.product_availability) as product_availability,
      r.sku
    FROM
      (
      SELECT
        pr.region_id as region_id,
        -- countryIds are to be obtained FROM xml
        NVL(pr.is_can_sell, 'N') as can_sell,
        NVL(pr.is_enabled, 'N') as enable,
        NVL(pr.supplier_id, -1)  as supplier_id,
        NVL(pr.list_price,9999) as list_price, --4
        -- compute isOnSale IN app
        NVL(pr.sale_price,9999) as sale_price,
        NVL(pr.sale_price_start, dtLnullDate) as sale_start,
        NVL(pr.sale_price_end, dtLnullDate) as sale_end,
        NVL(pr.is_preorder, 'N') as preorder,
        NVL(pr.preorder_start, dtLnullDate) as preorder_start, --9
        NVL(pr.preorder_end, dtLnullDate) as preorder_end,
        CAST(NVL(pr.preorder_buffer_day, -1) as int) as preorder_buffer_day,
        NVL(pr.preorder_deadline, dtLnullDate) as preorder_date,
        NVL(pa.avlb, 60) as product_availability,
        pr.prod_id as sku, --14
        pr.sequence
      FROM
        prod_region pr,
        prod_avlb pa
      WHERE pr.prod_id IN (iPsku1, iPsku2, iPsku3, iPsku4, iPsku5, iPsku6, iPsku7, iPsku8, iPsku9, iPsku10, iPsku11, iPsku12, iPsku13, iPsku14, iPsku15, iPsku16, iPsku17, iPsku18, iPsku19, iPsku20)
        AND pr.origin_id = 1 -- us
        AND pr.category_id = 1 -- b2c
        AND pa.prod_id = pr.prod_id
        AND pa.region_id = pr.region_id
        AND pa.origin_id = 1 -- us
        AND pa.category = 1 -- b2c
      ) r
    INNER JOIN
      ya_product p on
      (
        p.sku = r.sku
      )
    LEFT JOIN
      ya_availability_override o ON
      (
        r.supplier_id = o.supplier_id
        AND p.account_id = o.account_id
        AND SYSDATE BETWEEN o.start_date AND o.end_date
        AND r.product_availability < o.availability_id
        AND r.product_availability <> 0
      )
      ORDER BY r.sequence DESC;

  /* tw info */

    OPEN curPgetProd19 FOR
    SELECT
      NVL(p.release_date, dtLnullDate),
      NVL(rs.actual_count, 0) AS review_count,
      NVL(p.tw_launch_date, dtLnullDate) AS launch_date,
      --CAST(ROUND(NVL(average_rating, -1) + 0.5, 0) AS int) AS average_rating,
      CAST(ROUND(NVL(average_rating, 0) / NVL(weighted_count,1),0) AS INT) AS average_rating,
      p.sku
    FROM ya_product p,
      (
      SELECT
        SUM(actual_count) AS actual_count,
        SUM(weighted_count) as weighted_count,
        SUM(weighted_count * average_rating) as average_rating,
        sku
      FROM ya_review_summary rs
      WHERE rs.site_id = 7
      AND	rs.sku IN
        (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      GROUP BY rs.sku
      ) rs
      WHERE rs.sku (+) = p.sku
      AND
        p.sku IN
        (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        );


  /* promotion info  */

    OPEN curPgetProd20 FOR
      SELECT
        c.campaign_code,
        p.sku
      FROM
        ya_product p,
        ya_campaign c
      WHERE p.sku IN
        (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      AND	p.sku = c.sku
      ORDER BY p.sku, c.campaign_code;

  /* limited quantity  */

    OPEN curPgetProd21 FOR
    SELECT
      lq.frontend_quantity,
      lq.sku
    FROM ya_limited_quantity lq
    WHERE lq.sku IN
      (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
    AND lq.site_id IN (99, 7)
    AND lq.frontend_quantity > 0
    ORDER BY lq.sku;

  /* shipment unit  */

    SELECT 200 INTO iLshipmentunitconst FROM DUAL;
  /* IN grams */

    OPEN curPgetProd22 FOR
    SELECT
      CAST(
        CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit

        ELSE CEIL(NVL(CASE WHEN dimension_weight IS NOT NULL
        AND weight IS NOT NULL THEN
        CASE WHEN dimension_weight > weight THEN dimension_weight

        ELSE weight
        END
        ELSE weight
        END, iLshipmentunitconst) / iLshipmentunitconst)
        END AS INT) AS shipment_unit, t1.sku
        FROM ya_product t1,
       ya_shipping_unit t2
        WHERE t1.sku = t2.sku (+)
        AND 7 = t2.site_id (+)
        AND t1.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
            );

  /* description lang_id = 1 (en)  */

    OPEN curPgetProd23 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.tw_description_id = d.description_id (+)
    AND (pl.lang_id  = 1
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );

  /* description lang_id = 2 (b5)  */

    OPEN curPgetProd24 FOR
      SELECT
        d.description,
        pl.sku
      FROM ya_prod_lang pl,
     ya_description d
      WHERE pl.tw_description_id = d.description_id (+)
      AND	(pl.lang_id = 2
      AND	pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
    );


  /* description lang_id = 3 (jp)  */

    OPEN curPgetProd25 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.tw_description_id = d.description_id (+)
    AND (pl.lang_id = 3
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );

  /* description lang_id = 4 (kr)  */

    OPEN curPgetProd26 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE	pl.tw_description_id = d.description_id (+)
    AND (pl.lang_id = 4
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );

  /* description lang_id = 5 (gb)  */

    OPEN curPgetProd27 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE pl.tw_description_id = d.description_id (+)
    AND (pl.lang_id = 5
    AND pl.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
        )
      );
  OPEN curPgetProd28 FOR
    SELECT
      r.region_id,
      r.can_sell,
      r.enable,
      r.supplier_id,
      r.list_price,
      r.sale_price,
      r.sale_start,
      r.sale_end,
      r.preorder,
      r.preorder_start,
      r.preorder_end,
      r.preorder_buffer_day,
      r.preorder_date,
      NVL(o.availability_id, r.product_availability) as product_availability,
      r.sku
    FROM
      (
      SELECT
        pr.region_id as region_id,
        -- countryIds are to be obtained FROM xml
        NVL(pr.is_can_sell, 'N') as can_sell,
        NVL(pr.is_enabled, 'N') as enable,
        NVL(pr.supplier_id, -1)  as supplier_id,
        NVL(pr.list_price,9999) as list_price, --4
        -- compute isOnSale IN app,
        NVL(pr.sale_price,9999) as sale_price,
        NVL(pr.sale_price_start, dtLnullDate) as sale_start,
        NVL(pr.sale_price_end, dtLnullDate) as sale_end,
        NVL(pr.is_preorder, 'N') as preorder,
        NVL(pr.preorder_start, dtLnullDate) as preorder_start, --9
        NVL(pr.preorder_end, dtLnullDate) as preorder_end,
        CAST(NVL(pr.preorder_buffer_day, -1) as int) as preorder_buffer_day,
        NVL(pr.preorder_deadline, dtLnullDate) as preorder_date,
        NVL(pa.avlb, 60) as product_availability,
        pr.prod_id as sku, --14
        pr.sequence
      FROM
        prod_region pr,
        prod_avlb pa
      WHERE
        pr.prod_id IN (iPsku1, iPsku2, iPsku3, iPsku4, iPsku5, iPsku6, iPsku7, iPsku8, iPsku9, iPsku10, iPsku11, iPsku12, iPsku13, iPsku14, iPsku15, iPsku16, iPsku17, iPsku18, iPsku19, iPsku20)
        AND pr.origin_id = 7 -- tw
        AND pr.category_id = 1 -- b2c
        AND pa.prod_id = pr.prod_id
        AND pa.region_id = pr.region_id
        AND pa.origin_id = 7 -- tw
        AND pa.category = 1 -- b2c
      ) r
    INNER JOIN
      ya_product p on
        (
          p.sku = r.sku
        )
    LEFT JOIN
      ya_availability_override o ON
        (
          r.supplier_id = o.supplier_id
          AND p.account_id = o.account_id
          AND SYSDATE BETWEEN o.start_date AND o.end_date
          AND r.product_availability < o.availability_id
          AND r.product_availability <> 0
        )
    ORDER BY r.sequence DESC;

  RETURN;
  END GetProducts;

  PROCEDURE GetProduct (
    iPsku		IN      	INT,
    curPgetProd1        OUT		refCur,
    curPgetProd2        OUT		refCur,
    curPgetProd3        OUT		refCur,
    curPgetProd4        OUT		refCur,
    curPgetProd5        OUT		refCur,
    curPgetProd6        OUT		refCur,
    curPgetProd7        OUT		refCur,
    curPgetProd8        OUT		refCur,
    curPgetProd9        OUT		refCur,
    curPgetProd10       OUT		refCur,
    curPgetProd11       OUT		refCur,
    curPgetProd12       OUT		refCur,
    curPgetProd13       OUT		refCur,
    curPgetProd14       OUT		refCur,
    curPgetProd15       OUT		refCur,
    curPgetProd16       OUT		refCur,
    curPgetProd17       OUT		refCur,
    curPgetProd18       OUT		refCur,
    curPgetProd19       OUT		refCur,
    curPgetProd20       OUT		refCur,
    curPgetProd21       OUT		refCur,
    curPgetProd22       OUT		refCur,
    curPgetProd23       OUT		refCur,
    curPgetProd24       OUT		refCur,
    curPgetProd25       OUT		refCur,
    curPgetProd26       OUT		refCur,
    curPgetProd27       OUT		refCur,
    curPgetProd28       OUT		refCur
  )
  AS
      iLstartpos            INT;
      iLendpos              INT;
      dtLnullDate           DATE;
      iLshipmentunitconst   INT;
  BEGIN
    SELECT TO_DATE('01-01-1900','DD-MM-YYYY') INTO dtLnullDate FROM DUAL;

  /* basic info */

    OPEN curPgetProd1 FOR
    SELECT
      NVL(p.account_id, - 1),
      NVL(p.is_parent, 'N') as is_parent,
      --NVL(rating_id, - 1) as editorial_review_id,
      Fn_GetRatingID(p.sku),
      NVL(p.country_release_id, -1),
      p.cover_img_loc as cover_img_loc,
      NVL(p.cover_img_width, 0) as cover_img_width,
      NVL(p.cover_img_height, 0) as cover_img_height,
      p.preorder_buffer_day,
      p.product_version as product_version,
      round(TO_NUMBER(NVL(p.weight, 9999)), 2) as weight,
      NVL(p.width, 0) as width,
      NVL(p.height, 0) as height,
      NVL(p.length, 0) as length,
      c.content_img_loc as content_img_loc,
      CAST(NVL(c.content_img_width, 0) AS int) as content_img_width,
      CAST(NVL(c.content_img_height, 0) AS int) as content_img_height,
      c.content as content,
      pl.prod_name_img_loc,
      NVL(pl.name_img_width, -1),
      NVL(pl.name_img_height, -1),
      NVL(p.publisher_id, -1),
      NVL(cast(p.num_children AS INT), 0),
      p.sku
    FROM
      ya_product p
      LEFT JOIN ya_content c ON (p.content_id = c.content_id)
      --LEFT JOIN ya_prod_lang pl ON p.sku = pl.sku AND pl.lang_id IN (SELECT lang_id FROM ya_prod_lang WHERE sku=pl.sku AND preferred_flag='Y' AND ROWNUM=1)
      INNER JOIN ya_prod_lang pl ON p.sku = pl.sku AND pl.lang_id = 1
      --LEFT OUTER JOIN (SELECT sku, rating_id FROM ya_product_rating pr WHERE pr.sku = iPsku AND pr.shopper_id = 'EDITORIAL' AND ROWNUM=1) pr on pr.sku = p.sku
    WHERE
      p.sku = iPsku;

  /* parent info */
    OPEN curPgetProd2 FOR
    SELECT
      ps.parent_sku,
      pl1.prod_name_u as en_name,
      pl2.prod_name_u as b5_name,
      pl3.prod_name_u as jp_name,
      pl4.prod_name_u as kr_name,
      pl5.prod_name_u as gb_name,
      ps.sku
    FROM ya_prod_rel ps,
      (
      SELECT * FROM ya_prod_lang pl1
      WHERE pl1.lang_id = 1
      ) pl1,
      (
      SELECT * FROM ya_prod_lang pl2
      WHERE pl2.lang_id = 2
      ) pl2,
      (
      SELECT * FROM ya_prod_lang pl3
      WHERE pl3.lang_id = 3
      ) pl3,
      (
      SELECT * FROM  ya_prod_lang pl4
      WHERE pl4.lang_id = 4
      ) pl4,
      (
      SELECT * FROM  ya_prod_lang pl5
      WHERE pl5.lang_id = 5
      ) pl5
    WHERE pl1.sku (+) = ps.parent_sku
    AND	pl2.sku (+) = ps.parent_sku
    AND	pl3.sku (+) = ps.parent_sku
    AND	pl4.sku (+) = ps.parent_sku
    AND	pl5.sku (+) = ps.parent_sku
    AND	ps.sku = iPsku;


  /* parent group circle info */

    OPEN curPgetProd3 FOR
    SELECT
      gc.group_sku,
      pl1.prod_name_u as en_name,
      pl2.prod_name_u as b5_name,
      pl3.prod_name_u as jp_name,
      pl4.prod_name_u as kr_name,
      pl5.prod_name_u as gb_name,
      ps.parent_sku
    FROM (
         SELECT
     pr.sku,
     MAX(NVL(pr.parent_sku, -1)) parent_sku
         FROM ya_prod_rel pr
         WHERE pr.sku = iPsku
         GROUP BY pr.sku
         ) ps,
      ya_prod_group_detail gd,
      ya_prod_group_circle gc,
         (
         SELECT * FROM ya_prod_lang pl1
         WHERE pl1.lang_id = 1
         ) pl1,
         (
         SELECT *	FROM  ya_prod_lang pl2
         WHERE pl2.lang_id = 2
         ) pl2,
         (
         SELECT *	FROM  ya_prod_lang pl3
         WHERE pl3.lang_id = 3
         ) pl3,
         (
         SELECT *	FROM  ya_prod_lang pl4
         WHERE pl4.lang_id = 4
         ) pl4,
         (
         SELECT *	FROM  ya_prod_lang pl5
         WHERE pl5.lang_id = 5
         ) pl5
    WHERE	ps.parent_sku = gd.sku
    AND gc.group_circle_id = gd.group_circle_id
    AND pl1.sku (+) = gc.group_sku
    AND pl2.sku (+) = gc.group_sku
    AND pl3.sku (+) = gc.group_sku
    AND pl4.sku (+) = gc.group_sku
    AND pl5.sku (+) = gc.group_sku
    AND gc.group_sku <> gd.sku;


  /* artist info */
  /* return the roles of a artist for a product*/
  /* get artist info by proc_bo_GetArtistAttributeInfo*/

    OPEN curPgetProd4 FOR
    SELECT
      pa.artist_id,
      pa.show_in_browse,
      ar1.description,
      ar2.description,
      ar3.description,
      ar4.description,
      ar5.description,
      pa.rel_id,
      pa.sku
    FROM ya_product_artist pa,
      (
      SELECT * FROM ya_artist_rel ar1
      WHERE ar1.lang_id = 1
      ) ar1,
      (
      SELECT * FROM ya_artist_rel ar2
      WHERE ar2.lang_id = 2
      ) ar2,
      (
      SELECT * FROM ya_artist_rel ar3
      WHERE ar3.lang_id = 3
      ) ar3,
      (
      SELECT * FROM ya_artist_rel ar4
      WHERE ar4.lang_id = 4
      ) ar4,
      (
      SELECT * FROM  ya_artist_rel ar5
      WHERE ar5.lang_id = 5
      ) ar5
    WHERE	pa.rel_id = ar1.rel_id (+)
    AND	pa.rel_id = ar2.rel_id (+)
    AND	pa.rel_id = ar3.rel_id (+)
    AND	pa.rel_id = ar4.rel_id (+)
    AND	pa.rel_id = ar5.rel_id (+)
    AND	pa.sku = iPsku
    ORDER BY pa.rel_ranking;


  /* attribute info */
  /* return artist_id only */
  /* get attribute info by proc_bo_GetAttributeInfo */

    OPEN curPgetProd5 FOR
      SELECT
        CAST(pa.attribute_id AS int) as attribute_id,
        pa.sku
      FROM ya_prod_attr pa,
         ya_attribute a
      WHERE a.attribute_id  = pa.attribute_id
      AND pa.sku  = iPsku
      ORDER BY a.attribute_type_id;


  /* video info */

    OPEN curPgetProd6 FOR
      SELECT
        NVL(duration, 0),
        sample_loc,
        sku
      FROM ya_prod_video
      WHERE sku = iPsku;


  /* product name, subtitles, prod_name_aka, prod_subtitle_aka */

    OPEN curPgetProd7 FOR
    SELECT
      pl1.prod_name_u as en_product_name,
      pl2.prod_name_u as b5_product_name,
      pl3.prod_name_u as jp_product_name,
      pl4.prod_name_u as kr_product_name,
      pl5.prod_name_u as gb_product_name,
      pl1.prod_subtitle as en_product_subtitle,
      pl2.prod_subtitle as b5_product_subtitle,
      pl3.prod_subtitle as jp_product_subtitle,
      pl4.prod_subtitle as kr_product_subtitle,
      pl5.prod_subtitle as gb_product_subtitle,
      pl1.prod_name_aka as en_product_name_aka,
      pl2.prod_name_aka as b5_product_name_aka,
      pl3.prod_name_aka as jp_product_name_aka,
      pl4.prod_name_aka as kr_product_name_aka,
      pl5.prod_name_aka as gb_product_name_aka,
      pl1.prod_subtitle_aka as en_product_subtitle_aka,
      pl2.prod_subtitle_aka as b5_product_subtitle_aka,
      pl3.prod_subtitle_aka as jp_product_subtitle_aka,
      pl4.prod_subtitle_aka as kr_product_subtitle_aka,
      pl5.prod_subtitle_aka as gb_product_subtitle_aka,
      pl1.prod_series_title as en_product_series_title,
      pl2.prod_series_title as b5_product_series_title,
      pl3.prod_series_title as jp_product_series_title,
      pl4.prod_series_title as kr_product_series_title,
      pl5.prod_series_title as gb_product_series_title,
      pl1.prod_series_volume as en_product_series_volume,
      pl2.prod_series_volume as b5_product_series_volume,
      pl3.prod_series_volume as jp_product_series_volume,
      pl4.prod_series_volume as kr_product_series_volume,
      pl5.prod_series_volume as gb_product_series_volume,
      pl1.prod_title_volume as en_product_title_volume,
      pl2.prod_title_volume as b5_product_title_volume,
      pl3.prod_title_volume as jp_product_title_volume,
      pl4.prod_title_volume as kr_product_title_volume,
      pl5.prod_title_volume as gb_product_title_volume,
      p.sku
    FROM  ya_product p,
    (
    SELECT * FROM ya_prod_lang pl1
    WHERE pl1.lang_id = 1
    ) pl1,
    (
    SELECT * FROM ya_prod_lang pl2
    WHERE pl2.lang_id = 2
    ) pl2,
    (
    SELECT * FROM ya_prod_lang pl3
    WHERE pl3.lang_id = 3
    ) pl3,
    (
    SELECT * FROM ya_prod_lang pl4
    WHERE pl4.lang_id = 4
    ) pl4,
    (
    SELECT * FROM ya_prod_lang pl5
    WHERE pl5.lang_id = 5
    ) pl5
    WHERE pl1.sku (+) = p.sku
    AND pl2.sku (+) = p.sku
    AND pl3.sku (+) = p.sku
    AND pl4.sku (+) = p.sku
    AND pl5.sku (+) = p.sku
    AND p.sku = iPsku;


  /* product article*/

    OPEN curPgetProd8 FOR
    SELECT
      NVL(rel.article_id, 0) article_id,
      NVL(lang.lang_id, 0) lang_id,
      lang.title title,
      article.in_tracking_no in_tracking_no,
      article.out_tracking_no out_tracking_no,
      rel.rel_id
    FROM ya_article_rel rel,
         ya_article_lang lang,
         ya_article article
    WHERE rel.article_id = lang.article_id
    AND	rel.lang_id = lang.lang_id
    AND	rel.article_id = article.article_id
    AND	rel.rel_type = 1
    AND	rel.rel_id = iPsku
    AND	rel.enable = 'Y'
    AND	article.status = 8
    AND	article.enable = 'Y'
    ORDER BY rel.priority ASC;


  /* us info */

    OPEN curPgetProd9 FOR
    SELECT
      NVL(p.release_date, dtLnullDate),
      NVL(rs.actual_count, 0) as review_count,
      NVL(p.us_launch_date, dtLnullDate) as launch_date,
      --CAST(ROUND(NVL(average_rating, -1) + 0.5, 0) as int) as average_rating,
      CAST(ROUND(NVL(average_rating, 0) / NVL(weighted_count,1),0) as int) as average_rating,
      p.sku
    FROM ya_product p,
      (
      SELECT
        SUM(actual_count) as actual_count,
        SUM(weighted_count) as weighted_count,
        SUM(weighted_count * average_rating) as average_rating,
        sku
      FROM ya_review_summary rs
      WHERE rs.site_id = 1
      AND rs.sku = iPsku
      GROUP BY rs.sku
      ) rs
    WHERE rs.sku (+) = p.sku
    AND p.sku = iPsku;


  /* promotion info*/

    OPEN curPgetProd10 FOR
    SELECT
      c.campaign_code,
      p.sku
    FROM ya_product p,
         ya_campaign c
    WHERE p.sku = iPsku
    AND	p.sku = c.sku
    ORDER BY p.sku, c.campaign_code;


  /* limited quantity*/

    OPEN curPgetProd11 FOR
    SELECT
      lq.frontend_quantity,
      lq.sku
    FROM ya_limited_quantity lq
    WHERE lq.sku = iPsku
    AND	lq.site_id IN (99, 1)
    AND	lq.frontend_quantity  > 0
    ORDER BY lq.sku;

    /* IN grams */
    SELECT 200 INTO iLshipmentunitconst FROM DUAL;


    OPEN curPgetProd12 FOR
    SELECT
      CAST(
        CASE
      WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
        ELSE CEIL(NVL(CASE
              WHEN dimension_weight IS NOT NULL
              AND weight IS NOT NULL THEN
              CASE
              WHEN dimension_weight > weight THEN dimension_weight
              ELSE weight
                        END
              ELSE weight
            END, iLshipmentunitconst) / iLshipmentunitconst)
            END AS int) as shipment_unit,
      t1.sku
    FROM ya_product t1,
         ya_shipping_unit t2
    WHERE t1.sku = t2.sku (+)
    AND	1 = t2.site_id (+)
    AND	t1.sku = iPsku;


  /* description lang_id = 1 (en)*/

    OPEN curPgetProd13 FOR
    SELECT
      d.description,
      pl.sku
    FROM  ya_prod_lang pl,
      ya_description d
    WHERE	pl.us_description_id  = d.description_id (+)
    AND	pl.lang_id = 1
    AND	pl.sku = iPsku;


  /* description lang_id = 2 (b5)*/

    OPEN curPgetProd14 FOR
    SELECT
      d.description,
      pl.sku
    FROM  ya_prod_lang pl,
      ya_description d
    WHERE	pl.us_description_id = d.description_id (+)
    AND	pl.lang_id = 2
    AND	pl.sku  = iPsku;


  /* description lang_id = 3 (jp)*/

    OPEN curPgetProd15 FOR
    SELECT
      d.description,
      pl.sku
    FROM  ya_prod_lang pl,
      ya_description d
    WHERE pl.us_description_id = d.description_id (+)
    AND	pl.lang_id  = 3
    AND	pl.sku  = iPsku;

  /* description lang_id = 4 (kr)*/

    OPEN curPgetProd16 FOR
    SELECT
      d.description,
      pl.sku
    FROM  ya_prod_lang pl,
      ya_description d
    WHERE pl.us_description_id = d.description_id (+)
    AND	pl.lang_id  = 4
    AND	pl.sku  = iPsku;


  /* description lang_id = 5 (gb)*/

    OPEN curPgetProd17 FOR
      SELECT
        d.description,
        pl.sku
      FROM ya_prod_lang pl,
         ya_description d
      WHERE pl.us_description_id = d.description_id (+)
      AND	pl.lang_id = 5
      AND	pl.sku = iPsku;

  /* region info */
    OPEN curPgetProd18 FOR
      SELECT
        r.region_id,
        r.can_sell,
        r.enable,
        r.supplier_id,
        r.list_price,
        r.sale_price,
        r.sale_start,
        r.sale_end,
        r.preorder,
        r.preorder_start,
        r.preorder_end,
        r.preorder_buffer_day,
        r.preorder_date,
        NVL(o.availability_id, r.product_availability) as product_availability,
        r.sku
      FROM
        (
        SELECT
          pr.region_id as region_id,
          -- countryIds are to be obtained FROM xml
          NVL(pr.is_can_sell, 'N') as can_sell,
          NVL(pr.is_enabled, 'N') as enable,
          NVL(pr.supplier_id, -1)  as supplier_id,
          NVL(pr.list_price,9999) as list_price, --4
          -- compute isOnSale IN app
          NVL(pr.sale_price,9999) as sale_price,
          NVL(pr.sale_price_start, dtLnullDate) as sale_start,
          NVL(pr.sale_price_end, dtLnullDate) as sale_end,
          NVL(pr.is_preorder, 'N') as preorder,
          NVL(pr.preorder_start, dtLnullDate) as preorder_start, --9
          NVL(pr.preorder_end, dtLnullDate) as preorder_end,
          CAST(NVL(pr.preorder_buffer_day, -1) as int) as preorder_buffer_day,
          NVL(pr.preorder_deadline, dtLnullDate) as preorder_date,
          NVL(pa.avlb, 60) as product_availability,
          pr.prod_id as sku, --14
          pr.sequence
        FROM
          prod_region pr,
          prod_avlb pa
        WHERE pr.prod_id = iPsku
          AND pr.origin_id = 1 -- us
          AND pr.category_id = 1 -- b2c
          AND pa.prod_id = pr.prod_id
          AND pa.region_id = pr.region_id
          AND pa.origin_id = 1 -- us
          AND pa.category = 1 -- b2c
        ) r
      INNER JOIN
        ya_product p on
        (
          p.sku = r.sku
        )
      LEFT JOIN
        ya_availability_override o ON
        (
          r.supplier_id = o.supplier_id
          AND p.account_id = o.account_id
          AND SYSDATE BETWEEN o.start_date AND o.end_date
          AND r.product_availability < o.availability_id
          AND r.product_availability <> 0
        )
        ORDER BY r.sequence DESC;


  /* tw info */

    OPEN curPgetProd19 FOR
    SELECT
      NVL(p.release_date, dtLnullDate), -- 0
      NVL(rs.actual_count, 0) as review_count,
      NVL(p.tw_launch_date, dtLnullDate) as launch_date,
      --CAST(ROUND(NVL(average_rating, -1) + 0.5, 0) as int) as average_rating,
      CAST(ROUND(NVL(average_rating, 0) / NVL(weighted_count,1),0) as int) as average_rating,
      p.sku --4
    FROM ya_product p,
      (
       SELECT
         SUM(actual_count) as actual_count,
         SUM(weighted_count) as weighted_count,
         SUM(weighted_count * average_rating) as average_rating,
         sku
       FROM ya_review_summary rs
       WHERE rs.site_id = 1
       AND rs.sku = iPsku
       GROUP BY rs.sku
      ) rs
    WHERE rs.sku (+) = p.sku
    AND p.sku = iPsku;


  /* promotion info*/

    OPEN curPgetProd20 FOR
    SELECT
      c.campaign_code,
      p.sku
    FROM ya_product p,
         ya_campaign c
    WHERE p.sku = iPsku
    AND	p.sku = c.sku
    ORDER BY p.sku, c.campaign_code;


  /* limited quantity*/

    OPEN curPgetProd21 FOR
    SELECT
      lq.frontend_quantity,
      lq.sku
    FROM ya_limited_quantity lq
    WHERE lq.sku  = iPsku
    AND lq.site_id IN (99, 7)
    AND lq.frontend_quantity > 0
    ORDER BY lq.sku;


  /* shipment unit*/
  /*declare @shipmentunitconst int*/

    SELECT 200 INTO iLshipmentunitconst FROM DUAL;

  /* IN grams */
    OPEN curPgetProd22 FOR
    SELECT
      CAST(
        CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
    ELSE CEIL(NVL(CASE WHEN dimension_weight IS NOT NULL
          AND weight IS NOT NULL THEN
      CASE WHEN dimension_weight > weight THEN dimension_weight
        ELSE weight
        END
        ELSE weight
      END, iLshipmentunitconst) / iLshipmentunitconst)
      END AS int) as shipment_unit,
         t1.sku
    FROM ya_product t1,
         ya_shipping_unit t2
    WHERE t1.sku = t2.sku (+)
    AND	7 = t2.site_id (+)
    AND	t1.sku = iPsku;


  /* description lang_id = 1 (en)*/

    OPEN curPgetProd23 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE pl.tw_description_id = d.description_id (+)
    AND pl.lang_id = 1
    AND pl.sku = iPsku;


  /* description lang_id = 2 (b5)*/

    OPEN curPgetProd24 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE pl.tw_description_id = d.description_id (+)
    AND pl.lang_id = 2
    AND pl.sku = iPsku;


  /* description lang_id = 3 (jp)*/

    OPEN curPgetProd25 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE pl.tw_description_id = d.description_id (+)
    AND pl.lang_id = 3
    AND pl.sku = iPsku;


  /* description lang_id = 4 (kr)*/

    OPEN curPgetProd26 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE pl.tw_description_id = d.description_id (+)
    AND pl.lang_id = 4
    AND pl.sku = iPsku;


  /* description lang_id = 5 (gb)*/

    OPEN curPgetProd27 FOR
    SELECT
      d.description,
      pl.sku
    FROM ya_prod_lang pl,
         ya_description d
    WHERE pl.tw_description_id = d.description_id (+)
    AND pl.lang_id = 5
    AND pl.sku = iPsku;

  /* region info */

    OPEN curPgetProd28 FOR
    SELECT
      r.region_id,
      r.can_sell,
      r.enable,
      r.supplier_id,
      r.list_price,
      r.sale_price,
      r.sale_start,
      r.sale_end,
      r.preorder,
      r.preorder_start,
      r.preorder_end,
      r.preorder_buffer_day,
      r.preorder_date,
      NVL(o.availability_id, r.product_availability) as product_availability,
      r.sku
    FROM
      (
      SELECT
        pr.region_id as region_id,
        -- countryIds are to be obtained FROM xml
        NVL(pr.is_can_sell, 'N') as can_sell,
        NVL(pr.is_enabled, 'N') as enable,
        NVL(pr.supplier_id, -1)  as supplier_id,
        NVL(pr.list_price,9999) as list_price, --4
        -- compute isOnSale IN app,
        NVL(pr.sale_price,9999) as sale_price,
        NVL(pr.sale_price_start, dtLnullDate) as sale_start,
        NVL(pr.sale_price_end, dtLnullDate) as sale_end,
        NVL(pr.is_preorder, 'N') as preorder,
        NVL(pr.preorder_start, dtLnullDate) as preorder_start, --9
        NVL(pr.preorder_end, dtLnullDate) as preorder_end,
        CAST(NVL(pr.preorder_buffer_day, -1) as int) as preorder_buffer_day,
        NVL(pr.preorder_deadline, dtLnullDate) as preorder_date,
        NVL(pa.avlb, 60) as product_availability,
        pr.prod_id as sku, --14
        pr.sequence
      FROM
        prod_region pr,
        prod_avlb pa
      WHERE
        pr.prod_id = iPsku
        AND pr.origin_id = 7 -- tw
        AND pr.category_id = 1 -- b2c
        AND pa.prod_id = pr.prod_id
        AND pa.region_id = pr.region_id
        AND pa.origin_id = 7 -- tw
        AND pa.category = 1 -- b2c
      ) r
    INNER JOIN
      ya_product p on
        (
          p.sku = r.sku
        )
    LEFT JOIN
      ya_availability_override o ON
        (
          r.supplier_id = o.supplier_id
          AND p.account_id = o.account_id
          AND SYSDATE BETWEEN o.start_date AND o.end_date
          AND r.product_availability < o.availability_id
          AND r.product_availability <> 0
        )
    ORDER BY r.sequence DESC;
  RETURN;
  END GetProduct;

  PROCEDURE GetBookInfos (
    curPgetBook1	OUT	refCur,
    curPgetBook2	OUT	refCur,
    curPgetBook3	OUT	refCur,
    curPgetBook4	OUT	refCur,
    iPsku1		IN	INT DEFAULT NULL,
    iPsku2		IN	INT DEFAULT NULL,
    iPsku3		IN	INT DEFAULT NULL,
    iPsku4		IN	INT DEFAULT NULL,
    iPsku5		IN	INT DEFAULT NULL,
    iPsku6		IN	INT DEFAULT NULL,
    iPsku7		IN	INT DEFAULT NULL,
    iPsku8		IN	INT DEFAULT NULL,
    iPsku9		IN	INT DEFAULT NULL,
    iPsku10		IN	INT DEFAULT NULL,
    iPsku11		IN	INT DEFAULT NULL,
    iPsku12		IN	INT DEFAULT NULL,
    iPsku13		IN	INT DEFAULT NULL,
    iPsku14		IN	INT DEFAULT NULL,
    iPsku15		IN	INT DEFAULT NULL,
    iPsku16		IN	INT DEFAULT NULL,
    iPsku17		IN	INT DEFAULT NULL,
    iPsku18		IN	INT DEFAULT NULL,
    iPsku19		IN	INT DEFAULT NULL,
    iPsku20		IN	INT DEFAULT NULL
    )
  AS
  BEGIN
    OPEN curPgetBook1 FOR
      SELECT
        pp.isbn as isbn,
        pp.pages,
        lp.meaning as format,
        le.meaning as edition,
        pp.edition_number as edition_number,
        pp.volume_number as volume_number,
        pp.grade_from,
        pp.grade_to,
        p.sku
      FROM
        ya_product p, ya_prod_printed pp,
          (
          /* Western book format */
          SELECT * FROM ya_lookup lp
          WHERE lp.type_id = 100
          ) lp,
          (
          /* Western book edition */
          SELECT * FROM ya_lookup le
          WHERE le.type_id = 101
          ) le
      WHERE pp.sku = p.sku
      AND pp.format = lp.code_id (+)
      AND pp.edition = le.code_id (+)
      AND p.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20)
        ;

    OPEN curPgetBook2 FOR
      SELECT
        award_id,
        a.award_name as award_name,
        a.award_category as award_category,
        NVL(a.award_year, -1) as award_year,
        l.meaning as award_status,
        p.sku
      FROM
        ya_product p, ya_awards a,
        (
        SELECT * FROM ya_lookup l
        WHERE l.type_id = 103
        ) l
      WHERE a.sku = p.sku
      AND a.award_status_type = l.code_id
      AND p.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20)
        ;

    OPEN curPgetBook3 FOR
      SELECT
        NVL(tn5.note_id, NVL(tn4.note_id, NVL(tn3.note_id, NVL(tn2.note_id, NVL(tn1.note_id, -1))))),
        lt1.meaning as en_type,
        lt2.meaning as b5_type,
        lt3.meaning as jp_type,
        lt4.meaning as kr_type,
        lt5.meaning as gb_type,
        NVL(tn5.partial_text, NVL(tn4.partial_text, NVL(tn3.partial_text, NVL(tn2.partial_text, NVL(tn1.partial_text, -1))))),
        tn1.text_from_other as en_text_from_other,
        tn2.text_from_other as b5_text_from_other,
        tn3.text_from_other as jp_text_from_other,
        tn4.text_from_other as kr_text_from_other,
        tn5.text_from_other as gb_text_from_other,
        lm1.meaning as en_medium,
        lm2.meaning as b5_medium,
        lm3.meaning as jp_medium,
        lm4.meaning as kr_medium,
        lm5.meaning as en_medium,
        tn1.source_date_string as en_source_date_string,
        tn2.source_date_string as b5_source_date_string,
        tn3.source_date_string as jp_source_date_string,
        tn4.source_date_string as kr_source_date_string,
        tn5.source_date_string as gb_source_date_string,
        tn1.source_volume as en_source_volume,
        tn2.source_volume as b5_source_volume,
        tn3.source_volume as jp_source_volume,
        tn4.source_volume as kr_source_volume,
        tn5.source_volume as gb_source_volume,
        tn1.note_text as en_note_text,
        tn2.note_text as b5_note_text,
        tn3.note_text as jp_note_text,
        tn4.note_text as kr_note_text,
        tn5.note_text as gb_note_text,
        NVL(tn5.artist_id, NVL(tn4.artist_id, NVL(tn3.artist_id, NVL(tn2.artist_id, NVL(tn1.artist_id, -1))))),
        NVL(tn5.note_type, NVL(tn4.note_type, NVL(tn3.note_type, NVL(tn2.note_type, NVL(tn1.note_type, -1))))),
        NVL(pt.refer_sku, -1) as refer_sku,
        NVL(ypa.attribute_id, -1) as attribute_id,
        pt.sku
      FROM ya_prod_text_note pt,
        (
        SELECT * FROM ya_text_note tn1
        WHERE tn1.lang_id = 1
        ) tn1,
        (
        SELECT * FROM ya_text_note tn2
        WHERE tn2.lang_id = 2
        ) tn2,
        (
        SELECT * FROM ya_text_note tn3
        WHERE tn3.lang_id = 3
        ) tn3,
        (
        SELECT * FROM ya_text_note tn4
        WHERE tn4.lang_id = 4
        ) tn4,
        (
        SELECT * FROM ya_text_note tn5
        WHERE tn5.lang_id = 5
        ) tn5,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 105
        ) lt1,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 105
        ) lt2,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 105
        ) lt3,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 105
        ) lt4,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 105
        ) lt5,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 102
        ) lm1,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 102
        ) lm2,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 102
        ) lm3,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 102
        ) lm4,
        (
        SELECT meaning, code_id FROM ya_lookup
        WHERE type_id = 102
        ) lm5,
        (
          SELECT sku, attribute_id
          FROM
            ya_prod_attr
          WHERE
            attribute_id IN
            (select yat.attribute_id from ya_attribute yat where yat.attribute_type_id = 27)
        ) ypa

      WHERE pt.note_id = tn1.note_id (+)
      AND pt.note_id = tn2.note_id (+)
      AND pt.note_id = tn3.note_id (+)
      AND pt.note_id = tn4.note_id (+)
      AND pt.note_id = tn5.note_id (+)
      AND tn1.note_type = lt1.code_id (+)
      AND tn2.note_type = lt2.code_id (+)
      AND tn3.note_type = lt3.code_id (+)
      AND tn4.note_type = lt4.code_id (+)
      AND tn5.note_type = lt5.code_id (+)
      AND tn1.medium_id = lm1.code_id (+)
      AND tn2.medium_id = lm2.code_id (+)
      AND tn3.medium_id = lm3.code_id (+)
      AND tn4.medium_id = lm4.code_id (+)
      AND tn5.medium_id = lm5.code_id (+)
      AND ypa.sku (+) = pt.refer_sku
      AND pt.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20);

  /* outlet, books additional info
     mainly for Chinese books */
    OPEN curPgetBook4 FOR
      SELECT
        NVL(pp.reference_price, 0) as reference_price,
        pp.reference_currency as reference_currency,
        NVL(pp.condition, 0) as condition,
        pp.sku
      FROM ya_prod_printed pp
      WHERE pp.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20);
  RETURN;
  END GetBookInfos;


  PROCEDURE GetBookInfo (
    iPsku		IN 	INT,
    curPgetInfo1	OUT	refCur,
    curPgetInfo2	OUT	refCur,
    curPgetInfo3	OUT	refCur,
    curPgetInfo4	OUT	refCur
  )

  AS
  BEGIN

    OPEN curPgetInfo1 FOR
    SELECT
      pp.isbn as isbn,
      pp.pages,
      lp.meaning as format,
      le.meaning as edition,
      pp.edition_number as edition_number,
      pp.volume_number as volume_number,
      pp.grade_from,
      pp.grade_to,
      p.sku
    FROM ya_product p, ya_prod_printed pp,
      (
      SELECT * FROM ya_lookup lp
      WHERE lp.type_id = 100
      ) lp,
      (
      SELECT * FROM ya_lookup le
      WHERE le.type_id = 101
      ) le
      WHERE pp.sku = p.sku
      AND	(pp.format = lp.code_id (+))
      AND	(pp.edition = le.code_id (+))
      AND	(p.sku = iPsku);


    OPEN curPgetInfo2 FOR
    SELECT
      award_id,
      a.award_name as award_name,
      a.award_category as award_category,
      NVL(a.award_year, - 1) as award_year,
      l.meaning as award_status,
      p.sku
    FROM  ya_product p,
      ya_awards a,
      ya_lookup l
    WHERE	a.sku  = p.sku
    AND (a.award_status_type  = l.code_id
    AND l.type_id = 103)
    AND (p.sku = iPsku);


    OPEN curPgetInfo3 FOR
    SELECT
      NVL(tn5.note_id, NVL(tn4.note_id, NVL(tn3.note_id, NVL(tn2.note_id, NVL(tn1.note_id, -1))))),
      lt1.meaning as en_type,
      lt2.meaning as b5_type,
      lt3.meaning as jp_type,
      lt4.meaning as kr_type,
      lt5.meaning as gb_type,
      NVL(tn5.partial_text, NVL(tn4.partial_text, NVL(tn3.partial_text, NVL(tn2.partial_text, NVL(tn1.partial_text, -1))))),
      tn1.text_from_other as en_text_from_other,
      tn2.text_from_other as b5_text_from_other,
      tn3.text_from_other as jp_text_from_other,
      tn4.text_from_other as kr_text_from_other,
      tn5.text_from_other as gb_text_from_other,
      lm1.meaning as en_medium,
      lm2.meaning as b5_medium,
      lm3.meaning as jp_medium,
      lm4.meaning as kr_medium,
      lm5.meaning as en_medium,
      tn1.source_date_string as en_source_date_string,
      tn2.source_date_string as b5_source_date_string,
      tn3.source_date_string as jp_source_date_string,
      tn4.source_date_string as kr_source_date_string,
      tn5.source_date_string as gb_source_date_string,
      tn1.source_volume as en_source_volume,
      tn2.source_volume as b5_source_volume,
      tn3.source_volume as jp_source_volume,
      tn4.source_volume as kr_source_volume,
      tn5.source_volume as gb_source_volume,
      tn1.note_text as en_note_text,
      tn2.note_text as b5_note_text,
      tn3.note_text as jp_note_text,
      tn4.note_text as kr_note_text,
      tn5.note_text as gb_note_text,
      NVL(tn5.artist_id, NVL(tn4.artist_id, NVL(tn3.artist_id, NVL(tn2.artist_id, NVL(tn1.artist_id, -1))))),
      NVL(tn5.note_type, NVL(tn4.note_type, NVL(tn3.note_type, NVL(tn2.note_type, NVL(tn1.note_type, -1))))) as type_id,
      NVL(pt.refer_sku, -1) as refer_sku,
      NVL(ypa.attribute_id, -1) as attribute_id,
      pt.sku
    FROM  ya_prod_text_note pt,
      (	SELECT *
      FROM  ya_text_note tn1
      WHERE	 tn1.lang_id  = 1
    ) tn1,
      (	SELECT *
      FROM  ya_text_note tn2
      WHERE	 tn2.lang_id  = 2
    ) tn2,
      (	SELECT *
      FROM  ya_text_note tn3
      WHERE	 tn3.lang_id  = 3
    ) tn3,
      (	SELECT *
      FROM  ya_text_note tn4
      WHERE	 tn4.lang_id  = 4
    ) tn4,
      (	SELECT *
      FROM  ya_text_note tn5
      WHERE	 tn5.lang_id  = 5
    ) tn5,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 105
    ) lt1,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 105
    ) lt2,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 105
    ) lt3,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 105
    ) lt4,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 105
    ) lt5,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 102
    ) lm1,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 102
    ) lm2,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 102
    ) lm3,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 102
    ) lm4,
      (	SELECT meaning, code_id
      FROM  ya_lookup
      WHERE	 type_id  = 102
    ) lm5,
      (	SELECT *
      FROM  ya_prod_attr
      WHERE	 attribute_id  IN
        (
        SELECT yat.attribute_id
        FROM  ya_attribute yat
        WHERE	 yat.attribute_type_id  = 27
        )
    ) ypa
    WHERE	 pt.note_id  = tn1.note_id (+)
     AND	(pt.note_id  = tn2.note_id (+))
     AND	(pt.note_id  = tn3.note_id (+))
     AND	(pt.note_id  = tn4.note_id (+))
     AND	(pt.note_id  = tn5.note_id (+))
     AND	(tn1.note_type  = lt1.code_id (+))
     AND	(tn2.note_type  = lt2.code_id (+))
     AND	(tn3.note_type  = lt3.code_id (+))
     AND	(tn4.note_type  = lt4.code_id (+))
     AND	(tn5.note_type  = lt5.code_id (+))
     AND	(tn1.medium_id  = lm1.code_id (+))
     AND	(tn2.medium_id  = lm2.code_id (+))
     AND	(tn3.medium_id  = lm3.code_id (+))
     AND	(tn4.medium_id  = lm4.code_id (+))
     AND	(tn5.medium_id  = lm5.code_id (+))
     AND	(ypa.sku (+) = pt.refer_sku)
     AND	(pt.sku  = iPsku);



    OPEN curPgetInfo4 FOR
    SELECT
      NVL(reference_price, 0) as "reference_price",
      reference_currency as "reference_currency",
      NVL(condition, 0) as "condition",
      sku
    FROM  ya_prod_printed
    WHERE	sku = iPsku;


    RETURN;
  END GetBookInfo;

  PROCEDURE GetCrossSelling (
    iPsku		IN	INT,
    curPgetCross1      	OUT 	refCur,
    curPgetCross2	OUT	refCur
  )
  AS
  BEGIN

    OPEN curPgetCross1 FOR
    SELECT
      related_sku,
      type_id,
      rating
    FROM
    (SELECT
       CAST(related_sku as int) as related_sku,
       CAST(type_id as int) as type_id,
       rating
     FROM (
          SELECT
      cs1.related_sku,
      cs1.type_id,
      cs1.rating
    FROM ya_cross_selling cs1
    WHERE cs1.sku = iPsku
    AND cs1.type_id = 2
    AND cs1.rating = 6
    AND cs1.related_sku IN
      (
       SELECT pr.prod_id
       FROM prod_region pr,
      prod_avlb pa
      WHERE pr.prod_id = pa.prod_id
	  AND pr.region_id=1
      AND pr.is_enabled = 'Y'
      AND pa.origin_id = 1
      AND pa.category = 1
      AND pa.avlb < 60
       )
    UNION
    SELECT
      cs2.related_sku,
      cs2.type_id,
      cs2.rating
    FROM ya_cross_selling cs2
    WHERE cs2.sku = iPsku
    AND cs2.type_id = 2
    AND cs2.rating not IN (0, 6)
    AND cs2.related_sku IN
      (
      SELECT pr.prod_id
      FROM  prod_region pr,
        prod_avlb pa
      WHERE pr.prod_id = pa.prod_id
	  AND pr.region_id=1
      AND pr.is_enabled = 'Y'
      AND pa.origin_id = 1
      AND pa.category = 1
      AND pa.avlb < 60
      )
      ORDER BY rating DESC
      ) cs
    WHERE
      ROWNUM < 5

  UNION
    SELECT
      CAST(related_sku as int) as related_sku,
      CAST(type_id as int) as type_id,
      rating
    FROM (
          SELECT
      cs1.related_sku,
      cs1.type_id,
      cs1.rating
    FROM ya_cross_selling cs1
    WHERE cs1.sku = iPsku
    AND cs1.type_id = 4
    AND cs1.rating = 6
    AND cs1.related_sku IN
      (
       SELECT pr.prod_id
       FROM  prod_region pr,
         prod_avlb pa
       WHERE pr.prod_id = pa.prod_id
	   AND pr.region_id=1
       AND pr.is_enabled = 'Y'
       AND pa.origin_id = 1
       AND pa.category = 1
       AND pa.avlb < 60
       )
    UNION
    SELECT
      cs2.related_sku,
      cs2.type_id,
      cs2.rating
    FROM ya_cross_selling cs2
    WHERE cs2.sku = iPsku
    AND cs2.type_id = 4
    AND cs2.rating not IN (0, 6)
    AND cs2.related_sku IN
      (
      SELECT pr.prod_id
      FROM prod_region pr,
           prod_avlb pa
      WHERE	pr.prod_id = pa.prod_id
	  AND pr.region_id=1
      AND pr.is_enabled = 'Y'
      AND pa.origin_id = 1
      AND pa.category = 1
      AND pa.avlb < 60
      )
      ORDER BY rating DESC
    ) cs
    WHERE ROWNUM < 5

  UNION
    SELECT
      CAST(related_sku as int) as related_sku,
      CAST(type_id as int) as type_id,
      rating
    FROM (
    SELECT
      cs1.related_sku,
      cs1.type_id,
      cs1.rating
    FROM ya_cross_selling cs1
    WHERE	cs1.sku = iPsku
    AND cs1.type_id IN (1, 3)
    AND cs1.rating = 6
    AND cs1.related_sku IN
      (
      SELECT pr.prod_id
      FROM prod_region pr,
         prod_avlb pa
      WHERE pr.prod_id = pa.prod_id
	  AND   pr.region_id=1
      AND	pr.is_enabled = 'Y'
      AND	pa.origin_id = 1
      AND	pa.category = 1
      AND	pa.avlb < 60
      )
    UNION
    SELECT
      cs2.related_sku,
      cs2.type_id,
      cs2.rating
    FROM ya_cross_selling cs2
    WHERE	cs2.sku = iPsku
    AND cs2.type_id IN (1, 3)
    AND cs2.rating not IN (0, 6)
    AND cs2.related_sku IN
      (
      SELECT pr.prod_id
      FROM prod_region pr,
         prod_avlb pa
      WHERE pr.prod_id = pa.prod_id
	  AND   pr.region_id=1
      AND	pr.is_enabled = 'Y'
      AND	pa.origin_id = 1
      AND	pa.category = 1
      AND	pa.avlb < 60
      )
      ORDER BY rating DESC
    ) cs
    WHERE	ROWNUM < 5
    )
    ORDER BY
      type_id,
      rating DESC;


  /* global site */

  OPEN curPgetCross2 FOR
    SELECT
      related_sku,
      type_id,
      rating
    FROM
      (SELECT
         CAST(related_sku as int) as related_sku,
         CAST(type_id as int) as type_id,
         rating
       FROM (
         SELECT
     cs1.related_sku,
     cs1.type_id,
     cs1.rating
         FROM ya_cross_selling cs1
         WHERE cs1.sku = iPsku
         AND cs1.type_id = 2
         AND cs1.rating = 6
         AND cs1.related_sku IN
     (
     SELECT pr.prod_id
     FROM prod_region pr,
          prod_avlb pa
     WHERE pr.prod_id = pa.prod_id
	 AND pr.region_id=7
     AND pr.is_enabled = 'Y'
     AND pa.origin_id = 7
     AND pa.category = 1
     AND pa.avlb < 60
     )
    UNION
    SELECT
      cs2.related_sku,
      cs2.type_id,
      cs2.rating
    FROM ya_cross_selling cs2
    WHERE cs2.sku = iPsku
    AND cs2.type_id = 2
    AND cs2.rating not IN (0, 6)
    AND cs2.related_sku IN
            (
            SELECT pr.prod_id
            FROM prod_region pr,
                 prod_avlb pa
            WHERE pr.prod_id = pa.prod_id
			AND pr.region_id=7
            AND pr.is_enabled = 'Y'
            AND pa.origin_id = 7
            AND pa.category = 1
            AND pa.avlb < 60
            )
          ORDER BY rating DESC
    ) cs
    WHERE
      ROWNUM < 5
    UNION
    SELECT
      CAST(related_sku as int) as related_sku,
      CAST(type_id as int) as type_id,
      rating
    FROM (
      SELECT
        cs1.related_sku,
        cs1.type_id,
        cs1.rating
      FROM ya_cross_selling cs1
      WHERE cs1.sku = iPsku
      AND	cs1.type_id = 4
      AND	cs1.rating = 6
      AND	cs1.related_sku IN
        (
        SELECT pr.prod_id
        FROM prod_region pr,
             prod_avlb pa
        WHERE pr.prod_id = pa.prod_id
		AND pr.region_id=7
        AND pr.is_enabled = 'Y'
        AND pa.origin_id = 7
        AND pa.category = 1
        AND pa.avlb < 60
        )
       UNION
       SELECT
         cs2.related_sku,
         cs2.type_id,
         cs2.rating
       FROM ya_cross_selling cs2
       WHERE cs2.sku = iPsku
       AND cs2.type_id = 4
       AND cs2.rating not IN (0, 6)
       AND cs2.related_sku IN
         (
         SELECT pr.prod_id
         FROM prod_region pr,
              prod_avlb pa
         WHERE pr.prod_id = pa.prod_id
		 AND pr.region_id=7
         AND pr.is_enabled = 'Y'
         AND pa.origin_id = 7
         AND pa.category = 1
         AND pa.avlb < 60
         )
      ORDER BY rating DESC
    ) cs
    WHERE	ROWNUM  < 5
    UNION
    SELECT
      CAST(related_sku as int) as related_sku,
      CAST(type_id as int) as type_id,
      rating
    FROM (
    SELECT
      cs1.related_sku,
      cs1.type_id,
      cs1.rating
    FROM ya_cross_selling cs1
    WHERE	cs1.sku = iPsku
    AND cs1.type_id IN (1, 3)
    AND cs1.rating = 6
    AND cs1.related_sku IN
      (
      SELECT pr.prod_id
      FROM  prod_region pr,
          prod_avlb pa
      WHERE pr.prod_id = pa.prod_id
	  AND   pr.region_id=7
      AND	pr.is_enabled = 'Y'
      AND	pa.origin_id = 7
      AND	pa.category = 1
      AND	pa.avlb < 60
      )
    UNION
    SELECT
      cs2.related_sku,
      cs2.type_id,
      cs2.rating
    FROM ya_cross_selling cs2
    WHERE	cs2.sku = iPsku
    AND cs2.type_id IN (1, 3)
    AND cs2.rating not IN (0, 6)
    AND cs2.related_sku IN
      (
      SELECT pr.prod_id
      FROM prod_region pr,
         prod_avlb pa
      WHERE pr.prod_id = pa.prod_id
      AND	pr.is_enabled = 'Y'
      AND	pa.origin_id = 7
      AND	pa.category = 1
      AND	pa.avlb < 60
      )
      ORDER BY rating DESC
    ) cs
    WHERE ROWNUM < 5
    )
    ORDER BY
      type_id,
      rating DESC;
  return;
  END GetCrossSelling;

  PROCEDURE GetCrossSellingDifferentFormat (
    iPsku			IN 	INT,
    iPdifferent_format_type1	IN	INT DEFAULT 1,
    iPdifferent_format_type2	IN	INT DEFAULT 3,
    curPgetCross1		OUT	refCur,
    curPgetCross2		OUT	refCur
  )
  AS
  BEGIN

    /*us*/

    OPEN curPgetCross1 FOR
     SELECT
       cs.related_sku,
       cs.type_id,
       cs.sku
     FROM ya_cross_selling cs
     WHERE cs.sku  = iPsku
     AND type_id IN ( iPdifferent_format_type1, iPdifferent_format_type2)
     AND cs.related_sku  IN
     (
     SELECT pr.prod_id
     FROM prod_region pr,
 	 prod_avlb pa
     WHERE 1=1
          AND pr.prod_id=pa.prod_id
 	  AND pr.is_enabled  = 'Y'
 	  AND pa.region_id=1
 	  AND pr.region_id=1
          AND pa.avlb < 60
     );

    /*tw*/

    OPEN curPgetCross2 FOR
     SELECT
       cs.related_sku,
       cs.type_id,
       cs.sku
     FROM ya_cross_selling cs
     WHERE cs.sku = iPsku
     AND type_id IN ( iPdifferent_format_type1, iPdifferent_format_type2)
     AND cs.related_sku  IN
     (
     SELECT pr.prod_id
     FROM prod_region pr,
 	 prod_avlb pa
     WHERE 1=1
          AND pr.prod_id=pa.prod_id
 	  AND pr.is_enabled = 'Y'
 	  AND pr.region_id=7
 	  AND pa.region_id=7
          AND pa.avlb < 60
       );
    RETURN;
  END GetCrossSellingDifferentFormat;

  PROCEDURE GetCrossDifferentFormats (
    curPgetCrossSelling1		OUT	refCur,
    curPgetCrossSelling2		OUT	refCur,
    iPdifferent_format_type1	IN	INT DEFAULT 1,
    iPdifferent_format_type2	IN	INT DEFAULT 3,
    iPsku1			IN	INT DEFAULT NULL,
    iPsku2			IN	INT DEFAULT NULL,
    iPsku3			IN	INT DEFAULT NULL,
    iPsku4			IN	INT DEFAULT NULL,
    iPsku5			IN	INT DEFAULT NULL,
    iPsku6			IN	INT DEFAULT NULL,
    iPsku7			IN	INT DEFAULT NULL,
    iPsku8			IN	INT DEFAULT NULL,
    iPsku9			IN	INT DEFAULT NULL,
    iPsku10			IN	INT DEFAULT NULL,
    iPsku11			IN	INT DEFAULT NULL,
    iPsku12			IN	INT DEFAULT NULL,
    iPsku13			IN	INT DEFAULT NULL,
    iPsku14			IN	INT DEFAULT NULL,
    iPsku15			IN	INT DEFAULT NULL,
    iPsku16			IN	INT DEFAULT NULL,
    iPsku17			IN	INT DEFAULT NULL,
    iPsku18			IN	INT DEFAULT NULL,
    iPsku19			IN	INT DEFAULT NULL,
    iPsku20			IN	INT DEFAULT NULL
  )
AS
BEGIN
  /* us */
  OPEN curPgetCrossSelling1 FOR
  SELECT cs.related_sku, cs.type_id, cs.sku
  FROM ya_cross_selling cs
  WHERE cs.sku IN (
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20)
  AND cs.type_id IN (iPdifferent_format_type1, iPdifferent_format_type2)
  AND cs.related_sku
    IN (SELECT pr.prod_id
		FROM prod_region pr,
	       prod_avlb pa
		WHERE pr.prod_id=pa.prod_id
		AND pr.region_id=1
		AND pa.region_id=1
		AND pr.is_enabled = 'Y'
		AND	pa.avlb  < 60
		);


  /* tw */
  OPEN curPgetCrossSelling2 FOR
  SELECT cs.related_sku, cs.type_id, cs.sku
  FROM ya_cross_selling cs
  WHERE cs.sku IN(
iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,iPsku16,iPsku17,iPsku18,iPsku19,iPsku20)
  AND cs.type_id IN (iPdifferent_format_type1, iPdifferent_format_type2)
  AND cs.related_sku
    IN (SELECT pr.prod_id
		FROM prod_region pr,
	       prod_avlb pa
		WHERE pr.prod_id=pa.prod_id
		AND pr.region_id=1
		AND pa.region_id=1
		AND pr.is_enabled = 'Y'
		AND	pa.avlb  < 60);

  RETURN;
  END GetCrossDifferentFormats;

  PROCEDURE GetPromtionBundleInfo (
    iPsku IN INT,
    cPgetPromoBundle1 OUT refCur,
    cPgetPromoBundle2 OUT refCur
  )
  AS
    dtLcurrDate DATE;
  BEGIN
    SELECT SYSDATE INTO dtLcurrDate FROM DUAL;

    --us site
    OPEN cPgetPromoBundle1 FOR
      SELECT
        sku,
        partner_sku,
        bundled_discount,
        partner_bundled_discount,
        site_id
      FROM
        ya_promotion_bundle
      WHERE
        (sku = iPsku
        OR partner_sku = iPsku)
        AND site_id = 1
        AND dtLcurrDate BETWEEN NVL(start_date, dtLcurrDate) AND NVL(end_date, dtLcurrDate);

    --global site
    OPEN cPgetPromoBundle2 FOR
      SELECT
        sku,
        partner_sku,
        bundled_discount,
        partner_bundled_discount,
        site_id
      FROM
        ya_promotion_bundle
      WHERE
        (sku = iPsku
        OR partner_sku = iPsku)
        AND site_id = 7
        AND dtLcurrDate BETWEEN NVL(start_date, dtLcurrDate) AND NVL(end_date, dtLcurrDate);
    RETURN;
  END GetPromtionBundleInfo;

  PROCEDURE GetReview (
    iPsku		IN	INT,
    curPgetproduct1	OUT	refCur,
    curPgetproduct2	OUT	refCur,
    curPgetproduct3	OUT	refCur
  )
  AS
    dtLnullDate		DATE;
  BEGIN

    SELECT TO_DATE('01-01-1900','DD-MM-YYYY') INTO dtLnullDate FROM DUAL;

  /* reviews (editorial) */
    OPEN curPgetproduct1 FOR
    SELECT
      CAST(prl.lang_id AS int) as lang_id,
      CAST(NVL(pr.product_rating, 0) AS int) as product_rating,
      NVL(pr.reviewer, 'EDITORIAL') as reviewer,
      NVL(pr.date_posted, dtLnullDate) as date_posted,
      prl.title as title,
      r.review,
      r.review_img_loc,
      CAST(NVL(r.review_img_width, 0) AS int),
      CAST(NVL(r.review_img_height, 0) AS int),
      pr.sku
    FROM ya_product_rating pr,
         ya_prod_rating_lang prl,
         ya_review r
    WHERE	pr.rating_id = prl.rating_id (+)
    AND	prl.us_review_id = r.review_id (+)
    AND	pr.reviewer_type  = 'EDITORIAL'
    AND	pr.review_approved  = 'Y'
    AND	pr.sku  = iPsku
    AND	prl.lang_id  < 6
    AND	(r.review IS NOT NULL
    OR	r.review_img_loc IS NOT NULL);


  /* reviews (best reviews) */
    OPEN curPgetproduct2 FOR
    SELECT
      CAST(prl.lang_id AS int) as lang_id,
      CAST(NVL(pr.product_rating, 0) AS int) as product_rating,
      pr.reviewer,
      NVL(pr.date_posted, dtLnullDate) as date_posted,
      prl.title as title,
      r.review as review,
      r.review_img_loc as review_img_loc,
      CAST(NVL(r.review_img_width, 0) AS int) as review_img_width,
      CAST(NVL(r.review_img_height, 0) AS int) as review_img_height,
      pr.sku
    FROM ya_product_rating pr,
         ya_prod_rating_lang prl,
         ya_review r
    WHERE pr.rating_id = prl.rating_id
    AND	r.review_id  = prl.us_review_id
    AND	(pr.reviewer_type = 'WINNER'
    AND	pr.review_approved = 'Y'
    AND	pr.sku = iPsku
    AND	prl.lang_id < 6)
    ORDER BY pr.reviewer_type, pr.date_posted DESC;


  /* get latest 3 user reviews */
    OPEN curPgetproduct3 FOR
    SELECT
      lang_id,
      product_rating,
      reviewer,
      date_posted,
      title,
      review,
      review_img_loc,
      review_img_width,
      review_img_height,
      sku
    FROM
      (
      SELECT
        CAST(prl.lang_id AS int) as lang_id,
        CAST(NVL(pr.product_rating, 0) AS int) as product_rating,
        pr.reviewer,
        NVL(pr.date_posted, dtLnullDate) as date_posted,
        prl.title as title,
        r.review as review,
        r.review_img_loc as review_img_loc,
        CAST(NVL(r.review_img_width, 0) AS int) as review_img_width,
        CAST(NVL(r.review_img_height, 0) AS int) as review_img_height,
        pr.sku
      FROM ya_product_rating pr,
     ya_prod_rating_lang prl,
     ya_review r
      WHERE pr.reviewer_type = 'USER'
      AND	pr.review_approved  = 'Y'
      AND	pr.sku = iPsku
      AND	prl.lang_id < 6
      AND	pr.rating_id = prl.rating_id
      AND	r.review_id = prl.us_review_id
      ORDER BY date_posted DESC
      )
      WHERE ROWNUM < 4;
    RETURN;
  END GetReview;

    PROCEDURE GetReviews (
    curPgetMulti1	OUT	refCur,
    curPgetMulti2	OUT	refCur,
    curPgetMulti3	OUT	refCur,
    iPsku1 		IN	INT DEFAULT null,
    iPsku2 		IN	INT DEFAULT null,
    iPsku3 		IN	INT DEFAULT null,
    iPsku4 		IN	INT DEFAULT null,
    iPsku5 		IN	INT DEFAULT null,
    iPsku6 		IN	INT DEFAULT null,
    iPsku7 		IN	INT DEFAULT null,
    iPsku8 		IN	INT DEFAULT null,
    iPsku9 		IN	INT DEFAULT null,
    iPsku10		IN	INT DEFAULT null,
    iPsku11		IN	INT DEFAULT null,
    iPsku12		IN	INT DEFAULT null,
    iPsku13		IN	INT DEFAULT null,
    iPsku14		IN	INT DEFAULT null,
    iPsku15		IN	INT DEFAULT null,
    iPsku16		IN	INT DEFAULT null,
    iPsku17		IN	INT DEFAULT null,
    iPsku18		IN	INT DEFAULT null,
    iPsku19		IN	INT DEFAULT null,
    iPsku20		IN	INT DEFAULT null
  )
  AS
      dtLnullDate		DATE;
  BEGIN

    SELECT TO_DATE('01-01-1900','DD-MM-YYYY') INTO dtLnullDate FROM DUAL;

  /* reviews (editorial) */

    OPEN curPgetMulti1 FOR
    SELECT CAST(prl.lang_id AS int) as lang_id, CAST(NVL(pr.product_rating, 0) AS int)
           as product_rating,
           NVL(pr.reviewer, 'EDITORIAL') as reviewer, NVL(pr.date_posted, dtLnullDate) as
           date_posted, prl.title as title, r.review, r.review_img_loc,
           CAST(NVL(r.review_img_width, 0) AS int),
           CAST(NVL(r.review_img_height, 0) AS int), pr.sku
    FROM ya_product_rating pr, ya_prod_rating_lang prl, ya_review r
    WHERE pr.rating_id       = prl.rating_id (+)
      AND prl.us_review_id   = r.review_id (+)
      AND (
            pr.reviewer_type   = 'EDITORIAL'
        AND pr.review_approved = 'Y'
        AND pr.sku
            IN (
              iPsku1, iPsku2, iPsku3, iPsku4, iPsku5, iPsku6, iPsku7, iPsku8, iPsku9, iPsku10,
              iPsku11, iPsku12, iPsku13, iPsku14, iPsku15, iPsku16, iPsku17, iPsku18, iPsku19,
              iPsku20
            )
        AND prl.lang_id        < 6
        AND (
              r.review IS NOT NULL
           OR r.review_img_loc IS NOT NULL
            )
          );


  /* reviews (best reviews) */

    OPEN curPgetMulti2 FOR
      SELECT CAST(prl.lang_id AS int) as lang_id,
             CAST(NVL(pr.product_rating, 0) AS int) as product_rating, pr.reviewer,
             NVL(pr.date_posted, dtLnullDate) as date_posted, prl.title as title, r.review as
             review, r.review_img_loc as review_img_loc,
             CAST(NVL(r.review_img_width, 0) AS int) as review_img_width,
             CAST(NVL(r.review_img_height, 0) AS int) as review_img_height, pr.sku
      FROM ya_product_rating pr, ya_prod_rating_lang prl, ya_review r
      WHERE (pr.rating_id      = prl.rating_id)
        AND r.review_id        = prl.us_review_id
        AND (
              pr.reviewer_type   = 'WINNER'
          AND pr.review_approved = 'Y'
          AND pr.sku
              IN (
                iPsku1, iPsku2, iPsku3, iPsku4, iPsku5, iPsku6, iPsku7, iPsku8, iPsku9, iPsku10,
                iPsku11, iPsku12, iPsku13, iPsku14, iPsku15, iPsku16, iPsku17, iPsku18, iPsku19,
                iPsku20
              )
          AND prl.lang_id        < 6
            )
      ORDER BY pr.reviewer_type, pr.date_posted DESC;


  /* get latest 3 user reviews for each sku*/

    OPEN curPgetMulti3 FOR
      SELECT CAST(prl.lang_id AS int) as lang_id,
             CAST(NVL(pr.product_rating, 0) AS int) as product_rating, pr.reviewer,
             NVL(pr.date_posted, dtLnullDate) as date_posted, prl.title as title,
               r.review as review, r.review_img_loc as review_img_loc,
             CAST(NVL(r.review_img_width, 0) AS int) as review_img_width,
             CAST(NVL(r.review_img_height, 0) AS int) as review_img_height, pr.sku
        FROM ya_product_rating pr, ya_prod_rating_lang prl, ya_review r
       WHERE pr.rating_id        = prl.rating_id
         AND r.review_id         = prl.us_review_id
         AND pr.rating_id IN (
          SELECT rating_id
            FROM (
              SELECT pri.rating_id, pri.sku
                FROM ya_product_rating pri, ya_prod_rating_lang prl, ya_review r
               WHERE pri.reviewer_type   = 'USER'
                 AND pri.review_approved = 'Y'
                 AND prl.lang_id         < 6
                 AND pri.rating_id       = prl.rating_id
                 AND r.review_id         = prl.us_review_id
                 AND pri.sku
                     IN (
                       iPsku1, iPsku2, iPsku3, iPsku4, iPsku5, iPsku6, iPsku7, iPsku8, iPsku9,
                       iPsku10, iPsku11, iPsku12, iPsku13, iPsku14, iPsku15, iPsku16, iPsku17,
                       iPsku18, iPsku19, iPsku20
                     )
               ORDER BY date_posted DESC
                 ) r
           WHERE r.sku               = pr.sku
             AND ROWNUM              < 4
             )
         AND pr.sku
             IN (
               iPsku1, iPsku2, iPsku3, iPsku4, iPsku5, iPsku6, iPsku7, iPsku8, iPsku9, iPsku10,
               iPsku11, iPsku12, iPsku13, iPsku14, iPsku15, iPsku16, iPsku17, iPsku18, iPsku19,
               iPsku20
             )
       ORDER BY date_posted DESC;
    RETURN;
  END GetReviews;


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



  /*
  * Game Project 21 Nov 2005
  * proc_bo_GetProductTrailerRel
  */
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

  -- --- cross selling 2005 ---+
  PROCEDURE GetCrossSellingInfo
  (
    iPsku IN INT,
    curPresult1 OUT refcur,
    curPresult2 OUT refcur,
    curPresult3 OUT refcur,
    curPresult4 OUT refcur
  )
  AS
  BEGIN
    --us section cross selling
    OPEN curPresult1 FOR
    SELECT r2.sectionid, count(r2.crossSellsku)
    FROM
    (
      SELECT r.sectionid, r.crossSellsku
      FROM
      (
        SELECT dcs.sectionid, dcs.crossSellsku
        FROM
          dm_crossSell_sku dcs,
          prod_avlb pa,
          prod_region pr
        WHERE
          dcs.sku = iPsku
          AND pa.prod_id = dcs.crossSellsku
          AND pr.prod_id = pa.prod_id
          AND pr.region_id = pa.region_id
          AND pr.origin_id = pa.origin_id
          AND pr.category_id = pa.category
          AND pr.is_enabled = 'Y'
          AND pr.is_can_sell = 'Y'
          AND pa.origin_id = 1 -- us
          AND pa.region_id = 1 -- us region
          AND pa.category = 1 -- b2c
          AND pa.avlb < 60
          AND dcs.originId = pa.origin_id
        ORDER BY dcs.rank ASC, dcs.crossSellSku DESC
      ) r
      where ROWNUM <=100
    ) r2
    GROUP BY r2.sectionid;

    --us cross sell artist
    OPEN curPresult2 FOR
    SELECT crossSellArtistId
    FROM
    (
      SELECT crossSellArtistId
      FROM
        dm_crossSell_artist dca
      WHERE
        dca.sku = iPsku
        AND dca.originId = 1 -- us
        AND EXISTS
          (SELECT 1
           FROM
             ya_product_artist i_par,
             prod_avlb i_pa,
             prod_region i_pr
           WHERE
             i_par.artist_id = dca.crossSellArtistId
             AND i_pa.prod_id = i_par.sku
             AND i_pr.prod_id = i_pa.prod_id
             AND i_pr.region_id = i_pa.region_id
             AND i_pr.origin_id = i_pa.origin_id
             AND i_pr.category_id = i_pa.category
             AND i_pr.is_enabled = 'Y'
             AND i_pr.is_can_sell = 'Y'
             AND i_pa.origin_id = dca.originid
             AND i_pa.region_id = dca.originid
             AND i_pa.category = 1 -- b2c
             AND i_pa.avlb < 60
             AND ROWNUM = 1
           )
      ORDER BY
        rank ASC, crossSellArtistId ASC
    )
    WHERE
      ROWNUM <=10;

    --global section cross selling
    OPEN curPresult3 FOR
    SELECT r2.sectionid, count(r2.crossSellsku)
    FROM
    (
      SELECT r.sectionid, r.crossSellsku
      FROM
      (
        SELECT dcs.sectionid, dcs.crossSellsku
        FROM
          dm_crossSell_sku dcs,
          prod_avlb pa,
          prod_region pr
        WHERE
          dcs.sku = iPsku
          AND pa.prod_id = dcs.crossSellsku
          AND pr.prod_id = pa.prod_id
          AND pr.region_id = pa.region_id
          AND pr.origin_id = pa.origin_id
          AND pr.category_id = pa.category
          AND pr.is_enabled = 'Y'
          AND pr.is_can_sell = 'Y'
          AND pa.origin_id = 7 -- global
          AND pa.region_id = 7 -- global region
          AND pa.category = 1 -- b2c
          AND pa.avlb < 60
          AND dcs.originId = pa.origin_id
        ORDER BY dcs.rank ASC, dcs.crossSellSku DESC
      ) r
      where ROWNUM <=100
    ) r2
    GROUP BY r2.sectionid;

    --global cross sell artist
    OPEN curPresult4 FOR
    SELECT crossSellArtistId
    FROM
    (
      SELECT crossSellArtistId
      FROM
        dm_crossSell_artist dca
      WHERE
        dca.sku = iPsku
        AND dca.originId = 7 -- global
        AND EXISTS
          (SELECT 1
           FROM
             ya_product_artist i_par,
             prod_avlb i_pa,
             prod_region i_pr
           WHERE
             i_par.artist_id = dca.crossSellArtistId
             AND i_pa.prod_id = i_par.sku
             AND i_pr.prod_id = i_pa.prod_id
             AND i_pr.region_id = i_pa.region_id
             AND i_pr.origin_id = i_pa.origin_id
             AND i_pr.category_id = i_pa.category
             AND i_pr.is_enabled = 'Y'
             AND i_pr.is_can_sell = 'Y'
             AND i_pa.origin_id = dca.originid
             AND i_pa.region_id = dca.originid
             AND i_pa.category = 1 -- b2c
             AND i_pa.avlb < 60
             AND ROWNUM = 1
           )
      ORDER BY
        rank ASC, crossSellArtistId ASC
    )
    WHERE
      ROWNUM <=10;

  END GetCrossSellingInfo;

END Pkg_bo_ProductDalc;
/
 
REM END SS_ADM PKG_BO_PRODUCTDALC
