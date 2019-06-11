CREATE OR REPLACE package Pkg_fe_RewardsCreditAccess
AS
    TYPE refCur IS REF CURSOR;
    TYPE charInRewardsCode IS VARRAY(32) OF VARCHAR(1);

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
        iPshipment_id IN INT,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        iPerror_code OUT INT
    );

    PROCEDURE CreateRewardsCredit_New (
        iPorder_num IN INT,
        iPcash_out_info_id IN INT,
        sPshopper_id IN VARCHAR2,
        iPsite_id IN INT,
        iPcredit_type_id IN INT,
        cPcurrency IN VARCHAR2,
        nPamount IN NUMBER,
        deciPdiscount IN DECIMAL,
        cPremark IN VARCHAR2,
        iPshipment_id IN INT,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        cPcommit IN CHAR DEFAULT 'Y',
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

    PROCEDURE DebitRewardsCreditNew (
      cPshopper_id IN CHAR,
      deciPdebit_amount IN DECIMAL,
      iPorder_num IN INT,
      cPcurrency IN CHAR DEFAULT 'USD',
      iPsite_id IN INT,
      cPupdatedUser IN VARCHAR2,
      cPcommit IN CHAR DEFAULT 'Y',
      iPerror_code OUT INT
    );

    PROCEDURE DebitRewardsCreditForCashOut (
      cPshopper_id IN CHAR,
      deciPdebit_amount IN DECIMAL,
      iPcash_out_info_id IN INT,
      cPcurrency IN CHAR DEFAULT 'USD',
      iPsite_id IN INT,
      cPupdatedUser IN VARCHAR2,
      cPcommit IN CHAR DEFAULT 'Y',
      iPerror_code OUT INT
    );

    PROCEDURE SetExpireRewardsCredits(
        iPexpiryDate IN DATE,
        cPshopper_id IN CHAR,
        cPcommit IN CHAR DEFAULT 'Y',
        iPexpiredRewardsCredit OUT INT
    );

    PROCEDURE RecreateRewardsCredit (
        iPorder_num IN INT,
        sPshopper_id IN VARCHAR2,
        iPsite_id IN INT,
        iPcredit_type_id IN INT,
        cPcurrency IN VARCHAR2,
        nPamount IN NUMBER,
        deciPdiscount IN DECIMAL,
        cPremark IN VARCHAR2,
        iPshipment_id IN INT,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        iPexpiredCreditId INT,
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
        iArray charInRewardsCode;
    BEGIN
        iArray := charInRewardsCode('2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

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

        iLrecord_found := 1;

        WHILE iLrecord_found = 1 LOOP
            cPrewardsCode := iArray(trunc(dbms_random.value(1,33))) ||
                             iArray(trunc(dbms_random.value(1,33))) ||
                             iArray(trunc(dbms_random.value(1,33))) ||
                             iArray(trunc(dbms_random.value(1,33))) ||
                             iArray(trunc(dbms_random.value(1,33))) ||
                             iArray(trunc(dbms_random.value(1,33)));

            SELECT COUNT(*) INTO iLrecord_found FROM YA_SHOPPER WHERE rewards_code = cPrewardsCode;
        END LOOP;

        UPDATE YA_SHOPPER
        SET rewards_code = cPrewardsCode, updated_date = SYSDATE
        WHERE shopper_id = cPshopper_id;

        iPerror_code := 0;
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
        iPshipment_id IN INT,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        iPerror_code OUT INT
    )
    AS
        iLaction_id INT;
        iLrecord_found INT;
        iLcredit_id INT;
    BEGIN
        SELECT COUNT(1) INTO iLrecord_found FROM YA_SHOPPER WHERE shopper_id = sPshopper_id;
        IF iLrecord_found = 0 THEN
            iPerror_code := -1;
            RETURN;
        END IF;

        CASE iPcredit_type_id
            WHEN 1 THEN iLaction_id := 1;
            WHEN 2 THEN iLaction_id := 3;
            WHEN 3 THEN iLaction_id := 5;
        END CASE;

        SELECT seq_rewards_credit.NEXTVAL INTO iLcredit_id FROM DUAL;

        INSERT INTO ya_rewards_credit(id, site_id, shopper_id, credit_type_id, credit_discount, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, expiry_date, create_user, create_dt, mod_user, mod_dt, shipment_id)
        VALUES (iLcredit_id, iPsite_id, sPshopper_id, iPcredit_type_id, deciPdiscount, nPamount, nPamount, SYSDATE, 'N', cPremark, cPcurrency, iPexpiryDate, cPupdatedUser, SYSDATE, null, null, iPshipment_id);

        INSERT INTO ya_rewards_credit_txn(transaction_id, credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_datetime, transaction_remark, action_id, create_user, create_dt, mod_user, mod_dt, credit_credit_id)
        VALUES (SYS_GUID(), iLcredit_id, nPamount, iPorder_num, null, null, nPamount, SYSDATE, cPremark, iLaction_id, cPupdatedUser, SYSDATE, null, null, iLcredit_id);

        iPerror_code := 0;
        COMMIT;
    END CreateRewardsCredit;

    PROCEDURE CreateRewardsCredit_New (
        iPorder_num IN INT,
        iPcash_out_info_id IN INT,
        sPshopper_id IN VARCHAR2,
        iPsite_id IN INT,
        iPcredit_type_id IN INT,
        cPcurrency IN VARCHAR2,
        nPamount IN NUMBER,
        deciPdiscount IN DECIMAL,
        cPremark IN VARCHAR2,
        iPshipment_id IN INT,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        cPcommit IN CHAR DEFAULT 'Y',
        iPerror_code OUT INT
    )
    AS
        iLaction_id INT;
        iLrecord_found INT;
        iLcredit_id INT;
    BEGIN
        SELECT COUNT(1) INTO iLrecord_found FROM YA_SHOPPER WHERE shopper_id = sPshopper_id;
        IF iLrecord_found = 0 THEN
            iPerror_code := -1;
            RETURN;
        END IF;

        CASE iPcredit_type_id
            WHEN 1 THEN iLaction_id := 1;
            WHEN 2 THEN iLaction_id := 3;
            WHEN 3 THEN iLaction_id := 5;
            WHEN 4 THEN iLaction_id := 7;
            ELSE
                BEGIN
                    iPerror_code := -1;
                    RETURN;
                END;
        END CASE;

        SELECT seq_rewards_credit.NEXTVAL INTO iLcredit_id FROM DUAL;

        INSERT INTO ya_rewards_credit(id, site_id, shopper_id, credit_type_id, credit_discount, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, expiry_date, create_user, create_dt, mod_user, mod_dt, shipment_id)
        VALUES (iLcredit_id, iPsite_id, sPshopper_id, iPcredit_type_id, deciPdiscount, nPamount, nPamount, SYSDATE, 'N', cPremark, cPcurrency, iPexpiryDate, cPupdatedUser, SYSDATE, null, null, iPshipment_id);

        INSERT INTO ya_rewards_credit_txn(transaction_id, credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_datetime, transaction_remark, action_id, create_user, create_dt, mod_user, mod_dt, credit_credit_id, cash_out_info_id)
        VALUES (SYS_GUID(), iLcredit_id, nPamount, iPorder_num, null, null, nPamount, SYSDATE, cPremark, iLaction_id, cPupdatedUser, SYSDATE, null, null, iLcredit_id, iPcash_out_info_id);

        iPerror_code := 0;
        IF (cPcommit = 'Y') THEN
          BEGIN
            COMMIT;
          END;
        END IF;

        EXCEPTION WHEN OTHERS THEN
            BEGIN
              IF (cPcommit = 'Y') THEN
                BEGIN
                  ROLLBACK;
                END;
              END IF;

              iPerror_code := -1;
            END;
    END CreateRewardsCredit_New;

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
                WHERE shopper_id = cPshopper_id
                    AND currency = cPcurrency
                    AND site_id = iPsite_id
                    AND current_balance > 0
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
                        mod_dt,
                        debit_credit_id
                    )
                    VALUES (
                        SYS_GUID(),
                        iLcredit_id,
                        null,
                        null,
                        deciLdeduct_amount,
                        iPorder_num,
                        deciLcurrent_balance - deciLdeduct_amount,
                        SYSDATE,
                        null,
                        2, -- REDEEM
                        cPupdatedUser,
                        SYSDATE,
                        null, -- modCreate
                        null, -- modDate
                        iLcredit_id  -- debit_credit_id
                    );

                    UPDATE YA_REWARDS_CREDIT
                    SET current_balance = deciLcurrent_balance - deciLdeduct_amount,
                        mod_user = cPupdatedUser,
                        mod_dt = SYSDATE
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

    PROCEDURE DebitRewardsCreditForCashOut (
        cPshopper_id IN CHAR,
        deciPdebit_amount IN DECIMAL,
        iPcash_out_info_id IN INT,
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
                WHERE shopper_id = cPshopper_id
                    AND currency = cPcurrency
                    AND site_id = iPsite_id
                    AND current_balance > 0
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
                        mod_dt,
                        debit_credit_id,
                        cash_out_info_id
                    )
                    VALUES (
                        SYS_GUID(),
                        iLcredit_id,
                        null,
                        null,
                        deciLdeduct_amount,
                        null,
                        deciLcurrent_balance - deciLdeduct_amount,
                        SYSDATE,
                        null,
                        6, -- CASH_OUT
                        cPupdatedUser,
                        SYSDATE,
                        null, -- modCreate
                        null, -- modDate
                        iLcredit_id,  -- debit_credit_id
                        iPcash_out_info_id
                    );

                    UPDATE YA_REWARDS_CREDIT
                    SET current_balance = deciLcurrent_balance - deciLdeduct_amount,
                        mod_user = cPupdatedUser,
                        mod_dt = SYSDATE
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
    END DebitRewardsCreditForCashOut;

    PROCEDURE SetExpireRewardsCredits (
        iPexpiryDate IN DATE,
        cPshopper_id IN CHAR,
        cPcommit IN CHAR DEFAULT 'Y',
        iPexpiredRewardsCredit OUT INT   -- count how many rewards credit was expired
    )
    AS
        curRewardsCredit_cursor refCur;
        iLcredit_id INT;
        deciLdebit_amount DECIMAL(18,2);
        iLexpireDate DATE;
        iLexpiredRewardsCredit INT;     -- local variable to count how many rewards credit was expired
    BEGIN
        iLexpiredRewardsCredit := 0;    -- init counter

        OPEN curRewardsCredit_cursor FOR
        SELECT id, current_balance
        FROM ya_rewards_credit
        WHERE expiry_date < iPexpiryDate and shopper_id = cPshopper_id and current_balance > 0;

        FETCH curRewardsCredit_cursor INTO iLcredit_id, deciLdebit_amount;
        WHILE (curRewardsCredit_cursor%FOUND) LOOP
        BEGIN
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
                mod_dt,
                debit_credit_id
            )
            VALUES (
                SYS_GUID(),
                iLcredit_id,
                null,   -- creditAmount
                null,   -- creditOrderNum
                deciLdebit_amount,
                null,   -- debitOrderNum
                0,
                SYSDATE,
                null,   -- remark
                4,    -- EXPIRE
                'frontend',   -- createUser
                SYSDATE,    -- createDate
                null,   -- modCreate
                null,    -- modDate
                iLcredit_id   -- debit_credit_id
            );

            UPDATE ya_rewards_credit
            SET current_balance = 0, mod_dt = SYSDATE
            WHERE id = iLcredit_id;

            iLexpiredRewardsCredit := iLexpiredRewardsCredit + 1;  -- expired success, update counter
            FETCH curRewardsCredit_cursor INTO iLcredit_id, deciLdebit_amount;
        END;
        END LOOP;
        CLOSE curRewardsCredit_cursor;

        iPexpiredRewardsCredit := iLexpiredRewardsCredit;

        IF (cPcommit = 'Y') THEN
            BEGIN
                COMMIT;
            END;
        END IF;
    EXCEPTION WHEN OTHERS THEN
        IF (cPcommit = 'Y') THEN
            BEGIN
                ROLLBACK;
            END;
        END IF;

        iPexpiredRewardsCredit := -1;
    END SetExpireRewardsCredits;

    PROCEDURE RecreateRewardsCredit (
        iPorder_num IN INT,
        sPshopper_id IN VARCHAR2,
        iPsite_id IN INT,
        iPcredit_type_id IN INT,
        cPcurrency IN VARCHAR2,
        nPamount IN NUMBER,
        deciPdiscount IN DECIMAL,
        cPremark IN VARCHAR2,
        iPshipment_id IN INT,
        iPexpiryDate IN DATE,
        cPupdatedUser IN VARCHAR2,
        iPexpiredCreditId INT,
        iPerror_code OUT INT
    )
    AS
        iLaction_id INT;
        iLrecord_found INT;
        iLcredit_id INT;
    BEGIN
        SELECT COUNT(1) INTO iLrecord_found FROM YA_SHOPPER WHERE shopper_id = sPshopper_id;
        IF iLrecord_found = 0 THEN
            iPerror_code := -1;
            RETURN;
        END IF;

        SELECT seq_rewards_credit.NEXTVAL INTO iLcredit_id FROM DUAL;

        INSERT INTO ya_rewards_credit(id, site_id, shopper_id, credit_type_id, credit_discount, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, expiry_date, create_user, create_dt, mod_user, mod_dt, shipment_id)
        VALUES (iLcredit_id, iPsite_id, sPshopper_id, iPcredit_type_id, deciPdiscount, nPamount, nPamount, SYSDATE, 'N', cPremark, cPcurrency, iPexpiryDate, cPupdatedUser, SYSDATE, null, null, iPshipment_id);

        -- Add rewards credit transaction to recreate rewards credit (action_id := 5)
        INSERT INTO ya_rewards_credit_txn(transaction_id, credit_id, credit_amount, credit_ordernum, debit_amount, debit_ordernum, snapshot_balance, transaction_datetime, transaction_remark, action_id, create_user, create_dt, mod_user, mod_dt, credit_credit_id)
        VALUES (SYS_GUID(), iLcredit_id, nPamount, iPorder_num, null, null, nPamount, SYSDATE, cPremark, 5, cPupdatedUser, SYSDATE, null, null, iPexpiredCreditId);

        iPerror_code := 0;
        COMMIT;
    END RecreateRewardsCredit;

    PROCEDURE DebitRewardsCreditNew (
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
    	deciLsum_of_credit DECIMAL(18,2);
    	iLfirstCreditEnough INT;
    	iLfirstCreditNotEnough INT;
    	iLTxnActionId INT;
    	iLGroupedCreditId INT;
    	iLDebitCreditId INT;
    BEGIN
    	deciLsum_of_credit := 0;
    	iLfirstCreditNotEnough := 0;
    	iLfirstCreditEnough := 0;

        -- init groupedCreditId
        SELECT seq_rewards_credit.NEXTVAL INTO iLGroupedCreditId FROM DUAL;

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
    			WHERE shopper_id = cPshopper_id
    				AND currency = cPcurrency
    				AND site_id = iPsite_id
    				AND current_balance > 0
    			ORDER BY expiry_date ASC;

    			FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
    			WHILE (curLdeduct_cursor%FOUND) AND (deciLdebit_amount > 0) LOOP
    			BEGIN
    				IF (deciLdebit_amount > deciLcurrent_balance) THEN
    					BEGIN
    						deciLdeduct_amount := deciLcurrent_balance;
    						iLfirstCreditNotEnough := 1;
    					END;
    				ELSE
    					BEGIN
    						deciLdeduct_amount := deciLdebit_amount;
    						iLfirstCreditEnough := 1;
    					END;
    				END IF;

    				IF (iLfirstCreditEnough = 1 AND iLfirstCreditNotEnough = 0) THEN
    					BEGIN
    			            iLTxnActionId := 2;
    			            iLDebitCreditId := iLcredit_id;
    				    END;
    			    ELSE
    			        BEGIN
    			            iLTxnActionId := 8;
                            iLDebitCreditId := iLGroupedCreditId;
    			        END;
    			    END IF;

                    -- deduction
                    deciLdebit_amount := deciLdebit_amount - deciLcurrent_balance;
                    deciLsum_of_credit := deciLsum_of_credit + deciLdeduct_amount;

                    -- add grouped transaction record
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
                        mod_dt,
                        debit_credit_id
                    )
                    VALUES (
                        SYS_GUID(),
                        iLcredit_id,
                        null,
                        null,
                        deciLdeduct_amount,
                        iPorder_num,
                        deciLcurrent_balance - deciLdeduct_amount,
                        SYSDATE,
                        null,
                        iLTxnActionId,
                        cPupdatedUser,
                        SYSDATE,
                        null, -- modCreate
                        null, -- modDate
                        iLDebitCreditId  -- debit_credit_id
                    );

                    UPDATE YA_REWARDS_CREDIT
                    SET current_balance = deciLcurrent_balance - deciLdeduct_amount,
                        mod_user = cPupdatedUser,
                        mod_dt = SYSDATE
                    WHERE id = iLcredit_id;

    			FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
    		    END;
    		    END LOOP;
    		    CLOSE curLdeduct_cursor;

                IF (iLfirstCreditEnough = 0 OR iLfirstCreditNotEnough = 1) THEN
                    INSERT INTO ya_rewards_credit(id, site_id, shopper_id, credit_type_id, credit_discount, initial_balance, current_balance, transaction_datetime, bogus, remark, currency, expiry_date, create_user, create_dt, mod_user, mod_dt, shipment_id)
                    VALUES (iLGroupedCreditId, iPsite_id, cPshopper_id, 5, null, deciLsum_of_credit, deciLsum_of_credit, SYSDATE, 'N', 'Grouping', cPcurrency, SYSDATE + 1, cPupdatedUser, SYSDATE, null, null, null);

                    -- credit grouped credit
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
                        mod_dt,
                        credit_credit_id
                        )
                    VALUES (
                        SYS_GUID(),
                        iLGroupedCreditId,
                        deciLsum_of_credit,
                        null, -- credit_ordernum
                        null, -- debit_amount
                        null, -- debit_ordernum
                        deciLsum_of_credit,
                        SYSDATE,
                        null,
                        8, -- GROUPED
                        cPupdatedUser,
                        SYSDATE,
                        null, -- modCreate
                        null, -- modDate
                        iLGroupedCreditId  -- credit_credit_id
                    );

                    -- debit grouped credit
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
                        mod_dt,
                        debit_credit_id
                        )
                    VALUES (
                        SYS_GUID(),
                        iLGroupedCreditId,
                        null,
                        null, -- credit_ordernum
                        deciLsum_of_credit, -- debit_amount
                        iPorder_num, -- debit_ordernum
                        0,
                        SYSDATE,
                        null,
                        2, -- REDEEM
                        cPupdatedUser,
                        SYSDATE,
                        null, -- modCreate
                        null, -- modDate
                        iLGroupedCreditId  -- debit_credit_id
                    );

                    -- update grouped credit amount to 0
                    UPDATE YA_REWARDS_CREDIT
                    SET current_balance = 0,
                        mod_user = cPupdatedUser,
                        mod_dt = SYSDATE
                    WHERE id = iLGroupedCreditId;
                END IF;

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
    END DebitRewardsCreditNew;

END Pkg_fe_RewardsCreditAccess;
/