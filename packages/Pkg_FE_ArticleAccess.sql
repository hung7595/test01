
REM START SS_ADM PKG_FE_ARTICLEACCESS

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_ARTICLEACCESS" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetArticleByArticleId (
    iParticle_id IN INT,
    iPlang_id IN INT,
    iPoriginId IN INT,
    curPgetArticle1 OUT refCur,
    curPgetArticle2 OUT refCur,
    curPgetArticle3 OUT refCur,
    curPgetArticle4 OUT refCur,
    curPgetArticle5 OUT refCur
  );

  PROCEDURE GetPreviewedArticleByArticleId (
    iParticle_id IN INT,
    iPlang_id IN INT,
    iPoriginId IN INT,
    curPgetPreview1 OUT refCur,
    curPgetPreview2 OUT refCur,
    curPgetPreview3 OUT refCur,
    curPgetPreview4 OUT refCur,
    curPgetPreview5 OUT refCur
  );

  PROCEDURE CheckSkuHasArticle (
    iPsku IN INT,
    iPisArticle OUT INT
  );

  PROCEDURE GetAllArticleLang (
     iParticleId IN INT,
     cPpreview IN CHAR,
     curPgetAll OUT refCur
  );

  PROCEDURE GetArticleIdBySku (
    iPsku IN INT,
    oParticleId OUT INT
  );

  PROCEDURE GetProductArticleByProdGrpSku (
    iPprodId IN INT,
    iPlangId IN INT,
    curPgetProduct OUT refCur
  );

	PROCEDURE GetProductArticleByProdGrpSkus (
    cPprodId_csv IN VARCHAR2,
    curPgetProduct OUT refCur
  );

  PROCEDURE GetProductArticleByDeptID (
    iPdeptId IN INT,
    iPlangId IN INT,
    curPgetProduct OUT refCur
  );

  PROCEDURE GetProductArticleByArtistID (
    iPartistId IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetArticleCountByLangId (
    iPlangId IN INT,
    oPcount OUT INT
  );

  PROCEDURE GetArticlesByLangId (
    iPlang_Id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetNewArticleByArticleId (
    iParticle_id IN INT,
    iPlang_id IN INT,
    iPoriginId IN INT,
    curPgetArticle1 OUT refCur,
    curPgetArticle2 OUT refCur,
    curPgetArticle3 OUT refCur,
    curPgetArticle4 OUT refCur,
    curPgetArticle5 OUT refCur
  );

END Pkg_FE_ArticleAccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_ARTICLEACCESS" 
AS
  /* proc_fe_GetArticleByArticleId */
  PROCEDURE GetArticleByArticleId (
    iParticle_id IN INT,
    iPlang_id IN INT,
    iPoriginId IN INT,
    curPgetArticle1 OUT refCur,
    curPgetArticle2 OUT refCur,
    curPgetArticle3 OUT refCur,
    curPgetArticle4 OUT refCur,
    curPgetArticle5 OUT refCur
    )
  AS
  BEGIN
    /* get the article */
    OPEN curPgetArticle1 FOR
    SELECT
      NVL(article.product_group_sku,0) product_group_sku,
      lang.title title,
      lang.author author,
      lang.parsed_body parsed_body,
      lang.banner_image banner_image,
      article.in_tracking_no in_tracking_no,
      article.out_tracking_no out_tracking_no
    FROM
      ya_article_lang lang,
      ya_article article
    WHERE lang.article_id = article.article_id
    AND lang.article_id = iParticle_id
    AND lang.lang_id = iPlang_id
    AND article.enable = 'Y'
    AND article.status = 8;

    /* the mentioned products */
    OPEN curPgetArticle2 FOR
    SELECT
      NVL(lang.sku,0) sku,
      lang.prod_name_u prod_name,
      prod.cover_img_loc cover_img_loc,
      pa.avlb
    FROM
      ya_article_rel rel,
      ya_article article,
      ya_product prod,
      ya_prod_lang lang,
      prod_avlb pa
    WHERE
      article.article_id = rel.article_id
      AND rel.rel_id = prod.sku
      AND rel.rel_id = lang.sku
      AND rel.lang_id = lang.lang_id
      AND rel.rel_id = pa.prod_id
      AND rel.article_id = iParticle_id
      AND rel.enable = 'Y'
      AND rel.rel_type = 1
      AND lang.lang_id = iPlang_id
      AND article.enable = 'Y'
      AND article.status = 8
      AND pa.origin_id = iPoriginId
      AND pa.category = 1
      AND pa.region_id = iPoriginId
    ORDER BY rel.priority ASC;

    /* get the mentioned artists */
    OPEN curPgetArticle3 FOR
    SELECT
      NVL(artist.artist_id,0) artist_id,
      NVL2
        (
          akaname_u,
          akaname_u || ' ' || artist.lastname_u,
          artist.lastname_u || ' ' || artist.firstname_u
        ) lastname
    FROM
      ya_artist_lang artist,
      ya_article_rel rel,
      ya_article article
    WHERE artist.artist_id = rel.rel_id
    AND rel.lang_id = artist.lang_id
    AND article.article_id = rel.article_id
    AND article.enable = 'Y'
    AND article.status = 8
    AND rel.enable = 'Y'
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 4
    AND artist.lang_id = iPlang_id
    ORDER BY rel.priority ASC;

    /* get the mentioned director */
    OPEN curPgetArticle4 FOR
    SELECT
      NVL(artist.artist_id,0) artist_id,
      NVL2
        (
          akaname_u,
          akaname_u || ' ' || artist.lastname_u,
          artist.lastname_u || ' ' || artist.firstname_u
        ) lastname
    FROM
      ya_artist_lang artist,
      ya_article_rel rel,
      ya_article article
    WHERE artist.artist_id = rel.rel_id
    AND rel.lang_id = artist.lang_id
    AND article.article_id = rel.article_id
    AND article.enable = 'Y'
    AND article.status = 8
    AND rel.enable = 'Y'
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 5
    AND artist.lang_id = iPlang_id
    ORDER BY rel.priority ASC;

    /* get the categories */
    OPEN curPgetArticle5 FOR
    SELECT
      NVL(dept.dept_id,0) dept_id,
      dept.dept_name_u dept_name
    FROM
      ya_article_rel rel,
      ya_dept_lang dept,
      ya_article article
    WHERE rel.rel_id = dept.dept_id
    AND dept.lang_id = rel.lang_id
    AND rel.article_id = article.article_id
    AND article.enable = 'Y'
    AND article.status = 8
    AND rel.enable = 'Y'
    AND rel.article_id = iParticle_id
    AND (rel.rel_type = 2 OR rel.rel_type = 3)
    AND dept.lang_id = iPlang_id
    ORDER BY rel.priority ASC;
  RETURN;
  END;

  PROCEDURE GetPreviewedArticleByArticleId (
    iParticle_id IN INT,
    iPlang_id IN INT,
    iPoriginId IN	INT,
    curPgetPreview1 OUT refCur,
    curPgetPreview2 OUT refCur,
    curPgetPreview3 OUT refCur,
    curPgetPreview4 OUT refCur,
    curPgetPreview5 OUT refCur
  )
  AS
  BEGIN
    /* get the article */
    OPEN curPgetPreview1 FOR
    SELECT
      NVL(article.product_group_sku,0) product_group_sku,
      lang.title title,
      lang.author author,
      lang.parsed_body parsed_body,
      lang.banner_image banner_image,
      article.in_tracking_no in_tracking_no,
      article.out_tracking_no out_tracking_no
    FROM
      ya_article_lang lang,
      ya_article article
    WHERE lang.article_id = article.article_id
    AND	lang.article_id = iParticle_id
    AND   lang.lang_id = iPlang_id;

    /* the mentioned products */
    OPEN curPgetPreview2 FOR
    SELECT
      NVL(lang.sku,0) sku,
      lang.prod_name_u prod_name,
      prod.cover_img_loc cover_img_loc,
      pa.avlb
    FROM
      ya_article_rel rel,
      ya_article article,
      ya_product prod,
      ya_prod_lang lang,
      prod_avlb pa
    WHERE article.article_id = rel.article_id
    AND rel.rel_id = prod.sku
    AND rel.rel_id = lang.sku
    AND rel.lang_id = lang.lang_id
    AND rel.rel_id = pa.prod_id
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 1
    AND lang.lang_id = iPlang_id
    AND pa.origin_id = iPoriginId
    AND pa.category = 1
    AND pa.region_id = iPoriginId
    ORDER BY rel.priority asc;

    /* get the mentioned artists */
    OPEN curPgetPreview3 FOR
    SELECT
      NVL(artist.artist_id,0) artist_id,
      NVL2
        (
          akaname_u,
          akaname_u || ' ' || artist.lastname_u,
          artist.lastname_u || ' ' || artist.firstname_u
        ) lastname
    FROM
      ya_artist_lang artist,
      ya_article_rel rel,
      ya_article article
    WHERE artist.artist_id = rel.rel_id
    AND rel.lang_id = artist.lang_id
    AND article.article_id = rel.article_id
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 4
    AND artist.lang_id = iPlang_id
    ORDER BY rel.priority asc;

    /* get the mentioned director */
    OPEN curPgetPreview4 FOR
    SELECT
      NVL(artist.artist_id,0) artist_id,
      NVL2
        (
          akaname_u,
          akaname_u || ' ' || artist.lastname_u,
          artist.lastname_u || ' ' || artist.firstname_u
        ) lastname
    FROM
      ya_artist_lang artist,
      ya_article_rel rel,
      ya_article article
    WHERE artist.artist_id = rel.rel_id
    AND rel.lang_id = artist.lang_id
    AND article.article_id = rel.article_id
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 5
    AND artist.lang_id = iPlang_id
    ORDER BY rel.priority asc;

    /* get the categories */
    OPEN curPgetPreview5 FOR
    SELECT
      NVL(dept.dept_id,0) dept_id,
      dept.dept_name_u dept_name
    FROM
      ya_article_rel rel,
      ya_dept_lang dept,
      ya_article article
    WHERE rel.rel_id = dept.dept_id
    AND rel.lang_id = dept.lang_id
    AND rel.article_id = article.article_id
    AND rel.article_id = iParticle_id
    AND (rel.rel_type = 2 or rel.rel_type = 3)
    AND dept.lang_id = iPlang_id
    ORDER BY rel.priority asc;
    RETURN;
  END;

  PROCEDURE CheckSkuHasArticle (
    iPsku IN INT,
    iPisArticle OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(product_group_sku)
    INTO iPisArticle
    FROM ya_article
    WHERE product_group_sku = iPsku;
    RETURN;
  END;

  PROCEDURE GetAllArticleLang (
    iParticleId IN INT,
    cPpreview IN CHAR,
    curPgetAll OUT refCur
  )
  AS
    iLenable CHAR(1);
  BEGIN
    IF cPpreview = 'Y' THEN
      iLenable := 'N';
    ELSE
      iLenable := 'Y';
    END IF;

    OPEN curPgetAll FOR
    SELECT
      article.product_group_sku,
      lang.lang_id,
      lang.banner_Image,
      lang.parsed_body,
      in_tracking_no,
      out_tracking_no
    FROM ya_article article,
         ya_article_lang lang
    WHERE article.article_id = lang.article_id (+)
    AND lang.article_id = iParticleId
    AND article.status = 8
    AND article.enable = iLenable;

    RETURN;
  END;

  PROCEDURE GetArticleIdBySku (
    iPsku IN INT,
    oParticleId OUT INT
  )
  AS
  BEGIN
    SELECT r.article_id
    INTO oParticleId
    FROM
    (
      SELECT article_id
      FROM ya_article
      WHERE
        product_group_sku = iPsku
      ORDER BY article_id ASC
    ) r
    WHERE
      ROWNUM = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    oParticleId := -1;

    RETURN;
  END;

  PROCEDURE GetProductArticleByProdGrpSku (
    iPprodId IN INT,
    iPlangId IN INT,
    curPgetProduct OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetProduct FOR
    SELECT
      a.article_id,
      l.lang_id,
      a.in_tracking_no,
      a.out_tracking_no,
      l.title
    FROM
      ya_article a,
      ya_article_lang l
    WHERE a.article_id = l.article_id
    AND l.lang_id = iPlangId
    AND a.enable = 'Y'
    AND a.status = 8
    AND a.product_group_sku = iPprodId
    ORDER BY a.created_date desc, a.article_id asc;
    return;
  END;

	PROCEDURE GetProductArticleByProdGrpSkus (
    cPprodId_csv IN VARCHAR2,
		curPgetProduct OUT refCur
  )
  AS
    cLsql	CHAR(6000);
  BEGIN
    cLsql :=
			'SELECT product_group_sku, a.article_id, nvl(l.lang_id, 0) as lang_id, a.in_tracking_no, a.out_tracking_no, l.title ' ||
			'FROM ya_article a ' ||
			'LEFT JOIN ya_article_lang l ON a.article_id = l.article_id ' ||
			'WHERE a.enable = ''Y'' ' ||
			'AND a.status = 8 ' ||
			'AND a.product_group_sku IN (' ||	cPprodId_csv ||	')';

		OPEN curPgetProduct FOR cLsql;
    return;
  END;

  PROCEDURE GetProductArticleByDeptID (
    iPdeptId IN INT,
    iPlangId IN INT,
    curPgetProduct OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetProduct FOR
    SELECT
      a.article_id,
      l.lang_id,
      a.in_tracking_no,
      a.out_tracking_no,
      l.title
    FROM
      ya_article a,
      ya_article_lang l
    WHERE a.article_id = l.article_id
    AND l.lang_id = iPlangId
    AND a.enable = 'Y'
    AND a.status = 8
    AND a.article_id in
      (
      SELECT article_id
      FROM ya_article_rel
      WHERE rel_id = iPdeptId
      AND (rel_type = 2 OR rel_type = 3)
      AND enable = 'Y'
      GROUP BY article_id
      )
    ORDER BY a.created_date desc, a.article_id asc;
    return;
  END;


  PROCEDURE GetProductArticleByArtistID (
    iPartistId IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      a.article_id,
      l.lang_id,
      a.in_tracking_no,
      a.out_tracking_no,
      l.title
    FROM
      ya_article a
      INNER JOIN ya_article_lang l
      ON a.article_id = l.article_id
      AND l.lang_id = iPlangId
    WHERE
      a.enable = 'Y'
      AND a.status = 8
      AND a.article_id IN
      (
        SELECT article_id
        FROM ya_article_rel
        WHERE
          rel_id = iPartistId
          AND rel_type = 4
          AND enable = 'Y'
        GROUP BY article_id
      )
    ORDER BY
      a.created_date DESC,
      a.article_id ASC;
    RETURN;
  END GetProductArticleByArtistID;

  PROCEDURE GetArticleCountByLangId (
    iPlangId IN INT,
    oPcount OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(*) AS num INTO oPcount
      FROM
      (
        SELECT
          *
        FROM
          ya_article_lang lang,
          ya_article article
        WHERE lang.article_id = article.article_id
        AND lang.lang_id = iPlangId
        AND article.enable = 'Y'
        AND article.status = 8
      );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        oPcount := 0;
  END GetArticleCountByLangId;

  PROCEDURE GetArticlesByLangId (
    iPlang_Id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    /* get the article */
    OPEN curPresult FOR
    SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum
      from
      (
        SELECT
          NVL(article.product_group_sku,0) product_group_sku,
          lang.title title,
          lang.author author,
          lang.parsed_body parsed_body,
          lang.banner_image banner_image,
          article.in_tracking_no in_tracking_no,
          article.out_tracking_no out_tracking_no,
          NVL(article.article_id,0) article_id,
          lang.submission_date submission_date
        FROM
          ya_article_lang lang,
          ya_article article
        WHERE lang.article_id = article.article_id
        AND lang.lang_id = iPlang_Id
        AND article.enable = 'Y'
        AND article.status = 8
        ORDER BY lang.submission_date DESC
      ) innerQuery
      WHERE ROWNUM < (iPstart_rec + iProw_num + 1)
    )
    WHERE rnum > iPstart_rec;
  END GetArticlesByLangId;

  /* proc_fe_GetNewArticleByArticleId */
  PROCEDURE GetNewArticleByArticleId (
    iParticle_id IN INT,
    iPlang_id IN INT,
    iPoriginId IN INT,
    curPgetArticle1 OUT refCur,
    curPgetArticle2 OUT refCur,
    curPgetArticle3 OUT refCur,
    curPgetArticle4 OUT refCur,
    curPgetArticle5 OUT refCur
    )
  AS
  BEGIN
    /* get the article */
    OPEN curPgetArticle1 FOR
    SELECT
      NVL(article.product_group_sku,0) product_group_sku,
      lang.title title,
      lang.author author,
      lang.parsed_body parsed_body,
      lang.banner_image banner_image,
      article.in_tracking_no in_tracking_no,
      article.out_tracking_no out_tracking_no,
      NVL(article.article_id,0) article_id,
      lang.submission_date submission_date
    FROM
      ya_article_lang lang,
      ya_article article
    WHERE lang.article_id = article.article_id
    AND lang.article_id = iParticle_id
    AND lang.lang_id = iPlang_id
    AND article.enable = 'Y'
    AND article.status = 8;

    /* the mentioned products */
    OPEN curPgetArticle2 FOR
    SELECT
      NVL(lang.sku,0) sku,
      lang.prod_name_u prod_name,
      prod.cover_img_loc cover_img_loc,
      pa.avlb
    FROM
      ya_article_rel rel,
      ya_article article,
      ya_product prod,
      ya_prod_lang lang,
      prod_avlb pa
    WHERE
      article.article_id = rel.article_id
      AND rel.rel_id = prod.sku
      AND rel.rel_id = lang.sku
      AND rel.lang_id = lang.lang_id
      AND rel.rel_id = pa.prod_id
      AND rel.article_id = iParticle_id
      AND rel.enable = 'Y'
      AND rel.rel_type = 1
      AND lang.lang_id = iPlang_id
      AND article.enable = 'Y'
      AND article.status = 8
      AND pa.origin_id = iPoriginId
      AND pa.category = 1
      AND pa.region_id = iPoriginId
    ORDER BY rel.priority ASC;

    /* get the mentioned artists */
    OPEN curPgetArticle3 FOR
    SELECT
      NVL(artist.artist_id,0) artist_id,
      NVL2
        (
          akaname_u,
          akaname_u || ' ' || artist.lastname_u,
          artist.lastname_u || ' ' || artist.firstname_u
        ) lastname
    FROM
      ya_artist_lang artist,
      ya_article_rel rel,
      ya_article article
    WHERE artist.artist_id = rel.rel_id
    AND rel.lang_id = artist.lang_id
    AND article.article_id = rel.article_id
    AND article.enable = 'Y'
    AND article.status = 8
    AND rel.enable = 'Y'
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 4
    AND artist.lang_id = iPlang_id
    ORDER BY rel.priority ASC;

    /* get the mentioned director */
    OPEN curPgetArticle4 FOR
    SELECT
      NVL(artist.artist_id,0) artist_id,
      NVL2
        (
          akaname_u,
          akaname_u || ' ' || artist.lastname_u,
          artist.lastname_u || ' ' || artist.firstname_u
        ) lastname
    FROM
      ya_artist_lang artist,
      ya_article_rel rel,
      ya_article article
    WHERE artist.artist_id = rel.rel_id
    AND rel.lang_id = artist.lang_id
    AND article.article_id = rel.article_id
    AND article.enable = 'Y'
    AND article.status = 8
    AND rel.enable = 'Y'
    AND rel.article_id = iParticle_id
    AND rel.rel_type = 5
    AND artist.lang_id = iPlang_id
    ORDER BY rel.priority ASC;

    /* get the categories */
    OPEN curPgetArticle5 FOR
    SELECT
      NVL(dept.dept_id,0) dept_id,
      dept.dept_name_u dept_name
    FROM
      ya_article_rel rel,
      ya_dept_lang dept,
      ya_article article
    WHERE rel.rel_id = dept.dept_id
    AND dept.lang_id = rel.lang_id
    AND rel.article_id = article.article_id
    AND article.enable = 'Y'
    AND article.status = 8
    AND rel.enable = 'Y'
    AND rel.article_id = iParticle_id
    AND (rel.rel_type = 2 OR rel.rel_type = 3)
    AND dept.lang_id = iPlang_id
    ORDER BY rel.priority ASC;
  RETURN;
  END;

END Pkg_FE_ArticleAccess;
/
 
REM END SS_ADM PKG_FE_ARTICLEACCESS
