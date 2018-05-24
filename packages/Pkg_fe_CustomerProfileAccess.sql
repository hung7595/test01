CREATE OR REPLACE PACKAGE Pkg_fe_CustomerProfileAccess
AS
  TYPE refcur IS ref CURSOR;

  PROCEDURE UpdateNewsletterPref (
    cPshopper_id        IN  CHAR,
    iPsite_id           IN  INT,
    cPselectedCsv           IN  VARCHAR2,
    cPunselectedCsv         IN  VARCHAR2
  );

  PROCEDURE DeleteShopper (
    cPshopper_id IN  CHAR,
	cPcommit IN CHAR DEFAULT 'Y',
	iPreturn_value OUT INT
  );

  FUNCTION MaskEmail(email IN VARCHAR2) RETURN VARCHAR2;

END Pkg_fe_CustomerProfileAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_fe_CustomerProfileAccess
IS

  PROCEDURE UpdateNewsletterPref (
    cPshopper_id        IN  CHAR,
    iPsite_id           IN  INT,
    cPselectedCsv       IN  VARCHAR2,
    cPunselectedCsv     IN  VARCHAR2
  ) AS
  iLstartAnswerPos          INT := 1;
  iLendAnswerPos        INT;
  iLtemp            INT;
  cLselectedCsv         VARCHAR2(300);
  cLunselectedCsv       VARCHAR2(300);
  iLNewsletterExist INT;
  iLInExcludeList INT;
  cLemail               VARCHAR2(255);
  BEGIN
	SELECT email INTO cLemail FROM ya_shopper WHERE shopper_id = cPshopper_Id;
    iLtemp := LENGTH(RTRIM(cPselectedCsv));
    IF(iLtemp) > 1 THEN
      BEGIN
      SELECT 1 INTO iLInExcludeList FROM ya_reminder_exclude_list WHERE site_id = iPsite_id AND shopper_id = cPshopper_id;
        EXCEPTION WHEN NO_DATA_FOUND THEN
        iLInExcludeList := -1;
      END;
      IF(iLInExcludeList) > 0 THEN
        DELETE FROM ya_reminder_exclude_list WHERE site_id = iPsite_id AND shopper_id = cPshopper_id;
      END IF;
    BEGIN
      iLendAnswerPos := INSTR(cPselectedCsv, ',');
      cLselectedCsv := cPselectedCsv;
      WHILE  iLendAnswerPos  >  0
      LOOP
        BEGIN
        SELECT 1 INTO iLNewsletterExist FROM ya_newsletter_subscriber WHERE email = cLemail AND newsletter_id = CAST(SUBSTR(cLselectedCsv, iLstartanswerPos, iLendanswerPos - iLstartanswerPos) as INT) and site_id = iPsite_id;
        EXCEPTION WHEN NO_DATA_FOUND THEN
        iLNewsletterExist := -1;
        END;
        IF(iLNewsletterExist) > 0 THEN
          UPDATE ya_newsletter_subscriber SET
          status = 'A',
          last_modified_datetime = SYSDATE,
          shopper_id = cPshopper_id
          WHERE email = cLemail AND newsletter_id = CAST(SUBSTR(cLselectedCsv, iLstartanswerPos, iLendanswerPos - iLstartanswerPos) as INT) and site_id = iPsite_id;
        ELSE
          INSERT INTO ya_newsletter_subscriber
            (email,shopper_id,guid,date_time,site_id,newsletter_id,status,rowguid)
            VALUES
            (cLemail,cPshopper_id,sys_guid(),sysdate,iPsite_id,CAST(SUBSTR(cLselectedCsv, iLstartanswerPos, iLendanswerPos - iLstartanswerPos) as INT),'A',sys_guid());
        END IF;
        cLselectedCsv := SUBSTR(cLselectedCsv, iLendanswerPos + 1, LENGTH(RTRIM(cLselectedCsv)) - iLendanswerPos);
        iLendanswerPos := INSTR(cLselectedCsv, ',');
      END LOOP;
    END;
    END IF;
    iLendAnswerPos := INSTR(cPunselectedCsv, ',');
      cLunselectedCsv := cPunselectedCsv;
      WHILE  iLendAnswerPos  >  0
      LOOP
          UPDATE ya_newsletter_subscriber SET
          status = 'R',
          shopper_id = cPshopper_id,
          last_modified_datetime = SYSDATE
          WHERE email=cLemail AND newsletter_id = CAST(SUBSTR(cLunselectedCsv, iLstartanswerPos, iLendanswerPos - iLstartanswerPos) as INT) and site_id = iPsite_id;
        cLunselectedCsv := SUBSTR(cLunselectedCsv, iLendanswerPos + 1, LENGTH(RTRIM(cLunselectedCsv)) - iLendanswerPos);
        iLendanswerPos := INSTR(cLunselectedCsv, ',');
      END LOOP;
    COMMIT;
  END UpdateNewsletterPref;

  PROCEDURE DeleteShopper (
    cPshopper_id IN CHAR,
	cPcommit IN CHAR DEFAULT 'Y',
	iPreturn_value OUT INT
  )
  AS
    iLcheck INT;
	cLemail VARCHAR2(255);
	cLcorrespondence_email VARCHAR2(255);
	cLmasked_email VARCHAR2(255);
	cLmasked_correspondence_email VARCHAR2(255);
  BEGIN
	SELECT email, correspondence_email INTO cLemail,  cLcorrespondence_email FROM ya_shopper WHERE shopper_id = cPshopper_Id and member_type <> 11;

	IF (cLemail IS NULL) THEN
	  iPreturn_value := -2;
	  RETURN;
	ELSE
	  iLcheck := 1;

      WHILE (iLcheck > 0)
      LOOP
	    -- masked policy:
		-- 1. From the 4th character until the last character before @, we will change them into *, all the email domain character, we will change them into *
		-- 2. append timestamp
		-- 3. append 10 digit random string
		-- e.g.: thomas.kwok@yesasia.com --> thom*******@*************_20180523144544QWDJQEAQOB
        select Pkg_fe_CustomerProfileAccess.MaskEmail(cLemail) || '_' || TO_CHAR(sysdate, 'YYYYMMDDHH24MISS') || dbms_random.string('U', 10) into cLmasked_email from dual;

		-- email field length is 255, make sure not excess the 255
		cLmasked_email := substr(cLmasked_email, 0, 255);

        SELECT COUNT(1) INTO iLcheck FROM ya_shopper WHERE email = cLmasked_email;
      END LOOP;
	END IF;

	if (cLcorrespondence_email IS NULL) THEN
	  cLmasked_correspondence_email := '';
	ELSE
	  select Pkg_fe_CustomerProfileAccess.MaskEmail(cLcorrespondence_email) into cLmasked_correspondence_email from dual;
	END IF;

	-- "masks" shopper email, cc email, update the shopper's member type id as "11", remove password, first name, last name and screen name
	update ya_shopper set member_type = 11,
	  password = 'PASSWORD_REMOVED',
	  firstname = 'FIRSTNAME_REMOVED',
	  lastname = 'LASTNAME_REMOVED',
	  username = 'USERNAME_REMOVED',
	  nickname = 'NICKNAME_REMOVED',
	  email = cLmasked_email,
	  correspondence_email = cLmasked_correspondence_email
	where shopper_id = cPshopper_id;

    -- log should be updated just after the update of the ya_shopper because of the trigger
    update ya_shopper_log set old_value = Pkg_fe_CustomerProfileAccess.MaskEmail(old_value),
      new_value = Pkg_fe_CustomerProfileAccess.MaskEmail(new_value)
    where column_name = 'email' and shopper_id = cPshopper_id;

	-- "masks" other guest's shopper email as well with the same email address value
	update ya_shopper set email = cLmasked_email where shopper_id in (select shopper_id from ya_shopper where type_id = 3 and email = cLemail);

	-- unsubscribe notification subscription
	update ya_app_subscription_type set subscribed = 'N',
	  mod_dt = sysdate
	where subscription_id in (select id from ya_app_subscription where shopper_id = cPshopper_id);

	-- unsubscribe newsletter subscription, remove email address
	update ya_newsletter_subscriber set email = cLmasked_email,
	  status = 'R',
	  last_modified_datetime = sysdate
	where shopper_id = cPshopper_id;

	-- mark the customer review as rejected
	update ya_customer_review set review_approved = 'R',
	  mod_user = 'Delete Shopper Job',
	  mod_dt = sysdate
	where shopper_id = cPshopper_id;

	-- mark app access token expired
	update ya_app_access set is_sign_out = 'Y',
	  device_id = 'DEVICE_ID_REMOVED',
	  misc = 'Delete Shopper Job'
	where shopper_id = cPshopper_id;

	-- remove credit card
	delete ya_credit_card_profile where shopper_id = cPshopper_id;

	-- remove address
	delete ya_address where shopper_id = cPshopper_id;

	-- remove basket items, saved items
	delete ya_new_basket where shopper_id = cPshopper_id;

	-- unbind social network login
	update ya_shopper_social_login set user_id = 'USED_ID_REMOVED', mod_dt = sysdate where shopper_id = cPshopper_id;
	update ya_shopper_social_login_log set user_id = 'USED_ID_REMOVED' where shopper_id = cPshopper_id;
	update ya_oauth_request set redirect_url = 'REDIRECT_URL_REMOVED' where id in (select oauth_request_id from ya_oauth where id in (select oauth_id from ya_shopper_social_login_log where shopper_id = cPshopper_id));
	update ya_oauth_response set user_id = 'USER_ID_REMOVED',
	  user_name = 'USER_NAME_REMOVED',
	  user_profile_img_path = 'USER_PROFILE_IMAGE_PATH_REMOVED',
	  access_token = 'ACCESS_TOKEN_REMOVED',
	  user_email = Pkg_fe_CustomerProfileAccess.MaskEmail(user_email)
	where id in (select oauth_response_id from ya_oauth where id in (select oauth_id from ya_shopper_social_login_log where shopper_id = cPshopper_id));

	iPreturn_value := 0;

	IF cPcommit = 'Y' THEN
	  COMMIT;
	END IF;

	EXCEPTION WHEN OTHERS THEN
      BEGIN
	    IF (cPcommit = 'Y') THEN
		  BEGIN
		    ROLLBACK;
		  END;
	    END IF;

	    iPreturn_value := -1;
      END;
  END DeleteShopper;

  FUNCTION MaskEmail(email IN VARCHAR2) RETURN VARCHAR2
  IS
    return_val VARCHAR2(255);
  BEGIN
    -- From the 4th character until the last character before @, we will change them into *, all the email domain character, we will change them into *
    select substr(email, 0, case when instr(email, '@', 1) > 4  THEN 4 ELSE instr(email, '@', 1) END) || regexp_replace(substr(email, (case when instr(email, '@', 1) > 4 THEN 4 ELSE instr(email, '@', 1) END) + 1), '[^@]', '*') into return_val from dual;

    return return_val;
  END MaskEmail;

END Pkg_fe_CustomerProfileAccess;
/
