CREATE OR REPLACE PACKAGE Pkg_fe_CustomerProfileAccess
AS
  TYPE refcur IS ref CURSOR;

  PROCEDURE UpdateNewsletterPref (
    cPshopper_id        IN  CHAR,
    iPsite_id           IN  INT,
    cPselectedCsv           IN  VARCHAR2,
    cPunselectedCsv         IN  VARCHAR2
  );
    
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

END Pkg_fe_CustomerProfileAccess;
/