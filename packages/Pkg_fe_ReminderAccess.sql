CREATE OR REPLACE package Pkg_fe_ReminderAccess
AS
    PROCEDURE InsertReminderExcludeList (
    cPshopperId		IN	CHAR,
    iPtypeId		IN	INT,
    iPsiteId		IN	INT,
    iPRETURN OUT INT
  );
END Pkg_fe_ReminderAccess;
/

CREATE OR REPLACE package body Pkg_fe_ReminderAccess
IS
    PROCEDURE InsertReminderExcludeList (
    cPshopperId		IN	CHAR,
    iPtypeId		IN	INT,
    iPsiteId		IN	INT,
    iPRETURN OUT INT
    )
AS
    iLtemp		INT := 0;
BEGIN
  SELECT COUNT(1)
  INTO iLtemp
  FROM ya_reminder_exclude_list
  WHERE
    shopper_id = cPshopperId
    AND reminder_id = iPtypeId
    AND site_id = iPsiteId;

  IF iLtemp = 0 THEN
    BEGIN
      INSERT INTO ya_reminder_exclude_list (
        shopper_id,
        reminder_id,
        site_id,
        LAST_MODIFIED_DATETIME
        )
      VALUES (
        cPshopperId,
        iPtypeId,
        iPsiteId,
        SYSDATE
        );

      iPreturn := SQL%ROWCOUNT;
      IF SQLCODE <> 0 THEN
        ROLLBACK;
        iPreturn := 0;
        RETURN;
      END IF;
    END;
  END IF;
  COMMIT;
END;
END Pkg_fe_ReminderAccess;
/

