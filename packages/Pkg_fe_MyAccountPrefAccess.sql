CREATE OR REPLACE package Pkg_fe_MyAccountPrefAccess
As
  TYPE curGgetNews IS REF CURSOR;

  PROCEDURE SubscribeNewsletterEmail (
    cPemail IN VARCHAR2,
    cPshopper_id IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLsite_id IN INT,
    iLupdate_count OUT INT
  );
  
  PROCEDURE SubscribeNewsletterByGUID (
    cPGUID IN VARCHAR2,
    iLsite_id IN INT,
    iLupdate_count OUT INT
  );
  
  PROCEDURE SubscribeNewsletterByEmailGUID (
    cPemail IN VARCHAR2,
    cPGUID IN VARCHAR2,
    iLsite_id IN INT,
    iLupdate_count OUT INT
  );
  
  PROCEDURE SubscribePendingNewsletter (
    cPemail IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLsite_id IN INT,
    cPidentity IN VARCHAR2,
    iLupdate_count OUT INT
  );

  PROCEDURE GenerateAssociateLinkId (
    iPassociateId IN INT,
    cPsiteName IN VARCHAR2,
    iLlinkId OUT INT
  );

  PROCEDURE GetSimpleEmailList (
    iPnewsletter_id     IN  INT,
    iPsite_id IN INT,
    curPresult OUT curGgetNews
  );

  PROCEDURE GetLangPreferenceEmailList (
    iPnewsletter_id     IN  INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult OUT curGgetNews
  );

END Pkg_fe_MyAccountPrefAccess;
/

CREATE OR REPLACE package body Pkg_fe_MyAccountPrefAccess
IS

  PROCEDURE SubscribeNewsletterEmail (
    cPemail IN VARCHAR2,
    cPshopper_id IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLsite_id IN INT,
    iLupdate_count OUT INT
  )
  AS
    cPstatus VARCHAR2(1);
    iLrecord_count INT;
  BEGIN
    SELECT COUNT(status) INTO iLrecord_count FROM ya_newsletter_subscriber WHERE email = cPemail AND newsletter_id = iLnewsletter_id AND site_id = iLsite_id;
    IF iLrecord_count = 0 THEN
      INSERT INTO ya_newsletter_subscriber (guid, email, site_id, status, newsletter_id, last_modified_datetime, downloaded_flag, shopper_id)
        VALUES (SYS_GUID(), cPemail, iLsite_id, 'A', iLnewsletter_id, SYSDATE, 'N', cPshopper_id);
      iLupdate_count := 1;
    ELSE
      SELECT COUNT(status) INTO iLrecord_count FROM ya_newsletter_subscriber WHERE email = cPemail AND newsletter_id = iLnewsletter_id AND status = 'A'AND site_id = iLsite_id;
      IF iLrecord_count = 0 THEN
        UPDATE ya_newsletter_subscriber SET status = 'A', pending_status=null, downloaded_flag='N', last_modified_datetime=SYSDATE
        WHERE email = cPemail AND newsletter_id = iLnewsletter_id AND site_id = iLsite_id;
        iLupdate_count := SQL%rowcount;
      ELSE
        iLupdate_count := 0;
      END IF;
    END IF;
    COMMIT;
  END SubscribeNewsletterEmail;
  
  PROCEDURE SubscribeNewsletterByGUID (
    cPGUID IN VARCHAR2,
    iLsite_id IN INT,
    iLupdate_count OUT INT
  )
  AS
    iLrecord_count INT;
  BEGIN
    UPDATE ya_newsletter_subscriber SET status = 'A', pending_status=null, downloaded_flag='N', last_modified_datetime=SYSDATE, guid = SYS_GUID()
    WHERE guid = cPGUID AND site_id = iLsite_id;
    iLupdate_count := SQL%rowcount;
    COMMIT;
  END SubscribeNewsletterByGUID;
  
  PROCEDURE SubscribeNewsletterByEmailGUID (
    cPemail IN VARCHAR2,
    cPGUID IN VARCHAR2,
    iLsite_id IN INT,
    iLupdate_count OUT INT
  )
  AS
    iLrecord_count INT;
  BEGIN
    UPDATE ya_newsletter_subscriber SET status = 'A', pending_status=null, downloaded_flag='N', last_modified_datetime=SYSDATE, guid = SYS_GUID()
    WHERE email = cPemail AND SUBSTR(guid,2,6) = cPGUID AND site_id = iLsite_id;
    iLupdate_count := SQL%rowcount;
    COMMIT;
  END SubscribeNewsletterByEmailGUID;
  
  PROCEDURE SubscribePendingNewsletter (
    cPemail IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLsite_id IN INT,
    cPidentity IN VARCHAR2,
    iLupdate_count OUT INT
  )
  AS
    cPstatus VARCHAR2(1);
    iLrecord_count INT;
  BEGIN
    SELECT COUNT(1) INTO iLrecord_count FROM ya_newsletter_subscriber WHERE email = cPemail AND newsletter_id = iLnewsletter_id AND site_id = iLsite_id;
    IF iLrecord_count = 0 THEN
      INSERT INTO ya_newsletter_subscriber (guid, email, site_id, status, pending_status, newsletter_id, last_modified_datetime, downloaded_flag)
        VALUES (cPidentity, cPemail, iLsite_id, null, 'A', iLnewsletter_id, SYSDATE, 'N');
      iLupdate_count := 1;
    ELSE
      SELECT COUNT(1) INTO iLrecord_count FROM ya_newsletter_subscriber WHERE email = cPemail AND newsletter_id = iLnewsletter_id AND (status = 'A' or pending_status = 'A') AND site_id = iLsite_id;
      IF iLrecord_count = 0 THEN
        UPDATE ya_newsletter_subscriber SET pending_status = 'A', downloaded_flag='N', last_modified_datetime=SYSDATE, guid=cPidentity
        WHERE email = cPemail AND site_id = iLsite_id AND newsletter_id = iLnewsletter_id;
        iLupdate_count := SQL%rowcount;
      ELSE
        iLupdate_count := 0;
      END IF;
    END IF;
    UPDATE ya_newsletter_subscriber SET guid=cPidentity
    WHERE email = cPemail AND site_id = iLsite_id AND pending_status = 'A';
    COMMIT;
  END SubscribePendingNewsletter;

  PROCEDURE GenerateAssociateLinkId
  (
    iPassociateId IN INT,
    cPsiteName IN VARCHAR2,
    iLlinkId OUT INT
  )
  IS
    cLlinkCode VARCHAR(8);
    iLcheck INT;
    iLlength INT;
  BEGIN
    iLcheck := 1;
    iLlength := 8;

    WHILE (iLcheck>0)
    LOOP
      SELECT dbms_random.string('X', iLlength) str INTO cLlinkCode FROM dual;
      SELECT COUNT(1) INTO iLcheck FROM YA_ASSOCIATE_LINK WHERE link_code = cLlinkCode;
    END LOOP;

    SELECT SEQ_ASSOCIATE_LINK.nextval into iLlinkId from dual;

    INSERT INTO YA_ASSOCIATE_LINK (
      associate_id,link_id,site_name,LINK_CODE,LINK_TYPE,LINK_PERCENTAGE,LINK_STATUS,LINK_URL,LINK_DESC,CREATED_USER,CREATED_DATE,LANG_ID)
    VALUES (iPassociateId, iLlinkId, cPsiteName, cLlinkCode , 2, 0.1, 2, 'http:', cPsiteName, 'system', sysdate, 1 );
	
	IF (SQL%ROWCOUNT>0) AND (SQLCODE=0) THEN
	    COMMIT;
	ELSE
        iLlinkId := -1;
	    ROLLBACK;
	END IF;
  END GenerateAssociateLinkId;

  PROCEDURE GetSimpleEmailList (
    iPnewsletter_id     IN INT,
    iPsite_id IN INT,
    curPresult OUT curGgetNews
  )
  AS
  BEGIN
      OPEN curPresult FOR
        SELECT DISTINCT yns.email
        FROM ya_newsletter_subscriber yns
        WHERE yns.site_id = iPsite_id AND (case when yns.status = 'A' then yns.newsletter_id else null end) = iPnewsletter_id
        AND NOT EXISTS
        (
            SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = yns.shopper_id
        )
        AND NOT EXISTS
        (
            SELECT 1 FROM dm_hardbounce hardbounce WHERE lower(yns.email) = lower(hardbounce.email)
         );
  END GetSimpleEmailList;

  PROCEDURE GetLangPreferenceEmailList (
    iPnewsletter_id     IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult OUT curGgetNews
  )
  AS
  BEGIN
    -- normally, for site id = 14 only
    -- consider on ya_shopper_site_preference
    IF (iPlang_id = 1) THEN
      -- for default site lang, need to select both ya_shopper_site_preference is null and the ya_shopper_site_preference.lang_id = iPlang_id
      -- exclude the subscriber which subscribed yscn newsletter
      OPEN curPresult FOR
        SELECT distinct email from (
        SELECT email, shopper_id from (
          -- shopper who do not have site preference record
          SELECT yns.email, yns.shopper_id
		        FROM ya_newsletter_subscriber yns
		        WHERE yns.site_id = iPsite_id AND (case when yns.status = 'A' then yns.newsletter_id else null end) = iPnewsletter_id
		        AND NOT EXISTS
	            (
	                SELECT 1 FROM ya_shopper_site_preference yssp WHERE yssp.site_id = iPsite_id and yns.shopper_id = yssp.shopper_id
	            )
            UNION
              -- shopper who have site preference record and equal to select lang
	          SELECT yns.email, yns.shopper_id
	            FROM ya_newsletter_subscriber yns
	            LEFT JOIN ya_shopper_site_preference yssp on yssp.site_id = iPsite_id and yns.shopper_id = yssp.shopper_id
	            WHERE yns.site_id = iPsite_id AND (case when yns.status = 'A' then yns.newsletter_id else null end) = iPnewsletter_id
	            AND
	            (
	                -- handle "Shopper site preference's prefer lang"
	                yssp.prefer_lang_id = iPlang_id
	            )

		) a 
		WHERE 
            NOT EXISTS
            (
                SELECT 1 FROM ya_newsletter_subscriber WHERE a.email = email and site_id = 11
            )
	        AND NOT EXISTS
	        (
	            SELECT 1 FROM dm_hardbounce hardbounce WHERE lower(a.email) = lower(hardbounce.email)
	        )
	        AND NOT EXISTS
	        (
	            SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = a.shopper_id
	        )
      );
    ELSE
        IF (iPlang_id = 5) THEN
	      OPEN curPresult FOR
            SELECT distinct email from (
		        SELECT email, shopper_id from (
                -- shopper who have site preference record and equal to select lang
		          SELECT yns.email, yns.shopper_id
	                FROM ya_newsletter_subscriber yns
	                LEFT JOIN ya_shopper_site_preference yssp on yssp.site_id = iPsite_id and yns.shopper_id = yssp.shopper_id
	                WHERE yns.site_id = iPsite_id AND (case when yns.status = 'A' then yns.newsletter_id else null end) = iPnewsletter_id
	                AND
	                (
	                    -- handle "Shopper site preference's prefer lang"
	                    yssp.prefer_lang_id = iPlang_id
	                )
		          UNION
	                -- shopper who have subcribe both yscn and yshk newsletter
	                SELECT yns.email, yns.shopper_id
	                  FROM ya_newsletter_subscriber yns, ya_newsletter_subscriber yns_cn
	                  WHERE yns.site_id = iPsite_id AND (case when yns.status = 'A' then yns.newsletter_id else null end) = iPnewsletter_id
	                  AND yns.email = yns_cn.email and yns_cn.site_id = 11
		        ) a 
		        WHERE 
		            NOT EXISTS
		            (
		                SELECT 1 FROM dm_hardbounce hardbounce WHERE lower(a.email) = lower(hardbounce.email)
		            )
		            AND NOT EXISTS
		            (
		                SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = iPsite_id AND yrel.shopper_id = a.shopper_id
		            )
		      );
        ELSE
	      OPEN curPresult FOR
            -- shopper who have site preference record and equal to select lang
            SELECT distinct yns.email
            FROM ya_newsletter_subscriber yns
            LEFT JOIN ya_shopper_site_preference yssp on yssp.site_id = iPsite_id and yns.shopper_id = yssp.shopper_id
            WHERE yns.site_id = iPsite_id AND (case when yns.status = 'A' then yns.newsletter_id else null end) = iPnewsletter_id
            AND (
                -- handle "Shopper site preference's prefer lang"
                yssp.prefer_lang_id = iPlang_id
            ) AND NOT EXISTS (
                SELECT 1 FROM ya_newsletter_subscriber WHERE yns.email = email and site_id = 11
            ) AND NOT EXISTS (
                SELECT 1 FROM dm_hardbounce hardbounce WHERE lower(yns.email) = lower(hardbounce.email)
            )
            AND NOT EXISTS (
	            SELECT 1 FROM ya_reminder_exclude_list yrel WHERE yrel.site_id = yns.site_id AND yrel.shopper_id = yns.shopper_id
	        );
        END IF;
      
    END IF;

  END GetLangPreferenceEmailList;

END Pkg_fe_MyAccountPrefAccess;
/