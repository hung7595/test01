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
  
  PROCEDURE TransferCredit (
    cPshopper_id IN VARCHAR2,
    cPsource_site_ids_csv IN VARCHAR2,
    iPtarget_site_id IN INT,
    cPsource_currency IN VARCHAR,
    cPtarget_currency IN VARCHAR,
    nPtransfer_amount IN NUMBER,
    iPreturn_value OUT INT
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
  
  PROCEDURE TransferCredit (
    cPshopper_id IN VARCHAR2,
    cPsource_site_ids_csv IN VARCHAR2,
    iPtarget_site_id IN INT,
    cPsource_currency IN VARCHAR,
    cPtarget_currency IN VARCHAR,
    nPtransfer_amount IN NUMBER,
    iPreturn_value OUT INT
  )
  AS
    cLcredit_code VARCHAR2(10);
    cLcredit_group_code VARCHAR2(10);
    iLnew_credit_id INT;
    iLcredit_id INT;
    iLcredit_group_id INT;
    nLavail_amount NUMBER;
    iLis_group INT;
    dtLtransaction_date DATE;
    iLsource_currency_code INT;
    iLtarget_currency_code INT;
    nLexchange_rate NUMBER;
    iLrecord_found INT;
    nLcurrent_balance NUMBER;
    nLgroup_amount NUMBER;
    nLreduce_amount NUMBER;
    nLcredit_amount NUMBER;
    sLSQL1 VARCHAR2(1000);
    sLSQL2 VARCHAR2(1000);
    sLSQL3 VARCHAR2(1000);
    sLSQL4 VARCHAR2(1000);
    sLSQL5 VARCHAR2(1000);
  BEGIN
    dtLtransaction_date := SYSDATE;
    -- any credit record
    sLSQL1 := 'SELECT count(*) FROM ya_frontend_credit_system cs WHERE cs.shopper_id = ''' || cPshopper_id || ''' AND cs.currency = ''' || cPsource_currency 
    || ''' AND cs.site_id in (' || cPsource_site_ids_csv || ')';
    EXECUTE IMMEDIATE sLSQL1 INTO iLrecord_found;

    IF iLrecord_found = 0 THEN
      iPreturn_value := -2;
      RETURN;
    END IF;

    -- get available amount
    sLSQL2 := 'SELECT sum(cs.current_balance) FROM ya_frontend_credit_system cs WHERE cs.shopper_id = ''' || cPshopper_id || ''' AND cs.currency = ''' || cPsource_currency 
    || ''' AND cs.site_id in (' || cPsource_site_ids_csv || ')';
    EXECUTE IMMEDIATE sLSQL2 INTO nLavail_amount;

    IF nLavail_amount < nPtransfer_amount THEN
      iPreturn_value := -2;
    ELSE
      -- generate an unique credit code
      iLrecord_found := 1;
      WHILE iLrecord_found > 0
      LOOP
        cLcredit_code := dbms_random.string('X', 10);
        SELECT count(*) INTO iLrecord_found
        FROM ya_frontend_credit_system
        WHERE credit_code = cLcredit_code;
      END LOOP;

      -- check if one credit can fulfill the request
      sLSQL3 := 'SELECT count(*) FROM ya_frontend_credit_system cs WHERE cs.shopper_id = ''' || cPshopper_id 
        || ''' AND cs.current_balance > 0 AND cs.currency = ''' || cPsource_currency 
        || ''' AND cs.current_balance >= ''' || nPtransfer_amount
        || ''' AND cs.site_id in (' || cPsource_site_ids_csv || ')';
      EXECUTE IMMEDIATE sLSQL3 INTO iLrecord_found;

      IF iLrecord_found > 0 THEN
        iLis_group := 0;
        -- select single credit id
        sLSQL4 := 'SELECT credit_id FROM ya_frontend_credit_system cs WHERE cs.shopper_id = ''' || cPshopper_id 
        || ''' AND cs.currency = ''' || cPsource_currency 
        || ''' AND cs.current_balance >= ''' || nPtransfer_amount
        || ''' AND cs.site_id in (' || cPsource_site_ids_csv || ') AND rownum = 1';
        EXECUTE IMMEDIATE sLSQL4 INTO iLcredit_group_id;
      ELSE
        iLis_group := 1;
      END IF;

      SELECT code_id INTO iLsource_currency_code
      FROM ya_lookup
      WHERE type = 'Currency' and code = cPsource_currency;

      SELECT code_id INTO iLtarget_currency_code
      FROM ya_lookup
      WHERE type = 'Currency' and code = cPtarget_currency;

      IF iLtarget_currency_code = iLsource_currency_code THEN 
        nLexchange_rate := 1;
      ELSE
        SELECT count(*) INTO iLrecord_found
        FROM ya_exchange_rate
        WHERE source_currency_id = iLsource_currency_code
          AND currency_id = iLtarget_currency_code;
  
        IF iLrecord_found = 0 THEN
          SELECT 1/exchange_rate INTO nLexchange_rate
          FROM ya_exchange_rate
          WHERE source_currency_id = iLtarget_currency_code
            AND currency_id = iLsource_currency_code;
        ELSE
          SELECT exchange_rate INTO nLexchange_rate
          FROM ya_exchange_rate
          WHERE source_currency_id = iLsource_currency_code
            AND currency_id = iLtarget_currency_code;
        END IF;
      END IF;

      SELECT seq_frontend_credit_system.NEXTVAL into iLnew_credit_id FROM DUAL;
      INSERT INTO ya_frontend_credit_system (credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, currency, remark, rowguid)
      VALUES (iLnew_credit_id, iPtarget_site_id, cPshopper_id, cLcredit_code, 4, nPtransfer_amount * nLexchange_rate, nPtransfer_amount * nLexchange_rate, dtLtransaction_date, 'N', cPtarget_currency, null, SYS_GUID());

      -- grouping credit records to transfer
      IF iLis_group = 1 THEN
        iLrecord_found := 1;
        WHILE iLrecord_found > 0
        LOOP
          cLcredit_group_code := dbms_random.string('X', 10);
          SELECT count(*) INTO iLrecord_found FROM ya_frontend_credit_system WHERE credit_code = cLcredit_group_code;
        END LOOP;

        SELECT seq_frontend_credit_system.NEXTVAL into iLcredit_group_id FROM DUAL;

        INSERT INTO ya_frontend_credit_system (credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, currency, remark, rowguid)
        VALUES (iLcredit_group_id, iPtarget_site_id, cPshopper_id, cLcredit_group_code, 5, nPtransfer_amount, nPtransfer_amount, dtLtransaction_date, 'N', cPsource_currency, null, SYS_GUID());

        nLgroup_amount := 0;

        WHILE nLgroup_amount < nPtransfer_amount
        LOOP
	        sLSQL5 := 'SELECT cs.current_balance, cs.credit_id FROM ya_frontend_credit_system cs WHERE cs.shopper_id = ''' || cPshopper_id 
	        || ''' AND cs.currency = ''' || cPsource_currency 
	        || ''' AND cs.current_balance >  0 AND cs.site_id in (' || cPsource_site_ids_csv 
            || ') AND rownum = 1 ORDER BY credit_id';
	        EXECUTE IMMEDIATE sLSQL5 INTO nLcredit_amount, iLcredit_id;

          IF (nPtransfer_amount - nLgroup_amount) > nLcredit_amount THEN
            nLreduce_amount := nLcredit_amount;
            nLgroup_amount := nLgroup_amount + nLcredit_amount;
            nLcredit_amount := 0;
          ELSE
            nLreduce_amount := nPtransfer_amount - nLgroup_amount;
            nLcredit_amount := nLcredit_amount - (nPtransfer_amount - nLgroup_amount);
            nLgroup_amount := nPtransfer_amount;
          END IF;

          UPDATE ya_frontend_credit_system
            SET current_Balance = nLcredit_amount
          WHERE credit_id = iLcredit_id;

          INSERT INTO ya_frontend_credit_system_txn
          (credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_id, transaction_datetime, transaction_remark, action_id, credit_credit_id, debit_credit_id, rowguid)
          VALUES (iLcredit_id, null, null, nLreduce_amount, null, nLcredit_amount, SYS_GUID(), dtLtransaction_date, NULL, 3, NULL, iLcredit_group_id, SYS_GUID());

          INSERT INTO ya_frontend_credit_system_txn
          (credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_id, transaction_datetime, transaction_remark, action_id, credit_credit_id, debit_credit_id, rowguid)
          VALUES (iLcredit_group_id, nLreduce_amount, NULL, NULL, NULL, nLgroup_amount, SYS_GUID(), dtLtransaction_date, NULL, 3, iLcredit_id, NULL,  SYS_GUID());
        END LOOP;
      END IF;

      SELECT current_balance INTO nLcurrent_balance
      FROM ya_frontend_credit_system
      WHERE credit_id = iLcredit_group_id;

      UPDATE ya_frontend_credit_system
        SET current_Balance = nLcurrent_balance - nPtransfer_amount
      WHERE credit_id = iLcredit_group_id;

      INSERT INTO ya_frontend_credit_system_txn
      (credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_id, transaction_datetime, transaction_remark, action_id, credit_credit_id, debit_credit_id, rowguid)
      VALUES (iLcredit_group_id, null, null, nPtransfer_amount, null, nLcurrent_balance - nPtransfer_amount, SYS_GUID(), dtLtransaction_date, NULL, 3, NULL, iLnew_credit_id, SYS_GUID());

      INSERT INTO ya_frontend_credit_system_txn
      (credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_id, transaction_datetime, transaction_remark, action_id, credit_credit_id, debit_credit_id, rowguid)
      VALUES (iLnew_credit_id, ROUND(nPtransfer_amount * nLexchange_rate,2), NULL, NULL, NULL, ROUND(nPtransfer_amount * nLexchange_rate,2), SYS_GUID(), dtLtransaction_date, NULL, 3, iLcredit_group_id, NULL,  SYS_GUID());
      iPreturn_value := 0;
      COMMIT;
    END IF;
  END TransferCredit;
END Pkg_fe_ManagementCreditAccess;
/

