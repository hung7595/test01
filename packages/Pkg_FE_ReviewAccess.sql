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
		iPsite_id IN INT,
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
		iPsite_id IN INT,
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

  PROCEDURE GetShareGroupBySku (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	);
	
	PROCEDURE GetProReviewsByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	);
	
  PROCEDURE GetProdCustomerReview (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	);

	PROCEDURE GetProdRelByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur	
	);
	
	PROCEDURE GetProdByShareGroup (
	  iPgroup_id IN INT,
	  iPlang_id IN INT,
	  curPresult OUT refCur
	);
	
	PROCEDURE AddProdToShareGroup (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	);
	
	PROCEDURE DeleteProdFrmShareGroup (
	  iPsku IN INT
	);
	
	PROCEDURE AddShareGroupByMemberSku (
	  iPsku IN INT,
	  iPgroup_member_sku IN INT,
	  iPgroup_id OUT INT
	);
	
	PROCEDURE DeleteProReviewShareByGroupId (
	  iPgroup_id IN INT
	);
	
  PROCEDURE AddShareProReview (
	  iPparent_sku IN INT,
	  iPchild_sku IN INT
	);
	
	PROCEDURE DeleteCustReviewShareByGroupId (
	  iPgroup_id IN INT
	);
	
	PROCEDURE AddShareCustomerReview (
	  iPsku IN INT
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
      INNER JOIN ya_profess_review_lang prl ON pa.id = prl.profess_review_id and prl.lang_id = iPlang_id
    WHERE pa.sku IN (
      SELECT iPsku FROM dual
      UNION
      SELECT product_title_parent_sku
      from ya_product_title_rel
      where product_title_child_sku = iPsku
      and not exists (select 1 from ya_profess_review where sku = product_title_child_sku)
      );

--      OR EXISTS (SELECT 1 from ya_product_title_rel where product_title_child_sku = pa.sku)
--      OR pa.sku IN (SELECT product_title_parent_sku from ya_product_title_rel where product_title_child_sku = iPsku)
--      OR pa.sku IN (SELECT parent_sku AS sku FROM ya_review_share_proReview WHERE child_sku=iPsku AND not exists (SELECT 1 from ya_product_title_rel where product_title_child_sku = parent_sku))

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
		iPsite_id IN INT,		
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
							CASE rn.display_mode
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
			  and ((iPsite_id in (1,7) and r.site_id in (1,7)) or r.site_id = iPsite_id)
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
							CASE rn.display_mode
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
		iPsite_id IN INT,
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
							CASE rn.display_mode
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
        and ((iPsite_id in (1,7) and cr.site_id in (1,7)) 
              or cr.site_id = iPsite_id
              or (iPsite_id in (10,11,13,14,15,18) and cr.site_id in (10,11,13,14,15,18)))		
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
		  SET reviewer_type = 2, mod_dt = sysdate, mod_user = 'fe_review_mgt'
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
							CASE rn.display_mode
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
			r.shopper_id,s.email,-1 as rating_id,r.title,(case review_approved when 'Y' then 'Approved' else 'Rejected' end) as status,r.lang_id,r.reviewer_type
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
			  right outer join ya_customer_review r on summary.review_id = r.id
			  left outer join ya_shopper s on s.shopper_id=r.shopper_id
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
							CASE rn.display_mode
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
			r.shopper_id,s.email,-1 as rating_id,r.title,(case r.review_approved when 'Y' then 'Approved' else 'Rejected' end) as status,r.lang_id,r.reviewer_type
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
			  right outer join ya_customer_review r on summary.review_id = r.id
			  left outer join ya_shopper s on s.shopper_id=r.shopper_id
			  inner join ya_prod_lang pn on pn.sku=r.sku and pn.lang_id=r.lang_id
			WHERE	r.review_approved='Y'
			  and (pn.lang_id = iPlang_id OR iPlang_id = 0)
			  and r.reviewer_type=1 -- user
			  and  r.id in(
				  select review_id
				  from ya_review_helpful rh
				  group by review_id
				  having sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)>=iPtotal_vote
				  and	cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int)>=iPpositive_vote
			  )
			  and	(r.date_posted >= dPstart_date AND r.date_posted <= dPend_date)
			  and	r.id not in (select review_id from ya_review_exclude_list where exclude_for='S')
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
		Y, total, perc, sku, prod_name, date_posted, review_id, review,
		reivewer, shopper_id, email, rating_id, title, status, lang_id
		FROM
		(
			select
			nvl(summary.Y, 0) as Y, nvl(summary.total, 0) as total, nvl(summary.perc, 0) as perc, r.sku, pn.prod_name, date_posted, r.id as review_id, r.review,
			nvl(ltrim(nvl((case nickname when '' then firstname || ' ' || lastname else nickname end), firstname || ' ' || lastname)), 'Anonymous') as reivewer,
			r.shopper_id,s.email,-1 as rating_id,r.title,(case r.review_approved when 'Y' then 'Approved' end) as status,r.lang_id
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
			  left outer join ya_customer_review r on summary.review_id = r.id
			  left outer join ya_shopper s on s.shopper_id=r.shopper_id
			  inner join ya_prod_lang pn on pn.sku=r.sku and pn.lang_id=r.lang_id
			WHERE r.review_approved='Y'
			  and r.lang_id=iPlang_id
			  and r.reviewer_type=1 --user
			  and r.id in
			  (
				  select review_id
				  from ya_review_helpful rh
				  group by review_id
				  having sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)>=iPtotal_vote
				  and cast(round(sum(case rh.review_helpful when 'Y' then 1 else 0 end) / cast((sum(case rh.review_helpful when 'Y' then 1 else 0 end) + sum(case rh.review_helpful when 'N' then 1 else 0 end)) as float) * 100,0) as int)>=iPpositive_vote
			  )
			  and	(r.date_posted >= dPstart_date AND r.date_posted <= dPend_date)
			  and	r.id not in (select review_id from ya_review_exclude_list where exclude_for='S')
			order by r.date_posted desc
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
    UPDATE ya_customer_review SET review_approved = cPapprove, mod_dt = sysdate, mod_user = 'fe_review_mgt'
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
	
	PROCEDURE GetShareGroupBySku (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	)
	AS
	BEGIN
    BEGIN
      SELECT group_id INTO iPgroup_id
      FROM ya_review_share_group
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPgroup_id := 0;
          RETURN;
        END;
    END;	
	END GetShareGroupBySku;
	
	PROCEDURE GetProReviewsByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	)
	AS
	BEGIN
    OPEN curPresult FOR
    SELECT rsg.sku, tp.lang_id, tp.review, tp.reviewer, tp.us_review_id, tp.tw_review_id, tp.reviewer_type, rsg.updated_user, rsg.updated_dt
    FROM ya_review_share_group rsg
    LEFT OUTER JOIN (
      select a.sku, b.lang_id, b.review, '' reviewer, a.id us_review_id, a.id tw_review_id, 'EDITORIAL' reviewer_type
      from ya_review_share_group d
        left outer join ya_profess_review a on a.sku = d.sku
        left outer join ya_profess_review_lang b on a.id = b.profess_review_id
      where b.review is not null and d.group_id = iPgroup_id	
    ) tp on rsg.sku = tp.sku
    WHERE rsg.group_id = iPgroup_id
    ORDER BY rsg.sku, tp.lang_id;
	END GetProReviewsByGroupId;	
	
	PROCEDURE GetProdCustomerReview (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	)
	AS
	BEGIN
	  OPEN curPresult FOR
	  SELECT rsg.sku, rsc.sku, rsg.updated_user, rsg.updated_dt
    FROM ya_review_share_group rsg
      LEFT OUTER JOIN ya_review_share_customerReview rsc ON rsc.sku = rsg.sku
    WHERE rsg.group_id = iPgroup_id;
	END GetProdCustomerReview;
	
	PROCEDURE GetProdRelByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur	
	)
	AS
	BEGIN
	  OPEN curPresult FOR
    SELECT parent_sku, child_sku
    FROM ya_review_share_proReview ysp, ya_review_share_group rsg, ya_review_share_group rsg2
    WHERE rsg.sku = ysp.parent_sku
      AND rsg2.sku = ysp.child_sku
      AND rsg.group_id = iPgroup_id
      AND rsg2.group_id = iPgroup_id;
	END GetProdRelByGroupId;
	
	PROCEDURE GetProdByShareGroup (
	  iPgroup_id IN INT,
	  iPlang_id IN INT,
	  curPresult OUT refCur
	)
	AS
	BEGIN
	  OPEN curPresult FOR
    SELECT pl.sku, pl.prod_name
    FROM ya_prod_lang pl, ya_review_share_group rsg
    WHERE pl.sku = rsg.sku
      AND rsg.group_id = iPgroup_id
      AND lang_id=iPlang_id
    ORDER BY pl.sku;
	END GetProdByShareGroup;
	
	PROCEDURE AddProdToShareGroup (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	)
	AS
	  iLexist INT;
	BEGIN
	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_product
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPgroup_id := 0;
          RETURN;
        END;
    END;

	  BEGIN
      SELECT group_id INTO iPgroup_id
      FROM ya_review_share_group
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
	        SELECT SEQ_ya_review_share_group.nextval INTO iPgroup_id FROM dual;
	        	
          INSERT INTO ya_review_share_group (group_id, sku, updated_dt, updated_user)
          VALUES (iPgroup_id, iPsku, sysdate, 'system');

          INSERT INTO ya_review_share_customerreview (sku) VALUES (iPsku);
          COMMIT;
          RETURN;
        END;
    END;
	END AddProdToShareGroup;
	
	PROCEDURE DeleteProdFrmShareGroup (
	  iPsku IN INT
	)
	AS
	  iLexist INT;
	BEGIN
    DELETE FROM ya_review_share_proReview where parent_sku = iPsku or child_sku = iPsku;
    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;

    DELETE FROM ya_review_share_group where sku = iPsku AND updated_user = 'system';
    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;

    DELETE FROM ya_review_share_customerReview WHERE sku = iPsku 
      AND NOT EXISTS (SELECT 1 FROM ya_review_share_group WHERE sku = iPsku);
    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    ELSE
      BEGIN
        COMMIT;
      END;
    END IF;
	END DeleteProdFrmShareGroup;
	
	PROCEDURE AddShareGroupByMemberSku (
	  iPsku IN INT,
	  iPgroup_member_sku IN INT,
	  iPgroup_id OUT INT
	)
	AS
	  iLexist INT;
	BEGIN
	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_product
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPgroup_id := 0;
          RETURN;
        END;
    END;

	  BEGIN
      SELECT group_id INTO iPgroup_id
      FROM ya_review_share_group
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          INSERT INTO ya_review_share_group (group_id, sku, updated_dt, updated_user)
          SELECT group_id, iPsku, sysdate, 'system'
          FROM ya_review_share_group
          WHERE sku = iPgroup_member_sku
            AND rownum = 1;

          SELECT group_id INTO iPgroup_id
          FROM ya_review_share_group
          WHERE sku = iPsku;
        END;
    END;

	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_review_share_customerreview
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          INSERT INTO ya_review_share_customerreview (sku) VALUES (iPsku);
          COMMIT;
          RETURN;
        END;
    END;
	END AddShareGroupByMemberSku;
	
	PROCEDURE DeleteProReviewShareByGroupId (
	  iPgroup_id IN INT
	)
	AS
	BEGIN
    DELETE FROM ya_review_share_proReview
    WHERE parent_sku in (SELECT sku FROM ya_review_share_group where group_id = iPgroup_id and updated_user = 'system')
      OR parent_sku in (SELECT sku FROM ya_review_share_group where group_id = iPgroup_id and updated_user = 'system');
    COMMIT;
	END DeleteProReviewShareByGroupId;
	
	PROCEDURE AddShareProReview (
	  iPparent_sku IN INT,
	  iPchild_sku IN INT
	)
	AS
	BEGIN
    INSERT INTO ya_review_share_proReview (parent_sku, child_sku)
    VALUES (iPparent_sku, iPchild_sku);
    COMMIT;
	END AddShareProReview;
	
	PROCEDURE DeleteCustReviewShareByGroupId (
	  iPgroup_id IN INT
	)
	AS
	BEGIN
    DELETE FROM ya_review_share_customerReview
    WHERE sku in (SELECT sku FROM ya_review_share_group where group_id = iPgroup_id and updated_user = 'system');
    COMMIT;
	END DeleteCustReviewShareByGroupId;

	PROCEDURE AddShareCustomerReview (
	  iPsku IN INT
	)
	AS
	  iLexist INT;
	BEGIN
	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_review_share_customerreview
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          INSERT INTO ya_review_share_customerreview (sku) VALUES (iPsku);
          COMMIT;
          RETURN;
        END;
    END;	
	END AddShareCustomerReview;	
END Pkg_FE_ReviewAccess;
/