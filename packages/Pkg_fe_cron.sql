CREATE OR REPLACE PACKAGE Pkg_fe_cron -- fe "cronjobs"
AS
  PROCEDURE summarize_associate_hits;
  PROCEDURE cleanup_shopper_and_basket;
  --PROCEDURE review_genTopReviewer;
END Pkg_fe_cron;
/

CREATE OR REPLACE PACKAGE body Pkg_fe_cron
AS

--#########################################################################--
  PROCEDURE summarize_associate_hits
  AS
  BEGIN
	  /* Take a temp_assoc_hit_snapshot of raw hits that
       are going to be summarized */

	  EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_assoc_hit_snapshot';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_assoc_hit_summary';

	  INSERT INTO  temp_assoc_hit_snapshot
			( link_id ,
			hit_datetime )
	  SELECT
			t1.link_id,
			t1.hit_datetime
	  FROM  ya_associate_hits_raw t1
	  WHERE	TO_DATE(TO_CHAR(t1.hit_datetime, 'YYYY/MM/DD'), 'YYYY/MM/DD') <=
      TO_DATE(TO_CHAR((SYSDATE), 'Mon DD YYYY HH:MIAM'), 'Mon DD YYYY HH:MIAM');

		INSERT INTO  temp_assoc_hit_summary
			( link_id ,
			hit_day ,
			hits )
		SELECT
			t1.link_id,
			TO_DATE(TO_CHAR(t1.hit_datetime, 'YYYY/MM/DD'), 'YYYY/MM/DD'),
			COUNT(t1.link_id)
		FROM  temp_assoc_hit_snapshot t1
		GROUP BY t1.link_id,
			  TO_DATE(TO_CHAR(t1.hit_datetime, 'YYYY/MM/DD'), 'YYYY/MM/DD');

		/* Update counts if statistics already exists for the
      particular date */
    UPDATE
    (
      SELECT t1.hits AS temp_hits, t2.hits AS curr_hits
      FROM
        temp_assoc_hit_summary t1,
        ya_associate_hits_summary t2
      WHERE t1.link_id = t2.link_id
      AND t1.hit_day = t2.hit_day
    )
    SET curr_hits = temp_hits + curr_hits;

		/* Insert statistics */
    INSERT INTO  ya_associate_hits_summary
		  ( link_id ,
			hit_day ,
			hits )
		SELECT
			t1.link_id,
			t1.hit_day,
			t1.hits
		FROM  temp_assoc_hit_summary t1
		WHERE	 NOT   EXISTS
			(
		 	SELECT 'True'
			FROM  ya_associate_hits_summary t2
			WHERE	t1.link_id  = t2.link_id
			 AND	t2.hit_day  = t1.hit_day
			);
		DELETE
		FROM  ya_associate_hits_raw t1
		WHERE    EXISTS
			(
		 	SELECT 'True'
			FROM  temp_assoc_hit_snapshot t2
			WHERE	t1.link_id  = t2.link_id
			 AND	t1.hit_datetime  = t2.hit_datetime
			);
    COMMIT;

    --EXCEPTION
      --when others THEN
        --ROLLBACK;
  END summarize_associate_hits;

--#########################################################################--
/*
  PROCEDURE review_genTopReviewer
  AS
-------------------+= declaration =+-----------------------------------------
    dtLstartDate                  DATE;
    dtLendDate                    DATE;
    cLshopper_id                  CHAR(32);
    iLcounter                     INT;
    iLtotalreviewcount            INT;
    iLtotalhelpfulcount           INT;
    fLtotalscore                  FLOAT;
    iLtotalsubmitted              INT;
    iLtotalvotes                  INT;
    iLerrVal                      INT;

    --get all shopper within 3 motnhs
		CURSOR  cur_shopper_id
		  IS
        SELECT DISTINCT pr.shopper_id
        FROM  ya_product_rating pr,
           ya_prod_rating_lang prl
        WHERE	 pr.rating_id  = prl.rating_id
         AND	((pr.reviewer_type  = 'USER')
         AND	(pr.review_approved  = 'Y')
         AND	(pr.shopper_id  <> 'ANONYMOUS')
         AND	(TO_CHAR(pr.date_posted, 'YYYYMMDD')  <= TO_CHAR(dtLstartDate, 'YYYYMMDD')
         AND	TO_CHAR(pr.date_posted, 'YYYYMMDD')  >= TO_CHAR(dtLendDate, 'YYYYMMDD')))
        GROUP BY pr.shopper_id, pr.reviewer;

  	CURSOR  cur_top_reviewer_id
      IS
        SELECT shopper_id
          FROM
          (
            SELECT shopper_id
            FROM  temp_gen_top_reviewer_reviewer
            ORDER BY total_score DESC
          )WHERE ROWNUM < 31;
------------------------+= main =+-------------------------------
    BEGIN

      EXECUTE IMMEDIATE ' TRUNCATE TABLE temp_gen_top_reviewer_reviewer ' ;

      SELECT SYSDATE INTO dtLstartDate FROM DUAL;
      SELECT ADD_MONTHS(SYSDATE,- 3)  INTO dtLendDate FROM DUAL;
      iLcounter := 1;

      OPEN cur_shopper_id;
      FETCH cur_shopper_id INTO cLshopper_id;
      WHILE (cur_shopper_id%FOUND)
      LOOP
        -- print 'shopper_id=' + @shopper_id
        -- get review_id of that shopper
        -- put all review ID into a temp table

        EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_gen_top_reviewer_reviewID';

        --fill the temp table with all the products
        INSERT INTO  temp_gen_top_reviewer_reviewID ( review_id )
            SELECT prl.us_review_id
            FROM  ya_product_rating pr,
               ya_prod_rating_lang prl
            WHERE	 pr.rating_id  = prl.rating_id
             AND	((pr.reviewer_type  = 'USER')
             AND	(pr.review_approved  = 'Y')
             AND	(pr.shopper_id  <> 'ANONYMOUS')
             AND	(TO_CHAR(pr.date_posted, 'YYYYMMDD')  <= TO_CHAR(dtLstartDate, 'YYYYMMDD')
             AND	TO_CHAR(pr.date_posted, 'YYYYMMDD')  >= TO_CHAR(dtLendDate, 'YYYYMMDD'))
             AND	shopper_id  = cLshopper_id)
            ORDER BY pr.date_posted DESC;

        BEGIN
          SELECT COUNT(*) INTO iLtotalreviewcount FROM ya_review
          WHERE	 review_id  in
            (
            SELECT review_id
            FROM  temp_gen_top_reviewer_reviewID
            );
          EXCEPTION
            WHEN no_data_found THEN
              iLtotalreviewcount := 0;
        END;

        BEGIN
          SELECT COUNT(*) INTO iLtotalhelpfulcount FROM ya_review_helpful
          WHERE	 review_id  in
            (
            SELECT review_id
            FROM  temp_gen_top_reviewer_reviewID
            );
          EXCEPTION
            WHEN no_data_found THEN
              iLtotalhelpfulcount := 0;
        END;

        BEGIN
          SELECT (NVL(SUM(Y) * SUM("Y/Y+N") / COUNT(*), 0) * LOG(10, iLtotalreviewcount + 2))
            as total_score INTO fLtotalscore
          FROM (	SELECT
                 review_id,
                 SUM(case review_helpful
                     when 'Y'  then 1
                     else 0
                     end) as Y,
                 SUM(case review_helpful
                     when 'N'  then 1
                     else 0
                     end) as N,
                 CAST(SUM(case review_helpful
                     when 'Y'  then 1
                     else 0
                     end) as decimal) / (
                       SUM(case review_helpful
                           when 'Y'  then 1
                           else 0
                           end) +
                       SUM(case review_helpful
                           when 'N'  then 1
                           else 0
                           end)) as "Y/Y+N"
            FROM  ya_review_helpful
            WHERE	 review_id  in
              (
              SELECT review_id
              FROM  temp_gen_top_reviewer_reviewID
              )
            GROUP BY  review_id
          ) a;

          EXCEPTION
            WHEN no_data_found THEN
              fLtotalscore := 0;
        END;
  --print @totalscore
        INSERT INTO  temp_gen_top_reviewer_reviewer
          ( shopper_id ,
          total_score ,
          submitted_this_month ,
          helpful_votes )
        SELECT
           cLshopper_id,
           fLtotalScore,
           iLtotalreviewcount,
           iLtotalhelpfulcount
        FROM DUAL;

        FETCH  cur_shopper_id INTO cLshopper_id;

        iLcounter := iLcounter + 1;
        IF (MOD(iLcounter, 50) = 0 ) THEN
          dbms_lock.sleep(10);
        END IF;
      END LOOP;
      CLOSE cur_shopper_id;

      iLcounter := 1;
      OPEN cur_top_reviewer_id;
      FETCH cur_top_reviewer_id INTO cLshopper_id;
      WHILE (cur_top_reviewer_id%FOUND)
      LOOP
        BEGIN
          SELECT COUNT(*) INTO iLtotalsubmitted
          FROM  ya_product_rating
          WHERE	shopper_id  = cLshopper_id
           AND	review_approved  = 'Y';
          EXCEPTION
            WHEN no_data_found THEN
              iLtotalsubmitted := 0;
        END;

        BEGIN
          SELECT COUNT(*) INTO iLtotalvotes
          FROM  ya_review_helpful
          WHERE	 review_id  in
            (
            SELECT prl.us_review_id
            FROM  ya_product_rating pr,
               ya_prod_rating_lang prl
            WHERE	 pr.rating_id  = prl.rating_id
             AND	((pr.reviewer_type  = 'USER')
             AND	(pr.review_approved  = 'Y')
             AND	pr.shopper_id  = cLshopper_id)
            );
          EXCEPTION
            WHEN no_data_found THEN
              iLtotalvotes := 0;
        END;

  --print 'shopper_id= ' + @shopper_id
  --print @totalsubmitted
  --print @totalvotes

  --update temp table values
          UPDATE  temp_gen_top_reviewer_reviewer
          SET	total_submitted = iLtotalsubmitted,
              total_votes = iLtotalvotes
          WHERE  shopper_id  = cLshopper_id;

          FETCH cur_top_reviewer_id INTO cLshopper_id;

          iLcounter := iLcounter + 1;
          IF ( MOD(iLcounter, 50) = 0) THEN
            dbMs_lock.sleep(10);
          END IF;

      END LOOP;
      CLOSE cur_top_reviewer_id;

    INSERT INTO  ya_review_topReviewer
        ( month ,
        year ,
        shopper_id ,
        this_month_submitted ,
        total_submitted ,
        helpful_votes ,
        total_helpful_votes )
    SELECT *
     FROM
    (SELECT
         TO_NUMBER(TO_CHAR((SYSDATE), 'MM')),
         TO_NUMBER(TO_CHAR((SYSDATE), 'YYYY')),
         shopper_id,
         submitted_this_month,
         total_submitted,
         helpful_votes,
         total_votes
    FROM  temp_gen_top_reviewer_reviewer

    ORDER BY total_score DESC
    )WHERE ROWNUM < 31;

    COMMIT;

    --EXCEPTION
    --  WHEN others THEN
    --    ROLLBACK;
  END review_genTopReviewer;
  */
  PROCEDURE cleanup_shopper_and_basket
  AS
  BEGIN
    --DELETE basket
    DELETE FROM
      ya_new_basket
    WHERE
      shopper_id NOT IN (
        SELECT shopper_id FROM ya_shopper
      );

    --delete anonymous shopper
     DELETE FROM
       ya_shopper
     WHERE anonymous = 'Y'
       AND created_date <= (SYSDATE - 30);

    COMMIT;

    --EXCEPTION
    --  WHEN others THEN
    --    ROLLBACK;
  END cleanup_shopper_and_basket;
END Pkg_fe_cron;
/

