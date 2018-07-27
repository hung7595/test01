CREATE OR REPLACE package Pkg_fe_RewardsCreditAccess
AS
    TYPE refCur IS REF CURSOR;

    PROCEDURE CreateRewardsCode (
        cPshopper_id IN CHAR,
        cPrewardsCode OUT VARCHAR2,
        iPerror_code OUT INT
    );

    PROCEDURE CreateRewardsCredit (
        iPorder_num IN INT,
        sPshopper_id IN VARCHAR2,
        iPsite_id IN INT,
        iPcredit_type_id IN INT,
        cPcurrency IN VARCHAR2,
        nPamount IN NUMBER,
        deciPdiscount IN DECIMAL,
        cPremark IN VARCHAR2,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        iPerror_code OUT INT
    );

    PROCEDURE DebitRewardsCredit (
      cPshopper_id IN CHAR,
      deciPdebit_amount IN DECIMAL,
      iPorder_num IN INT,
      cPcurrency IN CHAR DEFAULT 'USD',
      iPsite_id IN INT,
      cPupdatedUser IN VARCHAR2,
      cPcommit IN CHAR DEFAULT 'Y',
      iPerror_code OUT INT
    );

END Pkg_fe_RewardsCreditAccess;
/

CREATE OR REPLACE package body Pkg_fe_RewardsCreditAccess
IS
    PROCEDURE CreateRewardsCode (
        cPshopper_id IN CHAR,
        cPrewardsCode OUT VARCHAR2,
        iPerror_code OUT INT
    )
    AS
        iLrecord_found INT;
        iLrewards_code_exist INT;
    BEGIN
        SELECT COUNT(1) INTO iLrecord_found FROM YA_SHOPPER WHERE shopper_id = cPshopper_id;

        IF iLrecord_found = 0 THEN
            iPerror_code := -1;
            RETURN;
        END IF;

        SELECT COUNT(1) INTO iLrewards_code_exist FROM YA_SHOPPER WHERE shopper_id = cPshopper_id AND rewards_code IS NOT NULL;

        IF iLrewards_code_exist > 0 THEN
            iPerror_code := -2;
            RETURN;
        END IF;

        iLrecord_found := 0;

        LOOP
            cPrewardsCode := dbms_random.string('X', 6);
            SELECT COUNT(*) INTO iLrecord_found FROM YA_SHOPPER WHERE rewards_code = cPrewardsCode;
        EXIT WHEN (iLrecord_found = 0 AND NOT (InStr(cPrewardsCode, '0') > 0 OR InStr(cPrewardsCode, '1') > 0 OR InStr(cPrewardsCode, 'I') > 0 OR InStr(cPrewardsCode, 'O') > 0));
        END LOOP;

        UPDATE YA_SHOPPER
        SET rewards_code = cPrewardsCode
        WHERE shopper_id = cPshopper_id;

        iPerror_code := 0;
        COMMIT;
    END CreateRewardsCode;

    PROCEDURE CreateRewardsCredit (
        iPorder_num IN INT,
        sPshopper_id IN VARCHAR2,
        iPsite_id IN INT,
        iPcredit_type_id IN INT,
        cPcurrency IN VARCHAR2,
        nPamount IN NUMBER,
        deciPdiscount IN DECIMAL,
        cPremark IN VARCHAR2,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        iPerror_code OUT INT
    )
    AS
        iLrecord_found INT;
        iLcredit_id INT;
    BEGIN
        SELECT COUNT(1) INTO iLrecord_found FROM YA_SHOPPER WHERE shopper_id = sPshopper_id;
        IF iLrecord_found = 0 THEN
            iPerror_code := -1;
            RETURN;
        END IF;

        SELECT COUNT(1) INTO iLrecord_found FROM YA_ORDER WHERE order_num = iPorder_num;
        IF iLrecord_found = 0 THEN
            iPerror_code := -2;
            RETURN;
        END IF;

        SELECT seq_rewards_credit.NEXTVAL INTO iLcredit_id FROM DUAL;

        INSERT INTO ya_rewards_credit(id, site_id, shopper_id, credit_type_id, credit_discount, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, expiry_date, create_user, create_dt, mod_user, mod_dt)
        VALUES (iLcredit_id, iPsite_id, sPshopper_id, iPcredit_type_id, deciPdiscount, nPamount, nPamount, SYSDATE, 'N', cPremark, cPcurrency, iPexpiryDate, cPupdatedUser, SYSDATE, null, null);

        INSERT INTO ya_rewards_credit_txn(transaction_id, credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_datetime, transaction_remark, action_id, create_user, create_dt, mod_user, mod_dt)
        VALUES (SYS_GUID(), iLcredit_id, nPamount, iPorder_num, null, null, nPamount, SYSDATE, cPremark, 1, cPupdatedUser, SYSDATE, null, null);

        iPerror_code := 0;
        COMMIT;
    END CreateRewardsCredit;

    PROCEDURE DebitRewardsCredit (
        cPshopper_id IN CHAR,
        deciPdebit_amount IN DECIMAL,
        iPorder_num IN INT,
        cPcurrency IN CHAR DEFAULT 'USD',
        iPsite_id IN INT,
        cPupdatedUser IN VARCHAR2,
        cPcommit IN CHAR DEFAULT 'Y',
        iPerror_code OUT INT
    )
    AS
        iLtemp_balance DECIMAL(18,2);
        iLcredit_id INT;
        deciLdebit_amount DECIMAL(18,2);
        deciLdeduct_amount DECIMAL(18,2);
        deciLcurrent_balance DECIMAL(18,2);
        curLdeduct_cursor refCur;

    BEGIN
        -- make sure enough credit
        SELECT NVL(SUM(current_balance), 0)
        INTO iLtemp_balance
        FROM ya_rewards_credit
        WHERE shopper_id = cPshopper_id AND currency = cPcurrency AND site_id = iPsite_id;

        deciLdebit_amount := round(deciPdebit_amount, 3);
        IF (iLtemp_balance < deciLdebit_amount) THEN
            BEGIN
                -- not enough credits
                iPerror_code := -1;
            END;
        ELSE
            BEGIN
                OPEN curLdeduct_cursor FOR
                SELECT id, current_balance
                FROM ya_rewards_credit
                WHERE shopper_id = cPshopper_id AND currency = cPcurrency AND site_id = iPsite_id
                ORDER BY expiry_date ASC;


                FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
                WHILE (curLdeduct_cursor%FOUND) AND (deciLdebit_amount > 0) LOOP
                BEGIN
                    IF (deciLdebit_amount >= deciLcurrent_balance) THEN
                        BEGIN
                            deciLdeduct_amount := deciLcurrent_balance;
                        END;
                    ELSE
                        BEGIN
                            deciLdeduct_amount := deciLdebit_amount;
                        END;
                    END IF;

                    -- deduction
                    deciLdebit_amount := deciLdebit_amount - deciLcurrent_balance;

                    -- add transaction record
                    INSERT INTO YA_REWARDS_CREDIT_TXN (
                        transaction_id,
                        credit_id,
                        credit_amount,
                        credit_ordernum,
                        debit_amount,
                        debit_ordernum,
                        snapshot_balance,
                        transaction_datetime,
                        transaction_remark,
                        action_id,
                        create_user,
                        create_dt,
                        mod_user,
                        mod_dt
                    )
                    VALUES (
                        SYS_GUID(),
                        iLcredit_id,
                        null,
                        null,
                        deciPdebit_amount,
                        iPorder_num,
                        deciLcurrent_balance - deciLdeduct_amount,
                        SYSDATE,
                        null,
                        2,
                        cPupdatedUser,
                        SYSDATE,
                        null,
                        null
                    );

                    UPDATE YA_REWARDS_CREDIT
                    SET current_balance = deciLcurrent_balance - deciLdeduct_amount
                    WHERE id = iLcredit_id;

                    FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
                END;
                END LOOP;
                CLOSE curLdeduct_cursor;

                IF (cPcommit = 'Y') THEN
                    BEGIN
                        COMMIT;
                    END;
                END IF;
                iPerror_code := 0;
            END;
        END IF;
        RETURN;

    EXCEPTION WHEN OTHERS THEN
        BEGIN
            IF (cPcommit = 'Y') THEN
                BEGIN
                    ROLLBACK;
                END;
            END IF;

            iPerror_code := -1;
        END;
    END DebitRewardsCredit;

END Pkg_fe_RewardsCreditAccess;
/