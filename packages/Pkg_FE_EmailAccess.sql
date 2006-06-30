CREATE OR REPLACE PACKAGE Pkg_FE_EmailAccess
AS
  TYPE refcur IS ref CURSOR;

  /* proc_fe_email_InsertClickedEmail */
  PROCEDURE InsertClickedEmail (
    iPemail_message_id IN INT,
    vcPemail IN VARCHAR2
  );

  /* proc_fe_email_InsertOpenedEmail */
  PROCEDURE InsertOpenedEmail (
    iPemail_message_id IN INT,
    vcPemail IN VARCHAR2
  );

  /* proc_fe_email_GetSubscribePref */
  PROCEDURE GetSubscriberPreference (
    cPshopper_id IN CHAR,
    rcPresult OUT refCur
  );

  /* proc_fe_email_UpdateSubscribePref */
  PROCEDURE UpdateSubscriberPreference (
    cPshopper_id IN CHAR,
    iPlang_pref IN INT,
    iPchoice_pref IN INT,
    iPsite_id IN INT,
    iPsubscription_id IN OUT INT
  );

  /* proc_fe_email_GetSubscribeArtist */
  PROCEDURE GetSubscribedArtist (
    cPshopper_id IN CHAR,
    iPlang_id IN INT,
    iPpref_id IN INT,
    rcPresult OUT refCur
  );

  /* proc_fe_email_DeleteExceptSubscribeArtist */
  PROCEDURE DelExceptSubscribedArtist (
    cPshopper_id IN CHAR,
    vcPartist_id_csv IN VARCHAR2,
    iPpref_id IN INT
  );

  /* proc_fe_email_InsertSubscribeArtist */
  PROCEDURE InsertSubscribArtist (
    cPshopper_id IN CHAR,
    vcPartist_id_csv IN VARCHAR2,
    iPpref_id IN INT
  );

  /* proc_fe_email_GetSubscribeText */
  PROCEDURE GetSubscribedText (
    cPshopper_id IN CHAR,
    iPlang_id IN INT,
    rcPresult OUT refCur
  );

  /* proc_fe_email_DeleteExceptSubscribeText */
  PROCEDURE DelExceptSubscribedText (
    cPshopper_id IN CHAR,
    iPid_csv IN VARCHAR2
  );

  /* proc_fe_email_InsertSubscribeText */
  PROCEDURE InsertSubscribedText (
    cPshopper_id IN CHAR,
    vcPsubscribed_text IN VARCHAR2
  );

  /* proc_fe_email_InsertSubscribeText */
  -- this one is created for the transition period
  PROCEDURE InsertSubscribedText_new (
    cPshopper_id IN CHAR,
		iPlang_id IN INT,
    vcPsubscribed_text IN VARCHAR2,
    iPrecId IN OUT INT
  );

  /* proc_fe_email_InsertOrderConversionEmail */
  PROCEDURE InsertOrderConEmail (
    iPorder_num IN INT,
    iPemail_message_id IN INT
  );
END Pkg_FE_EmailAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_FE_EmailAccess
IS
  /* proc_fe_email_InsertClickedEmail */
  PROCEDURE InsertClickedEmail (
    iPemail_message_id IN INT,
    vcPemail IN VARCHAR2
  )
  AS
  BEGIN
    INSERT INTO ya_email_clickedEmail
      (
        email_message_id,
        email
      )
    VALUES
      (
        iPemail_message_id,
        vcPemail
      );

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END InsertClickedEmail;


  /* proc_fe_email_InsertOpenedEmail */
  PROCEDURE InsertOpenedEmail (
    iPemail_message_id IN INT,
    vcPemail IN VARCHAR2
  )
  AS
  BEGIN
    INSERT INTO ya_email_openedEmail
      (
        email_message_id,
        email
      )
    VALUES
      (
        iPemail_message_id,
        vcPemail
      );

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END InsertOpenedEmail;



  /* proc_fe_email_GetSubscribePref */
  PROCEDURE GetSubscriberPreference (
    cPshopper_id IN CHAR,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT
      lang_pref,
      choice_pref,
      site_id
    FROM
      ya_email_shopper_sub_pref
    WHERE
      shopper_id = cPshopper_id;
    RETURN;
  END GetSubscriberPreference;


  /* proc_fe_email_UpdateSubscribePref */
  PROCEDURE UpdateSubscriberPreference (
    cPshopper_id IN CHAR,
    iPlang_pref IN INT,
    iPchoice_pref IN INT,
    iPsite_id IN INT,
    iPsubscription_id IN OUT INT
  )
  AS
    iLtemp INT;
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp
    FROM
      ya_email_shopper_sub_pref
    WHERE shopper_id = cPshopper_id;

    IF iLtemp > 0 THEN
      UPDATE ya_email_shopper_sub_pref
      SET
        lang_pref = iPlang_pref,
        choice_pref = iPchoice_pref,
        site_id = iPsite_id
      WHERE shopper_id = cPshopper_id;
    ELSE
      BEGIN
        IF iPsubscription_id IS NULL OR iPsubscription_id < 0 THEN
          SELECT seq_email_shopper_sub_pref.nextval INTO iPsubscription_id FROM dual;
        ELSE
          SELECT seq_email_shopper_sub_pref.nextval INTO iLseq_currval FROM dual;
          iLseq_diff := iPsubscription_id - iLseq_currval;
          IF iLseq_diff <> 0 THEN
            EXECUTE IMMEDIATE 'ALTER SEQUENCE seq_email_shopper_sub_pref INCREMENT BY ' || iLseq_diff;
            SELECT seq_email_shopper_sub_pref.nextval INTO iLseq_currval FROM dual;
            EXECUTE IMMEDIATE 'ALTER SEQUENCE seq_email_shopper_sub_pref INCREMENT BY 1';
          END IF;
        END IF;

        INSERT INTO ya_email_shopper_sub_pref
          (
            shopper_id,
            lang_pref,
            choice_pref,
            site_id,
            SHOPPER_SUBSCRIBE_ID
          )
        VALUES
          (
            cPshopper_id,
            iPlang_pref,
            iPchoice_pref,
            iPsite_id,
            iPsubscription_id
          );
      END;
    END IF;

    IF iPchoice_pref <> 2 THEN
      DELETE FROM ya_reminder_exclude_list
      WHERE shopper_id = cPshopper_id;
    ELSE
      BEGIN
        SELECT COUNT(1)
        INTO iLtemp
        FROM ya_reminder_exclude_list
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        IF iLtemp = 0 THEN
          INSERT INTO ya_reminder_exclude_list
            (
              shopper_id,
              reminder_id,
              last_modified_datetime,
              site_id
            )
          VALUES
            (
              cPshopper_id,
              1,
              SYSDATE(),
              iPsite_id
            );
        END IF;
      END;
    END IF;

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END;


  /* proc_fe_email_GetSubscribeArtist */
  PROCEDURE GetSubscribedArtist (
    cPshopper_id IN CHAR,
    iPlang_id IN INT,
    iPpref_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT
      a.artist_id,
      b.firstname,
      b.lastname,
      b.akaname,
      c.firstname AS eng_firstname,
      c.lastname AS eng_lastname,
      c.akaname AS eng_akaname
    FROM
      ya_email_shopper_sub_artist a
      INNER JOIN ya_artist_lang b ON a.artist_id = b.artist_id AND b.lang_id = iPlang_id
      INNER JOIN ya_artist_lang c ON a.artist_id = c.artist_id AND c.lang_id = 1
    WHERE a.shopper_id = cPshopper_id
    AND a.pref_id = iPpref_id
    ORDER BY a.artist_id;
  END GetSubscribedArtist;


  /* proc_fe_email_DeleteExceptSubscribeArtist */
  PROCEDURE DelExceptSubscribedArtist (
    cPshopper_id IN CHAR,
    vcPartist_id_csv IN VARCHAR2,
    iPpref_id IN INT
  )
  AS
    iLstart_pos INT := 1;
    iLend_pos INT := 1;
    vcLartist_id_csv VARCHAR2(1000);
    iLtemp INT;
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_email_int_table';

    vcLartist_id_csv := vcPartist_id_csv;
    iLtemp := NVL(LENGTH(RTRIM(vcLartist_id_csv)),0);

    IF iLtemp > 0 THEN
      BEGIN
        iLend_pos := INSTR(vcLartist_id_csv, ',');

        WHILE iLend_pos > 0 LOOP
          BEGIN
            INSERT INTO temp_email_int_table (column1)
            VALUES (cast(substr(vcLartist_id_csv,1,iLend_pos-1) AS INT));
            vcLartist_id_csv := substr(vcLartist_id_csv, iLend_pos + 1);
            iLend_pos := instr(vcLartist_id_csv, ',');
          END;
        END LOOP;

        INSERT INTO temp_email_int_table (column1)
        VALUES (cast(vcLartist_id_csv AS INT));
      END;
    END IF;

    DELETE FROM ya_email_shopper_sub_artist
    WHERE shopper_id = cPshopper_id
    AND pref_id = iPpref_id
    AND artist_id NOT IN (SELECT column1 FROM temp_email_int_table);

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END DelExceptSubscribedArtist;


  /* proc_fe_email_InsertSubscribeArtist */
  PROCEDURE InsertSubscribArtist (
    cPshopper_id IN CHAR,
    vcPartist_id_csv IN VARCHAR2,
    iPpref_id IN INT
  )
  AS
    iLstart_pos INT := 1;
    iLend_pos INT := 1;
    vcLartist_id_csv VARCHAR2(1000);
    iLtemp INT;
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_email_int_table';

    vcLartist_id_csv := vcPartist_id_csv;
    iLtemp := NVL(LENGTH(RTRIM(vcLartist_id_csv)),0);

    IF iLtemp > 0 THEN
      BEGIN
        iLend_pos := INSTR(vcLartist_id_csv, ',');

        WHILE iLend_pos > 0 LOOP
          BEGIN
            INSERT INTO temp_email_int_table (column1)
            VALUES (cast(substr(vcLartist_id_csv,1,iLend_pos-1) AS INT));

            vcLartist_id_csv := substr(vcLartist_id_csv, iLend_pos + 1);
            iLend_pos := instr(vcLartist_id_csv, ',');
          END;
        END LOOP;

        INSERT INTO temp_email_int_table (column1)
        VALUES (cast(vcLartist_id_csv AS INT));
      END;
    END IF;

    INSERT INTO ya_email_shopper_sub_artist
      (
        shopper_id,
        artist_id,
        pref_id
      )
    SELECT
      cPshopper_id,
      column1,
      iPpref_id
    FROM temp_email_int_table a
  	WHERE
      NOT EXISTS
        (
          SELECT 0
          FROM ya_email_shopper_sub_artist
          WHERE shopper_id = cPshopper_id
          AND artist_id = a.column1
					AND pref_id = iPpref_id
        );
  END InsertSubscribArtist;


  /* proc_fe_email_GetSubscribeText */
  PROCEDURE GetSubscribedText (
    cPshopper_id IN CHAR,
    iPlang_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT
      id,
      subscribe_text
    FROM
      ya_email_shopper_sub_text
    WHERE
      shopper_id = cPshopper_id;
  END GetSubscribedText;



  /* proc_fe_email_DeleteExceptSubscribeText */
  PROCEDURE DelExceptSubscribedText (
    cPshopper_id IN CHAR,
    iPid_csv IN VARCHAR2
  )
  AS
    iLstart_pos INT := 1;
    iLend_pos INT := 1;
    vcL_id_csv VARCHAR2(1000);
    iLtemp INT;
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_email_int_table';

    vcL_id_csv := iPid_csv;
    iLtemp := NVL(LENGTH(RTRIM(vcL_id_csv)),0);

    IF iLtemp > 0 THEN
      BEGIN
        iLend_pos := INSTR(vcL_id_csv, ',');

        WHILE iLend_pos > 0 LOOP
          BEGIN
            INSERT INTO temp_email_int_table (column1)
            VALUES (cast(substr(vcL_id_csv,1,iLend_pos-1) AS INT));

            vcL_id_csv := substr(vcL_id_csv, iLend_pos + 1);
            iLend_pos := instr(vcL_id_csv, ',');
          END;
        END LOOP;

        INSERT INTO temp_email_int_table (column1)
        VALUES (cast(vcL_id_csv AS INT));
      END;
    END IF;

    DELETE FROM ya_email_shopper_sub_text
    WHERE shopper_id = cPshopper_id
    AND id NOT IN (SELECT column1 FROM temp_email_int_table);

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END DelExceptSubscribedText;

    /* proc_fe_email_InsertSubscribeText */
  PROCEDURE InsertSubscribedText (
    cPshopper_id IN CHAR,
    vcPsubscribed_text IN VARCHAR2
  )
  AS
    iLtemp INT;
  BEGIN
    SELECT COUNT(0)
    INTO iLtemp
    FROM ya_email_shopper_sub_text
    WHERE
      shopper_id = cPshopper_id
      AND subscribe_text = vcPsubscribed_text;

    IF iLtemp = 0 THEN
      INSERT INTO ya_email_shopper_sub_text
        (
          shopper_id,
          subscribe_text
        )
      VALUES
        (
          cPshopper_id,
          vcPsubscribed_text
        );
    END IF;
  END InsertSubscribedText;

  /* proc_fe_email_InsertSubscribeText */
  PROCEDURE InsertSubscribedText_new (
    cPshopper_id IN CHAR,
		iPlang_id IN INT,
    vcPsubscribed_text IN VARCHAR2,
    iPrecId IN OUT INT
  )
  AS
    iLtemp INT;
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    SELECT COUNT(0)
    INTO iLtemp
    FROM ya_email_shopper_sub_text
    WHERE
      shopper_id = cPshopper_id
      AND subscribe_text = vcPsubscribed_text;

    IF iLtemp = 0 THEN
      IF iPrecId IS NULL OR iPrecId < 0 THEN
        SELECT seq_email_shopper_sub_text.nextval INTO iPrecId FROM dual;
      ELSE
        SELECT seq_email_shopper_sub_text.nextval INTO iLseq_currval FROM dual;
        iLseq_diff := iPrecId - iLseq_currval;
        IF iLseq_diff <> 0 THEN
          EXECUTE IMMEDIATE 'ALTER SEQUENCE seq_email_shopper_sub_text INCREMENT BY ' || iLseq_diff;
          SELECT seq_email_shopper_sub_text.nextval INTO iLseq_currval FROM dual;
          EXECUTE IMMEDIATE 'ALTER SEQUENCE seq_email_shopper_sub_text INCREMENT BY 1';
        END IF;
      END IF;

      INSERT INTO ya_email_shopper_sub_text
        (
          id,
          shopper_id,
					lang_id,
          subscribe_text
        )
      VALUES
        (
          iPrecId,
          cPshopper_id,
					iPlang_id,
          vcPsubscribed_text
        );
    END IF;
  END InsertSubscribedText_new;


  /* proc_fe_email_InsertOrderConversionEmail */
  PROCEDURE InsertOrderConEmail (
    iPorder_num IN INT,
    iPemail_message_id IN INT
  )
  AS
  BEGIN
    INSERT INTO ya_email_orderConversionEmail
    (
      order_num,
      email_message_id
    )
    VALUES
    (
      iPorder_num,
      iPemail_message_id
    );

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END;
END Pkg_FE_EmailAccess;
/

