CREATE OR REPLACE package Pkg_fe_ManagementCreditAccess
As
  PROCEDURE CreateCredit (
    iPsite_id IN INT,
    cPemail IN VARCHAR2,
    iPcredit_type IN INT,
    cPcurrency IN VARCHAR2,
    nPbalance IN NUMBER,
    cPremark IN VARCHAR2,
    cPcredit_code OUT VARCHAR2,
    iPerror_code OUT INT
  );

  PROCEDURE CreateCreditByShopperId (
    iPsite_id IN INT,
    sPshopper_id IN VARCHAR2,
    iPcredit_type IN INT,
    cPcurrency IN VARCHAR2,
    nPbalance IN NUMBER,
    cPremark IN VARCHAR2,
    cPcredit_code OUT VARCHAR2,
    iPerror_code OUT INT
  );
  
END Pkg_fe_ManagementCreditAccess;
/

CREATE OR REPLACE package body Pkg_fe_ManagementCreditAccess
IS
  PROCEDURE CreateCredit(
    iPsite_id IN INT,
    cPemail IN VARCHAR2,
    iPcredit_type IN INT,
    cPcurrency IN VARCHAR2,
    nPbalance IN NUMBER,
    cPremark IN VARCHAR2,
    cPcredit_code OUT VARCHAR2,
    iPerror_code OUT INT
  )
  AS
    cLshopper_id VARCHAR2(32);
    iLcredit_id INT;
    iLrecord_found INT;
  BEGIN
    SELECT count(1) INTO iLrecord_found FROM ya_shopper WHERE email = cPemail;

    IF iLrecord_found = 0 THEN
      iPerror_code := -2;
      RETURN;
    END IF;

    SELECT shopper_id INTO cLshopper_id FROM ya_shopper WHERE email = cPemail;

    iLrecord_found := 1;
    WHILE iLrecord_found > 0
    LOOP
      cPcredit_code := dbms_random.string('X', 10);
      SELECT count(*) INTO iLrecord_found
      FROM ya_frontend_credit_system
      WHERE credit_code = cPcredit_code;
    END LOOP;

    SELECT seq_frontend_credit_system.NEXTVAL into iLcredit_id FROM DUAL;

    INSERT INTO ya_frontend_credit_system (credit_id, site_Id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, rowguid)
    VALUES (iLcredit_id, iPsite_id, cLshopper_id, cPcredit_code, iPcredit_type, nPbalance, nPbalance, SYSDATE, 'N', cPremark, cPcurrency, SYS_GUID());

    INSERT INTO ya_frontend_credit_system_txn (credit_id, credit_amount, snapshot_balance, rowguid, action_id)
    VALUES (iLcredit_id, nPbalance, nPbalance, SYS_GUID(), 1);

    iPerror_code := 0;
    COMMIT;
  END CreateCredit;
  
  PROCEDURE CreateCreditByShopperId(
    iPsite_id IN INT,
    sPshopper_id IN VARCHAR2,
    iPcredit_type IN INT,
    cPcurrency IN VARCHAR2,
    nPbalance IN NUMBER,
    cPremark IN VARCHAR2,
    cPcredit_code OUT VARCHAR2,
    iPerror_code OUT INT
  )
  AS
    iLcredit_id INT;
    iLrecord_found INT;
  BEGIN
    SELECT count(1) INTO iLrecord_found FROM ya_shopper WHERE shopper_id = sPshopper_id;

    IF iLrecord_found = 0 THEN
      iPerror_code := -2;
      RETURN;
    END IF;

    iLrecord_found := 1;
    WHILE iLrecord_found > 0
    LOOP
      cPcredit_code := dbms_random.string('X', 10);
      SELECT count(*) INTO iLrecord_found
      FROM ya_frontend_credit_system
      WHERE credit_code = cPcredit_code;
    END LOOP;

    SELECT seq_frontend_credit_system.NEXTVAL into iLcredit_id FROM DUAL;

    INSERT INTO ya_frontend_credit_system (credit_id, site_Id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, rowguid)
    VALUES (iLcredit_id, iPsite_id, sPshopper_id, cPcredit_code, iPcredit_type, nPbalance, nPbalance, SYSDATE, 'N', cPremark, cPcurrency, SYS_GUID());

    INSERT INTO ya_frontend_credit_system_txn (credit_id, credit_amount, snapshot_balance, rowguid, action_id)
    VALUES (iLcredit_id, nPbalance, nPbalance, SYS_GUID(), 1);

    iPerror_code := 0;
    COMMIT;
  END CreateCreditByShopperId;  
END Pkg_fe_ManagementCreditAccess;
/

