
REM START SS_ADM PKG_FE_NEWSLETTERACCESS

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_NEWSLETTERACCESS" 
AS
  TYPE curGgetNews IS REF CURSOR;
  PROCEDURE GetNewsletterTopic (
    cPnewsletterIdCsv IN VARCHAR2,
    iPlangId  IN INT,
    iPsiteId  IN INT,
    curPgetNews  OUT curGgetNews
  );

  PROCEDURE SubscribeNewsletter (
    cPshopperId  IN CHAR,
    iPsiteId  IN INT,
    cPnewsletterCsv IN VARCHAR2,
    iPstatus  IN CHAR,
    cPguid  OUT CHAR
  );

  PROCEDURE IsNewsletterSubscriber (
    cPshopperId  IN CHAR,
    iPnewsletterId IN INT,
    iPreturn  OUT INT
  );

  /* proc_fe_SubscribeNewsletterByEmail */
  PROCEDURE SubscribeNewsletterByEmail (
    vcPemail IN VARCHAR2,
    iPsite_id IN INT,
    vcPnewsletter_csv IN VARCHAR2,
    cPstatus IN CHAR,
    cPguid OUT CHAR
  );
  
  PROCEDURE GetExistingEmailList (
    iPnewsletter_id		IN	INT,
		iPsite_id IN INT,
		vcPmembershipType IN VARCHAR2,
		curPresult 			OUT 	curGgetNews
  );

END Pkg_fe_NewsletterAccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_NEWSLETTERACCESS" 
IS
/* GetNewsletterTopic */
  PROCEDURE GetNewsletterTopic (
    cPnewsletterIdCsv IN VARCHAR2,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPgetNews OUT curGgetNews
  )
  AS
    iLtypeId INT := 84;  /* Newsletter type Id */
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT;
    cLnewsletterIdCsv VARCHAR2(100);
    iLsequenceid INT;
    icounter INT;
  BEGIN
    cLnewsletterIdCsv := cPnewsletterIdCsv;
    iLstartpos := 1;
    iCounter := 1;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_news_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLnewsletterIdCsv)),0);

    IF(iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLnewsletterIdCsv, ',');

        WHILE  iLendpos  >  0
        LOOP
          BEGIN
            INSERT INTO temp_news_int_table
              (
                column1, -- Order Id
                column2  -- newsletter Id
              )
            VALUES
              (
                iCounter,
                CAST(SUBSTR(cLnewsletterIdCsv,1,iLendpos-1) AS INT)
              );

            cLnewsletterIdCsv := SUBSTR(cLnewsletterIdCsv, iLendpos+1);
            iLendpos := INSTR(cLnewsletterIdCsv, ',');
            iCounter := iCounter + 1;
          END;
        END LOOP;
        INSERT INTO temp_news_int_table
          (
            column1, -- Order Id
            column2  -- newsletter Id
          )
        VALUES
          (
            iCounter,
            CAST(cLnewsletterIdCsv AS INT)
          );
      END;
    END IF;

    OPEN curPgetNews FOR
    SELECT
      nl.newsletter_id,
      nl.topic,
      l.code
    FROM
      temp_news_int_table n,
      ya_newsletter_type nt,
      ya_newsletter_site ns,
      ya_newsletter_lang nl,
      ya_lookup l
    WHERE
      n.column2 = nt.newsletter_type_id
      AND nt.newsletter_id = ns.newsletter_id
      AND nt.newsletter_id = nl.newsletter_id
      AND nl.newsletter_id = l.code_id
      AND l.type_id = iLtypeId
      AND nl.lang_id = iPlangId
      AND ns.site_id = iPsiteId
      AND ns.site_enabled = 'Y'
    ORDER BY n.column1; -- Order Id
    EXCEPTION
      WHEN OTHERS THEN NULL;
    RETURN;
  END GetNewsletterTopic;

/* SubscribeNewsletter */
  PROCEDURE SubscribeNewsletter (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPnewsletterCsv IN VARCHAR2,
    iPstatus IN CHAR,
    cPguid OUT CHAR
  )
  AS
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT := 0;
    cLnewsletterCsv VARCHAR2(100);
    cLemail VARCHAR2(255);
    cLguid CHAR(32);
  BEGIN
    iLstartpos := 1;
    cLnewsletterCsv := cPnewsletterCsv;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_news_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLnewsletterCsv)),0);

    IF (iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLnewsletterCsv, ',');
        WHILE iLendpos  >  0
        LOOP
          BEGIN
            INSERT INTO temp_news_int_table
              (
                column1 -- newsletter Id
              )
            VALUES
              (
                CAST(SUBSTR(cLnewsletterCsv,1,iLendpos-1) AS INT)
              );

            cLnewsletterCsv := SUBSTR(cLnewsletterCsv, iLendpos+1);
            iLendpos := INSTR(cLnewsletterCsv, ',');
          END;
        END LOOP;
        INSERT INTO temp_news_int_table
          (
            column1 -- newsletter Id
          )
        VALUES
          (
            CAST(cLnewsletterCsv AS INT)
          );
      END;
    END IF;

    cLguid := SYS_GUID();

    SELECT email INTO cLemail FROM ya_shopper WHERE shopper_id = cPshopperId;

    -- download_flag = 'N' (deprecated column)
    INSERT INTO ya_newsletter_subscriber
      (
        guid,
        email,
        site_id,
        status,
        newsletter_id,
        last_modified_datetime,
        downloaded_flag,
		shopper_id
      )
    SELECT
      cLguid,
      cLemail,
      iPsiteId,
      iPstatus,
      column1,
      SYSDATE,
      'N', -- column1 => newsletter Id
	  cPshopperId
    FROM
      temp_news_int_table
    WHERE column1 NOT IN -- newsletter Id
      (
        SELECT newsletter_id
        FROM ya_newsletter_subscriber
        WHERE email = cLemail
      );
    COMMIT;
    cPguid := cLguid;
  EXCEPTION WHEN OTHERS THEN
    BEGIN
      cPguid := NULL;
      ROLLBACK;
    END;
  RETURN;
  END SubscribeNewsletter;


  /* IsNewsletterSubscriber */
  PROCEDURE IsNewsletterSubscriber (
    cPshopperId IN CHAR,
    iPnewsletterId IN INT,
    iPreturn OUT INT
  )
AS
BEGIN
  SELECT 1
  INTO iPreturn
  FROM ya_newsletter_subscriber
  WHERE
    newsletter_id = iPnewsletterId
    AND email =
      (
        SELECT email
        FROM ya_shopper
        WHERE shopper_id = cPshopperId
      )
    AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      iPreturn := -1;
  RETURN;
END;


  PROCEDURE SubscribeNewsletterByEmail (
    vcPemail IN VARCHAR2,
    iPsite_id IN INT,
    vcPnewsletter_csv IN VARCHAR2,
    cPstatus IN CHAR,
    cPguid OUT CHAR
  )
  AS
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT := 0;
    cLnewsletterCsv VARCHAR2(100);
    cLguid CHAR(32);
  BEGIN
    iLstartpos := 1;
    cLnewsletterCsv := vcPnewsletter_csv;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_news_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLnewsletterCsv)),0);

    IF(iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLnewsletterCsv, ',');
        WHILE iLendpos > 0
        LOOP
          BEGIN
            INSERT INTO temp_news_int_table
              (
                column1
              )
            VALUES
              (
                CAST(SUBSTR(cLnewsletterCsv,1,iLendpos-1) AS INT)
              );

            cLnewsletterCsv := SUBSTR(cLnewsletterCsv, iLendpos+1);
            iLendpos := INSTR(cLnewsletterCsv, ',');
          END;
        END LOOP;
        INSERT INTO temp_news_int_table
          (
            column1
          )
        VALUES
          (
            CAST(cLnewsletterCsv AS INT)
          );
      END;
    END IF;

    cLguid := SYS_GUID();

    INSERT INTO ya_newsletter_subscriber
      (
        guid,
        email,
        site_id,
        status,
        newsletter_id,
        last_modified_datetime,
        downloaded_flag
      )
    SELECT
      cLguid,
      vcPemail,
      iPsite_id,
      cPstatus,
      column1,  -- newsletterId
      SYSDATE,
      'N'
    FROM
      temp_news_int_table
    WHERE column1 NOT IN -- newsletterId
      (
        SELECT newsletter_id
        FROM ya_newsletter_subscriber
        WHERE email = vcPemail
      );
    COMMIT;
    cPguid := cLguid;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
        cPguid := '';
      END;
    END IF;
    RETURN;
  END SubscribeNewsletterByEmail;

	PROCEDURE GetExistingEmailList (
    iPnewsletter_id		IN INT,
		iPsite_id IN INT,
		vcPmembershipType IN VARCHAR2,
		curPresult 			OUT curGgetNews
  )
  AS
  BEGIN 
		IF (iPnewsletter_id = 45 and vcPmembershipType <> 'All') THEN
			IF (vcPmembershipType = 'Regular') THEN
				OPEN curPresult FOR 
		    SELECT DISTINCT regularEmailList.email AS email FROM
				(
					(
						--email of monthly newsletter subscriber who don't have any membership
						SELECT DISTINCT yns.email
						FROM ya_newsletter_subscriber yns
						LEFT JOIN loyalty_customer lc ON lc.ya_shopper_id = yns.shopper_id AND lc.site_id = iPsite_id
						LEFT JOIN loyalty_membership lm ON lc.loyalty_membership_id = lm.id
						WHERE yns.newsletter_id = 45 AND yns.status = 'A' AND yns.site_id = iPsite_id
						AND 
						(
							NOT EXISTS
							(
								SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = yns.shopper_id
							) 
							OR yns.shopper_id IS NULL
						) 
						AND NOT EXISTS 
						(
							SELECT 1 FROM ya_shopper ya WHERE yns.shopper_id IS NOT NULL
							AND ya.shopper_id = yns.shopper_id AND ya.member_type = 3
						)
						AND lm.membership_name IS NULL
					)
					UNION
					(
						--email of monthly newsletter subscriber who has this year's "Regular" membership
						SELECT DISTINCT yns.email
						FROM ya_newsletter_subscriber yns
						LEFT JOIN loyalty_customer lc ON lc.ya_shopper_id = yns.shopper_id AND lc.site_id = iPsite_id
						LEFT JOIN loyalty_membership lm ON lc.loyalty_membership_id = lm.id AND lm.membership_year = to_char(sysdate, 'YYYY')
						WHERE yns.newsletter_id = 45 AND yns.status = 'A' AND yns.site_id = iPsite_id AND 
						(
							NOT EXISTS
							(
								SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = yns.shopper_id
							) 
							OR yns.shopper_id IS NULL
						) 
						AND NOT EXISTS
						(
							SELECT 1 FROM ya_shopper ya WHERE yns.shopper_id IS NOT NULL
							AND ya.shopper_id = yns.shopper_id AND ya.member_type = 3
						)
						AND lm.membership_name = vcPmembershipType
					)
				) regularEmailList;
			ELSE
				OPEN curPresult FOR 
					--email of monthly newsletter subscriber who has this year's membership apart from "Regular"
					SELECT DISTINCT yns.email
					FROM ya_newsletter_subscriber yns
					LEFT JOIN loyalty_customer lc ON lc.ya_shopper_id = yns.shopper_id AND lc.site_id = iPsite_id
					LEFT JOIN loyalty_membership lm ON lc.loyalty_membership_id = lm.id AND lm.membership_year = to_char(sysdate, 'YYYY')
					WHERE yns.newsletter_id = 45 AND yns.status = 'A' AND yns.site_id = iPsite_id
					AND 
					(
						NOT EXISTS
						(
							SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = yns.shopper_id
						) 
						OR yns.shopper_id IS NULL
					) 
					AND NOT EXISTS 
					(
						SELECT 1 FROM ya_shopper ya WHERE yns.shopper_id IS NOT NULL
						AND ya.shopper_id = yns.shopper_id 
						AND ya.member_type = 3
					)
					AND (lm.membership_name = vcPmembershipType);
			END IF;
		ELSE
			OPEN curPresult FOR 
	    SELECT DISTINCT email
	    FROM ya_newsletter_subscriber yns
	    WHERE yns.newsletter_id = iPnewsletter_id AND yns.status = 'A' AND yns.site_id = iPsite_id
			AND 
			(
				NOT EXISTS 
			  (
					SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = yns.shopper_id
				) 
				OR yns.shopper_id IS NULL
			)
			AND NOT EXISTS
			(
				SELECT 1 FROM ya_shopper ya WHERE yns.shopper_id IS NOT NULL
				AND ya.shopper_id = yns.shopper_id AND ya.member_type = 3
			);
		END IF;
    
  END GetExistingEmailList;
	
END Pkg_fe_NewsletterAccess;
/
 
REM END SS_ADM PKG_FE_NEWSLETTERACCESS
