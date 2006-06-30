CREATE OR REPLACE PACKAGE Pkg_FE_ContentAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE GetPopChart (
    iPfile_id IN INT,
    curPresult OUT curG
  );

  PROCEDURE GetPopChart_Mirror (
    iPfile_id IN INT,
    curPresult OUT curG
  );

  PROCEDURE GetImageLot (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetImageLot_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetTextLot (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetTextLot_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetTopSellersCount (
    iPdept_id IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetWeeklyPoll (
    iPlangId IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  );

  PROCEDURE VoteWeeklyPoll (
    iPpollId IN INT,
    iPanswer IN INT
  );

  PROCEDURE GetContentPageId (
    iPsiteId IN INT,
    iPcontainerId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetSurveyInformation (
    iPsurveyId IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  );

  PROCEDURE AddSurveyRecord (
    iPsiteId IN INT,
    iPsurveyId IN INT,
    cPemail IN VARCHAR2,
    cPshopperId IN CHAR,
    cPchoiceCsv IN VARCHAR2,
    cPrecordId OUT CHAR
  );

  PROCEDURE AddSurveyRecordDetail (
    cPrecordId IN CHAR,
    iPcode IN INT,
    cPremark IN VARCHAR2
  );

  PROCEDURE GetSurveyAnswerPopularityData (
    iPsite_id IN INT,
    iPsurvey_code IN INT,
    cPquestion_id IN VARCHAR2,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  );

/*
  PROCEDURE InsertSurveyAnswerData (
    iPsite_id IN INT,
    iPsurvey_code IN INT,
    cPsurvey_name IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPquestion_id IN VARCHAR2,
    cPquestion_answer IN VARCHAR2,
    cPname IN VARCHAR2,
    cPmember_only IN CHAR,
    iPreturn OUT INT
  );
*/

  PROCEDURE AddCheckoutSurveyRecord (
    iPsiteId IN INT DEFAULT NULL,
    iPsurveyId IN INT DEFAULT NULL,
    cPshopperId IN CHAR DEFAULT NULL,
    cPchoiceCSV IN VARCHAR2,
    iPtextChoice IN INT DEFAULT NULL,
    cPcomment IN VARCHAR2 DEFAULT NULL,
    cPoutputId OUT CHAR
  );

  PROCEDURE UpdateCheckoutSurveyDetail (
    cPrecordId IN CHAR,
    iPcode IN INT,
    cPdetail IN VARCHAR2
  );

  PROCEDURE GetThemeStorePoll (
    iPlang_id IN INT,
    iPtheme_id IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  );

  -- proc_fe_themestore_updatePollResult
  PROCEDURE VoteThemeStorePoll (
    iPpoll_id IN INT,
    iPanswer IN INT
  );

  -- proc_fe_GetFeaturedArtist
  PROCEDURE GetDeptFeaturedArtist (
    iPdept_id IN INT,
    vcPartist_role IN VARCHAR2,
    curPresult OUT curG
  );

  -- proc_fe_getFeaturedLinkDept
  PROCEDURE GetDeptFeaturedLink (
    iPdept_id IN INT,
    iPtype_id IN INT,
    iPlang_id IN INT,
    curPresult OUT curG
  );
END Pkg_FE_ContentAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_ContentAccess
IS
  PROCEDURE GetPopChart (
    iPfile_id IN INT,
    curPresult OUT curG
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      pc.popchart_id,
      pc.file_id,
      pc.lot_location,
      pc.last_position,
      pc.desc_img_loc,
      pc.desc_img_width,
      pc.desc_img_height,
      pl.sku,
      pl.prod_lot_id
    FROM
      ya_popchart pc
      LEFT OUTER JOIN ya_product_lot pl ON
        pc.lot_location = pl.lot_location
        AND pc.file_id = pl.file_id
    WHERE
      pc.file_id = iPfile_id
    ORDER BY pc.lot_location;
    RETURN;
  END GetPopChart;



  PROCEDURE GetPopChart_Mirror (
    iPfile_id IN INT,
    curPresult OUT curG
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      pc.popchart_id,
      pc.file_id,
      pc.lot_location,
      pc.last_position,
      pc.desc_img_loc,
      pc.desc_img_width,
      pc.desc_img_height,
      pl.sku,
      pl.prod_lot_id
    FROM
      ya_mirror_popchart pc
      LEFT OUTER JOIN ya_mirror_product_lot pl ON
        pc.lot_location = pl.lot_location
        AND pc.file_id = pl.file_id
    WHERE
      pc.file_id = iPfile_id
    ORDER BY pc.lot_location;
    RETURN;
  END GetPopChart_Mirror;



  PROCEDURE GetImageLot (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
      ill.image_loc,
      ill.link_url,
      NVL(ill.image_height, 0),
      NVL(ill.image_width, 0),
      il.lot_location,
      ill.alt
    FROM
      ya_image_lot il,
      ya_img_lot_lang ill
    WHERE
      il.image_lot_id = ill.image_lot_id
      AND il.file_id = iPfileId
      AND ill.lang_id = iPlangId
    ORDER BY il.lot_location;
    RETURN;
  END GetImageLot;


  PROCEDURE GetImageLot_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
      ill.image_loc,
      ill.link_url,
      NVL(ill.image_height, 0),
      NVL(ill.image_width, 0),
      il.lot_location,
      ill.alt
    FROM
      ya_mirror_image_lot il,
      ya_mirror_img_lot_lang ill
    WHERE
      il.image_lot_id = ill.image_lot_id
      AND il.file_id = iPfileId
      AND ill.lang_id = iPlangId
    ORDER BY il.lot_location;
    RETURN;
  END GetImageLot_Mirror;


  PROCEDURE GetTextLot (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
      tl.lot_location,
      tll.description,
      ptll.desc_img_loc AS image_loc,
      NVL(ptll.desc_img_width, -1) AS image_width,
      NVL(ptll.desc_img_height, -1) AS image_height
    FROM
      ya_text_lot tl
      LEFT OUTER JOIN ya_text_lot_lang tll ON tl.text_lot_id = tll.text_lot_id AND tll.lang_id = iPlangId
      LEFT OUTER JOIN ya_text_lot_lang ptll ON tl.text_lot_id = ptll.text_lot_id AND ptll.preferred_flag = 'Y'
    WHERE
      tl.file_id = iPfileId
      ORDER BY tl.lot_location, tl.priority;

    RETURN;
  END GetTextLot;


  PROCEDURE GetTextLot_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
      tl.lot_location,
      tll.description,
      ptll.desc_img_loc AS image_loc,
      NVL(ptll.desc_img_width, -1) AS image_width,
      NVL(ptll.desc_img_height, -1) AS image_height
    FROM
      ya_mirror_text_lot tl
      LEFT OUTER JOIN ya_mirror_text_lot_lang tll ON tl.text_lot_id = tll.text_lot_id AND tll.lang_id = iPlangId
      LEFT OUTER JOIN ya_mirror_text_lot_lang ptll ON tl.text_lot_id = ptll.text_lot_id AND ptll.preferred_flag = 'Y'
    WHERE
      tl.file_id = iPfileId
      ORDER BY tl.lot_location, tl.priority;

    RETURN;
  END GetTextLot_Mirror;


  PROCEDURE GetTopSellersCount (
    iPdept_id IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT top_count
    FROM ya_top_sellers
    WHERE dept_id = iPdept_id;
    RETURN;
  END GetTopSellersCount;


  PROCEDURE GetWeeklyPoll (
    iPlangId IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  )
  AS
    iLpollId INT;
  BEGIN
    /* Get weekly poll question and answer */
    BEGIN
      SELECT r.poll_id INTO iLpollId
      FROM
      (
        SELECT poll_id
        FROM ya_poll
        WHERE
        (SYSDATE - created_datetime) >= 0
        ORDER BY (SYSDATE - created_datetime), poll_id DESC
      ) r
      WHERE
        ROWNUM = 1;

      EXCEPTION when no_data_found THEN
        iLpollId := -1;
    END;

    /* Get Poll Question */
    OPEN curPresult1 FOR
    SELECT
      pl.item_content,
      (TO_DATE(created_datetime) + ( 1 * 7 ) ),
      created_datetime,
      iLpollId
    FROM
      ya_poll p,
      ya_poll_lang pl
    WHERE
      p.poll_id = pl.poll_id
      AND p.poll_id = iLpollId
      AND pl.item_type = 'Q'
      AND pl.lang_id = iPlangId;

    /* Get Poll Answer */
    OPEN curPresult2 FOR
    SELECT
      pr.result_count,
      pl.item_content,
      pl.item_id
    FROM
      ya_poll_lang pl,
      ya_poll_result pr
    WHERE
      pl.poll_id = pr.poll_id
      AND pl.item_id = pr.item_id
      AND pl.poll_id = iLpollId
      AND pl.lang_id = iPlangId
    ORDER BY pl.item_order;
    RETURN;
  END GetWeeklyPoll;


  PROCEDURE VoteWeeklyPoll (
    iPpollId IN INT,
    iPanswer IN INT
  )
  AS
  BEGIN
    UPDATE ya_poll_result
    SET result_count = result_count + 1,
    last_update = SYSDATE
    WHERE
      poll_id = iPpollId
      AND item_id = iPanswer;

    IF SQL%ROWCOUNT = 0 THEN
      BEGIN
        INSERT INTO ya_poll_result (poll_id, item_id, result_count, last_update, ROWGUID)
        VALUES (iPpollId, iPanswer, 1, SYSDATE, sys_guid());
      END;
    END IF;

    COMMIT;
  END VoteWeeklyPoll;


  PROCEDURE GetContentPageId (
    iPsiteId IN INT,
    iPcontainerId IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT page_id
    FROM ya_content_page
    WHERE
      site_id = iPsiteId
      AND container_id = iPcontainerId;
    RETURN;
  END GetContentPageId;


  PROCEDURE GetSurveyInformation (
    iPsurveyId IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
      s.survey_id,
      ql.question_id,
      ql.lang_id,
      ql.question,
      q.type_id
    FROM
      ya_survey s,
      ya_survey_question q,
      ya_survey_question_lang ql
    WHERE
      s.survey_id = q.survey_id
      AND s.survey_id = ql.survey_id
      AND q.question_id = ql.question_id
      AND s.survey_id = iPsurveyId
    ORDER BY ql.question_id, ql.lang_id;

    OPEN curPresult2 FOR
    SELECT
      s.survey_id,
      sc.question_id,
      sc.code,
      cl.lang_id,
      cl.content,
      sc.text_entry
    FROM
      ya_survey s,
      ya_survey_choice sc,
      ya_survey_choice_lang cl
    WHERE
      s.survey_id = sc.survey_id
      AND s.survey_id = cl.survey_id
      AND sc.code = cl.code
      AND s.survey_id = iPsurveyId
    ORDER BY sc.code, cl.lang_id;
    RETURN;
  END GetSurveyInformation;


  PROCEDURE AddSurveyRecord (
    iPsiteId IN INT,
    iPsurveyId IN INT,
    cPemail IN VARCHAR2,
    cPshopperId IN CHAR,
    cPchoiceCsv IN VARCHAR2,
    cPrecordId OUT CHAR
  )
  AS
    iLendpos  INT;
    iLtemp  INT := 0;
    cLchoiceCsv VARCHAR2(1000);
    cLrecordId CHAR(32);
  BEGIN
    cLchoiceCsv := cPchoiceCsv;
    cLrecordId := SYS_GUID();

    INSERT INTO ya_survey_record
      (
      record_id,
      survey_id,
      shopper_id,
      email,
      site_id
      )
    VALUES
      (
      cLrecordId ,
      iPsurveyId ,
      cPshopperId ,
      cPemail ,
      iPsiteId
      );

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      cPrecordId := -1;
      RETURN;
    END IF;

    iLtemp := NVL(LENGTH(RTRIM(cLchoiceCsv)),0);

    IF (iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLchoiceCsv, ',');
        WHILE iLendpos  >  0
          LOOP
            BEGIN
--              dbms_output.put_line(SUBSTR(cLchoiceCsv, 1, iLendpos-1));

              INSERT INTO ya_survey_record_detail
                (
                  record_id,
                  code
                )
              VALUES
                (
                  cLrecordId,
                  CAST(SUBSTR(cLchoiceCsv, 1, iLendpos-1) AS int)
                );

          cLchoiceCsv := SUBSTR(cLchoiceCsv, iLendpos+1);

          iLendpos := INSTR(cLchoiceCsv, ',');

          IF SQLCODE <> 0 THEN
            ROLLBACK;
            cPrecordId := -1;
            RETURN;
          END IF;
        END;
        END LOOP;

--        dbms_output.put_line(cLchoiceCsv);

        /* Throw in the last one */
        INSERT INTO ya_survey_record_detail
          (
            record_id,
            code
          )
        VALUES
          (
            cLrecordId,
            CAST(cLchoiceCsv AS int)
          );

        IF SQLCODE <> 0 THEN
          ROLLBACK;
          cPrecordId := -1;
          RETURN;
        END IF;
      END;
    END IF;
    COMMIT;
    cPrecordId := cLrecordId;
    RETURN;
  END AddSurveyRecord;


  PROCEDURE AddSurveyRecordDetail (
    cPrecordId IN CHAR,
    iPcode IN INT,
    cPremark IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_survey_record_detail
    SET remark = cPremark
    WHERE record_id = cPrecordId
    AND code = iPcode;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
    RETURN;
  END AddSurveyRecordDetail;


  PROCEDURE GetSurveyAnswerPopularityData (
    iPsite_id IN INT,
    iPsurvey_code IN INT,
    cPquestion_id IN VARCHAR2,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT
      question_answer,
      COUNT(question_answer)
    FROM ya_survey_answer
    WHERE
      survey_code = iPsurvey_code
      AND question_id = cPquestion_id
      AND site_id = iPsite_id
    GROUP BY survey_code, question_id, question_answer;

    OPEN curPresult2 FOR
    SELECT COUNT(question_id)
    FROM ya_survey_answer
    WHERE
      survey_code = iPsurvey_code
      AND question_id = cPquestion_id
      AND site_id = iPsite_id;

    RETURN;
  END GetSurveyAnswerPopularityData;

/*
  PROCEDURE InsertSurveyAnswerData (
    iPsite_id IN INT,
    iPsurvey_code IN INT,
    cPsurvey_name IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPquestion_id IN VARCHAR2,
    cPquestion_answer IN VARCHAR2,
    cPname IN VARCHAR2,
    cPmember_only IN CHAR,
    iPreturn OUT INT
  )
  AS
    cLshopper_id VARCHAR2(32) :=0 ;
  BEGIN
    IF cPmember_only = 'Y' THEN
      BEGIN
        INSERT INTO ya_survey_answer
        (
          site_id,
          survey_code,
          survey_name,
          email,
          question_id,
          question_answer,
          name,
          shopper_id
        )
        SELECT
          iPsite_id,
          iPsurvey_code,
          cPsurvey_name,
          email,
          cPquestion_id,
          cPquestion_answer,
          cPname,
          shopper_id
        FROM ya_shopper s
        WHERE
          email = cPemail
          AND member_type <> 3
          AND NOT EXISTS
          (
            SELECT 1
            FROM ya_survey_answer
            WHERE
              site_id = iPsite_id
              AND survey_code = iPsurvey_code
              AND email = s.email
              AND question_id = cPquestion_id
          );
      END;
    ELSE
      BEGIN
        BEGIN
          SELECT shopper_id
          INTO cLshopper_id
          FROM ya_shopper
          WHERE email = cPemail;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          cLshopper_id := NULL;
        END;

        INSERT INTO ya_survey_answer
        (
          site_id,
          survey_code,
          survey_name,
          email,
          question_id,
          question_answer,
          name,
          shopper_id,
          ANSWER_DATETIME,
          ROWGUID
        )
        SELECT
          iPsite_id,
          iPsurvey_code,
          cPsurvey_name,
          cPemail,
          cPquestion_id,
          cPquestion_answer,
          cPname,
          cLshopper_id,
          SYSDATE,
          SYS_GUID()
        FROM ya_shopper s
        WHERE NOT EXISTS
        (
          SELECT 1
          FROM ya_survey_answer
          WHERE
            site_id = iPsite_id
            AND survey_code = iPsurvey_code
            AND email = cPemail
            AND question_id = cPquestion_id
        );
        iPreturn := SQL%ROWCOUNT;
      END;
    END IF;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      iPreturn := -1;
    END IF;
    COMMIT;
    RETURN;
  END InsertSurveyAnswerData;
*/

  -- proc_fe_AddCheckoutSurveyRecord
  PROCEDURE AddCheckoutSurveyRecord (
    iPsiteId IN INT DEFAULT NULL,
    iPsurveyId IN INT DEFAULT NULL,
    cPshopperId IN CHAR DEFAULT NULL,
    cPchoiceCSV IN VARCHAR2,
    iPtextChoice IN INT DEFAULT NULL,
    cPcomment IN VARCHAR2 DEFAULT NULL,
    cPoutputId OUT CHAR
  )
  AS
    cLrecordId CHAR(32);
    cLemail VARCHAR2(255);
    iLstartpos INT;
    iLendpos INT;
    iLtemp INTEGER := 0;
    cLchoiceCSV VARCHAR2(500);
  BEGIN
    cLchoiceCSV := cPchoiceCSV;
    cLrecordId := SYS_GUID();

    BEGIN
      SELECT email INTO cLemail
      FROM ya_shopper
      WHERE shopper_id = cPshopperId;

    EXCEPTION WHEN no_data_found THEN
      cLemail := NULL;
    END;


    INSERT INTO ya_survey_record
    (
      record_id,
      survey_id,
      shopper_id,
      email,
      site_id
    )
    VALUES
    (
      cLrecordId ,
      iPsurveyId ,
      cPshopperId ,
      cLemail ,
      iPsiteId
    );
    IF SQLCODE <> 0 THEN
      ROLLBACK;
      cPoutputId := NULL;
      RETURN;
    END IF;

    iLstartpos := 1;
    iLtemp := NVL(LENGTH(RTRIM(cLchoiceCSV)),0);

    IF iLtemp > 0 THEN
      BEGIN
        iLendpos := INSTR(cLchoiceCSV, ',');
        WHILE iLendpos > 0 LOOP
          BEGIN
            INSERT INTO ya_survey_record_detail
              (
                record_id,
                code
              )
            VALUES
              (
                cLrecordId,
                CAST(SUBSTR(cLchoiceCSV, 1,iLendpos - 1) AS int)
              );

            cLchoiceCSV := SUBSTR(cLchoiceCSV, iLendpos + 1);
            iLendpos := INSTR(cLchoiceCSV, ',');
          END;
        END LOOP;

        INSERT INTO ya_survey_record_detail
          (
            record_id,
            code
          )
        VALUES
          (
            cLrecordId,
            CAST(cLchoiceCSV AS int)
          );

        IF SQLCODE <> 0 THEN
          ROLLBACK;
          cPoutputId := NULL;
          RETURN;
        END IF;
      END;
    END IF;

    UPDATE ya_survey_record_detail
    SET remark = cPcomment
    WHERE
      record_id = cLrecordId
      AND code = iPtextChoice;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      cPoutputId := NULL;
    END IF;

    cPoutputId := cLrecordId;
    COMMIT;

    RETURN;
  END AddCheckoutSurveyRecord;


  PROCEDURE UpdateCheckoutSurveyDetail (
    cPrecordId IN CHAR,
    iPcode IN INT,
    cPdetail IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_survey_record_detail
    SET remark = cPdetail
    WHERE
      record_id = cPrecordId
      AND code = iPcode;
    COMMIT;
  END UpdateCheckoutSurveyDetail;


  PROCEDURE GetThemeStorePoll (
    iPlang_id IN INT,
    iPtheme_id IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG
  )
  AS
    iLpoll_id INT;
  BEGIN
    BEGIN
      SELECT poll_id
      INTO iLpoll_id
      FROM
        (
          SELECT poll_id
          FROM ya_themestore_poll
          WHERE
            theme_id = iPtheme_id
            AND ROUND(SYSDATE() - created_datetime) >= 0
          ORDER BY ROUND(SYSDATE() - created_datetime)
        )
      WHERE ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      SELECT NULL INTO iLpoll_id FROM DUAL;
    END;


    -- Get Poll Question
    OPEN curPresult1 FOR
    SELECT
      pl.item_content,
      SYSDATE() + 1,
      created_datetime,
      iLpoll_id
    FROM
      ya_themestore_poll p
      INNER JOIN ya_themestore_poll_lang pl ON
        p.poll_id = pl.poll_id
    WHERE
      p.poll_id = iLpoll_id
      AND pl.item_type = 'Q'
      AND pl.lang_id = iPlang_id;

    /* Get Poll Answer */
    OPEN curPresult2 FOR
    SELECT
      pr.result_count,
      pl.item_content,
      pl.item_id
    FROM
      ya_themestore_poll_lang pl
      INNER JOIN ya_themestore_poll_result pr ON
        pl.poll_id = pr.poll_id
        AND pl.item_id = pr.item_id
    WHERE
      pl.poll_id = iLpoll_id
      AND pl.lang_id = iPlang_id
    ORDER BY pl.item_order;
    RETURN;
  END GetThemeStorePoll;



  PROCEDURE VoteThemeStorePoll (
    iPpoll_id IN INT,
    iPanswer IN INT
  )
  AS
  BEGIN
    UPDATE ya_themestore_poll_result
    SET
      result_count = result_count + 1,
      last_update = SYSDATE()
    WHERE
      poll_id = iPpoll_id
      AND item_id = iPanswer;

    IF SQL%ROWCOUNT = 0 THEN
      BEGIN
        INSERT INTO ya_themestore_poll_result
          (
            poll_id,
            item_id,
            result_count,
            last_update
          )
        VALUES
          (
            iPpoll_id,
            iPanswer,
            1,
            SYSDATE()
          );
      END;
    END IF;
/*
  EXCEPTION WHEN others THEN
    ROLLBACK;
*/
    COMMIT;
    RETURN;
  END VoteThemeStorePoll;



  PROCEDURE GetDeptFeaturedArtist (
    iPdept_id IN INT,
    vcPartist_role IN VARCHAR2,
    curPresult OUT curG
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      artist_id
    FROM
      ya_featured_artist_dept_rel
    WHERE
      dept_id = iPdept_id
      AND artist_role = vcPartist_role;
    RETURN;
  END GetDeptFeaturedArtist;


  PROCEDURE GetDeptFeaturedLink (
    iPdept_id IN INT,
    iPtype_id IN INT,
    iPlang_id IN INT,
    curPresult OUT curG
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      fldrl.content,
      fldrl.link
    FROM
      ya_featured_link_dept_rel fldr,
      ya_featured_link_dept_rel_lang fldrl
    WHERE
      fldrl.id = fldr.id
      AND fldr.dept_id = iPdept_id
      AND fldr.type_id = iPtype_id
      AND fldrl.lang_id = iPlang_id;
    RETURN;
  END GetDeptFeaturedLink;
END Pkg_FE_ContentAccess;
/

