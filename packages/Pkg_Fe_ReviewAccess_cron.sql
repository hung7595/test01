
REM START SS_ADM PKG_FE_REVIEWACCESS_CRON

  CREATE OR REPLACE PACKAGE "PKG_FE_REVIEWACCESS_CRON" 
AS
  TYPE refCur IS REF CURSOR;

	PROCEDURE GetEditorReviewNumBySku (
		iProwAffect OUT INT
  );

END Pkg_Fe_ReviewAccess_cron;
/
CREATE OR REPLACE PACKAGE BODY PKG_FE_REVIEWACCESS_CRON
IS
	PROCEDURE GetEditorReviewNumBySku (
		iProwAffect OUT INT
	)
  AS
  BEGIN
		INSERT INTO ya_emag_editor_review_prod(sku, site_id, lang_id)
		SELECT prodRat.sku, prodReg.originId, prodRatLang.lang_id
		FROM
		(
			SELECT sku, rating_id FROM ya_product_rating
			WHERE 1=1
			AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
		) prodRat,
		(
			SELECT rating_id, us_review_id, lang_id FROM ya_prod_rating_lang
		) prodRatLang,
		(
			SELECT review_id FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
		) rev,
		(
			SELECT prod_id as productid, origin_id as originid FROM prod_region WHERE origin_id = region_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
		) prodReg
		WHERE prodRat.rating_id = prodRatLang.rating_id
		AND prodRatLang.us_review_id =  rev.review_id
		AND prodRat.sku = prodReg.productId
		and not exists(
			select * from ya_emag_editor_review_prod eerp where eerp.sku = prodRat.sku and eerp.site_id = prodReg.originId and eerp.lang_id = prodRatLang.lang_id
		)
		group by prodRat.sku, prodReg.originId, prodRatLang.lang_id;

		iProwAffect := sql%rowcount;

		COMMIT;
    RETURN;
  END GetEditorReviewNumBySku;

END Pkg_Fe_ReviewAccess_cron;
/
 
REM END SS_ADM PKG_FE_REVIEWACCESS_CRON
