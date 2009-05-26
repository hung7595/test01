REM START SS_ADM PKG_FE_REVIEWACCESS

CREATE OR REPLACE PACKAGE "PKG_FE_REVIEWACCESS"
AS
  TYPE refCur IS REF CURSOR;

	PROCEDURE GetReviewReportByReviewId (
		iPreview_id IN INT,
    curPresult OUT refCur
  );

	PROCEDURE DeleteReviewReport (
		iPreport_id IN INT,
		iProwAffect OUT INT
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
  
  PROCEDURE AddExcludeList (
		iPreview_id IN INT
  );
  
	PROCEDURE UpdateCustomerReviewWinner (
		iPreview_id IN INT,
		iProwAffect OUT INT
  );

	PROCEDURE GetPagedSpotlightReviewBySKU (
		iPsku IN INT,
		iPpage_number IN INT,
		iPpage_size IN INT,
		iPnum_record OUT INT,
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

	PROCEDURE UpdateEditorReview (
		iPreview_id IN INT,
		cPtitle IN VARCHAR2,
    cPcontent IN CLOB
  );
  
	PROCEDURE DeleteEditorReview (
	  iPreview_id IN INT
	);
	  
	PROCEDURE UpdateCustomerReviewApprove (
		iPreview_id IN INT,
		cPapprove IN CHAR,
		iProwAffect OUT INT
  );

  PROCEDURE InsertProfessionalReview (
    iPsku IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN CLOB,
    iPlangID IN INT,
    iPreview_id IN OUT INT,
    cPisCommit IN CHAR DEFAULT 'Y'
  );
  
	PROCEDURE GetEditorReviewSkuList (
    iPsite_id IN INT,
    curPresult OUT refCur
  );  

  PROCEDURE GetProReviewBySku (
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPstart_rec IN INT,
    iProw_num IN INT,
    iPget_share IN INT,
    curPresult OUT refCur
  );
  
END Pkg_FE_ReviewAccess;
/
CREATE OR REPLACE PACKAGE BODY "PKG_FE_REVIEWACCESS" 
IS

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
  BEGIN
    OPEN curPresult FOR
    SELECT -1 as rating_id, pa.id as review_id, pa.sku,
    0 as product_rating,
    prl.date_posted, 'Y' as review_approved,
    '' as shopper_id,
    '' as reviewer,
    'EDITORIAL' as reviewer_type,
    prl.lang_id,
    '' as title,
    prl.review,
    '' as review_img_loc,
    0 as review_img_width,
    0 as review_img_height,
    '' as firstname, '' as lastname, '' as nickname,
    0 as displaymode,
    0 as helpful_num,
    0 as nonhelpful_num
    FROM ya_profess_review pa
      INNER JOIN ya_profess_review_lang prl ON pa.id = prl.profess_review_id
    WHERE pa.sku = iPsku
      OR pa.sku IN (SELECT 1 from ya_product_title_rel where product_title_child_sku = sku)
      OR pa.sku IN (SELECT product_title_parent_sku from ya_product_title_rel where product_title_child_sku = iPsku)
      OR pa.sku IN (SELECT parent_sku AS sku FROM ya_review_share_proReview WHERE child_sku=iPsku AND not exists (SELECT 1 from ya_product_title_rel where product_title_child_sku = parent_sku));
    RETURN;
  END GetProReviewBySku;

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
		EXECUTE IMMEDIATE 'TRUNCATE TABLE ss_adm.temp_spotlight_review_report';

    INSERT INTO ss_adm.temp_spotlight_review_report
    (
			id,
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
    sku, prod_name, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id--, reviewer_type
		FROM
		(
			select
			r.sku, pn.prod_name, r.date_posted, r.id as review_id, r.review,
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
						WHERE rn.shopper_id=r.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			r.shopper_id, s.email, -1 as rating_id, r.title,(case review_approved when 'Y' then 'Approved' end) as status, r.lang_id
			FROM ya_customer_review r
			  left join ya_shopper s ON (s.shopper_id=r.shopper_id)
			  inner join ya_prod_lang pn ON pn.sku=r.sku and pn.lang_id=r.lang_id
			WHERE	r.review_approved='Y'
			  and r.id in (select review_id from ya_review_report group by review_id having count(review_id) >= iPreport_count)
			order by date_posted desc
		) inner_table;

	  --Return Total Record count
    SELECT count(1) INTO iPnum_record From ss_adm.temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM ss_adm.temp_spotlight_review_report order by ID
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
		EXECUTE IMMEDIATE 'TRUNCATE TABLE ss_adm.temp_spotlight_review_report';

    INSERT INTO ss_adm.temp_spotlight_review_report
    (
			id,
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
    sku, prod_name, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id--, reviewer_type
		FROM
		(
			select
			r.sku, pn.prod_name, r.date_posted, r.id as review_id, r.review,
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
						WHERE rn.shopper_id=r.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			r.shopper_id,s.email,-1 as rating_id,r.title,(case review_approved when 'Y' then 'Approved' end) as status,r.lang_id
			FROM ya_customer_review r
			  left join ya_shopper s ON (s.shopper_id=r.shopper_id)
			  inner join ya_prod_lang pn ON pn.sku=r.sku and pn.lang_id=r.lang_id
			WHERE	r.review_approved='Y'
			  and r.sku = iPsku
			order by r.date_posted desc
		) inner_table;

	  --Return Total Record count
    SELECT count(1) INTO iPnum_record From ss_adm.temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM ss_adm.temp_spotlight_review_report order by ID
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
		EXECUTE IMMEDIATE 'TRUNCATE TABLE ss_adm.temp_spotlight_review_report';

    INSERT INTO ss_adm.temp_spotlight_review_report
    (
			id,
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
    sku, prod_name, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id--, reviewer_type
		FROM
		(
			select
			cr.sku, pn.prod_name, cr.date_posted, cr.id as review_id, cr.review,
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
						WHERE rn.shopper_id=cr.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			cr.shopper_id,s.email,-1 as rating_id,cr.title,(case review_approved when 'Y' then 'Approved' end) as status,cr.lang_id
			FROM ya_customer_review cr
			  left join ya_shopper s ON (s.shopper_id=cr.shopper_id)
			  inner join ya_prod_lang pn ON pn.sku=cr.sku and pn.lang_id=cr.lang_id
			WHERE	cr.review_approved='Y'
			  and (pn.lang_id=iPlang_id OR iPlang_id = 0)
			  and cr.id in (
				  select distinct review_id from ya_review_report rr
				  where (rr.created_datetime >= dPstart_date AND rr.created_datetime <= dPend_date)
			  )
			order by cr.date_posted desc
		) inner_table;

	  --Return Total Record count
    SELECT count(1) INTO iPnum_record From ss_adm.temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records
		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM ss_adm.temp_spotlight_review_report order by ID
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetReviewReportByDateRange;

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

	PROCEDURE UpdateCustomerReviewWinner (
		iPreview_id IN INT,
		iProwAffect OUT INT
  )
	AS
	BEGIN
	  
		UPDATE ya_customer_review
		  SET reviewer_type = 2
		WHERE id = iPreview_id;

		iProwAffect := sql%rowcount;

    COMMIT;
		RETURN;
	END UpdateCustomerReviewWinner;

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
		EXECUTE IMMEDIATE 'TRUNCATE TABLE ss_adm.temp_spotlight_review_report';

		INSERT INTO ss_adm.temp_spotlight_review_report
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
		Y, total, perc, sku, prod_name, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id, reviewer_type
		FROM
		(
			select
			nvl(summary.Y, 0) as Y, nvl(summary.total, 0) as total, nvl(summary.perc, 0) as perc, r.sku, pn.prod_name, r.date_posted, r.id as review_id, r.review,
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
						WHERE rn.shopper_id=r.shopper_id)
					),
					ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname))
				), 'Anonymous'
			) as reivewer,
			r.shopper_id,s.email,-1 as rating_id,r.title,(case review_approved when 'Y' then 'Approved' end) as status,r.lang_id,r.reviewer_type
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
			  inner join ya_customer_review r on summary.review_id = r.id
			  left join ya_shopper s on s.shopper_id=r.shopper_id
			  inner join ya_prod_lang pn on pn.sku=r.sku and pn.lang_id=r.lang_id
			WHERE	r.id not in (select review_id from ya_review_exclude_list where exclude_for='S')
  			and r.sku = iPsku
			order by date_posted desc
		) inner_table;

    --Return Total Record count
    SELECT count(1) INTO iPnum_record From ss_adm.temp_spotlight_review_report;

    -- calculate the first and last ID of the range of topics we need
		iLfrom_id := ((iPpage_number - 1) * iPpage_size) + 1;
    iLto_id := iPpage_number * iPpage_size;

		-- select the page of records

		OPEN curPresult	FOR
			SELECT * FROM
			(
				SELECT innerQuery.*, rownum AS rnum
				from(
					SELECT * FROM ss_adm.temp_spotlight_review_report order by ID
				) innerQuery
				WHERE ROWNUM <= iLto_id
			)
			WHERE rnum >= iLfrom_id;

    COMMIT;
		RETURN;
	END GetPagedSpotlightReviewBySKU;

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
					-1 as rating_id, prodRat.id as review_id, prodRat.sku,
					0 AS product_rating,
					prodRat.date_posted, 'Y' as review_approved,
					prodRat.shopper_id AS shopper_id,
					'EDITOR' AS reviewer,
					'EDITOR' AS reviewer_type,
					prodRat.lang_id AS lang_id,
					prodRat.title AS title,
					prodRat.review AS review,
					null AS review_img_loc,
					0 AS review_img_width,
					0 AS review_img_height,
					shopper.firstname AS firstname, shopper.lastname AS lastname, shopper.nickname AS nickname,
					NVL(revName.display_mode, 0) AS display_mode
				FROM ya_editor_note prodRat
				  LEFT JOIN ya_shopper shopper ON prodRat.shopper_id = shopper.shopper_id
				  LEFT JOIN ya_review_reviewerName revName ON prodRat.shopper_id=revName.shopper_id
				  INNER JOIN
				    (
        	    SELECT prod_id as productId FROM prod_region WHERE region_id = iPsite_id AND origin_id = iPsite_id AND category_id = 1 AND is_enabled = 'Y'
				    ) prodReg ON prodRat.sku = prodReg.productId
				WHERE prodRat.sku = iPsku
				  AND prodRat.lang_id = iPlang_id
				ORDER BY prodRat.date_posted desc
      ) innerQuery
      WHERE ROWNUM < (iPstart_index + iPnum_record + 1)
    )
    WHERE rnum > iPstart_index;

    RETURN;
  END GetEditorReviewsBySku;

	PROCEDURE UpdateEditorReview (
		iPreview_id IN INT,
		cPtitle IN VARCHAR2,
    cPcontent IN CLOB
  )
	AS
	BEGIN
	  UPDATE ya_editor_note
	    SET title = cPtitle,
	    review = cPcontent
	  WHERE id = iPreview_id;

    COMMIT;
		RETURN;
	END UpdateEditorReview;
	
	PROCEDURE DeleteEditorReview (
	  iPreview_id IN INT
	)
	AS
	BEGIN
	  DELETE FROM ya_editor_note WHERE id = iPreview_id;
	  COMMIT;
	END DeleteEditorReview;
	
	PROCEDURE UpdateCustomerReviewApprove (
		iPreview_id IN INT,
		cPapprove IN CHAR,
		iProwAffect OUT INT
  )
	AS
		iLrating_count INT;
	BEGIN
    UPDATE ya_customer_review SET review_approved = cPapprove
    WHERE id = iPreview_id;
    
		COMMIT;
		RETURN;
	END UpdateCustomerReviewApprove;

  PROCEDURE InsertProfessionalReview (
    iPsku IN INT,
    cPtitle IN VARCHAR2,
    cPreview IN CLOB,
    iPlangID IN INT,
    iPreview_id IN OUT INT,
    cPisCommit IN CHAR DEFAULT 'Y'
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    SELECT SEQ_PROFESS_REVIEW.nextval INTO iPreview_id FROM dual;

    INSERT INTO ya_profess_review
    (
      ID,
      SKU
    )
    VALUES
    (
      iPreview_id,
      iPsku
    );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        iPreview_id := -1;
        RETURN;
      END;
    END IF;

    INSERT INTO ya_profess_review_lang
      (
        profess_review_id,
        date_posted,
        lang_id,
        review,
        mod_dt
      )
    VALUES
      (
        iPreview_id,
        SYSDATE,
        iPlangID,
        cPreview,
        SYSDATE
      );

    IF cPisCommit = 'Y' THEN
      BEGIN
        COMMIT;
      END;
    END IF;
    RETURN;
  END InsertProfessionalReview;	

	PROCEDURE GetEditorReviewSkuList (
    iPsite_id IN INT,
    curPresult OUT refCur
  )
	AS
	BEGIN
    OPEN curPresult FOR
			SELECT sku, lang_id
			FROM ya_emag_editor_review_prod
			WHERE site_id = iPsite_id;
	END GetEditorReviewSkuList;  
END Pkg_FE_ReviewAccess;
/