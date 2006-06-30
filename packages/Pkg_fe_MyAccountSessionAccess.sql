CREATE OR REPLACE package Pkg_fe_MyAccountSessionAccess
As
  PROCEDURE UpdateSession (
    cPshopper_id IN VARCHAR2,
    cPsession_id IN VARCHAR2
  );

  PROCEDURE DeleteSession (
    cPsession_id IN VARCHAR2
  );
END Pkg_fe_MyAccountSessionAccess;
/

CREATE OR REPLACE package body Pkg_fe_MyAccountSessionAccess
IS
  PROCEDURE UpdateSession (
    cPshopper_id IN VARCHAR2,
    cPsession_id IN VARCHAR2
  )
  AS
    iLrow_count INT;
  BEGIN
    UPDATE ya_session SET timestamp = SYSDATE WHERE session_id = cPsession_id AND shopper_id = cPshopper_id;

    iLrow_count := SQL%ROWCOUNT;

    IF iLrow_count = 0 THEN
      DELETE FROM ya_session WHERE shopper_id = cPshopper_id;
      INSERT INTO ya_session (session_id, timestamp, shopper_id) VALUES (cPsession_id, SYSDATE, cPshopper_id);
    END IF;

    COMMIT;
  END UpdateSession;

  PROCEDURE DeleteSession (
    cPsession_id IN VARCHAR2
  )
  AS
  BEGIN
    DELETE FROM ya_session WHERE session_id = cPsession_id;
    COMMIT;
  END DeleteSession;
END Pkg_fe_MyAccountSessionAccess;
/

