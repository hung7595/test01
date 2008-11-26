
REM START SS_ADM PKG_FE_REVIEWACCESS

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_REVIEWACCESS" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetUserReviewsBySku (
    iPsku IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetUserReviewsById (
    cPid_csv IN VARCHAR2,
    curPresult OUT refCur
  );

  PROCEDURE GetSpecialReviewsByType (
    iPtype_id IN INT,
    ncPreviewer_type IN NVARCHAR2,
    curPresult OUT refCur
  );

  PROCEDURE GetReviewsByShopperID (
    cPshopper_id IN CHAR,
    iPlang_id IN INT,
    iPsite_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_review_getCustReviewBySku */
  PROCEDURE GetReviewsBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    iPget_best IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetBestReviewsBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_review_getProReviewBySku */
  PROCEDURE GetProReviewBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_review_getCustReviews */
  PROCEDURE GetReviewById (
    iPreview_id IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_review_getProductReview */
  PROCEDURE GetReviewCountBySku (
    iPsku IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_review_getShopperReview */
  PROCEDURE GetReviewCountByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  );

  /* proc_fe_review_getShopperReviewHelpful */
  PROCEDURE GetHelpfulCountByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  );

  /* proc_fe_WriteSpecialReview */
  PROCEDURE InsertSpecialReviewData (
    iPtype_id IN INT,
    nvcPreview_title IN NVARCHAR2,
    nvcPreview_body IN NVARCHAR2,
    nvcPreviewer_name IN NVARCHAR2,
    nvcPreviewer_email IN NVARCHAR2,
    nvcPreviewer_type IN NVARCHAR2,
    ncPreview_approved IN NCHAR,
    iPlang_id IN INT,
    iPreview_id IN OUT INT
  );
/* proc_fe_write_review */
  PROCEDURE InsertReviewData (
    iPsku IN INT,
    iPrating IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN VARCHAR2,
    cPshopperID IN CHAR,
    cPshopperName IN VARCHAR2,
    iPlangID IN INT,
    cPapproved IN CHAR,
    cPreviewerType IN VARCHAR2,
    iPreview_id IN OUT INT,
    iPrating_id IN OUT INT
  );
  /* proc_fe_write_review_1 */
  PROCEDURE InsertReviewData1 (
    iPsku IN INT,
    iPrating IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN VARCHAR2,
    cPshopperID IN CHAR,
    cPshopperName IN VARCHAR2,
    iPlangID IN INT,
    cPapproved IN CHAR,
    cPreviewerType IN VARCHAR2,
    cPactionType IN VARCHAR2,
    cPremark IN CLOB,
    iPreview_id IN OUT INT,
    iPrating_id IN OUT INT
  );
  /* proc_fe_write_review_1 - revise data type */
  PROCEDURE InsertReviewData2 (
    iPsku IN INT,
    iPrating IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN CLOB,
    cPshopperID IN CHAR,
    cPshopperName IN VARCHAR2,
    iPlangID IN INT,
    cPapproved IN CHAR,
    cPreviewerType IN VARCHAR2,
    cPactionType IN VARCHAR2,
    cPremark IN CLOB,
    iPreview_id IN OUT INT,
    iPrating_id IN OUT INT,
    cPisCommit IN CHAR DEFAULT 'Y'
  );

  /* proc_fe_review_addReviewHelpful */
  PROCEDURE InserHelpfulReviewData (
    iPreview_id IN INT,
    cPshopper_id IN CHAR,
    cPreview_helpful IN CHAR
  );

  /* proc_fe_review_getReviewHelpfulStat */
  PROCEDURE GetReviewHelpfulState (
    iPreview_id IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_review_IsShopperMarkedReviewHelpful */
  PROCEDURE IsShopperMarkedHelpful (
    iPreview_id IN INT,
    cPshopper_id IN CHAR,
    iPreturn OUT INT
  );

  /* proc_fe_review_addReviewReport */
  PROCEDURE AddReviewReport (
    iPreview_id IN INT,
    iPsku IN INT,
    cPshopper_id IN CHAR,
    iPreason IN INT,
    clobPreport_content IN CLOB,
    iPreturn IN OUT INT
  );

  /* proc_fe_review_getTopReviewerMonth */
  PROCEDURE GetTopReviewerMonth (
    curPresult OUT refCur
  );

  /*
    Name: proc_fe_review_getShareGroupBySku

    Description:
      Get Review Sharing Group by Inputted Sku
      Parameter(s):
      - sku:  sku input
  */
  PROCEDURE GetReviewShareGroupSkus (
    iPsku IN INT,
    curPresult OUT refCur
  );

  /*
    UPDATE Review Name
  */
  PROCEDURE SetReviewerName (
    cPshopperId IN CHAR,
    cPfirstname IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPnickname IN VARCHAR2,
    iPdisplayMode IN INT
  );

  PROCEDURE GetReviewerName (
    cPshopperId IN VARCHAR2,
    curPresult OUT refCur
  );

  PROCEDURE GetTopReviewerByMonth (
    iPmonth IN INT,
    iPyear IN INT,
    curPresult OUT refCur
  );
  PROCEDURE GetBannedPhrases (
    curPresult OUT refCur
  );

	/* cron_fe_review_updateShopperReviewCount */
	PROCEDURE UpdateShopperReviewCount (
    iPresult OUT INT
  );

	/* proc_fe_review_getShopperReviewCount */
	PROCEDURE GetShopperReviewCount (
    cPshopper_id IN CHAR,
    iPreview_count OUT INT
  );

	PROCEDURE GetProductShareReviewRating (
    iPsku IN INT,
    iPtotal_rating OUT INT,
    iPnum_review OUT INT
  );
   PROCEDURE GetReviewsBySkuWithNoLang (
    iPsku IN INT,
    iPsite_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    iPget_best IN INT,
    curPresult OUT refCur
  );
   PROCEDURE GetAllReviewsByShopperID (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    curPresult OUT refCur
  );
	-- Editor Review -- BEGIN ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE GetEditorReviews (
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  );

	PROCEDURE GetEditorReviewsBySku (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPsku IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  );

	PROCEDURE GetEditorReviewsByShopperId (
    iPsite_id IN INT,
    iPlang_id IN INT,
		cPshopper_id IN CHAR,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  );

	PROCEDURE GetEditorReviewsByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  );

	PROCEDURE GetEditorReviewNumBySku (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPsku IN INT,
    iPresult OUT INT
  );

	PROCEDURE GetEditorReviewNumByShopperId (
    iPsite_id IN INT,
    iPlang_id IN INT,
		cPshopper_id IN CHAR,
    iPresult OUT INT
  );

	PROCEDURE GetEditorReviewNumByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPresult OUT INT
  );

	PROCEDURE GetProReviewsBySkus (
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
		iPget_share	IN INT,
    curPresult OUT refCur,
    iPsku1 IN	INT DEFAULT NULL,
    iPsku2 IN	INT DEFAULT NULL,
    iPsku3 IN	INT DEFAULT NULL,
    iPsku4 IN	INT DEFAULT NULL,
    iPsku5 IN	INT DEFAULT NULL,
    iPsku6 IN	INT DEFAULT NULL,
    iPsku7 IN	INT DEFAULT NULL,
    iPsku8 IN	INT DEFAULT NULL,
    iPsku9 IN	INT DEFAULT NULL,
    iPsku10 IN	INT DEFAULT NULL,
    iPsku11 IN	INT DEFAULT NULL,
    iPsku12 IN	INT DEFAULT NULL,
    iPsku13 IN	INT DEFAULT NULL,
    iPsku14 IN	INT DEFAULT NULL,
    iPsku15 IN	INT DEFAULT NULL,
    iPsku16 IN	INT DEFAULT NULL,
    iPsku17 IN	INT DEFAULT NULL,
    iPsku18 IN	INT DEFAULT NULL,
    iPsku19 IN	INT DEFAULT NULL,
    iPsku20 IN	INT DEFAULT NULL
  );

	PROCEDURE GetProReviewsByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  );

	PROCEDURE GetProReviewNumByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPresult OUT INT
  );

	PROCEDURE IsEditorPickProduct (
    iPsite_id IN INT,
		iPsku IN INT,
    curPresult OUT refCur
  );

	PROCEDURE IsEditorPickMultiProduct (
    iPsite_id IN INT,
    curPresult OUT refCur,
    iPsku1 IN	INT DEFAULT NULL,
    iPsku2 IN	INT DEFAULT NULL,
    iPsku3 IN	INT DEFAULT NULL,
    iPsku4 IN	INT DEFAULT NULL,
    iPsku5 IN	INT DEFAULT NULL,
    iPsku6 IN	INT DEFAULT NULL,
    iPsku7 IN	INT DEFAULT NULL,
    iPsku8 IN	INT DEFAULT NULL,
    iPsku9 IN	INT DEFAULT NULL,
    iPsku10 IN	INT DEFAULT NULL,
    iPsku11 IN	INT DEFAULT NULL,
    iPsku12 IN	INT DEFAULT NULL,
    iPsku13 IN	INT DEFAULT NULL,
    iPsku14 IN	INT DEFAULT NULL,
    iPsku15 IN	INT DEFAULT NULL,
    iPsku16 IN	INT DEFAULT NULL,
    iPsku17 IN	INT DEFAULT NULL,
    iPsku18 IN	INT DEFAULT NULL,
    iPsku19 IN	INT DEFAULT NULL,
    iPsku20 IN	INT DEFAULT NULL
  );
	-- Editor Review -- END ---------------------------------------------------------------------------------------------------------------------------------------------

	-- Review Update -- BEGIN ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE UpdateReview (
		iPrating_id IN INT,
		iPlang_id IN INT,
		cPtitle IN VARCHAR2,
    cPcontent IN CLOB
  );

	PROCEDURE UpdateReviewApproveStatus (
		iPrating_id IN INT,
		cPapprove IN CHAR,
		iProwAffect OUT INT
  );
	-- Review Update -- END ---------------------------------------------------------------------------------------------------------------------------------------------

	-- Spotlight Review -- BEGIN ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE UpdateSpotlightReview (
		iPrating_id IN INT,
		iProwAffect OUT INT
  );

	PROCEDURE AddExcludeList (
		iPreview_id IN INT
  );

	PROCEDURE GetPagedSpotlightReviewBySKU (
		iPsku IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
	);

	PROCEDURE GetPagedSpotlightReviewByDate (
		iPtotal_vote INT,
		iPpositive_vote INT,
		iPlang_id INT,
		dPstart_date DATE,
		dPend_date DATE,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
	);
	-- Spotlight Review -- END ---------------------------------------------------------------------------------------------------------------------------------------------

	-- Report This -- START -----------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE GetReviewReportByReviewId (
		iPreview_id IN INT,
    curPresult OUT refCur
  );

	PROCEDURE DeleteReviewReport (
		iPreport_id IN INT,
		iProwAffect OUT INT
  );

	PROCEDURE AddReviewActionLog (
		iPrating_id IN INT,
		iPaction_type IN VARCHAR2,
		iPremark IN NVARCHAR2
  );

	PROCEDURE AddReviewApprove (
		iPrating_id IN INT
  );

	PROCEDURE GetReviewReportByReportCount (
		iPreport_count IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
		curPresult OUT refCur
  );

	PROCEDURE GetReviewReportBySKU (
		iPsku IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
  );

	PROCEDURE GetReviewReportByDateRange (
		iPlang_id IN INT,
		dPstart_date IN DATE,
		dPend_date IN DATE,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
  );
	-- Report This -- END -----------------------------------------------------------------------------------------------------------------------------------------------

	-- Review Approval -- Start -----------------------------------------------------------------------------------------------------------------------------------------------
	/* proc_fe_review_getReviewKey */
	PROCEDURE GetReviewKey (
		curPresult OUT refCur
  );

	/* proc_fe_getNewReview */
	PROCEDURE GetNewReview (
		curPresult OUT refCur
  );

	/* proc_fe_getNewReviewCount */
	PROCEDURE GetNewReviewCount (
		curPresult OUT refCur
  );

	/* proc_fe_review_deleteReviewApprovalSystemKey */
	PROCEDURE DeleteReviewApprovalSystemKey;

	/* proc_fe_review_addReviewApprovalSystemKey */
	PROCEDURE AddReviewApprovalSystemKey (
		iPrreview_id IN INT,
		iPrating_id IN INT,
		cPreview_key IN NCLOB,
		dPdate_posted IN DATE
  );

	/* proc_fe_updateReviewStatus */
	PROCEDURE UpdateReviewStatus (
		iPrating_id IN INT,
		cPstatus IN CHAR,
		cPaction_type IN VARCHAR2,
		cPremark IN NVARCHAR2
  );

	-- Review Approval -- END -----------------------------------------------------------------------------------------------------------------------------------------------
END Pkg_FE_ReviewAccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_REVIEWACCESS" 
is
  PROCEDURE GetUserReviewsBySku (
    iPsku IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT pr.rating_id
    FROM ya_product_rating pr
    WHERE
      pr.reviewer_type = 'USER'
      AND pr.review_approved = 'Y'
      AND pr.sku = iPsku
    ORDER BY pr.date_posted desc;
    RETURN;
  END;


  PROCEDURE GetUserReviewsById (
    cPid_csv IN VARCHAR2,
    curPresult OUT refCur
  )
  AS
    cLsql	CHAR(6000);
  BEGIN
    cLsql :=
      'SELECT NVL(prl.lang_id,1) AS lang_id, ' ||
      'NVL(pr.product_rating,0) AS product_rating, ' ||
      'NVL(pr.reviewer,''Anonymous'') as reviewer, ' ||
      'pr.date_posted, ' ||
      'prl.title AS title, ' ||
      'r.review AS review, ' ||
      'r.review_img_loc AS review_img_loc, ' ||
      'NVL(r.review_img_width,0) AS review_img_width, ' ||
      'NVL(r.review_img_height,0) AS review_img_height ' ||
      'FROM ya_product_rating pr, ' ||
      'ya_prod_rating_lang prl, ' ||
      'ya_review r ' ||
      'WHERE pr.rating_id = prl.rating_id  ' ||
      'AND (r.review_id = prl.us_review_id ' ||
      'OR r.review_id = prl.tw_review_id) ' ||
      'AND pr.reviewer_type = ''USER'' ' ||
      'AND pr.review_approved = ''Y'' ' ||
      'AND pr.rating_id IN (' ||
      cPid_csv ||
      ')ORDER BY date_posted desc ';

    OPEN curPresult FOR cLsql;
    RETURN;
  END GetUserReviewsById;


  PROCEDURE GetSpecialReviewsByType (
    iPtype_id IN INT,
    ncPreviewer_type IN NVARCHAR2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      review_title,
      review_body,
      reviewer_name,
      reviewer_email,
      CASE reviewer_type
        WHEN N'USER' THEN 2
        WHEN N'EDITORIAL' THEN 1
        WHEN N'WINNER' THEN 3
      END AS review_type,
      created_datetime,
      cast (lang_id AS INT),
      review_id
    FROM ya_special_review
    WHERE
      type_id = iPtype_id
      AND review_approved = 'Y'
      AND reviewer_type = ncPreviewer_type
    ORDER BY created_datetime ASC;
    RETURN;
  END GetSpecialReviewsByType;


  PROCEDURE GetReviewsByShopperID (
    cPshopper_id IN CHAR,
    iPlang_id IN INT,
    iPsite_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    curPresult OUT refCur
  )
  AS
    dtLlast_date_posted DATE;
    iLstart_rec INT;
    iLlast_rating_id INT;
  BEGIN
    SELECT (iPstart_rec + 1) INTO iLstart_rec FROM DUAL;

    --get start record

    BEGIN
      SELECT
        r.date_posted, r.rating_id INTO
        dtLlast_date_posted, iLlast_rating_id
      FROM
      (
        SELECT
          x.date_posted,
          x.rating_id
        FROM
        (
          SELECT
            a.date_posted, a.rating_id
          FROM
            (
              SELECT * FROM ya_product_rating WHERE review_approved='Y'
              AND shopper_id = cPshopper_id
              AND (reviewer_type = 'USER' OR reviewer_type = 'WINNER')
            ) a,
            (
              SELECT * FROM ya_prod_rating_lang WHERE lang_id = iPlang_id
            ) b,
            (
              SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
            ) c
          WHERE
            a.rating_id = b.rating_id
            AND b.us_review_id =  c.review_id
						AND a.sku in (
        			SELECT prod_id as productid FROM prod_region WHERE (region_id <> 10 OR origin_id <> 10) AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
						)
          ORDER BY
            a.date_posted DESC , a.rating_id DESC
        ) x
        WHERE
          ROWNUM <= iLstart_rec
        ORDER BY
          x.date_posted, x.rating_id
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO dtLlast_date_posted FROM DUAL;
        SELECT -1 INTO iLlast_rating_id FROM DUAL;
    END;

    -- get final result
    OPEN curPresult FOR
    SELECT *
    FROM
    (
      SELECT
        a.rating_id, c.review_id, a.sku,
        cast(NVL(a.product_rating, 0) AS INT) AS product_rating,
        a.date_posted, a.review_approved,
        a.shopper_id AS shopper_id,
        a.reviewer AS reviewer,
        a.reviewer_type,

        cast(NVL(b.lang_id, 1) AS INT) AS lang_id,
        b.title AS title,
        c.review AS review,

        c.review_img_loc as review_img_loc,
        CAST(NVL(c.review_img_width, 0) AS INT) AS review_img_width,
        CAST(NVL(c.review_img_height, 0) AS INT) AS review_img_height,

        d.firstname AS firstname,
        d.lastname AS lastname,
        d.nickname AS nickname,
        NVL(e.display_mode, 0) AS display_mode,

        CAST(NVL(f.helpful_num, 0) AS INT) AS helpful_num,
        CAST(NVL(g.nonhelpful_num, 0) AS INT) AS nonhelpful_num
      FROM
      (
        SELECT * FROM ya_product_rating WHERE review_approved='Y'
        AND shopper_id = cPshopper_id
        AND (reviewer_type = 'USER' OR reviewer_type = 'WINNER')
      ) a
      LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
      LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
      (
        SELECT * FROM ya_prod_rating_lang WHERE lang_id = iPlang_id
      ) b,
      (
        SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
      ) c
      LEFT JOIN
      (
        SELECT review_id, count(*) as helpful_num
        FROM ya_review_helpful WHERE review_helpful='Y'
        GROUP BY review_id
      ) f ON c.review_id=f.review_id
      LEFT JOIN
      (
        SELECT review_id, count(*) as nonhelpful_num
        FROM ya_review_helpful WHERE review_helpful='N'
        GROUP BY review_id
      ) g ON c.review_id=g.review_id
      WHERE a.rating_id = b.rating_id
      AND b.us_review_id = c.review_id
			AND a.sku in (
        SELECT prod_id as productid FROM prod_region WHERE (region_id <> 10 OR origin_id <> 10) AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
			)
      AND
      (
        (a.date_posted = dtLlast_date_posted AND a.rating_id <= iLlast_rating_id) OR
        (a.date_posted < dtLlast_date_posted)
      )
      ORDER BY a.date_posted DESC, a.rating_id DESC
    ) r
    WHERE
      ROWNUM <=
      CASE
        WHEN iProw_num = 0 THEN (ROWNUM + 1)
        ELSE iProw_num
       END;

    RETURN;
  END GetReviewsByShopperID;



  PROCEDURE GetReviewsBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    iPget_best IN INT,
    curPresult OUT refCur
  )
  AS
    dtLlast_date_posted DATE;
    iLstart_rec INT;
    iLlast_rating_id INT;
  BEGIN
    SELECT (iPstart_rec + 1) INTO iLstart_rec FROM DUAL;

    --get start record

    BEGIN
      SELECT
        r.date_posted, r.rating_id INTO
        dtLlast_date_posted, iLlast_rating_id
      FROM
      (
        SELECT
          x.date_posted,
          x.rating_id
        FROM
        (
          SELECT a.date_posted, a.rating_id
          FROM
          (
               SELECT a2.* FROM
                   (
                         SELECT * FROM ya_product_rating
                         WHERE review_approved='Y'
                         AND (reviewer_type = 'USER' OR CASE WHEN iPget_best=1 THEN 'WINNER'  WHEN iPget_best=0 THEN 'dummy' END = reviewer_type)
                         AND sku <> iPsku
                    ) a2,
                    (
                         SELECT a1.sku FROM ya_review_share_group a1, ya_review_share_customerReview c1
                         WHERE a1.group_id = (SELECT b1.group_id FROM ya_review_share_group b1 WHERE b1.sku = iPsku)
                         AND a1.sku = c1.sku
                         AND a1.sku <> iPsku
                         AND iPget_share = 1
                     )b2
               WHERE a2.sku = b2.sku
               UNION
               SELECT * FROM ya_product_rating
               WHERE review_approved='Y'
               AND (reviewer_type = 'USER' OR CASE WHEN iPget_best=1 THEN 'WINNER'  WHEN iPget_best=0 THEN 'dummy' END = reviewer_type)
               AND sku = iPsku
          ) a,
          (
               SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id OR lang_id=1)
          ) b,
          (
               SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
          )c
          WHERE a.rating_id = b.rating_id
          AND b.us_review_id =  c.review_id
          ORDER BY a.date_posted DESC, a.rating_id DESC
        ) x
        WHERE
          ROWNUM <= iLstart_rec
        ORDER BY
          x.date_posted, x.rating_id
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO dtLlast_date_posted FROM DUAL;
        SELECT -1 INTO iLlast_rating_id FROM DUAL;
    END;

    -- get final result

    OPEN curPresult FOR
    SELECT *
    FROM
    (
        SELECT
          a.rating_id, c.review_id, a.sku,
          CAST(NVL(a.product_rating, 0) AS int) as product_rating,
          a.date_posted, a.review_approved,
          a.shopper_id as shopper_id,
          a.reviewer as reviewer,
          a.reviewer_type,
          CAST(NVL(b.lang_id, 1) AS int) as lang_id,
          b.title as title,
          c.review as review,
          c.review_img_loc as review_img_loc,
          CAST(NVL(c.review_img_width, 0) AS int) as review_img_width,
          CAST(NVL(c.review_img_height, 0) AS int) as review_img_height,
          d.firstname as firstname, d.lastname as lastname,
          d.nickname as nickname, NVL(e.display_mode, 0) as display_mode,
          CAST(NVL(f.helpful_num, 0) AS int) as helpful_num,
          CAST(NVL(g.nonhelpful_num, 0) AS int) as nonhelpful_num
        FROM
        (
          SELECT a2.*
          FROM
          (
            SELECT *
            FROM ya_product_rating
            WHERE
              review_approved =  'Y'
              AND
              (
                reviewer_type   =  'USER'
                OR
                  CASE
                    WHEN iPget_best  =  1 THEN 'WINNER'
                    WHEN iPget_best  =  0 THEN 'dummy'
                  END =  reviewer_type
              )
              AND sku <> iPsku
            ) a2,
          (
            SELECT a1.sku
            FROM ya_review_share_group a1, ya_review_share_customerReview c1
            WHERE
              a1.group_id =
              (
                SELECT b1.group_id
                FROM ya_review_share_group b1
                WHERE
                  b1.sku = iPsku
              )
              AND a1.sku          =  c1.sku
              AND a1.sku          <> iPsku
              AND iPget_share     =  1
          ) b2
          WHERE a2.sku = b2.sku
        UNION
          SELECT * FROM ya_product_rating
          WHERE
            review_approved='Y'
            AND
            (
              reviewer_type = 'USER'
              OR
                CASE
                  WHEN iPget_best=1 THEN 'WINNER'
                  WHEN iPget_best=0 THEN 'dummy'
                END = reviewer_type
            )
            AND sku = iPsku
        ) a
        LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
        LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
        (
          SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id OR lang_id=1)
        ) b,
        (
          SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
        )c
        LEFT JOIN
        (
          SELECT review_id, count(*) as helpful_num FROM ya_review_helpful WHERE review_helpful='Y' GROUP BY review_id
        ) f ON c.review_id=f.review_id
        LEFT JOIN
        (
          SELECT review_id, count(*) as nonhelpful_num FROM ya_review_helpful WHERE review_helpful='N' GROUP BY review_id
        ) g ON c.review_id=g.review_id
        WHERE
          a.rating_id = b.rating_id
          AND b.us_review_id = c.review_id
          AND
          (
            (a.date_posted = dtLlast_date_posted AND a.rating_id <= iLlast_rating_id)
            OR (a.date_posted < dtLlast_date_posted)
          )
        ORDER BY a.date_posted desc, a.rating_id desc
    )
    WHERE
      ROWNUM <=
        CASE
          WHEN iProw_num = 0 THEN (ROWNUM + 1)
          ELSE iProw_num
        END;

    RETURN;
  END GetReviewsBySku;



  PROCEDURE GetBestReviewsBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  )
  AS
    dtLlast_date_posted DATE;
    iLstart_rec INT;
    iLlast_rating_id INT;
  BEGIN
    SELECT (iPstart_rec + 1) INTO iLstart_rec FROM DUAL;

    --get start record

    BEGIN
      SELECT
        r.date_posted, r.rating_id INTO
        dtLlast_date_posted, iLlast_rating_id
      FROM
      (
        SELECT
          x.date_posted,
          x.rating_id
        FROM
        (
          SELECT a.date_posted, a.rating_id
          FROM
          (
            SELECT a2.* FROM
            (
              SELECT * FROM ya_product_rating
              WHERE
                review_approved='Y'
                AND reviewer_type = 'WINNER'
                AND sku <> iPsku
            ) a2,
            (
              SELECT a1.sku FROM ya_review_share_group a1, ya_review_share_customerReview c1
              WHERE a1.group_id = (SELECT b1.group_id FROM ya_review_share_group b1 WHERE b1.sku =
              iPsku)
              AND a1.sku = c1.sku
              AND a1.sku <> iPsku
              AND iPget_share = 1
            ) b2
            WHERE a2.sku = b2.sku
            UNION
            SELECT * FROM ya_product_rating
            WHERE review_approved='Y'
            AND reviewer_type = 'WINNER'
            AND sku = iPsku
          ) a,
          (
            SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id OR lang_id = 1)
          ) b,
          (
            SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
          ) c
          WHERE a.rating_id = b.rating_id
          AND b.us_review_id =  c.review_id
          ORDER BY a.date_posted DESC, a.rating_id DESC
        ) x
        WHERE
          ROWNUM <= iLstart_rec
        ORDER BY
          x.date_posted, x.rating_id
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO dtLlast_date_posted FROM DUAL;
        SELECT -1 INTO iLlast_rating_id FROM DUAL;
    END;

    -- get final result

    OPEN curPresult FOR
    SELECT *
    FROM
    (
      SELECT
        a.rating_id, c.review_id, a.sku,
        cast(NVL(a.product_rating, 0) AS int) AS product_rating,
        a.date_posted, a.review_approved,
        a.shopper_id AS shopper_id,
        a.reviewer AS reviewer,
        a.reviewer_type,
        cast(NVL(b.lang_id, 1) AS int) AS lang_id,
        b.title AS title,
        c.review AS review,
        c.review_img_loc AS review_img_loc,
        cast(NVL(c.review_img_width, 0) AS int) AS review_img_width,
        cast(NVL(c.review_img_height, 0) AS int) AS review_img_height,
        d.firstname AS firstname, d.lastname AS lastname, d.nickname AS nickname,
          NVL(e.display_mode, 0) AS display_mode,
        cast(NVL(f.helpful_num, 0) AS INT) AS helpful_num,
        cast(NVL(g.nonhelpful_num, 0) AS INT) AS nonhelpful_num
      FROM
      (
        SELECT a2.* FROM
        (
          SELECT * FROM ya_product_rating
          WHERE review_approved='Y'
          AND reviewer_type = 'WINNER'
          AND sku <> iPsku
        ) a2,
        (
          SELECT a1.sku FROM ya_review_share_group a1, ya_review_share_customerReview c1
          WHERE a1.group_id = (SELECT b1.group_id FROM ya_review_share_group b1 WHERE b1.sku =
            iPsku)
          AND a1.sku = c1.sku
          AND a1.sku <> iPsku
          AND iPget_share = 1
        )b2
        WHERE a2.sku = b2.sku
        UNION
        SELECT * FROM ya_product_rating
        WHERE review_approved='Y'
        AND reviewer_type = 'WINNER'
        AND sku = iPsku
      ) a
      LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
      LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
      (
        SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id OR lang_id = 1)
      ) b,
      (
        SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
      ) c
      LEFT JOIN (
        SELECT review_id, count(*) AS helpful_num FROM ya_review_helpful WHERE review_helpful='Y'
          GROUP BY review_id
      ) f ON c.review_id=f.review_id
      LEFT JOIN (
        SELECT review_id, count(*) AS nonhelpful_num FROM ya_review_helpful WHERE review_helpful='N'
          GROUP BY review_id
      ) g ON c.review_id=g.review_id
      WHERE a.rating_id = b.rating_id
      AND b.us_review_id =  c.review_id
      --AND CASE WHEN @site_id = 1 THEN b.us_review_id WHEN @site_id = 7 THEN b.tw_review_id END =  c.review_id
      AND
      (
        (a.date_posted = dtLlast_date_posted AND a.rating_id <= iLlast_rating_id) OR (a.date_posted <
          dtLlast_date_posted)
      )
      ORDER BY a.date_posted DESC, a.rating_id DESC
    )
    WHERE
      ROWNUM <=
        CASE
          WHEN iProw_num = 0 THEN (ROWNUM + 1)
          ELSE iProw_num
        END;

    RETURN;

  END GetBestReviewsBySku;



  PROCEDURE GetProReviewBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  )
  AS
    dtLlast_date_posted DATE;
    dtLoldest_date_posted DATE;
    iLstart_rec INT;
    iLlast_rating_id INT;
  BEGIN
    SELECT (iPstart_rec + 1) INTO iLstart_rec FROM DUAL;
    dtLoldest_date_posted := to_date('2000-08-01', 'YYYY-MM-DD');

    --get start record

    BEGIN
      SELECT
        NVL(r.date_posted, dtLoldest_date_posted), r.rating_id INTO
        dtLlast_date_posted, iLlast_rating_id
      FROM
      (
        SELECT
          x.date_posted,
          x.rating_id
        FROM
        (
          SELECT a.date_posted, a.rating_id
          FROM
          (
            SELECT a1.* FROM
            (
              SELECT * FROM ya_product_rating WHERE review_approved='Y' AND reviewer_type =
              'EDITORIAL'
            )a1,
            (
              SELECT parent_sku AS sku FROM ya_review_share_proReview WHERE child_sku=iPsku
            )a2
            WHERE a1.sku = a2.sku

            UNION

            SELECT * FROM ya_product_rating WHERE review_approved='Y' AND reviewer_type =
            'EDITORIAL' AND sku=iPsku
          ) a,
          (
            SELECT * FROM ya_prod_rating_lang WHERE lang_id = iPlang_id
          )b,
          (
            SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
          ) c
        WHERE
          a.rating_id = b.rating_id
          AND b.us_review_id  =  c.review_id
          --AND CASE WHEN @site_id = 1 THEN b.us_review_id WHEN @site_id = 7 THEN b.tw_review_id END =  c.review_id
        ORDER BY a.date_posted DESC NULLS LAST, a.rating_id desc
        ) x
        WHERE
          ROWNUM <= iLstart_rec
        ORDER BY
          x.date_posted NULLS LAST, x.rating_id
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO dtLlast_date_posted FROM DUAL;
        SELECT -1 INTO iLlast_rating_id FROM DUAL;
    END;

    -- get final result

    OPEN curPresult FOR
    SELECT *
    FROM
    (
      SELECT
        a.rating_id, c.review_id, a.sku,
        cast(NVL(a.product_rating, 0) AS int) AS product_rating,
        NVL(a.date_posted, dtLoldest_date_posted), a.review_approved,
        a.shopper_id AS shopper_id,
        a.reviewer AS reviewer,
        a.reviewer_type,
        cast(NVL(b.lang_id, 1) AS int) AS lang_id,
        b.title AS title,
        c.review AS review,
        c.review_img_loc AS review_img_loc,
        cast(NVL(c.review_img_width, 0) AS int) AS review_img_width,
        cast(NVL(c.review_img_height, 0) AS int) AS review_img_height,
        d.firstname AS firstname, d.lastname AS lastname, d.nickname AS nickname,
          NVL(e.display_mode, 0) AS display_mode,
        cast(NVL(f.helpful_num, 0) AS INT) AS helpful_num,
        cast(NVL(g.nonhelpful_num, 0) AS INT) AS nonhelpful_num
      FROM
      (
         SELECT a1.* FROM
         (
           SELECT * FROM ya_product_rating WHERE review_approved='Y' AND reviewer_type = 'EDITORIAL'
         )a1,
         (
           SELECT parent_sku as sku FROM ya_review_share_proReview WHERE child_sku=iPsku
         )a2
         WHERE a1.sku = a2.sku

         UNION

         SELECT * FROM ya_product_rating WHERE review_approved='Y' AND reviewer_type = 'EDITORIAL'
         AND sku=iPsku
      ) a
      LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
      LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
      (
        SELECT * FROM ya_prod_rating_lang WHERE lang_id = iPlang_id
      )b,
      (
        SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
      ) c
      LEFT JOIN
      (
        SELECT review_id, count(*) as helpful_num FROM ya_review_helpful WHERE review_helpful='Y'
          GROUP BY review_id
      ) f ON c.review_id=f.review_id
      LEFT JOIN
      (
        SELECT review_id, count(*) as nonhelpful_num FROM ya_review_helpful WHERE review_helpful='N'
          GROUP BY review_id
      ) g ON c.review_id=g.review_id
      WHERE
        a.rating_id = b.rating_id
        AND b.us_review_id  =  c.review_id
        --AND CASE WHEN @site_id = 1 THEN b.us_review_id WHEN @site_id = 7 THEN b.tw_review_id END =  c.review_id
        AND
        (
          (a.date_posted = dtLlast_date_posted AND a.rating_id <= iLlast_rating_id) OR
            (a.date_posted < dtLlast_date_posted) OR
          (dtLlast_date_posted = dtLoldest_date_posted AND a.rating_id <= iLlast_rating_id AND a.date_posted IS NULL)
        )
        ORDER BY a.date_posted DESC NULLS LAST, a.rating_id DESC
    )
    WHERE
      ROWNUM <=
        CASE
          WHEN iProw_num = 0 THEN ROWNUM
          ELSE iProw_num
        END;

    RETURN;
  END GetProReviewBySku;


  PROCEDURE GetReviewById (
    iPreview_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      a.rating_id, c.review_id, a.sku,
      CAST(NVL(a.product_rating, 0) AS int) AS product_rating,
      a.date_posted, a.review_approved,
      a.shopper_id AS shopper_id,
      NVL(a.reviewer, 'Anonymous') AS reviewer,
      a.reviewer_type,
      CAST(NVL(b.lang_id, 1) AS int) AS lang_id,
      b.title AS title,
      c.review AS review,
      c.review_img_loc AS review_img_loc,
      CAST(NVL(c.review_img_width, 0) AS int) AS review_img_width,
      CAST(NVL(c.review_img_height, 0) AS int) AS review_img_height,
      d.firstname AS firstname, d.lastname AS lastname,
      d.nickname AS nickname, NVL(e.display_mode, 0) AS display_mode,
      CAST(NVL(f.helpful_num, 0) AS int) AS helpful_num,
      CAST(NVL(g.nonhelpful_num, 0) AS int) AS nonhelpful_num
    FROM
    (
      SELECT * FROM ya_product_rating WHERE review_approved='Y'
    )a
    LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
    LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
    ya_prod_rating_lang b,
    (
      SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0))) AND review_id = iPreview_id
    ) c
    LEFT JOIN
    (
      SELECT review_id, count(*) AS helpful_num FROM ya_review_helpful WHERE review_helpful='Y' GROUP BY review_id
    ) f ON c.review_id=f.review_id
    LEFT JOIN
    (
      SELECT review_id, count(*) AS nonhelpful_num FROM ya_review_helpful WHERE review_helpful='N' GROUP BY review_id
    ) g ON c.review_id=g.review_id
    WHERE b.rating_id = a.rating_id
    AND b.us_review_id = c.review_id;

    RETURN;
  END GetReviewById;



  PROCEDURE GetReviewCountBySku (
    iPsku IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      a.reviewer_type,
      NVL(b.lang_id, 1) AS  lang_id,
      COUNT(1) AS num
    FROM
      (
        SELECT t1_1.*
        FROM
          (
            SELECT *
            FROM ya_product_rating
            WHERE
              review_approved='Y'
              AND ((reviewer_type = 'USER') OR (reviewer_type = 'WINNER'))
          ) t1_1,
          (
            SELECT a1.sku
            FROM
              ya_review_share_group a1,
              ya_review_share_customerReview c1
            WHERE
              a1.group_id =
                (
                  SELECT b1.group_id
                  FROM ya_review_share_group b1
                  WHERE b1.sku = iPsku
                )
              AND a1.sku = c1.sku
              AND a1.sku <> iPsku
              AND iPget_share = 1
          )t1_2
        WHERE t1_1.sku = t1_2.sku

        UNION

        SELECT *
        FROM ya_product_rating
        WHERE
          review_approved='Y'
          AND ((reviewer_type = 'USER') OR (reviewer_type = 'WINNER'))
          AND sku = iPsku

        UNION

        SELECT t3_1.*
        FROM
          (
            SELECT *
            FROM ya_product_rating
            WHERE
              review_approved='Y'
              AND reviewer_type = 'EDITORIAL'
          )t3_1,
          (
            SELECT a2.parent_sku AS sku
            FROM ya_review_share_proReview a2
            WHERE a2.child_sku = iPsku
          )t3_2
        WHERE t3_1.sku = t3_2.sku

        UNION

        SELECT *
        FROM ya_product_rating
        WHERE
          review_approved='Y'
          AND reviewer_type = 'EDITORIAL'
          AND sku = iPsku
      ) a,
      ya_prod_rating_lang b,
      (
        SELECT *
        FROM ya_review
        WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
      ) c
    WHERE
      a.rating_id=b.rating_id
      AND b.us_review_id = c.review_id
    GROUP BY b.lang_id, a.reviewer_type;
    RETURN;
  END GetReviewCountBySku;



  PROCEDURE GetReviewCountByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      a.reviewer_type,
      NVL(b.lang_id, 1) AS lang_id,
      COUNT(1) AS num
    FROM
      (
        SELECT rating_id, shopper_id, REVIEW_APPROVED, REVIEWER_TYPE, SKU
        FROM ya_product_rating
        WHERE
          review_approved='Y'
          AND shopper_id=cPshopper_id
      ) a,
      ya_prod_rating_lang b,
      (
        SELECT review_id
        FROM ya_review
        WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
      ) c
    WHERE
      a.rating_id=b.rating_id
      AND b.us_review_id = c.review_id
			AND a.sku in (
        SELECT prod_id as productid FROM prod_region WHERE (region_id <> 10 OR origin_id <> 10) AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
			)
    GROUP BY b.lang_id, a.reviewer_type;
    RETURN;
  END GetReviewCountByShopperId;



  PROCEDURE GetHelpfulCountByShopperId (
    cPshopper_id IN CHAR,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      d.review_helpful,
      COUNT(1) AS num
    FROM
      ya_product_rating a,
      ya_prod_rating_lang b,
      ya_review c,
      ya_review_helpful d,
			prod_region h
    WHERE
      a.rating_id = b.rating_id
      AND a.shopper_id = cPshopper_id
      AND b.us_review_id =  c.review_id
      AND c.review_id = d.review_id
			AND a.sku = h.prod_id
			AND h.is_enabled = 'Y' AND (h.region_id <> 10 OR h.origin_id <> 10) AND category_id = 1
    GROUP BY d.review_helpful;
  END GetHelpfulCountByShopperId;


  PROCEDURE InsertSpecialReviewData (
    iPtype_id IN INT,
    nvcPreview_title IN NVARCHAR2,
    nvcPreview_body IN NVARCHAR2,
    nvcPreviewer_name IN NVARCHAR2,
    nvcPreviewer_email IN NVARCHAR2,
    nvcPreviewer_type IN NVARCHAR2,
    ncPreview_approved IN NCHAR,
    iPlang_id IN INT,
    iPreview_id IN OUT INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPreview_id IS NULL OR iPreview_id < 0 THEN
      SELECT SEQ_special_review.nextval INTO iPreview_id FROM dual;
    ELSE
      SELECT SEQ_special_review.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPreview_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_special_review INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_special_review.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_special_review INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO
      ya_special_review
      (
        type_id,
        review_title,
        review_body,
        reviewer_name,
        reviewer_email,
        reviewer_type,
        review_approved,
        lang_id,
        review_id
      )
    VALUES
      (
        iPtype_id,
        nvcPreview_title,
        nvcPreview_body,
        nvcPreviewer_name,
        nvcPreviewer_email,
        nvcPreviewer_type,
        ncPreview_approved,
        iPlang_id,
        iPreview_id
      );

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
      iPreview_id := -1;
    END IF;
  END InsertSpecialReviewData;


PROCEDURE InsertReviewData (
    iPsku IN INT,
    iPrating IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN VARCHAR2,
    cPshopperID IN CHAR,
    cPshopperName IN VARCHAR2,
    iPlangID IN INT,
    cPapproved IN CHAR,
    cPreviewerType IN VARCHAR2,
    iPreview_id IN OUT INT,
    iPrating_id IN OUT INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPreview_id IS NULL OR iPreview_id < 0 THEN
      SELECT SEQ_review.nextval INTO iPreview_id FROM dual;
    ELSE
      SELECT SEQ_review.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPreview_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_review.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_review
      (
        review,
        REVIEW_ID
      )
    VALUES
      (
        cPreview,
        iPreview_id
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    IF iPrating_id IS NULL OR iPrating_id < 0 THEN
      SELECT SEQ_ya_product_rating.nextval INTO iPrating_id FROM DUAL;
    ELSE
      SELECT SEQ_ya_product_rating.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPrating_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
         EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ya_product_rating INCREMENT BY ' || iLseq_diff;
         SELECT SEQ_ya_product_rating.nextval INTO iLseq_currval FROM dual;
         EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ya_product_rating INCREMENT BY 1';
       END IF;
     END IF;

    INSERT INTO ya_product_rating
      (
        sku,
        product_rating,
        date_posted,
        shopper_id,
        review_approved,
        reviewer_type,
        reviewer,
        RATING_ID
      )
    VALUES
      (
        iPsku,
        iPrating,
        SYSDATE,
        cPshopperID,
        cPapproved,
        cPreviewerType,
        cPshopperName,
        iPrating_id
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        RETURN;
      END;
    END IF;

    INSERT INTO ya_prod_rating_lang
      (
        rating_id,
        lang_id,
        title,
        us_review_id,
        jp_review_id,
        hk_review_id,
        tw_review_id,
        preferred_flag
      )
    VALUES
      (
        iPrating_id,
        iPlangID,
        cPtitle,
        iPreview_id,
        iPreview_id,
        iPreview_id,
        iPreview_id,
        'Y'
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    COMMIT;
    RETURN;
  END InsertReviewData;


  PROCEDURE InsertReviewData1 (
    iPsku IN INT,
    iPrating IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN VARCHAR2,
    cPshopperID IN CHAR,
    cPshopperName IN VARCHAR2,
    iPlangID IN INT,
    cPapproved IN CHAR,
    cPreviewerType IN VARCHAR2,
    cPactionType IN VARCHAR2,
    cPremark IN CLOB,
    iPreview_id IN OUT INT,
    iPrating_id IN OUT INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPreview_id IS NULL OR iPreview_id < 0 THEN
      SELECT SEQ_review.nextval INTO iPreview_id FROM dual;
    ELSE
      SELECT SEQ_review.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPreview_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_review.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_review
      (
        review,
        REVIEW_ID
      )
    VALUES
      (
        cPreview,
        iPreview_id
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    IF iPrating_id IS NULL OR iPrating_id < 0 THEN
      SELECT SEQ_ya_product_rating.nextval INTO iPrating_id FROM DUAL;
    ELSE
      SELECT SEQ_ya_product_rating.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPrating_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
         EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ya_product_rating INCREMENT BY ' || iLseq_diff;
         SELECT SEQ_ya_product_rating.nextval INTO iLseq_currval FROM dual;
         EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ya_product_rating INCREMENT BY 1';
       END IF;
     END IF;

    INSERT INTO ya_product_rating
      (
        sku,
        product_rating,
        date_posted,
        shopper_id,
        review_approved,
        reviewer_type,
        reviewer,
        RATING_ID
      )
    VALUES
      (
        iPsku,
        iPrating,
        SYSDATE,
        cPshopperID,
        cPapproved,
        cPreviewerType,
        cPshopperName,
        iPrating_id
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        RETURN;
      END;
    END IF;

    INSERT INTO ya_prod_rating_lang
      (
        rating_id,
        lang_id,
        title,
        us_review_id,
        jp_review_id,
        hk_review_id,
        tw_review_id,
        preferred_flag
      )
    VALUES
      (
        iPrating_id,
        iPlangID,
        cPtitle,
        iPreview_id,
        iPreview_id,
        iPreview_id,
        iPreview_id,
        'Y'
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    If cPapproved <>'N' THEN
      BEGIN
	IF cPapproved ='Y' THEN
	  BEGIN
	    insert into ya_product_review_approve
	    (rating_id, approved_datetime)
	    values (iPrating_id, sysdate)  ;
	  END;
	END IF;
	 insert into ya_review_action_log
	 (rating_id, action_type, remark, updated_datetime)
	  values
	  (iPrating_id, cPactionType , cPremark, sysdate)  ;
      END;
    END IF;

     IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    COMMIT;
    RETURN;
  END InsertReviewData1;

  PROCEDURE InsertReviewData2 (
    iPsku IN INT,
    iPrating IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN CLOB,
    cPshopperID IN CHAR,
    cPshopperName IN VARCHAR2,
    iPlangID IN INT,
    cPapproved IN CHAR,
    cPreviewerType IN VARCHAR2,
    cPactionType IN VARCHAR2,
    cPremark IN CLOB,
    iPreview_id IN OUT INT,
    iPrating_id IN OUT INT,
    cPisCommit IN CHAR DEFAULT 'Y'
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPreview_id IS NULL OR iPreview_id < 0 THEN
      SELECT SEQ_review.nextval INTO iPreview_id FROM dual;
    ELSE
      SELECT SEQ_review.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPreview_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_review.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_review
      (
        review,
        REVIEW_ID
      )
    VALUES
      (
        cPreview,
        iPreview_id
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    IF iPrating_id IS NULL OR iPrating_id < 0 THEN
      SELECT SEQ_ya_product_rating.nextval INTO iPrating_id FROM DUAL;
    ELSE
      SELECT SEQ_ya_product_rating.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPrating_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
         EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ya_product_rating INCREMENT BY ' || iLseq_diff;
         SELECT SEQ_ya_product_rating.nextval INTO iLseq_currval FROM dual;
         EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ya_product_rating INCREMENT BY 1';
       END IF;
     END IF;

    INSERT INTO ya_product_rating
      (
        sku,
        product_rating,
        date_posted,
        shopper_id,
        review_approved,
        reviewer_type,
        reviewer,
        RATING_ID
      )
    VALUES
      (
        iPsku,
        iPrating,
        SYSDATE,
        cPshopperID,
        cPapproved,
        cPreviewerType,
        cPshopperName,
        iPrating_id
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        RETURN;
      END;
    END IF;

    INSERT INTO ya_prod_rating_lang
      (
        rating_id,
        lang_id,
        title,
        us_review_id,
        jp_review_id,
        hk_review_id,
        tw_review_id,
        preferred_flag
      )
    VALUES
      (
        iPrating_id,
        iPlangID,
        cPtitle,
        iPreview_id,
        iPreview_id,
        iPreview_id,
        iPreview_id,
        'Y'
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    IF ((cPapproved <>'Y' OR cPapproved <>'N') AND (cPreviewerType <> 'EDITORIAL' AND cPreviewerType <> 'EDITOR')) THEN
			-- data use in review approval system
			BEGIN
				INSERT INTO ya_review_tmp_newReviewList(review_id, review, rating_id, date_posted, shopper_id, reviewer, title, lang_id)
				VALUES(iPreview_id, cPreview, iPrating_id, SYSDATE, cPshopperID, cPshopperName, cPtitle, iPlangID);
			END;
		END IF;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPrating_id := -1;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    If cPapproved <>'N' THEN
      BEGIN
				IF cPapproved ='Y' THEN
					BEGIN
						insert into ya_product_review_approve(rating_id, approved_datetime)
						values(iPrating_id, sysdate);
					END;
				END IF;
				insert into ya_review_action_log(rating_id, action_type, remark, updated_datetime)
				values(iPrating_id, cPactionType , cPremark, sysdate)  ;
      END;
    END IF;

		IF SQLCODE <> 0 THEN
			BEGIN
				ROLLBACK;
				iPrating_id := -1;
				iPreview_id := -1;
				RETURN;
			END;
		END IF;

    IF cPisCommit = 'Y' THEN
      BEGIN
        COMMIT;
      END;
    END IF;
    RETURN;
  END InsertReviewData2;
  

  PROCEDURE InserHelpfulReviewData (
    iPreview_id IN INT,
    cPshopper_id IN CHAR,
    cPreview_helpful IN CHAR
  )
  AS
  BEGIN
    INSERT INTO ya_review_helpful
      (
        review_id,
        shopper_id,
        review_helpful
      )
    VALUES
      (
        iPreview_id,
        cPshopper_id,
        cPreview_helpful
      );

    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END InserHelpfulReviewData;



  PROCEDURE GetReviewHelpfulState (
    iPreview_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      review_helpful,
      COUNT(1) AS num
    FROM ya_review_helpful
    WHERE
      review_id = iPreview_id
    GROUP BY review_helpful;
    RETURN;
  END GetReviewHelpfulState;



  PROCEDURE IsShopperMarkedHelpful (
    iPreview_id IN INT,
    cPshopper_id IN CHAR,
    iPreturn OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(1)
    INTO iPreturn
    FROM ya_review_helpful
    WHERE
      review_id = iPreview_id
      AND shopper_id = cPshopper_id;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    iPreturn := 0;
  END IsShopperMarkedHelpful;




  PROCEDURE AddReviewReport (
    iPreview_id IN INT,
    iPsku IN INT,
    cPshopper_id IN CHAR,
    iPreason IN INT,
    clobPreport_content IN CLOB,
    iPreturn IN OUT INT
  )
  AS
    iLseq_diff INT;
    iLseq_currval INT;
  BEGIN
    IF iPreturn IS NULL OR iPreturn < 0 THEN
      SELECT SEQ_review_report.nextval INTO iPreturn FROM DUAL;
    ELSE
      SELECT SEQ_review_report.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPreturn - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review_report INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_review_report.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_review_report INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_review_report
      (
        REPORT_ID,
        REVIEW_ID,
        SKU,
        SHOPPER_ID,
        REASON,
        REPORT_CONTENT,
        CREATED_DATETIME
      )
    VALUES
      (
        iPreturn,
        iPreview_id,
        iPsku,
        cPshopper_id,
        iPreason,
        clobPreport_content,
        SYSDATE
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPreturn := 0;
        RETURN;
      END;
    END IF;

    COMMIT;

    RETURN;
  END AddReviewReport;



  PROCEDURE GetTopReviewerMonth (
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      month,
      year
    FROM
      ya_review_topReviewer
    GROUP BY year, month;
    RETURN;
  END GetTopReviewerMonth;



  PROCEDURE GetReviewShareGroupSkus (
    iPsku IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    --IF check sku already belong to a group, return group id
    --ELSE, create group with sku
    OPEN curPresult FOR
    SELECT sku
    FROM
      ya_review_share_group
    WHERE
      group_id IN
      (
        SELECT
          group_id
        FROM
          ya_review_share_group
        WHERE
          sku=iPsku
      );
  END GetReviewShareGroupSkus;

  PROCEDURE SetReviewerName (
    cPshopperId IN CHAR,
    cPfirstname IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPnickname IN VARCHAR2,
    iPdisplayMode IN INT
  )
  AS
    iLtmp INT;
  BEGIN
--    dbms_output.put_line(cPnickname || '*');
    UPDATE ya_shopper
    SET
      firstname = cPfirstname,
      lastname = cPlastname,
      nickname = cPnickname
    WHERE
      shopper_id = cPshopperId;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      RETURN;
    END IF;

    BEGIN
      SELECT 1 INTO iLtmp
      FROM
        ya_review_reviewerName
      WHERE
        shopper_id = cPshopperId;

      EXCEPTION WHEN no_data_found THEN
        iLtmp := -1;
    END;

    IF iLtmp = -1 THEN
      BEGIN
        INSERT INTO ya_review_reviewerName (shopper_id, display_mode)
        VALUES (cPshopperId, iPDisplayMode);
      END;
    ELSE
      BEGIN
        UPDATE ya_review_reviewerName
        SET display_mode=iPdisplayMode
        WHERE shopper_id=cPshopperId;
      END;
    END IF;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;

    RETURN;
  END SetReviewerName;

  PROCEDURE GetReviewerName (
    cPshopperId IN VARCHAR2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      a.shopper_id,
      a.firstname as firstname,
      a.lastname as lastname,
      a.nickname as nickname,
      NVL(b.display_mode,'0') as display_mode
    FROM
      ya_shopper a,
      ya_review_reviewerName b
    WHERE
      a.shopper_id = cPshopperId
      AND a.shopper_id = b.shopper_id (+);
    RETURN;
  END GetReviewerName;

  PROCEDURE GetTopReviewerByMonth (
    iPmonth IN INT,
    iPyear IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      tr.year,
      tr.month,
      s.shopper_id,
      s.firstname,
      s.lastname,
      s.nickname,
      NVL(display_mode, 0) AS display_mode,
      tr.this_month_submitted,
      tr.total_submitted,
      tr.helpful_votes,
      tr.total_helpful_votes
    FROM
      ya_review_topReviewer tr,
      ya_shopper s,
      ya_review_reviewerName rn
    WHERE
      tr.shopper_id = s.shopper_id (+)
      AND s.shopper_id = rn.shopper_id (+)
      AND s.shopper_id = rn.shopper_id (+)
      AND month=iPmonth
      AND year=iPyear;
  END GetTopReviewerByMonth;

PROCEDURE GetBannedPhrases(
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    select phrase, lang_id, risk_level from ya_review_banned_phrase;

    RETURN;
  END GetBannedPhrases;

PROCEDURE UpdateShopperReviewCount (
    iPresult OUT INT
  )
	AS
	BEGIN

		DELETE FROM ya_review_shopper_review_count;

		INSERT INTO ya_review_shopper_review_count(shopper_id, review_count)
			SELECT shopper_id, COUNT(*) FROM ya_product_rating
			WHERE sku > 0
			AND (reviewer_type = 'USER' OR reviewer_type = 'WINNER')
			AND review_approved = 'Y'
			AND shopper_id IS NOT NULL AND LENGTH(TRIM(shopper_id)) = 32
			GROUP BY shopper_id;

			iPresult := 0;

    RETURN;
	END UpdateShopperReviewCount;

PROCEDURE GetShopperReviewCount (
    cPshopper_id IN CHAR,
    iPreview_count OUT INT
  )
	AS
	BEGIN
		SELECT NVL(SUM(review_count), 0) INTO iPreview_count
		FROM ya_review_shopper_review_count
		WHERE shopper_id = cPshopper_id;

		RETURN;
	END GetShopperReviewCount;

	PROCEDURE GetProductShareReviewRating (
    iPsku IN INT,
    iPtotal_rating OUT INT,
    iPnum_review OUT INT
  )
	AS
	BEGIN
		SELECT count(*), NVL(SUM(product_rating), 0) INTO iPnum_review, iPtotal_rating
		FROM
		(
			SELECT a2.*
			FROM
			(
				SELECT *
				FROM ya_product_rating
				WHERE
				review_approved =  'Y'
				AND
				(
					reviewer_type = 'USER' OR reviewer_type = 'WINNER'
				)
				AND sku <> iPsku
			) a2,
			(
				SELECT a1.sku
				FROM ya_review_share_group a1, ya_review_share_customerReview c1
				WHERE
				a1.group_id =
				(
					SELECT b1.group_id
					FROM ya_review_share_group b1
					WHERE	b1.sku = iPsku
				)
				AND a1.sku = c1.sku
				AND a1.sku <> iPsku
			) b2
			WHERE a2.sku = b2.sku
			UNION
			SELECT * FROM ya_product_rating
			WHERE
			review_approved='Y'
			AND
			(
				reviewer_type = 'USER' OR reviewer_type = 'WINNER'
			)
			AND sku = iPsku

		) a,
		(
			SELECT * FROM ya_prod_rating_lang
		) b,
		(
			SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
		)c
		WHERE a.rating_id = b.rating_id
		AND b.us_review_id = c.review_id;

		RETURN;
	END GetProductShareReviewRating;

 PROCEDURE GetReviewsBySkuWithNoLang (
    iPsku IN INT,
    iPsite_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    iPget_best IN INT,
    curPresult OUT refCur
  )
  AS
    dtLlast_date_posted DATE;
    iLstart_rec INT;
    iLlast_rating_id INT;
  BEGIN
    SELECT (iPstart_rec + 1) INTO iLstart_rec FROM DUAL;

    --get start record

    BEGIN
      SELECT
        r.date_posted, r.rating_id INTO
        dtLlast_date_posted, iLlast_rating_id
      FROM
      (
        SELECT
          x.date_posted,
          x.rating_id
        FROM
        (
          SELECT a.date_posted, a.rating_id
          FROM
          (
               SELECT a2.* FROM
                   (
                         SELECT * FROM ya_product_rating
                         WHERE review_approved='Y'
                         AND (reviewer_type = 'USER' OR CASE WHEN iPget_best=1 THEN 'WINNER'  WHEN iPget_best=0 THEN 'dummy' END = reviewer_type)
                         AND sku <> iPsku
                    ) a2,
                    (
                         SELECT a1.sku FROM ya_review_share_group a1, ya_review_share_customerReview c1
                         WHERE a1.group_id = (SELECT b1.group_id FROM ya_review_share_group b1 WHERE b1.sku = iPsku)
                         AND a1.sku = c1.sku
                         AND a1.sku <> iPsku
                         AND iPget_share = 1
                     )b2
               WHERE a2.sku = b2.sku
               UNION
               SELECT * FROM ya_product_rating
               WHERE review_approved='Y'
               AND (reviewer_type = 'USER' OR CASE WHEN iPget_best=1 THEN 'WINNER'  WHEN iPget_best=0 THEN 'dummy' END = reviewer_type)
               AND sku = iPsku
          ) a,
          (
               SELECT * FROM ya_prod_rating_lang --WHERE (lang_id = iPlang_id OR lang_id=1)
          ) b,
          (
               SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
          )c
          WHERE a.rating_id = b.rating_id
          AND b.us_review_id =  c.review_id
          ORDER BY a.date_posted DESC, a.rating_id DESC
        ) x
        WHERE
          ROWNUM <= iLstart_rec
        ORDER BY
          x.date_posted, x.rating_id
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO dtLlast_date_posted FROM DUAL;
        SELECT -1 INTO iLlast_rating_id FROM DUAL;
    END;

    -- get final result

    OPEN curPresult FOR
    SELECT *
    FROM
    (
        SELECT
          a.rating_id, c.review_id, a.sku,
          CAST(NVL(a.product_rating, 0) AS int) as product_rating,
          a.date_posted, a.review_approved,
          a.shopper_id as shopper_id,
          a.reviewer as reviewer,
          a.reviewer_type,
          CAST(NVL(b.lang_id, 1) AS int) as lang_id,
          b.title as title,
          c.review as review,
          c.review_img_loc as review_img_loc,
          CAST(NVL(c.review_img_width, 0) AS int) as review_img_width,
          CAST(NVL(c.review_img_height, 0) AS int) as review_img_height,
          d.firstname as firstname, d.lastname as lastname,
          d.nickname as nickname, NVL(e.display_mode, 0) as display_mode,
          CAST(NVL(f.helpful_num, 0) AS int) as helpful_num,
          CAST(NVL(g.nonhelpful_num, 0) AS int) as nonhelpful_num
        FROM
        (
          SELECT a2.*
          FROM
          (
            SELECT *
            FROM ya_product_rating
            WHERE
              review_approved =  'Y'
              AND
              (
                reviewer_type   =  'USER'
                OR
                  CASE
                    WHEN iPget_best  =  1 THEN 'WINNER'
                    WHEN iPget_best  =  0 THEN 'dummy'
                  END =  reviewer_type
              )
              AND sku <> iPsku
            ) a2,
          (
            SELECT a1.sku
            FROM ya_review_share_group a1, ya_review_share_customerReview c1
            WHERE
              a1.group_id =
              (
                SELECT b1.group_id
                FROM ya_review_share_group b1
                WHERE
                  b1.sku = iPsku
              )
              AND a1.sku          =  c1.sku
              AND a1.sku          <> iPsku
              AND iPget_share     =  1
          ) b2
          WHERE a2.sku = b2.sku
        UNION
          SELECT * FROM ya_product_rating
          WHERE
            review_approved='Y'
            AND
            (
              reviewer_type = 'USER'
              OR
                CASE
                  WHEN iPget_best=1 THEN 'WINNER'
                  WHEN iPget_best=0 THEN 'dummy'
                END = reviewer_type
            )
            AND sku = iPsku
        ) a
        LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
        LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
        (
          SELECT * FROM ya_prod_rating_lang --WHERE (lang_id = iPlang_id OR lang_id=1)
        ) b,
        (
          SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
        )c
        LEFT JOIN
        (
          SELECT review_id, count(*) as helpful_num FROM ya_review_helpful WHERE review_helpful='Y' GROUP BY review_id
        ) f ON c.review_id=f.review_id
        LEFT JOIN
        (
          SELECT review_id, count(*) as nonhelpful_num FROM ya_review_helpful WHERE review_helpful='N' GROUP BY review_id
        ) g ON c.review_id=g.review_id
        WHERE
          a.rating_id = b.rating_id
          AND b.us_review_id = c.review_id
          AND
          (
            (a.date_posted = dtLlast_date_posted AND a.rating_id <= iLlast_rating_id)
            OR (a.date_posted < dtLlast_date_posted)
          )
        ORDER BY a.date_posted desc, a.rating_id desc
    )
    WHERE
      ROWNUM <=
        CASE
          WHEN iProw_num = 0 THEN (ROWNUM + 1)
          ELSE iProw_num
        END;

    RETURN;
  END GetReviewsBySkuWithNoLang;
PROCEDURE GetAllReviewsByShopperID (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    curPresult OUT refCur
  )
  AS
    dtLlast_date_posted DATE;
    iLstart_rec INT;
    iLlast_rating_id INT;
  BEGIN
    SELECT (iPstart_rec + 1) INTO iLstart_rec FROM DUAL;

    --get start record

    BEGIN
      SELECT
        r.date_posted, r.rating_id INTO
        dtLlast_date_posted, iLlast_rating_id
      FROM
      (
        SELECT
          x.date_posted,
          x.rating_id
        FROM
        (
          SELECT
            a.date_posted, a.rating_id
          FROM
            (
              SELECT * FROM ya_product_rating WHERE review_approved='Y'
              AND shopper_id = cPshopper_id
              AND (reviewer_type = 'USER' OR reviewer_type = 'WINNER')
            ) a,
						(
        			SELECT * FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
						) h ,
            (
              SELECT * FROM ya_prod_rating_lang --WHERE lang_id = iPlang_id
            ) b,
            (
              SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
            ) c
          WHERE
            a.rating_id = b.rating_id
            AND b.us_review_id =  c.review_id
						AND a.sku = h.prod_id
          ORDER BY
            a.date_posted DESC , a.rating_id DESC
        ) x
        WHERE
          ROWNUM <= iLstart_rec
        ORDER BY
          x.date_posted, x.rating_id
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO dtLlast_date_posted FROM DUAL;
        SELECT -1 INTO iLlast_rating_id FROM DUAL;
    END;

    -- get final result
    OPEN curPresult FOR
    SELECT *
    FROM
    (
      SELECT
        a.rating_id, c.review_id, a.sku,
        cast(NVL(a.product_rating, 0) AS INT) AS product_rating,
        a.date_posted, a.review_approved,
        a.shopper_id AS shopper_id,
        a.reviewer AS reviewer,
        a.reviewer_type,

        cast(NVL(b.lang_id, 1) AS INT) AS lang_id,
        b.title AS title,
        c.review AS review,

        c.review_img_loc as review_img_loc,
        CAST(NVL(c.review_img_width, 0) AS INT) AS review_img_width,
        CAST(NVL(c.review_img_height, 0) AS INT) AS review_img_height,

        d.firstname AS firstname,
        d.lastname AS lastname,
        d.nickname AS nickname,
        NVL(e.display_mode, 0) AS display_mode,

        CAST(NVL(f.helpful_num, 0) AS INT) AS helpful_num,
        CAST(NVL(g.nonhelpful_num, 0) AS INT) AS nonhelpful_num
      FROM
      (
        SELECT * FROM ya_product_rating WHERE review_approved='Y'
        AND shopper_id = cPshopper_id
        AND (reviewer_type = 'USER' OR reviewer_type = 'WINNER')
      ) a
      LEFT JOIN ya_shopper d ON a.shopper_id=d.shopper_id
      LEFT JOIN ya_review_reviewerName e ON a.shopper_id=e.shopper_id,
			(
        SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
			) h,
			(
        SELECT * FROM ya_prod_rating_lang --WHERE lang_id = iPlang_id
      ) b,
      (
        SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
      ) c
      LEFT JOIN
      (
        SELECT review_id, count(*) as helpful_num
        FROM ya_review_helpful WHERE review_helpful='Y'
        GROUP BY review_id
      ) f ON c.review_id=f.review_id
      LEFT JOIN
      (
        SELECT review_id, count(*) as nonhelpful_num
        FROM ya_review_helpful WHERE review_helpful='N'
        GROUP BY review_id
      ) g ON c.review_id=g.review_id
      WHERE a.rating_id = b.rating_id
      AND b.us_review_id = c.review_id
			AND a.sku = h.productid
      AND
      (
        (a.date_posted = dtLlast_date_posted AND a.rating_id <= iLlast_rating_id) OR
        (a.date_posted < dtLlast_date_posted)
      )
      ORDER BY a.date_posted DESC, a.rating_id DESC
    ) r
    WHERE
      ROWNUM <=
      CASE
        WHEN iProw_num = 0 THEN (ROWNUM + 1)
        ELSE iProw_num
       END;

    RETURN;
  END GetAllReviewsByShopperID;

	-- Editor Review -- BEGIN ---------------------------------------------------------------------------------------------------------------------------------------------
	-- Get Editor Review Count ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE GetEditorReviews (
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
		SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum from
      (
				SELECT
					prodRat.rating_id, rev.review_id, prodRat.sku,
					cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
					prodRat.date_posted, prodRat.review_approved,
					prodRat.shopper_id AS shopper_id,
					prodRat.reviewer AS reviewer,
					prodRat.reviewer_type,
					cast(NVL(prodRatLang.lang_id, 1) AS int) AS lang_id,
					prodRatLang.title AS title,
					rev.review AS review,
					rev.review_img_loc AS review_img_loc,
					cast(NVL(rev.review_img_width, 0) AS int) AS review_img_width,
					cast(NVL(rev.review_img_height, 0) AS int) AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				FROM
				(
					SELECT * FROM ya_product_rating
					WHERE 1=1
					AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
				) prodRat
				LEFT JOIN ya_shopper shopper ON prodRat.shopper_id=shopper.shopper_id
				LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id,
				(
					SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
				) prodRatLang,
				(
					SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
				) rev,
				(
        	SELECT prod_id as productId FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
				) prodReg
				WHERE prodRat.rating_id = prodRatLang.rating_id
				AND prodRatLang.us_review_id = rev.review_id
				AND prodRat.sku = prodReg.productid
				ORDER BY prodRat.date_posted desc
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetEditorReviews;

	PROCEDURE GetEditorReviewsBySku (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPsku IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum from
      (
				SELECT
					prodRat.rating_id, rev.review_id, prodRat.sku,
					cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
					prodRat.date_posted, prodRat.review_approved,
					prodRat.shopper_id AS shopper_id,
					prodRat.reviewer AS reviewer,
					prodRat.reviewer_type,
					cast(NVL(prodRatLang.lang_id, 1) AS int) AS lang_id,
					prodRatLang.title AS title,
					rev.review AS review,
					rev.review_img_loc AS review_img_loc,
					cast(NVL(rev.review_img_width, 0) AS int) AS review_img_width,
					cast(NVL(rev.review_img_height, 0) AS int) AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				FROM
				(
					SELECT * FROM ya_product_rating
					WHERE review_approved='Y'
					AND reviewer_type = 'EDITOR'
					AND sku = iPsku
				) prodRat
				LEFT JOIN ya_shopper shopper ON prodRat.shopper_id=shopper.shopper_id
				LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id,
				(
					SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
				) prodRatLang,
				(
					SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
				) rev,
				(
        	SELECT prod_id as productId FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
				) prodReg
				WHERE prodRat.rating_id = prodRatLang.rating_id
				AND prodRatLang.us_review_id = rev.review_id
				AND prodRat.sku = prodReg.productId
				ORDER BY prodRat.date_posted desc
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetEditorReviewsBySku;

	PROCEDURE GetEditorReviewsByShopperId (
    iPsite_id IN INT,
    iPlang_id IN INT,
		cPshopper_id IN CHAR,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum from
      (
				SELECT
					prodRat.rating_id, rev.review_id, prodRat.sku,
					cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
					prodRat.date_posted, prodRat.review_approved,
					prodRat.shopper_id AS shopper_id,
					prodRat.reviewer AS reviewer,
					prodRat.reviewer_type,
					cast(NVL(prodRatLang.lang_id, 1) AS int) AS lang_id,
					prodRatLang.title AS title,
					rev.review AS review,
					rev.review_img_loc AS review_img_loc,
					cast(NVL(rev.review_img_width, 0) AS int) AS review_img_width,
					cast(NVL(rev.review_img_height, 0) AS int) AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				FROM
				(
					SELECT * FROM ya_product_rating
					WHERE review_approved='Y'
					AND reviewer_type = 'EDITOR'
					AND shopper_id = cPshopper_id
				) prodRat
				LEFT JOIN ya_shopper shopper ON prodRat.shopper_id=shopper.shopper_id
				LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id,
				(
					SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
				) prodRatLang,
				(
					SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
				) rev,
				(
        	SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
				) prodReg
				WHERE prodRat.rating_id = prodRatLang.rating_id
				AND prodRatLang.us_review_id =  rev.review_id
				AND prodRat.sku = prodReg.productId
				ORDER BY prodRat.date_posted desc
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetEditorReviewsByShopperId;

  PROCEDURE GetEditorReviewsByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum from
      (
				SELECT
					prodRat.rating_id, rev.review_id, prodRat.sku,
					cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
					prodRat.date_posted, prodRat.review_approved,
					prodRat.shopper_id AS shopper_id,
					prodRat.reviewer AS reviewer,
					prodRat.reviewer_type,
					cast(NVL(prodRatLang.lang_id, 1) AS int) AS lang_id,
					prodRatLang.title AS title,
					rev.review AS review,
					rev.review_img_loc AS review_img_loc,
					cast(NVL(rev.review_img_width, 0) AS int) AS review_img_width,
					cast(NVL(rev.review_img_height, 0) AS int) AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				FROM
				(
					SELECT m.* FROM ya_product_rating m
					INNER JOIN ya_product n ON m.sku = n.sku AND account_id in (select account_id from ya_emag_prod_line_account where prod_line_id = iPprd_ln_id)
					WHERE 1=1
					AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
				) prodRat
				LEFT JOIN ya_shopper shopper ON prodRat.shopper_id=shopper.shopper_id
				LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id,
				(
					SELECT * FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
				) prodRatLang,
				(
					SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
				) rev,
				(
        	SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
				) prodReg
				WHERE prodRat.rating_id = prodRatLang.rating_id
				AND prodRatLang.us_review_id =  rev.review_id
				AND prodRat.sku = prodReg.productId
				ORDER BY prodRat.date_posted desc
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetEditorReviewsByPrdLn;

	-- Get Editor Review Count ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE GetEditorReviewNumBySku (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPsku IN INT,
    iPresult OUT INT
  )
  AS
  BEGIN
		SELECT COUNT(*) INTO iPresult
		FROM
		(
			SELECT sku, rating_id FROM ya_product_rating
			WHERE 1=1
			AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
			AND sku = iPsku
		) prodRat,
		(
			SELECT rating_id, us_review_id FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
		) prodRatLang,
		(
			SELECT review_id FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
		) rev,
		(
      SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
		) prodReg
		WHERE prodRat.rating_id = prodRatLang.rating_id
		AND prodRatLang.us_review_id =  rev.review_id
		AND prodRat.sku = prodReg.productId;

		RETURN;
  END GetEditorReviewNumBySku;

	PROCEDURE GetEditorReviewNumByShopperId (
    iPsite_id IN INT,
    iPlang_id IN INT,
		cPshopper_id IN CHAR,
    iPresult OUT INT
  )
  AS
  BEGIN
		SELECT COUNT(*) INTO iPresult
		FROM
		(
			SELECT sku, rating_id FROM ya_product_rating
			WHERE 1=1
			AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
			AND shopper_id = cPshopper_id
		) prodRat,
		(
			SELECT rating_id, us_review_id FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
		) prodRatLang,
		(
			SELECT review_id FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
		) rev,
		(
      SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
		) prodReg
		WHERE prodRat.rating_id = prodRatLang.rating_id
		AND prodRatLang.us_review_id = rev.review_id
		AND prodRat.sku = prodReg.productId;

		RETURN;
  END GetEditorReviewNumByShopperId;

	PROCEDURE GetEditorReviewNumByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPresult OUT INT
  )
  AS
  BEGIN
		SELECT COUNT(*) INTO iPresult
		FROM
		(
			SELECT m.sku, m.rating_id FROM ya_product_rating m
			INNER JOIN ya_product n ON m.sku = n.sku AND account_id in (select account_id from ya_emag_prod_line_account where prod_line_id = iPprd_ln_id)
			WHERE 1=1
			AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
		) prodRat,
		(
			SELECT rating_id, us_review_id FROM ya_prod_rating_lang WHERE (lang_id = iPlang_id)
		) prodRatLang,
		(
			SELECT review_id FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
		) rev,
		(
      SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
		) prodReg
		WHERE prodRat.rating_id = prodRatLang.rating_id
		AND prodRatLang.us_review_id = rev.review_id
		AND prodRat.sku = prodReg.productId;

		RETURN;
  END GetEditorReviewNumByPrdLn;

	-- Get Professional Review ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE GetProReviewsBySkus (
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
		iPget_share	IN INT,
    curPresult OUT refCur,
    iPsku1 IN	INT DEFAULT NULL,
    iPsku2 IN	INT DEFAULT NULL,
    iPsku3 IN	INT DEFAULT NULL,
    iPsku4 IN	INT DEFAULT NULL,
    iPsku5 IN	INT DEFAULT NULL,
    iPsku6 IN	INT DEFAULT NULL,
    iPsku7 IN	INT DEFAULT NULL,
    iPsku8 IN	INT DEFAULT NULL,
    iPsku9 IN	INT DEFAULT NULL,
    iPsku10 IN	INT DEFAULT NULL,
    iPsku11 IN	INT DEFAULT NULL,
    iPsku12 IN	INT DEFAULT NULL,
    iPsku13 IN	INT DEFAULT NULL,
    iPsku14 IN	INT DEFAULT NULL,
    iPsku15 IN	INT DEFAULT NULL,
    iPsku16 IN	INT DEFAULT NULL,
    iPsku17 IN	INT DEFAULT NULL,
    iPsku18 IN	INT DEFAULT NULL,
    iPsku19 IN	INT DEFAULT NULL,
    iPsku20 IN	INT DEFAULT NULL
  )
	  AS
    dtLoldest_date_posted DATE;
  BEGIN
    dtLoldest_date_posted := to_date('2000-08-01', 'YYYY-MM-DD');
		OPEN curPresult FOR
    SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum from
      (
				SELECT
					prodRat.rating_id, rev.review_id, prodRat.sku,
					cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
					NVL(prodRat.date_posted, dtLoldest_date_posted), prodRat.review_approved,
					prodRat.shopper_id AS shopper_id,
					prodRat.reviewer AS reviewer,
					prodRat.reviewer_type,
					cast(NVL(prodRatLang.lang_id, 1) AS int) AS lang_id,
					prodRatLang.title AS title,
					rev.review AS review,
					rev.review_img_loc AS review_img_loc,
					cast(NVL(rev.review_img_width, 0) AS int) AS review_img_width,
					cast(NVL(rev.review_img_height, 0) AS int) AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				FROM
				(
					SELECT tmp_prodRat.* FROM ya_product_rating tmp_prodRat, ya_review_share_proReview tmp_prodShare
					WHERE tmp_prodRat.sku = tmp_prodShare.parent_sku
					AND reviewer_type = 'EDITORIAL'
					AND review_approved='Y'
					AND tmp_prodShare.child_sku in (
						iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,
						iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,
						iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,
						iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
					)
					AND iPget_share = 1
					AND NOT EXISTS (SELECT 1 FROM ya_product_title_rel WHERE product_title_child_sku=tmp_prodRat.sku)
					UNION
					SELECT m.* FROM ya_product_rating m
					WHERE m.review_approved='Y'
					AND m.reviewer_type = 'EDITORIAL'
					AND m.sku in (
						iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,
						iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,
						iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,
						iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
					)
					AND NOT EXISTS (SELECT 1 FROM ya_product_title_rel WHERE product_title_child_sku=m.sku)
					UNION
					SELECT n.* FROM ya_product_rating n
					WHERE review_approved='Y'
					AND reviewer_type = 'EDITORIAL'
					AND n.sku IN (SELECT product_title_parent_sku FROM ya_product_title_rel WHERE product_title_child_sku in (
						iPsku1,iPsku2,iPsku3,iPsku4,iPsku5,
						iPsku6,iPsku7,iPsku8,iPsku9,iPsku10,
						iPsku11,iPsku12,iPsku13,iPsku14,iPsku15,
						iPsku16,iPsku17,iPsku18,iPsku19,iPsku20
					))
				) prodRat
				LEFT JOIN ya_shopper shopper ON prodRat.shopper_id=shopper.shopper_id
				LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id,
				(
					SELECT * FROM ya_prod_rating_lang WHERE lang_id = iPlang_id
				)prodRatLang,
				(
					SELECT * FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
				) rev
--				(
--      		SELECT prod_id as productid FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
--				) prodReg
				WHERE	prodRat.rating_id = prodRatLang.rating_id
				AND prodRatLang.us_review_id  =  rev.review_id
--				AND prodRat.sku = prodReg.productId
				ORDER BY prodRat.date_posted desc NULLS LAST
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetProReviewsBySkus;

	PROCEDURE GetProReviewsByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPstart_index IN INT,
    iPnum_record IN INT,
    curPresult OUT refCur
  )
  AS
    dtLoldest_date_posted DATE;
  BEGIN
    dtLoldest_date_posted := to_date('2000-08-01', 'YYYY-MM-DD');
		OPEN curPresult FOR
    SELECT * FROM
    (
      SELECT innerQuery.*, rownum rnum from
      (
				select
					prodRat.rating_id, prodRat.review_id, prodRat.sku,
					cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
					NVL(prodRat.date_posted, dtLoldest_date_posted),
					prodRat.review_approved,
					prodRat.shopper_id AS shopper_id,
					prodRat.reviewer AS reviewer,
					prodRat.reviewer_type,
					cast(NVL(prodRat.lang_id, 1) AS int) AS lang_id,
					prodRat.title AS title,
					prodRat.review AS review,
					prodRat.review_img_loc AS review_img_loc,
					cast(NVL(prodRat.review_img_width, 0) AS int) AS review_img_width,
					cast(NVL(prodRat.review_img_height, 0) AS int) AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				from vw_FE_ReviewAccess prodRat
--				INNER JOIN ya_emag_prod_line_record_limit eplr ON eplr.prod_line_id = iPprd_ln_id
				LEFT JOIN ya_shopper shopper ON prodRat.shopper_id=shopper.shopper_id
				LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id
				WHERE 1=1
				AND prodRat.lang_id = iPlang_id
				AND prodRat.account_id in (select account_id from ya_emag_prod_line_account where prod_line_id = iPprd_ln_id)
--				AND prodRat.sku in (SELECT prod_id as productId FROM prod_region WHERE origin_id = 1 AND region_id = 1 AND category_id = 1 AND is_enabled = 'Y')
--				AND	prodRat.date_posted >= sysdate - eplr.start_date
				ORDER BY prodRat.date_posted desc NULLS LAST
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetProReviewsByPrdLn;

	-- Get Professional Review Count ---------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE GetProReviewNumByPrdLn (
    iPsite_id IN INT,
    iPlang_id IN INT,
		iPprd_ln_id IN INT,
    iPresult OUT INT
  )
  AS
  BEGIN

		select count(1) INTO iPresult
		from vw_FE_ReviewAccess v
--		INNER JOIN ya_emag_prod_line_record_limit eplr ON eplr.prod_line_id = iPprd_ln_id
		WHERE 1=1
		AND v.lang_id = iPlang_id
		AND v.account_id in (select account_id from ya_emag_prod_line_account where prod_line_id = iPprd_ln_id);
--		AND v.sku in (SELECT prod_id FROM prod_region WHERE origin_id = 1 AND region_id = 1 AND category_id = 1 AND is_enabled = 'Y')
--		AND	v.date_posted >= sysdate - eplr.start_date;

		RETURN;
  END GetProReviewNumByPrdLn;

	-- Sku is Editor Pick? ---------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE IsEditorPickProduct (
    iPsite_id IN INT,
		iPsku IN INT,
    curPresult OUT refCur
  )
	AS
  BEGIN
    OPEN curPresult FOR
			SELECT prodRat.sku, prodRatLang.lang_id
			FROM ya_product_rating prodRat
			INNER JOIN ya_prod_rating_lang prodRatLang ON prodRat.rating_id = prodRatLang.rating_id
			INNER JOIN prod_region prodReg ON prodRat.sku = prodReg.prod_id AND prodReg.origin_id = iPsite_id AND prodReg.region_id = iPsite_id AND prodReg.category_id = 1 AND prodReg.is_enabled = 'Y' --AND prodReg.cansell = 'Y'
			WHERE prodRat.reviewer_type = 'EDITOR'
			AND prodRat.sku = iPsku
			GROUP BY prodRat.sku, prodRatLang.lang_id;
  END IsEditorPickProduct;

	PROCEDURE IsEditorPickMultiProduct (
    iPsite_id IN INT,
    curPresult OUT refCur,
    iPsku1 IN	INT DEFAULT NULL,
    iPsku2 IN	INT DEFAULT NULL,
    iPsku3 IN	INT DEFAULT NULL,
    iPsku4 IN	INT DEFAULT NULL,
    iPsku5 IN	INT DEFAULT NULL,
    iPsku6 IN	INT DEFAULT NULL,
    iPsku7 IN	INT DEFAULT NULL,
    iPsku8 IN	INT DEFAULT NULL,
    iPsku9 IN	INT DEFAULT NULL,
    iPsku10 IN	INT DEFAULT NULL,
    iPsku11 IN	INT DEFAULT NULL,
    iPsku12 IN	INT DEFAULT NULL,
    iPsku13 IN	INT DEFAULT NULL,
    iPsku14 IN	INT DEFAULT NULL,
    iPsku15 IN	INT DEFAULT NULL,
    iPsku16 IN	INT DEFAULT NULL,
    iPsku17 IN	INT DEFAULT NULL,
    iPsku18 IN	INT DEFAULT NULL,
    iPsku19 IN	INT DEFAULT NULL,
    iPsku20 IN	INT DEFAULT NULL
  )
	AS
  BEGIN
    OPEN curPresult FOR
			SELECT prodRat.sku, prodRatLang.lang_id
			FROM ya_product_rating prodRat
			INNER JOIN ya_prod_rating_lang prodRatLang ON prodRat.rating_id = prodRatLang.rating_id
			INNER JOIN prod_region prodReg ON prodRat.sku = prodReg.prod_id AND prodReg.origin_id = iPsite_id AND prodReg.region_id = iPsite_id AND prodReg.category_id = 1 AND prodReg.is_enabled = 'Y' --AND prodReg.cansell = 'Y'
			WHERE prodRat.reviewer_type = 'EDITOR'
			AND prodRat.sku IN(
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
					iPsku20
			)
			GROUP BY prodRat.sku, prodRatLang.lang_id;
  END IsEditorPickMultiProduct;

	-- Update Review ---------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE UpdateReview (
		iPrating_id IN INT,
		iPlang_id IN INT,
		cPtitle IN VARCHAR2,
    cPcontent IN CLOB
  )
	AS
    iLreview_id INT;
	BEGIN
		SELECT us_review_id INTO iLreview_id
		FROM ya_prod_rating_lang
		WHERE rating_id = iPrating_id AND lang_id = iPlang_id;

		UPDATE ya_prod_rating_lang
		SET title = cPtitle
		WHERE rating_id = iPrating_id AND lang_id = iPlang_id;

		UPDATE ya_review
		SET review = cPcontent
		WHERE review_id = iLreview_id;

    COMMIT;
		RETURN;
	END UpdateReview;

	PROCEDURE UpdateReviewApproveStatus (
		iPrating_id IN INT,
		cPapprove IN CHAR,
		iProwAffect OUT INT
  )
	AS
		iLrating_count INT;
	BEGIN
		UPDATE ya_product_rating
		SET review_approved = cPapprove
		WHERE rating_id = iPrating_id;

		iProwAffect := sql%rowcount;

		IF cPapprove = 'R' THEN
			SELECT count(*) INTO iLrating_count FROM ya_product_review_approve WHERE rating_id = iPrating_id;
			IF (iLrating_count > 0) THEN
					UPDATE ya_product_review_approve
					SET approved_datetime=SYSDATE() WHERE rating_id=iPrating_id;
			ELSE
				Insert into ya_product_review_approve (rating_id) values (iPrating_id);
			END IF;
		END IF;

		COMMIT;
		RETURN;
	END UpdateReviewApproveStatus;

	-- Spotlight Review -----------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE UpdateSpotlightReview (
		iPrating_id IN INT,
		iProwAffect OUT INT
  )
	AS
	BEGIN
		UPDATE ya_product_rating
		SET reviewer_type = 'WINNER'
		WHERE rating_id = iPrating_id;

		iProwAffect := sql%rowcount;

    COMMIT;
		RETURN;
	END UpdateSpotlightReview;

	PROCEDURE AddExcludeList (
		iPreview_id IN INT
  )
	AS
	BEGIN
		INSERT INTO ya_review_exclude_list(review_id, exclude_for)
		VALUES(iPreview_id, 'S');

    COMMIT;
		RETURN;
	END AddExcludeList;

	PROCEDURE GetPagedSpotlightReviewBySKU (
		iPsku IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
	)
	AS
    -- range of records to extract for the specified page
    iLfrom_id INT;
    iLto_id INT;
	BEGIN
		-- Empty temp table
		EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_spotlight_review_report';

		INSERT INTO temp_spotlight_review_report
		(
			id,
			positive,
			total,
			perc,
			sku,
			prod_name_u,
			date_posted,
			review_id,
			review,
			reviewer,
			shopper_id,
			email,
			rating_id,
			title,
			status,
			lang_id,
			reviewer_type
		)
		SELECT ROWNUM,
		Y, total, perc, sku, prod_name_u, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id, reviewer_type
		FROM
		(
			select
			nvl(summary.Y, 0) as Y, nvl(summary.total, 0) as total, nvl(summary.perc, 0) as perc, pr.sku, pn.prod_name_u, date_posted, r.review_id, review,
			nvl(
				nvl(
					LTrim(
						(
						SELECT
							CASE display_mode
								WHEN 0 THEN s.nickname
								WHEN 1 THEN s.firstname
								WHEN 2 THEN s.firstname || ' ' || s.lastname
								WHEN 3 THEN s.lastname || ' ' || s.firstname
							end
						FROM ya_review_reviewerName rn
						inner join ya_shopper s on rn.shopper_id=s.shopper_id
						WHERE rn.shopper_id=pr.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			pr.shopper_id,s.email,pr.rating_id,prl.title,(case review_approved when 'Y' then 'Approved' end) as status,prl.lang_id,reviewer_type
			from
			(
				select
				rh.review_id,
				sum(case rh.review_helpful when 'Y' then 1 else 0 end) as Y,
				(sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)  ) as total,
				cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int) as perc
				from ya_review_helpful rh
				group by rh.review_id
			)  summary
			right join  ya_review r on summary.review_id =r.review_id
			inner join ya_prod_rating_lang prl on prl.us_review_id=r.review_id
			inner join ya_product_rating pr on pr.rating_id=prl.rating_id
			left join ya_shopper s on s.shopper_id=pr.shopper_id
			inner join ya_prod_lang pn on pn.sku=pr.sku and pn.lang_id=prl.lang_id
			WHERE	review_approved='Y'
			and (reviewer_type='USER' or reviewer_type='WINNER')
			and	r.review_id not in (select review_id from ya_review_exclude_list where exclude_for='S')
			and pr.sku = iPsku
			order by date_posted desc
		) inner_table;

    --Return Total Record count
    SELECT count(1) INTO iPnum_record From temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records

		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM temp_spotlight_review_report order by ID
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetPagedSpotlightReviewBySKU;

	PROCEDURE GetPagedSpotlightReviewByDate (
		iPtotal_vote INT,
		iPpositive_vote INT,
		iPlang_id INT,
		dPstart_date DATE,
		dPend_date DATE,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
	)
	AS
    -- range of records to extract for the specified page
    iLfrom_id INT;
    iLto_id INT;
		iLtmp_table_id INT;
	BEGIN
		-- Empty temp table
		EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_spotlight_review_report';

		INSERT INTO temp_spotlight_review_report
		(
			id,
			positive,
			total,
			perc,
			sku,
			prod_name_u,
			date_posted,
			review_id,
			review,
			reviewer,
			shopper_id,
			email,
			rating_id,
			title,
			status,
			lang_id,
			reviewer_type
		)
		SELECT ROWNUM,
		Y, total, perc, sku, prod_name_u, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id, reviewer_type
		FROM
		(
			select
			nvl(summary.Y, 0) as Y, nvl(summary.total, 0) as total, nvl(summary.perc, 0) as perc, pr.sku, pn.prod_name_u, date_posted, r.review_id, review,
			nvl(
				nvl(
					LTrim(
						(
						SELECT
							CASE display_mode
								WHEN 0 THEN s.nickname
								WHEN 1 THEN s.firstname
								WHEN 2 THEN s.firstname || ' ' || s.lastname
								WHEN 3 THEN s.lastname || ' ' || s.firstname
							end
						FROM ya_review_reviewerName rn
						inner join ya_shopper s on rn.shopper_id=s.shopper_id
						WHERE rn.shopper_id=pr.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			pr.shopper_id,s.email,pr.rating_id,prl.title,(case review_approved when 'Y' then 'Approved' end) as status,prl.lang_id,reviewer_type
			from
			(
				select
				rh.review_id,
				sum(case rh.review_helpful when 'Y' then 1 else 0 end) as Y,
				(sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)  ) as total,
				cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int) as perc
				from ya_review_helpful rh
				group by rh.review_id
			)  summary
			right join ya_review r on summary.review_id = r.review_id
			inner join ya_prod_rating_lang prl on prl.us_review_id=r.review_id
			inner join ya_product_rating pr on pr.rating_id=prl.rating_id
			left join ya_shopper s on s.shopper_id=pr.shopper_id
			inner join ya_prod_lang pn on pn.sku=pr.sku and pn.lang_id=prl.lang_id
			WHERE	review_approved='Y'
			and (pn.lang_id = iPlang_id OR iPlang_id = 0)
			and (reviewer_type='USER')-- or reviewer_type='WINNER')
			and  r.review_id in(
				select review_id
				from ya_review_helpful rh
				group by review_id
				having sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)>=iPtotal_vote
				and	cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int)>=iPpositive_vote
			)
			and	(pr.date_posted >= dPstart_date AND pr.date_posted <= dPend_date)
			and	r.review_id not in (select review_id from ya_review_exclude_list where exclude_for='S')
			order by date_posted desc
		) inner_table;

		SELECT COUNT(*) INTO iLtmp_table_id FROM temp_spotlight_review_report;

		INSERT INTO temp_spotlight_review_report
		(
			id,
			positive,
			total,
			perc,
			sku,
			prod_name_u,
			date_posted,
			review_id,
			review,
			reviewer,
			shopper_id,
			email,
			rating_id,
			title,
			status,
			lang_id
		)
		SELECT iLtmp_table_id + ROWNUM,
		Y, total, perc, sku, prod_name_u, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id
		FROM
		(
			select
			nvl(summary.Y, 0) as Y, nvl(summary.total, 0) as total, nvl(summary.perc, 0) as perc, pr.sku, pn.prod_name_u, date_posted, r.review_id, review,
			nvl(ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname)), 'Anonymous') as reivewer,
			pr.shopper_id,s.email,pr.rating_id,prl.title,(case review_approved when 'Y' then 'Approved' end) as status,prl.lang_id
			from
			(
				select
				rh.review_id,
				sum(case rh.review_helpful when 'Y' then 1 else 0 end) as Y,
				(sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)  ) as total,
				cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int) as perc
				from ya_review_helpful rh
				group by rh.review_id
			)  summary
			left join ya_review r on summary.review_id = r.review_id
			inner join ya_prod_rating_lang prl on prl.us_review_id=r.review_id
			inner join ya_product_rating pr on pr.rating_id=prl.rating_id
			left join ya_shopper s on s.shopper_id=pr.shopper_id
			inner join ya_prod_lang pn on pn.sku=pr.sku and pn.lang_id=prl.lang_id
			WHERE review_approved='Y'
			and prl.lang_id=iPlang_id
			and reviewer_type='USER'
			and r.review_id in
			(
				select review_id
				from ya_review_helpful rh
				group by review_id
				having sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)>=iPtotal_vote
				and cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int)>=iPpositive_vote
			)
	--		and	(convert(varchar2,pr.date_posted,112) <= convert(varchar2,dPend_date,112) AND convert(varchar2,pr.date_posted,112)>= convert(varchar2,dPstart_date,112))
			and	(pr.date_posted >= dPstart_date AND pr.date_posted <= dPend_date)
			and	r.review_id not in (select review_id from ya_review_exclude_list where exclude_for='S')
			order by date_posted desc
		) inner_table;

    --Return Total Record count
    SELECT count(1) INTO iPnum_record From temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

    -- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM temp_spotlight_review_report
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetPagedSpotlightReviewByDate;

	-- Report This -----------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE GetReviewReportByReviewId (
		iPreview_id IN INT,
    curPresult OUT refCur
  )
	AS
	BEGIN
		OPEN curPresult	FOR
			select
			trim(
				nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname)
			) as reporter,
			s.email, rr.report_id, rr.shopper_id, rr.reason, rr.report_content, rr.created_datetime, rr.updated_datetime
			FROM ya_review_report rr
			left join ya_shopper s on (s.shopper_id=rr.shopper_id)
			where	rr.review_id = iPreview_id
			order by created_datetime desc;

		RETURN;
	END GetReviewReportByReviewId;

	PROCEDURE DeleteReviewReport (
		iPreport_id IN INT,
		iProwAffect OUT INT
  )
	AS
	BEGIN
		delete from ya_review_report where report_id = iPreport_id;
		iProwAffect := sql%rowcount;

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
		END IF;

		RETURN;
	END DeleteReviewReport;

	PROCEDURE AddReviewActionLog (
		iPrating_id IN INT,
		iPaction_type IN VARCHAR2,
		iPremark IN NVARCHAR2
  )
	AS
	BEGIN
		INSERT INTO ya_review_action_log
		(
			rating_id,
			action_type,
			remark,
			updated_datetime
		)
		VALUES
		(
			iPrating_id,
			iPaction_type,
			iPremark,
			SYSDATE()
		);
	END AddReviewActionLog;

	PROCEDURE AddReviewApprove (
		iPrating_id IN INT
  )
	AS
	BEGIN

		UPDATE ya_product_review_approve SET approved_datetime = SYSDATE()
		WHERE rating_id = iPrating_id;

	END AddReviewApprove;

	PROCEDURE GetReviewReportByReportCount (
		iPreport_count IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
		curPresult OUT refCur
  )
	AS
    -- range of records to extract for the specified page
    iLfrom_id INT;
    iLto_id INT;
	BEGIN
		-- Empty temp table
		EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_spotlight_review_report';

    INSERT INTO temp_spotlight_review_report
    (
			id,
--			positive,
--			total,
--			perc,
			sku,
			prod_name_u,
			date_posted,
			review_id,
			review,
			reviewer,
			shopper_id,
			email,
			rating_id,
			title,
			status,
			lang_id
    )
		SELECT ROWNUM,
    sku, prod_name_u, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id--, reviewer_type
		FROM
		(
			select
			pr.sku, pn.prod_name_u, date_posted, r.review_id, review,
			nvl(
				nvl(
					LTrim(
						(
						SELECT
							CASE display_mode
								WHEN 0 THEN s.nickname
								WHEN 1 THEN s.firstname
								WHEN 2 THEN s.firstname || ' ' || s.lastname
								WHEN 3 THEN s.lastname || ' ' || s.firstname
							end
						FROM ya_review_reviewerName rn
						inner join ya_shopper s on rn.shopper_id=s.shopper_id
						WHERE rn.shopper_id=pr.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			pr.shopper_id,s.email,pr.rating_id,prl.title,(case review_approved when 'Y' then 'Approved' end) as status,prl.lang_id
			FROM ya_product_rating pr
			inner join ya_prod_rating_lang prl ON (pr.rating_id = prl.rating_id)
			inner join ya_review r ON (r.review_id = prl.us_review_id)
			left join ya_shopper s ON (s.shopper_id=pr.shopper_id)
			inner join ya_prod_lang pn ON pn.sku=pr.sku and pn.lang_id=prl.lang_id
			WHERE	review_approved='Y'
			and (reviewer_type='USER' or reviewer_type='WINNER')
			and r.review_id in (select review_id from ya_review_report group by review_id having count(review_id) >= iPreport_count)
			order by date_posted desc
		) inner_table;

	  --Return Total Record count
    SELECT count(1) INTO iPnum_record From temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM temp_spotlight_review_report order by ID
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetReviewReportByReportCount;

	PROCEDURE GetReviewReportBySKU (
		iPsku IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
  )
	AS
    -- range of records to extract for the specified page
    iLfrom_id INT;
    iLto_id INT;
	BEGIN
		-- Empty temp table
		EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_spotlight_review_report';

    INSERT INTO temp_spotlight_review_report
    (
			id,
--			positive,
--			total,
--			perc,
			sku,
			prod_name_u,
			date_posted,
			review_id,
			review,
			reviewer,
			shopper_id,
			email,
			rating_id,
			title,
			status,
			lang_id
		)
		SELECT ROWNUM,
    sku, prod_name_u, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id--, reviewer_type
		FROM
		(
			select
			pr.sku, pn.prod_name_u, date_posted, r.review_id, review,
			nvl(
				nvl(
					LTrim(
						(
						SELECT
							CASE display_mode
								WHEN 0 THEN s.nickname
								WHEN 1 THEN s.firstname
								WHEN 2 THEN s.firstname || ' ' || s.lastname
								WHEN 3 THEN s.lastname || ' ' || s.firstname
							end
						FROM ya_review_reviewerName rn
						inner join ya_shopper s on rn.shopper_id=s.shopper_id
						WHERE rn.shopper_id=pr.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			pr.shopper_id,s.email,pr.rating_id,prl.title,(case review_approved when 'Y' then 'Approved' end) as status,prl.lang_id
			FROM ya_product_rating pr
			inner join ya_prod_rating_lang prl ON (pr.rating_id = prl.rating_id)
			inner join ya_review r ON (r.review_id = prl.us_review_id)
			left join ya_shopper s ON (s.shopper_id=pr.shopper_id)
			inner join ya_prod_lang pn ON pn.sku=pr.sku and pn.lang_id=prl.lang_id
			WHERE	review_approved='Y'
			and (reviewer_type='USER' or reviewer_type='WINNER')
			and r.review_id in (
				select distinct us_review_id from ya_product_rating pr inner join ya_prod_rating_lang prl on pr.rating_id=prl.rating_id where pr.sku = iPsku
			)
			order by date_posted desc
		) inner_table;

	  --Return Total Record count
    SELECT count(1) INTO iPnum_record From temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM temp_spotlight_review_report order by ID
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetReviewReportBySKU;

	PROCEDURE GetReviewReportByDateRange (
		iPlang_id IN INT,
		dPstart_date IN DATE,
		dPend_date IN DATE,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
    curPresult OUT refCur
  )
	AS
    -- range of records to extract for the specified page
    iLfrom_id INT;
    iLto_id INT;
	BEGIN
		-- Empty temp table
		EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_spotlight_review_report';

    INSERT INTO temp_spotlight_review_report
    (
			id,
--			positive,
--			total,
--			perc,
			sku,
			prod_name_u,
			date_posted,
			review_id,
			review,
			reviewer,
			shopper_id,
			email,
			rating_id,
			title,
			status,
			lang_id
    )
		SELECT ROWNUM,
    sku, prod_name_u, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id--, reviewer_type
		FROM
		(
			select
			pr.sku, pn.prod_name_u, date_posted, r.review_id, review,
			nvl(
				nvl(
					LTrim(
						(
						SELECT
							CASE display_mode
								WHEN 0 THEN s.nickname
								WHEN 1 THEN s.firstname
								WHEN 2 THEN s.firstname || ' ' || s.lastname
								WHEN 3 THEN s.lastname || ' ' || s.firstname
							end
						FROM ya_review_reviewerName rn
						inner join ya_shopper s on rn.shopper_id=s.shopper_id
						WHERE rn.shopper_id=pr.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			pr.shopper_id,s.email,pr.rating_id,prl.title,(case review_approved when 'Y' then 'Approved' end) as status,prl.lang_id
			FROM ya_product_rating pr
			inner join ya_prod_rating_lang prl ON (pr.rating_id = prl.rating_id)
			inner join ya_review r ON (r.review_id = prl.us_review_id)
			left join ya_shopper s ON (s.shopper_id=pr.shopper_id)
			inner join ya_prod_lang pn ON pn.sku=pr.sku and pn.lang_id=prl.lang_id
			WHERE	review_approved='Y'
			and (pn.lang_id=iPlang_id OR iPlang_id = 0)
			and (reviewer_type='USER' or reviewer_type='WINNER')
			and r.review_id in (
				select distinct review_id from ya_review_report rr
				where (rr.created_datetime >= dPstart_date AND rr.created_datetime <= dPend_date)
			)
			order by date_posted desc
		) inner_table;

	  --Return Total Record count
    SELECT count(1) INTO iPnum_record From temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM temp_spotlight_review_report order by ID
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetReviewReportByDateRange;

	-- Review Approval -- Start -----------------------------------------------------------------------------------------------------------------------------------------------
	/* proc_fe_review_getReviewKey */
	PROCEDURE GetReviewKey (
		curPresult OUT refCur
  )
	AS
		dLcutoff_date date;
		dLlastcreated_date date;
		iLrating_count INT;
	BEGIN
		dLcutoff_date := SYSDATE - 1;
		dLlastcreated_date := dLcutoff_date;

		SELECT COUNT(*) INTO iLrating_count FROM ya_review_approval_system_key;

		IF (iLrating_count > 0) THEN
			select created_date INTO dLlastcreated_date
			from ya_review_approval_system_key
			WHERE ROWNUM<=1
			order by date_posted desc;
		END IF;

		--print dLcutoff_date;
		--print dLlastcreated_date;

		IF (dLlastcreated_date - dLcutoff_date < 0)  THEN
			dLcutoff_date := dLlastcreated_date - 1;
		END IF;

		--print dLcutoff_date;

		OPEN curPresult FOR
			select review_id, rating_id, review_key, date_posted
			from ya_review_approval_system_key
			WHERE date_posted >= dLcutoff_date;

		RETURN;
	END GetReviewKey;

	/* proc_fe_getNewReview */
	PROCEDURE GetNewReview (
		curPresult OUT refCur
  )
	AS
	BEGIN
		OPEN curPresult FOR
			select
			a.review_id as reviewId,  --0
			nvl(a.review, ' ') as content,
			a.lang_id as langId,
			nvl(a.title, ' ') as title,
			a.rating_id as ratingId,  --4
			a.date_posted as datePosted,
			nvl(a.shopper_id, ' ') as shopperId,
			nvl(a.reviewer, ' ') as reviewerName
			from ya_review_tmp_newReviewList a
			/*
			inner join ya_product_rating b on a.rating_id = b.rating_id
			where review_approved ='N'
			*/
			WHERE rownum <=512;

			RETURN;
	END GetNewReview;

	/* proc_fe_getNewReviewCount */
	PROCEDURE GetNewReviewCount (
		curPresult OUT refCur
  )
	AS
	BEGIN
		-- same logic as proc_fe_getNewReview
		-- return the number of reviews which haven't been processed yet,
		-- instead of reviews
		OPEN curPresult FOR
			select count(*)	from ya_review_tmp_newReviewList;
			/*
			inner join ya_product_rating b on a.rating_id = b.rating_id
			where review_approved ='N'
			*/

		RETURN;
	END GetNewReviewCount;

	/* proc_fe_review_deleteReviewApprovalSystemKey */
	PROCEDURE DeleteReviewApprovalSystemKey
	AS
	BEGIN
		DELETE FROM ya_review_approval_system_key;

		IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
		ELSE
			BEGIN
	      COMMIT;
			END;
    END IF;
    RETURN;
	END DeleteReviewApprovalSystemKey;

	/* proc_fe_review_addReviewApprovalSystemKey */
	PROCEDURE AddReviewApprovalSystemKey (
		iPrreview_id IN INT,
		iPrating_id IN INT,
		cPreview_key IN NCLOB,
		dPdate_posted IN DATE
  )
	AS
	BEGIN
    INSERT INTO ya_review_approval_system_key(review_id, rating_id, review_key, date_posted)
    VALUES(iPrreview_id, iPrating_id, cPreview_key, dPdate_posted);

		IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
		ELSE
			BEGIN
	      COMMIT;
			END;
    END IF;
    RETURN;
	END AddReviewApprovalSystemKey;

	/* proc_fe_updateReviewStatus */
	PROCEDURE UpdateReviewStatus (
		iPrating_id IN INT,
		cPstatus IN CHAR,
		cPaction_type IN VARCHAR2,
		cPremark IN NVARCHAR2
  )
	AS
		iLrating_count INT;
	BEGIN
		UPDATE ya_product_rating
		SET review_approved = cPstatus
		WHERE rating_id = iPrating_id;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
    END IF;

		IF (cPstatus = 'Y') THEN
			SELECT COUNT(*) INTO iLrating_count FROM ya_product_review_approve WHERE rating_id = iPrating_id;
			IF (iLrating_count <= 0) THEN
				INSERT INTO ya_product_review_approve(rating_id, approved_datetime)
				VALUES(iPrating_id, SYSDATE);
			END IF;
		END IF;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
    END IF;

		select COUNT(*) INTO iLrating_count from ya_review_action_log where rating_id = iPrating_id;
		IF (iLrating_count <= 0) THEN
			insert into ya_review_action_log(rating_id, action_type, remark, updated_datetime)
			values(iPrating_id, cPaction_type, cPremark, SYSDATE);
		else
			select COUNT(*) INTO iLrating_count from ya_review_action_log where rating_id = iPrating_id;
			if (iLrating_count > 1)  THEN
				update ya_review_action_log
				set action_type = cPaction_type,
				remark = cPremark,
				updated_datetime = SYSDATE
				where rating_id = iPrating_id
				and action_type= 'Instant Review Approval System';
			else
				update ya_review_action_log
				set action_type = cPaction_type,
				remark = cPremark,
				updated_datetime = SYSDATE
				where rating_id = iPrating_id;
			END IF;
		END IF;

		delete from ya_review_tmp_newReviewList where rating_id = iPrating_id;

		IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
		ELSE
			BEGIN
	      COMMIT;
	      RETURN;
			END;
    END IF;
	END UpdateReviewStatus;

	-- Review Approval -- END -----------------------------------------------------------------------------------------------------------------------------------------------

END Pkg_FE_ReviewAccess;
/
 
REM END SS_ADM PKG_FE_REVIEWACCESS
