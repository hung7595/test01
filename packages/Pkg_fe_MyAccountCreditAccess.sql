
REM START SS_ADM PKG_FE_MYACCOUNTCREDITACCESS

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_MYACCOUNTCREDITACCESS" 
As
  TYPE curGcredit_history IS REF CURSOR;

  PROCEDURE TransferCredit2 (
    cPemail IN VARCHAR2,
    iPsite_id IN INT,
    cPsource_currency IN VARCHAR,
    cPtarget_currency IN VARCHAR,
    nPtransfer_amount IN NUMBER,
    iPreturn_value OUT INT
  );

  PROCEDURE UpdateGiftCertContent (
    cPpurchase_name IN VARCHAR2,
    cPpurchase_email IN VARCHAR2,
    cPrecipient_name IN VARCHAR2,
    cPrecipient_email IN VARCHAR2,
    iLecard_type_id IN INT,
    cPmessage IN VARCHAR2,
    cPsubject IN VARCHAR2,
    cPcustomized IN VARCHAR2,
    sPcert_code IN VARCHAR2,
    iLupdate_count OUT INT
  );

  PROCEDURE GetCreditTransactionHistory (
    sPshopper_id IN VARCHAR2,
    iPsite_id IN INT,
    iLrecord_count IN INT,
    curPcredit_history OUT curGcredit_history
  );

  PROCEDURE TransferCredit (
    iLsite_id IN INT,
    cPemail IN VARCHAR2,
    iLamount IN NUMBER,
    cPfrom_currency IN VARCHAR2,
    cPto_currency IN VARCHAR2,
    iLreturn_value OUT INT
  );
END Pkg_fe_MyAccountCreditAccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_MYACCOUNTCREDITACCESS" 
IS
  PROCEDURE TransferCredit2 (
    cPemail IN VARCHAR2,
    iPsite_id IN INT,
    cPsource_currency IN VARCHAR,
    cPtarget_currency IN VARCHAR,
    nPtransfer_amount IN NUMBER,
    iPreturn_value OUT INT
  )
  AS
    cLshopper_id VARCHAR2(32);
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
  BEGIN
    dtLtransaction_date := SYSDATE;

    SELECT count(*) INTO iLrecord_found FROM ya_shopper WHERE email = cPemail;
    IF iLrecord_found = 0 THEN
      iPreturn_value := -1;
      RETURN;
    END IF;

    SELECT shopper_id INTO cLshopper_id FROM ya_shopper WHERE email = cPemail;

    SELECT count(*) INTO iLrecord_found FROM ya_frontend_credit_system cs WHERE cs.shopper_id = cLshopper_id AND cs.currency = cPsource_currency
                        AND ((cs.site_id = iPsite_id and cs.site_id not in (1,7)) or (cs.site_id in (1,7) and (iPsite_id = 1 or iPsite_id = 7)));

    IF iLrecord_found = 0 THEN
      iPreturn_value := -2;
      RETURN;
    END IF;

    -- get available amount
    SELECT sum(cs.current_balance) INTO nLavail_amount
    FROM ya_frontend_credit_system cs
    WHERE cs.shopper_id = cLshopper_id
      AND cs.currency = cPsource_currency
      AND ((cs.site_id = iPsite_id and cs.site_id not in (1,7)) or (cs.site_id in (1,7) and (iPsite_id = 1 or iPsite_id = 7)));

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
      SELECT count(*) INTO iLrecord_found FROM ya_frontend_credit_system cs
      WHERE cs.shopper_id = cLshopper_id
        AND cs.current_balance > 0
        AND cs.currency = cPsource_currency
        AND cs.current_balance >= nPtransfer_amount
        AND ((cs.site_id = iPsite_id and cs.site_id not in (1,7)) or (cs.site_id in (1,7) and (iPsite_id = 1 or iPsite_id = 7)));

      IF iLrecord_found > 0 THEN
        iLis_group := 0;
        -- select single credit id
        SELECT credit_id INTO iLcredit_group_id
        FROM ya_frontend_credit_system cs
        WHERE cs.shopper_id = cLshopper_id AND cs.currency = cPsource_currency AND cs.current_balance >= nPtransfer_amount AND rownum = 1
          AND ((cs.site_id = iPsite_id and cs.site_id not in (1,7)) or (cs.site_id in (1,7) and (iPsite_id = 1 or iPsite_id = 7)));
      ELSE
        iLis_group := 1;
      END IF;

      SELECT code_id INTO iLsource_currency_code
      FROM ya_lookup
      WHERE type = 'Currency' and code = cPsource_currency;

      SELECT code_id INTO iLtarget_currency_code
      FROM ya_lookup
      WHERE type = 'Currency' and code = cPtarget_currency;

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

      SELECT seq_frontend_credit_system.NEXTVAL into iLnew_credit_id FROM DUAL;
      INSERT INTO ya_frontend_credit_system (credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, currency, remark, rowguid)
      VALUES (iLnew_credit_id, iPsite_id, cLshopper_id, cLcredit_code, 4, nPtransfer_amount * nLexchange_rate, nPtransfer_amount * nLexchange_rate, dtLtransaction_date, 'N', cPtarget_currency, null, SYS_GUID());

      IF iLis_group = 1 THEN
        iLrecord_found := 1;
        WHILE iLrecord_found > 0
        LOOP
          cLcredit_group_code := dbms_random.string('X', 10);
          SELECT count(*) INTO iLrecord_found FROM ya_frontend_credit_system WHERE credit_code = cLcredit_group_code;
        END LOOP;

        SELECT seq_frontend_credit_system.NEXTVAL into iLcredit_group_id FROM DUAL;

        INSERT INTO ya_frontend_credit_system (credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, currency, remark, rowguid)
        VALUES (iLcredit_group_id, iPsite_id, cLshopper_id, cLcredit_group_code, 5, nPtransfer_amount, nPtransfer_amount, dtLtransaction_date, 'N', cPsource_currency, null, SYS_GUID());

        nLgroup_amount := 0;

        WHILE nLgroup_amount < nPtransfer_amount
        LOOP
          SELECT cs.current_balance, cs.credit_id INTO nLcredit_amount, iLcredit_id
          FROM ya_frontend_credit_system cs
          WHERE cs.shopper_id = cLshopper_id
            AND cs.currency = cPsource_currency
            AND cs.current_balance > 0
            AND ((cs.site_id = iPsite_id and cs.site_id not in (1,7)) or (cs.site_id in (1,7) and (iPsite_id = 1 or iPsite_id = 7)))
            AND ROWNUM = 1
          ORDER BY credit_id;

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
  END TransferCredit2;

  PROCEDURE UpdateGiftCertContent (
    cPpurchase_name IN VARCHAR2,
    cPpurchase_email IN VARCHAR2,
    cPrecipient_name IN VARCHAR2,
    cPrecipient_email IN VARCHAR2,
    iLecard_type_id IN INT,
    cPmessage IN VARCHAR2,
    cPsubject IN VARCHAR2,
    cPcustomized IN VARCHAR2,
    sPcert_code IN VARCHAR2,
    iLupdate_count OUT INT
  )
  AS
  BEGIN
    UPDATE ya_gift_cert
    SET purchaser_name = cPpurchase_name, purchaser_email = cPpurchase_email, recipient_name = cPrecipient_name
      , recipient_email = cPrecipient_email, ecard_type_id = iLecard_type_id, greeting_msg = cPmessage
      , msg_subject = cPsubject, customized = cPcustomized
    WHERE cert_code = sPcert_code;
    iLupdate_count := SQL%rowcount;
    COMMIT;
  END UpdateGiftCertContent;

  PROCEDURE GetCreditTransactionHistory (
    sPshopper_id IN VARCHAR2,
    iPsite_id IN INT,
    iLrecord_count IN INT,
    curPcredit_history OUT curGcredit_history
  )
  AS
  BEGIN
    OPEN curPcredit_history FOR
    SELECT * FROM (
      SELECT sum(fcst.credit_amount) as credit_amount,
        sum(fcst.debit_amount) as debit_amount,
        fcst.debit_ordernum,
        -1 as order_id, sum(fcst.snapshot_balance) as snapshot_balance,
        to_char(fcst.transaction_datetime, 'MON DD, YYYY') as trans_date,
        fcst.transaction_datetime,
        gc.purchaser_email,
        fcs.credit_type_id,
        fcs.currency as source_currency,
        fcs_e.currency as exchange_currency,
        fcst_e.credit_amount as converted_amount
      FROM ya_frontend_credit_system fcs
        INNER JOIN ya_frontend_credit_system_txn fcst ON fcs.credit_id = fcst.credit_id AND fcst.credit_credit_id is null
        LEFT OUTER JOIN ya_gift_cert gc ON fcs.credit_code = gc.cert_code
        LEFT OUTER JOIN ya_frontend_credit_system_txn fcst_e ON fcst_e.credit_credit_id = fcst.credit_id and fcst_e.credit_id = fcst.debit_credit_id
        LEFT OUTER JOIN ya_frontend_credit_system fcs_e ON fcs_e.credit_id = fcst_e.credit_id
        LEFT OUTER JOIN ya_frontend_credit_system_txn fcst1 ON fcst1.credit_id = fcst.credit_id and fcst1.action_id = 4 and fcst.action_id = 4
      WHERE fcs.shopper_id = sPshopper_id
        AND fcst1.credit_id is null
        AND ((fcs.site_id = iPsite_id and fcs.site_id not in (1,7)) or (fcs.site_id in (1,7) and (iPsite_id = 1 or iPsite_id = 7)))
      GROUP BY fcst.transaction_id, fcst.debit_ordernum, gc.purchaser_email, to_char(fcst.transaction_datetime, 'MON DD, YYYY'),
        fcst.transaction_datetime, fcs.credit_type_id, fcs.currency, fcs_e.currency, fcst_e.credit_amount
      ORDER BY fcst.transaction_datetime DESC
    ) fcst WHERE ROWNUM <= iLrecord_count
    ORDER BY fcst.transaction_datetime DESC;
  END GetCreditTransactionHistory;

  PROCEDURE TransferCredit (
    iLsite_id IN INT,
    cPemail IN VARCHAR2,
    iLamount IN NUMBER,
    cPfrom_currency IN VARCHAR2,
    cPto_currency IN VARCHAR2,
    iLreturn_value OUT INT
  )
  AS
  BEGIN
    iLreturn_value := 1;
  END TransferCredit;
END Pkg_fe_MyAccountCreditAccess;
/
 
REM END SS_ADM PKG_FE_MYACCOUNTCREDITACCESS
