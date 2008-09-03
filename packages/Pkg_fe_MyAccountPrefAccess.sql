CREATE OR REPLACE package Pkg_fe_MyAccountPrefAccess
As
  PROCEDURE AddReminderExcludeList (
    cPshopper_id IN VARCHAR2,
    iLsite_id IN INT
  );

  PROCEDURE DeleteReminderExcludeList (
    cPshopper_id IN VARCHAR2,
    iLsite_id IN INT
  );

  PROCEDURE UpdateNewsletterEmail (
    cPshopper_id IN VARCHAR2,
    cPold_email IN VARCHAR2,
    cPnew_email IN VARCHAR2
  );

  PROCEDURE SubscribePendingNewsletter (
    cPemail IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLsite_id IN INT,
    cPidentity IN VARCHAR2,
    iLupdate_count OUT INT
  );

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

  PROCEDURE UnsubscribeNewsletterEmail (
    cPemail IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLupdate_count OUT INT
  );
END Pkg_fe_MyAccountPrefAccess;
/

CREATE OR REPLACE package body Pkg_fe_MyAccountPrefAccess
IS
  PROCEDURE AddReminderExcludeList (
    cPshopper_id IN VARCHAR2,
    iLsite_id IN INT
  )
  AS
  BEGIN
    DELETE FROM ya_reminder_exclude_list WHERE shopper_id = cPshopper_id AND site_id = iLsite_id;
    COMMIT;

    INSERT INTO ya_reminder_exclude_list (shopper_id, reminder_id, last_modified_datetime, site_id, rowguid)
    VALUES (cPshopper_id, 1, SYSDATE, iLsite_id, SYS_GUID());
    COMMIT;
  END AddReminderExcludeList;

  PROCEDURE DeleteReminderExcludeList (
    cPshopper_id IN VARCHAR2,
    iLsite_id IN INT
  )
  AS
  BEGIN
    DELETE FROM ya_reminder_exclude_list WHERE shopper_id = cPshopper_id AND site_id = iLsite_id;
    COMMIT;
  END DeleteReminderExcludeList;

  PROCEDURE UpdateNewsletterEmail (
    cPshopper_id IN VARCHAR2,
    cPold_email IN VARCHAR2,
    cPnew_email IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_newsletter_subscriber SET email = cPnew_email WHERE email = cPold_email;
    COMMIT;
  END UpdateNewsletterEmail;

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

  PROCEDURE UnsubscribeNewsletterEmail (
    cPemail IN VARCHAR2,
    iLnewsletter_id IN INT,
    iLupdate_count OUT INT
  )
  AS
  BEGIN
    UPDATE ya_newsletter_subscriber SET status='R', pending_status=null, downloaded_flag='N', last_modified_datetime=SYSDATE
    WHERE email = cPemail AND newsletter_id = iLnewsletter_id AND status <> 'R';
    iLupdate_count := SQL%rowcount;
    COMMIT;
  END UnsubscribeNewsletterEmail;
END Pkg_fe_MyAccountPrefAccess;
/

