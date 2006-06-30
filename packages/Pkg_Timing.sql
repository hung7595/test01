CREATE OR REPLACE PACKAGE Pkg_Timing
AS
  PROCEDURE InsertLog(
    cPdb IN VARCHAR2,
    cPmethod_name IN VARCHAR2,
    ncPparameter IN NVARCHAR2,
    tPrun_time IN NUMBER,
    ncPremark IN NVARCHAR2
  );
END Pkg_Timing;
/

CREATE OR REPLACE PACKAGE body Pkg_Timing
AS
  PROCEDURE InsertLog(
    cPdb IN VARCHAR2,
    cPmethod_name IN VARCHAR2,
    ncPparameter IN NVARCHAR2,
    tPrun_time IN NUMBER,
    ncPremark IN NVARCHAR2
  )
  AS
    iLtrial_id INT;
  BEGIN
    SELECT seq_db_timing_log.nextval INTO iLtrial_id FROM DUAL;

    INSERT INTO db_timing_log
    (trial_id, db, method_name, parameter, run_time, remark)
    VALUES
    (iLtrial_id, cPdb, cPmethod_name, ncPparameter, tPrun_time, ncPremark);

    COMMIT;
  END InsertLog;
END Pkg_Timing;
/

