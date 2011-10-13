CREATE OR REPLACE PACKAGE "PKG_FE_ORDERACCESS2" 
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_InsertSalesCode */
  PROCEDURE InsertSaleCode (
    iPorder_num IN INT,
    vcPsales_code IN VARCHAR2
  );

  /* sp_debit_credit */
  PROCEDURE DebitCredit (
    cPshopper_id IN CHAR,
    deciPdebit_amount IN DECIMAL,
    iPorder_num IN INT,
    cPcurrency IN CHAR DEFAULT 'USD',
    iPreturn OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL,
    cPcommit IN CHAR DEFAULT 'Y'
  );

  /* sp_debit_credit */
  PROCEDURE DebitCreditBySite (
    cPshopper_id IN CHAR,
    deciPdebit_amount IN DECIMAL,
    iPorder_num IN INT,
    cPcurrency IN CHAR DEFAULT 'USD',
    iPsite_id IN INT,
    iPreturn OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL,
    cPcommit IN CHAR DEFAULT 'Y'
  );

  PROCEDURE UpdateLimitedQuantity (
    vcPsku_csv IN VARCHAR2,
    vcPqty_csv IN VARCHAR2,
    iPsite_id IN INT
  );

  /* proc_fe_InsertOrderXml_encrypted */
  PROCEDURE InsertOrderXmlEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR,
    vcPlimited_qty_csv IN VARCHAR,
    iPlang_type IN INT DEFAULT 1,
    cPcurrency IN CHAR,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );
  
  PROCEDURE InsertPaypalECOrderXml (
    cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );

  PROCEDURE InsertPDOrderXml (
	cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );
  
  PROCEDURE InsertPPECOrderXmlEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );
  
  PROCEDURE InsertPDOrderXmlEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );
  
  PROCEDURE GetShadowOrderWithWarrantyYS (
	cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult13 OUT refCur, -- GetShopper refCur1
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur, -- GetBasket refCur7
    curPresult8 OUT refCur, -- GetCoupon refCur1
    curPresult9 OUT refCur, -- GetCoupon refCur2
    curPresult10 OUT refCur, -- GetCoupon refCur3
    curPresult11 OUT refCur, -- GetCoupon refCur4
    curPresult12 OUT refCur, -- GetCoupon refCur5
	curPresult14 OUT refCur
  );

  /* proc_fe_GetOrder_encrypted */
  PROCEDURE GetOrderWithWarrantyEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
	  curPresult13 OUT refCur, -- GetShopper refCur1
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur, -- GetBasket refCur7
    curPresult8 OUT refCur, -- GetCoupon refCur1
    curPresult9 OUT refCur, -- GetCoupon refCur2
    curPresult10 OUT refCur, -- GetCoupon refCur3
    curPresult11 OUT refCur, -- GetCoupon refCur4
    curPresult12 OUT refCur, -- GetCoupon refCur5
	  curPresult14 OUT refCur
  );

  /* proc_fe_GetOrder_encrypted */
  PROCEDURE GetOrderEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult13 OUT refCur, -- GetShopper refCur1
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
	  curPresult7 OUT refCur, -- GetBasket refCur7 (optional)
    curPresult8 OUT refCur, -- GetCoupon refCur1
    curPresult9 OUT refCur, -- GetCoupon refCur2
    curPresult10 OUT refCur, -- GetCoupon refCur3
    curPresult11 OUT refCur, -- GetCoupon refCur4
    curPresult12 OUT refCur, -- GetCoupon refCur5
	  curPresult14 OUT refCur
  );

  /* proc_fe_GetOrderXML */
  PROCEDURE GetOrderXml (
    iPorder_num IN INT,
    clobPorder_xml OUT CLOB
  );

  /* proc_fe_GetBackendOrder */
  PROCEDURE GetOrderFromBackend (
    iPorder_num IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur
  );

  /* proc_fe_CheckFECouponUsage */
  PROCEDURE CheckCouponUsage (
    cPshopper_id IN CHAR,
    vcPcoupon_code IN VARCHAR,
    iPreturn OUT INT
  );

  /* proc_fe_GetOrderCount */
  PROCEDURE GetOrderCount (
    cPshopper_id IN CHAR,
    iPcount OUT INT
  );

  /* proc_fe_GetPreCheckoutData_encrypted */
  PROCEDURE GetPreCheckoutDataEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  /* proc_fe_CreateCheckoutData_encrypted */
  PROCEDURE CreateCheckoutDataEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPship_to_firstname IN NVARCHAR2,
    nvcPship_to_lastname IN NVARCHAR2,
    nvcPship_to_address_one IN NVARCHAR2,
    nvcPship_to_address_two IN NVARCHAR2,
    nvcPship_to_city IN NVARCHAR2,
    iPship_to_state_id IN INT,
    nvcPship_to_state IN NVARCHAR2,
    nvcPship_to_zip IN NVARCHAR2,
    iPship_to_country_id IN INT,
    nvcPship_to_phone IN NVARCHAR2,
    nvcPship_to_email IN NVARCHAR2,
    iPship_address_id IN INT,
    iPpayment_method IN INT,
    nvcPbill_to_address_one IN NVARCHAR2,
    nvcPbill_to_address_two IN NVARCHAR2,
    nvcPbill_to_city IN NVARCHAR2,
    iPbill_to_state_id IN INT,
    nvcPbill_to_state IN NVARCHAR2,
    nvcPbill_to_zip IN NVARCHAR2,
    iPbill_to_country_id IN INT,
    nvcPbill_to_phone IN NVARCHAR2,
    nvcPbill_to_email IN NVARCHAR2,
    iPbill_address_id IN INT,
    iPcard_profile_id IN INT,
    iPcard_type_id IN INT,
    vcPcard_number IN VARCHAR2,
    iPcard_exp_month IN INT,
    iPcard_exp_year IN INT,
    nvcPcard_firstname IN NVARCHAR2,
    nvcPcard_lastname IN NVARCHAR2,
    vcPcard_numberEncrypted IN VARCHAR2,
    iPencryptionKey_id IN INT,
	cPcurrency IN CHAR DEFAULT 'USD'
  );

  /* proc_fe_UpdateShippingInfo */
  PROCEDURE UpdateShoppingInfo (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPshipping_method_id IN INT,
    iPsplit_shipment IN INT
  );

  /* proc_fe_UpdateShippingAddress */
  PROCEDURE UpdateShippingAddress (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPship_to_firstname IN NVARCHAR2,
    nvcPship_to_lastname IN NVARCHAR2,
    nvcPship_to_address_one IN NVARCHAR2,
    nvcPship_to_address_two IN NVARCHAR2,
    nvcPship_to_city IN NVARCHAR2,
    iPship_to_state_id IN INT,
    nvcPship_to_state IN NVARCHAR2,
    nvcPship_to_zip IN NVARCHAR2,
    iPship_to_country_id IN INT,
    nvcPship_to_phone IN NVARCHAR2,
    nvcPship_to_email IN NVARCHAR2,
    iPaddress_id IN INT,
    cPcurrency IN CHAR DEFAULT 'USD'
  );
  
  PROCEDURE UpdateShippingAddressYS (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPship_to_firstname IN NVARCHAR2,
    nvcPship_to_lastname IN NVARCHAR2,
    nvcPship_to_address_one IN NVARCHAR2,
    nvcPship_to_address_two IN NVARCHAR2,
    nvcPship_to_city IN NVARCHAR2,
    iPship_to_state_id IN INT,
    nvcPship_to_state IN NVARCHAR2,
    nvcPship_to_zip IN NVARCHAR2,
    iPship_to_country_id IN INT,
    nvcPship_to_phone IN NVARCHAR2,	
    nvcPship_to_evephone IN NVARCHAR2,
    nvcPship_to_email IN NVARCHAR2,
    iPaddress_id IN INT,
    cPcurrency IN CHAR DEFAULT 'USD'
  );

  /* proc_fe_UpdateBillingAddress */
  PROCEDURE UpdateBillAddress (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPbill_to_address_one IN NVARCHAR2,
    nvcPbill_to_address_two IN NVARCHAR2,
    nvcPbill_to_city IN NVARCHAR2,
    iPbill_to_state_id IN INT,
    nvcPbill_to_state IN NVARCHAR2,
    nvcPbill_to_zip IN NVARCHAR2,
    iPbill_to_country_id IN INT,
    nvcPbill_to_email IN NVARCHAR2,
    iPaddress_id IN INT,
    cPcurrency IN CHAR DEFAULT 'USD'
  );

  /* proc_fe_UpdateCreditCardPaymentInfo */
  PROCEDURE UpdateCreditCardPaymentInfo (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPprofile_id IN INT,
    iPmethod_id IN INT,
    iPtype_id IN INT,
    vcPcard_number IN VARCHAR2,
    iPexp_month IN INT,
    iPexp_year IN INT,
    nvcPfirstname IN NVARCHAR2,
    nvcPlastname IN NVARCHAR2,
    vcPcoupon_code IN VARCHAR2,
    nPcredit_amount IN NUMBER
  );

  /* proc_fe_UpdateCreditCardPaymentInfo_encrypted */
  PROCEDURE UpdateCCPaymentInfoEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPprofile_id IN INT,
    iPmethod_id IN INT,
    iPtype_id IN INT,
    vcPcard_number IN VARCHAR2,
    iPexp_month IN INT,
    iPexp_year IN INT,
    nvcPfirstname IN NVARCHAR2,
    nvcPlastname IN NVARCHAR2,
    vcPcoupon_code IN VARCHAR2,
    nPcredit_amount IN NUMBER,
    vcPcard_numberEncrypted IN VARCHAR2,
    iPencryption_keyId IN INT
  );

  /* proc_fe_UpdatePaymentInfoAndPhone */
  PROCEDURE UpdatePaymentInfoPhone (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPmethod_id IN INT,
    nvcPphone IN NVARCHAR2,
    vcPcoupon_code IN VARCHAR2,
    nPcredit_amount IN NUMBER
  );

  /* proc_fe_CopyShippingAddressFromAddressBook */
  PROCEDURE CopyShipAddressFromAddressBook (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPaddress_id IN INT,
	iPlang_id IN INT
  );

  /* proc_fe_CopyBillingAddressFromAddressBook */
  PROCEDURE CopyBillAddressFromAddressBook (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPaddress_id IN INT,
	iPlang_id IN INT
  );

  /* proc_fe_UpdateCouponCode */
  PROCEDURE UpdateCouponCode (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2
  );

  /* proc_fe_UpdateAppliedCredit */
  PROCEDURE UpdateApplicationCredit (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    deciPcredit_amount IN DECIMAL
  );
  /*proc_fe_UpdateCheckOutCurrency*/
  PROCEDURE UpdateCheckOutCurrency (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPcurrency IN CHAR
  );

  /* for cvc project*/
  PROCEDURE UpdatePaymentInfo (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPcc_uid IN CHAR,
    nvcPcust_comment IN NVARCHAR2,
    nvcPbank_name IN NVARCHAR2,
    nvcPbank_phone IN NVARCHAR2
  );

  PROCEDURE GetShopperIdByCcUId (
    cPshopper_id OUT CHAR,
    cPcc_uid IN CHAR
  );
  
END Pkg_Fe_Orderaccess2;
/
CREATE OR REPLACE PACKAGE BODY PKG_FE_ORDERACCESS2
AS
  PROCEDURE InsertSaleCode (
    iPorder_num IN INT,
    vcPsales_code IN VARCHAR2
  )
  AS
  BEGIN
    INSERT INTO ya_order_sales
      (
        order_num,
        sales_code
      )
    VALUES
      (
        iPorder_num,
        vcPsales_code
      );

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    ELSE
      BEGIN
        COMMIT;
      END;
    END IF;

    RETURN;
  END InsertSaleCode;

  PROCEDURE DebitCreditBySite (
    cPshopper_id IN CHAR,
    deciPdebit_amount IN DECIMAL,
    iPorder_num IN INT,
    cPcurrency IN CHAR DEFAULT 'USD',
    iPsite_id IN INT,
    iPreturn OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL,
    cPcommit IN CHAR DEFAULT 'Y'
  )
  AS
    dtLcurrent_datetime DATE;
    cLtransaction_id CHAR(32);
    iLcredit_id INT;
    deciLcurrent_balance DECIMAL(18, 2);
    deciLdeduct_amount DECIMAL(18,2);
    iLtemp DECIMAL(18,2);
    curLdeduct_cursor refCur;
    deciLdebit_amount DECIMAL(18, 2);
  BEGIN
    -- This stored PROCEDURE is also used BY backend system for debit customer credit account.
    -- should be returned IF the debit_amount is more than customer credit balance.

    dtLcurrent_datetime := SYSDATE;
    IF (cPtransaction_id IS NULL) THEN
      BEGIN
        cLtransaction_id := SYS_GUID();
      END;
    ELSE
      BEGIN
        SELECT cPtransaction_id INTO cLtransaction_id FROM DUAL;
      END;
    END IF;

    -- Make sure there's enough credit
    SELECT NVL(SUM(current_balance), 0)
    INTO iLtemp
    FROM YA_FRONTEND_CREDIT_SYSTEM
    WHERE
      shopper_id = cPshopper_id
      AND currency = cPcurrency
      AND ((site_id = iPsite_id AND site_id NOT IN (1,7)) OR (site_id IN (1,7) AND (iPsite_id = 1 OR iPsite_id = 7)));

    deciLdebit_amount := round(deciPdebit_amount,3);
    IF ( iLtemp < deciLdebit_amount) THEN
      BEGIN
        -- Raiseerror otherwise
insert into ss_adm.package_log values ('PKG_FE_ORDERACCESS','DEBITCREDITBYSITE',sysdate,'SS_ADM','1 - iLtemp >= deciPdebit_amount (' || to_char(iLtemp) || ',' || to_char(deciPdebit_amount) || ',' || to_char(deciLdebit_amount) || ')' );                
        iPreturn := -1;
      END;
    ELSE
      BEGIN
        -- Declare cursor to deduct credit chronologically FROM accounts (certs)
        OPEN curLdeduct_cursor FOR
        SELECT
          fcs.credit_id,
          fcs.current_balance
        FROM
          YA_FRONTEND_CREDIT_SYSTEM fcs
        WHERE
          fcs.current_balance > 0
          AND fcs.shopper_id = cPshopper_id
          AND fcs.currency = cPcurrency
          AND ((fcs.site_id = iPsite_id AND fcs.site_id NOT IN (1,7)) OR (fcs.site_id IN (1,7) AND (iPsite_id = 1 OR iPsite_id = 7)))
        ORDER BY fcs.transaction_datetime ASC;


        FETCH curLdeduct_cursor INTO iLcredit_id, decilcurrent_balance;
        WHILE (curLdeduct_cursor%FOUND) AND (deciLdebit_amount > 0) LOOP
          BEGIN
            -- Calculate deduct amount for each line
            -- Find deducted amount for the account (cert)
            IF deciLdebit_amount >= deciLcurrent_balance THEN
              BEGIN
                deciLdeduct_amount := deciLcurrent_balance;
              END;
            ELSE
              BEGIN
                deciLdeduct_amount := deciLdebit_amount;
              END;
            END IF;

            -- Decrement debit amount (until < 0)
            deciLdebit_amount := deciLdebit_amount - deciLcurrent_balance;

            -- Record transaction
            INSERT INTO YA_FRONTEND_CREDIT_SYSTEM_TXN
              (
                credit_id,
                debit_amount,
                debit_ordernum,
                transaction_id,
                transaction_datetime,
                snapshot_balance,
                action_id
              )
            VALUES
              (
                iLcredit_id,
                deciLdeduct_amount,
                iPorder_num,
                cLtransaction_id,
                dtLcurrent_datetime,
                deciLcurrent_balance - deciLdeduct_amount,
                2 -- 2 = accrediting ORDER(ref ya_lookup type='credit_action'
              );

            -- UPDATE current balance AS well
            UPDATE YA_FRONTEND_CREDIT_SYSTEM
            SET current_balance = deciLcurrent_balance - deciLdeduct_amount
            WHERE credit_id = iLcredit_id;

            FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
          END;
        END LOOP;
        CLOSE curLdeduct_cursor;
        IF (cPcommit = 'Y') THEN
          BEGIN
            COMMIT;
          END;
        END IF;
        iPreturn := 1;
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
	  insert into ss_adm.package_log values ('PKG_FE_ORDERACCESS','DEBITCREDITBYSITE',sysdate,'SS_ADM','3 - OTHERS' );
      iPreturn := -1;
    END;
  END DebitCreditBySite;

  PROCEDURE DebitCredit (
    cPshopper_id IN CHAR,
    deciPdebit_amount IN DECIMAL,
    iPorder_num IN INT,
    cPcurrency IN CHAR DEFAULT 'USD',
    iPreturn OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL,
    cPcommit IN CHAR DEFAULT 'Y'
  )
  AS
    dtLcurrent_datetime DATE;
    cLtransaction_id CHAR(32);
    iLcredit_id INT;
    deciLcurrent_balance DECIMAL(18, 2);
    deciLdeduct_amount DECIMAL(18,2);
    iLtemp DECIMAL(18,2);
    curLdeduct_cursor refCur;
    deciLdebit_amount DECIMAL(18, 2);
  BEGIN
    -- This stored PROCEDURE is also used BY backend system for debit customer credit account.
    -- should be returned IF the debit_amount is more than customer credit balance.

    dtLcurrent_datetime := SYSDATE;
    IF (cPtransaction_id IS NULL) THEN
      BEGIN
        cLtransaction_id := SYS_GUID();
      END;
    ELSE
      BEGIN
        SELECT cPtransaction_id INTO cLtransaction_id FROM DUAL;
      END;
    END IF;

    -- Make sure there's enough credit
    SELECT NVL(SUM(current_balance), 0)
    INTO iLtemp
    FROM YA_FRONTEND_CREDIT_SYSTEM
    WHERE
      shopper_id = cPshopper_id
      AND currency = cPcurrency;

    deciLdebit_amount := deciPdebit_amount;
    IF (iLtemp < deciPdebit_amount) THEN
      BEGIN
        -- Raiseerror otherwise
        iPreturn := -1;
      END;
    ELSE
      BEGIN
        -- Declare cursor to deduct credit chronologically FROM accounts (certs)
        OPEN curLdeduct_cursor FOR
        SELECT
          fcs.credit_id,
          fcs.current_balance
        FROM
          YA_FRONTEND_CREDIT_SYSTEM fcs
        WHERE
          fcs.current_balance > 0
          AND fcs.shopper_id = cPshopper_id
          AND fcs.currency = cPcurrency
        ORDER BY fcs.transaction_datetime ASC;


        FETCH curLdeduct_cursor INTO iLcredit_id, decilcurrent_balance;
        WHILE (curLdeduct_cursor%FOUND) AND (deciLdebit_amount > 0) LOOP
          BEGIN
            -- Calculate deduct amount for each line
            -- Find deducted amount for the account (cert)
            IF deciLdebit_amount >= deciLcurrent_balance THEN
              BEGIN
                deciLdeduct_amount := deciLcurrent_balance;
              END;
            ELSE
              BEGIN
                deciLdeduct_amount := deciLdebit_amount;
              END;
            END IF;

            -- Decrement debit amount (until < 0)
            deciLdebit_amount := deciLdebit_amount - deciLcurrent_balance;

            -- Record transaction
            INSERT INTO YA_FRONTEND_CREDIT_SYSTEM_TXN
              (
                credit_id,
                debit_amount,
                debit_ordernum,
                transaction_id,
                transaction_datetime,
                snapshot_balance,
                action_id
              )
            VALUES
              (
                iLcredit_id,
                deciLdeduct_amount,
                iPorder_num,
                cLtransaction_id,
                dtLcurrent_datetime,
                deciLcurrent_balance - deciLdeduct_amount,
                2 -- 2 = accrediting ORDER(ref ya_lookup type='credit_action'
              );

            -- UPDATE current balance AS well
            UPDATE YA_FRONTEND_CREDIT_SYSTEM
            SET current_balance = deciLcurrent_balance - deciLdeduct_amount
            WHERE credit_id = iLcredit_id;

            FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
          END;
        END LOOP;
        CLOSE curLdeduct_cursor;
        IF (cPcommit = 'Y') THEN
          BEGIN
            COMMIT;
          END;
        END IF;
        iPreturn := 1;
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
      iPreturn := -1;
    END;
  END DebitCredit;
  
  PROCEDURE UpdateLimitedQuantity (
    vcPsku_csv IN VARCHAR2,
    vcPqty_csv IN VARCHAR2,
    iPsite_id IN INT
  )
  AS
    vcLsku_csv VARCHAR2(1000);
    vcLqty_csv VARCHAR2(300);
    iLsku_pointer INT;
    iLqty_pointer INT;
    iLcurrent_sku INT;
    iLcurrent_qty INT;
    iLlast_record INT;
    iLaction INT;
    iLapply_site_id INT;
  BEGIN
    SELECT INSTR(vcPsku_csv, ',') INTO iLsku_pointer FROM DUAL;
    SELECT INSTR(vcPqty_csv, ',') INTO iLqty_pointer FROM DUAL;
    vcLsku_csv := vcPsku_csv;
    vcLqty_csv := vcPqty_csv;

    iLlast_record := 0;

    IF (iLsku_pointer = 0) THEN
    	iLlast_record := 1;
    END IF;

    WHILE (iLsku_pointer > 0 OR iLlast_record = 1) LOOP
      BEGIN
        IF (iLsku_pointer = 0 AND iLlast_record = 1) THEN
          BEGIN
            SELECT CAST(vcLsku_csv AS INT) INTO iLcurrent_sku FROM DUAL;
            SELECT CAST(vcLqty_csv AS INT) INTO iLcurrent_qty FROM DUAL;
            iLlast_record := 0;
          END;
        ELSE
          BEGIN
            SELECT CAST(SUBSTR(vcLsku_csv, 1, iLsku_pointer-1) AS INT) INTO iLcurrent_sku FROM DUAL;
            SELECT CAST(SUBSTR(vcLqty_csv, 1, iLqty_pointer-1) AS INT) INTO iLcurrent_qty FROM DUAL;
          END;
        END IF;

        -- UPDATE frontend quantity
        INSERT INTO YA_LIMITED_QUANTITY_ACTION
          (
            sku,
            site_id,
            action_id,
            action_datetime
          )
        SELECT sku, site_id, action_id, SYSDATE 
        FROM ya_limited_quantity 
        WHERE 
          site_id = (
            select max(lq2.site_id)
            from ya_limited_quantity lq2
            where lq2.frontend_quantity > 0
              and lq2.site_id in (iPsite_id, 99)
              and lq2.sku = iLcurrent_sku
          )        
        --site_id IN (99, iPsite_id)
        --AND frontend_quantity > 0
        AND frontend_quantity - iLcurrent_qty <= 0
        AND sku = iLcurrent_sku;
        
        UPDATE YA_LIMITED_QUANTITY
        SET
          frontend_quantity = frontend_quantity - iLcurrent_qty,
          FE_last_change_datetime = SYSDATE
        WHERE
          sku = iLcurrent_sku
          --AND site_id IN (99, iPsite_id)
          AND site_id = (
            select max(lq2.site_id)
            from ya_limited_quantity lq2
            where lq2.frontend_quantity > 0
              and lq2.site_id in (iPsite_id, 99)
              and lq2.sku = iLcurrent_sku
          );

        IF (iLsku_pointer > 0) THEN
          BEGIN
            SELECT SUBSTR(vcLsku_csv, iLsku_pointer+1) INTO vcLsku_csv FROM DUAL;
            SELECT SUBSTR(vcLqty_csv, iLqty_pointer+1) INTO vcLqty_csv FROM DUAL;
            SELECT INSTR(vcLsku_csv, ',') INTO iLsku_pointer FROM DUAL;
            SELECT INSTR(vcLqty_csv, ',') INTO iLqty_pointer FROM DUAL;
            IF (iLsku_pointer = 0) THEN
              BEGIN
                iLlast_record := 1;
              END;
            END IF;
          END;
        END IF;
      END;
    END LOOP;

    COMMIT;
    RETURN;

    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          ROLLBACK;
          RAISE;
        END;

  END UpdateLimitedQuantity;

  PROCEDURE InsertOrderXmlEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR,
    vcPlimited_qty_csv IN VARCHAR,
    iPlang_type IN INT DEFAULT 1,
    cPcurrency IN CHAR,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  )
  AS
    iLexist INT;
    iLdebit_credit_return INT;
    iLseq_currval INT;
    iLseq_diff INT;
    iLbuffer_code INT;
  BEGIN
    SELECT SEQ_order.NEXTVAL INTO iPorder_num FROM DUAL;

    INSERT INTO ya_order
      (
        ORDER_NUM,
        shopper_id,
        site_id,
        coupon_code,
        order_xml,
        encryptionKey
      )
    VALUES
      (
        iPorder_num,
        cPshopper_id,
        iPsite_id,
        vcPcoupon_code,
        clobPorder_xml,
        iPencryptionKey_id
      );

    -- update buffer campaign
    -- 60001: US, 60002: Global
/*    
    IF iPsite_id = 1 THEN
      iLbuffer_code := 60001;
    ELSIF iPsite_id = 7 THEN
      iLbuffer_code := 60002;
    END IF;

    INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
    SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, iLbuffer_code
    FROM ya_new_basket nb
      INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code in (SELECT cl.campaign_code FROM ya_campaign_lookup cl WHERE cl.campaign_type = 2)
    WHERE nb.shopper_id = cPshopper_id
      AND nb.type = 0
      AND nb.site_id = iPsite_id
      AND EXISTS (
        SELECT 1
        FROM ya_limited_quantity lq
        WHERE lq.sku = nb.sku AND lq.site_id IN (99, iPsite_id)
        AND lq.frontend_quantity > 0
      );
*/
    -- for automatic clearance tool buffering
    -- 50001: US, 50002: Global
    IF iPsite_id = 1 THEN
      INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
      SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
      FROM ya_new_basket nb
        INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50001
      WHERE nb.shopper_id = cPshopper_id
        AND nb.type = 0
        AND nb.site_id = iPsite_id;
    ELSIF iPsite_id = 7 THEN
      INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
      SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
      FROM ya_new_basket nb
        INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50002
      WHERE nb.shopper_id = cPshopper_id
        AND nb.type = 0
        AND nb.site_id = iPsite_id;
    END IF;
        
    -- remove basket's items
    DELETE FROM YA_NEW_BASKET
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id
      AND TYPE = 0;

    DELETE FROM YA_WARRANTY_BASKET
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    -- remove checkout data
    DELETE FROM ya_checkout_data
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    -- remove gift card data
    DELETE FROM ya_giftcard_data
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    IF (iPbill_profile_id <> -1) THEN
      BEGIN
        UPDATE YA_ADDRESS
        SET preferred_bill = 'N'
        WHERE
          shopper_id = cPshopper_id
          AND preferred_bill = 'Y'
          AND created_by_checkout_session = 'N';

        UPDATE YA_ADDRESS
        SET preferred_bill = 'Y'
        WHERE
          address_id = iPbill_profile_id
          AND shopper_id = cPshopper_id;
      END;
    END IF;

    IF (iPship_profile_id <> -1) THEN
      BEGIN
        UPDATE YA_ADDRESS
        SET preferred_ship = 'N'
        WHERE
          shopper_id = cPshopper_id
          AND preferred_ship = 'Y'
          AND site_id = iPsite_id
          AND created_by_checkout_session = 'N';

        UPDATE YA_ADDRESS
        SET preferred_ship = 'Y'
        WHERE
          address_id = iPship_profile_id
          AND shopper_id = cPshopper_id;
      END;
    END IF;

    IF (iPcc_profile_id <> -1) THEN
      BEGIN
        UPDATE YA_CREDIT_CARD_PROFILE
        SET preferred = 'N'
        WHERE
          preferred = 'Y'
          AND shopper_id = cPshopper_id
          AND created_by_checkout_session = 'N';

        UPDATE YA_CREDIT_CARD_PROFILE
        SET preferred = 'Y'
        WHERE
          profile_id = iPcc_profile_id
          AND shopper_id = cPshopper_id
          AND created_by_checkout_session = 'N';
      END;
    END IF;

    IF (LENGTH(vcPcoupon_code) > 0) THEN
      BEGIN
        UPDATE YA_COUPON
        SET coupon_used = 'Y'
        WHERE
          coupon_code = vcPcoupon_code
          AND
            (
              (
                shopper_id = cPshopper_id
                AND all_shoppers NOT IN ('Y', 'U')
              ) -- Y: all shoppers, U: unique
              OR all_shoppers = 'O'
            );
      END;
    END IF;

    IF (nPcredit_amount > 0) THEN
      BEGIN
        Pkg_Fe_Orderaccess2.DebitCreditBySite(cPshopper_id, nPcredit_amount, iPorder_num, cPcurrency, iPsite_id, iLdebit_credit_return, cPtransaction_id);
      END;
    END IF;
    
    IF (LENGTH(vcPlimited_sku_csv) > 0) THEN
      BEGIN
        UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
      END;
    END IF;

  COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      BEGIN
        iPorder_num := -1;
        ROLLBACK;
      END;
  END InsertOrderXmlEncrypted;
  
  PROCEDURE InsertPaypalECOrderXml (
	  cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  )
  AS
    iLstatus INT;
    iLpaypal_status INT;
    iLexist INT;
    iLdebit_credit_return INT;
    iLseq_currval INT;
    iLseq_diff INT;
    iLbuffer_code INT;
    cLcurrency CHAR(3); -- indicate the currency of the credit
  BEGIN
    BEGIN
      SELECT order_status, ec_payment_status
      INTO iLstatus, iLpaypal_status
      FROM ya_paypal_ec_order_mapping ec
      WHERE payment_txn_id = cPguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;
	
	-- fetch the currency
	IF nPcredit_amount > 0 THEN
	  BEGIN
		SELECT currency
		INTO cLcurrency
		FROM ya_checkout_data
		WHERE paypal_uid = cPguid;
	  EXCEPTION
		WHEN NO_DATA_FOUND THEN
          BEGIN
			-- Safe guard unless the currency cannot be fetched in the ya_checkout_data by paypal_uid
			SELECT currency_code
			INTO cLcurrency
			FROM ya_paypal_ec_get_details 
			WHERE order_mapping_id IN (select id from ya_paypal_ec_order_mapping where payment_txn_id = cPguid);
		  END;
	  END;
	END IF;
	
    IF iLstatus IN (3,4) AND iLpaypal_status IN (2,8) THEN
      BEGIN
        SELECT SEQ_order.NEXTVAL INTO iPorder_num FROM DUAL;

        INSERT INTO ya_order
          (
            ORDER_NUM,
            shopper_id,
            site_id,
            coupon_code,
            order_xml,
            encryptionKey
          )
        VALUES
          (
            iPorder_num,
            cPshopper_id,
            iPsite_id,
            vcPcoupon_code,
            clobPorder_xml,
            iPencryptionKey_id
          );

        -- update buffer campaign
        -- 60001: US, 60002: Global
/*        
        IF iPsite_id = 1 THEN
          iLbuffer_code := 60001;
        ELSIF iPsite_id = 7 THEN
          iLbuffer_code := 60002;
        END IF;

        INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
        SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, iLbuffer_code
        FROM YA_NEW_BASKET_SHADOW nb
          INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code in (SELECT cl.campaign_code FROM ya_campaign_lookup cl WHERE cl.campaign_type = 2)
        WHERE nb.shopper_id = cPshopper_id
          AND nb.type = 0
          AND nb.site_id = iPsite_id
          AND EXISTS (
            SELECT 1
            FROM ya_limited_quantity lq
            WHERE lq.sku = nb.sku AND ((lq.site_id <> 10 AND lq.site_id IN (99, iPsite_id)) OR (lq.site_id = iPsite_id AND iPsite_id = 10))
            AND lq.frontend_quantity > 0
          );
*/
        -- for automatic clearance tool buffering
        -- 50001: US, 50002: Global
        IF iPsite_id = 1 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM YA_NEW_BASKET_SHADOW nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50001
          WHERE nb.shopper_id = cPshopper_id
			      AND nb.paypal_uid = cPguid
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        ELSIF iPsite_id = 7 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM YA_NEW_BASKET_SHADOW nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50002
          WHERE nb.shopper_id = cPshopper_id
		        AND nb.paypal_uid = cPguid
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        END IF;

		    DELETE FROM YA_NEW_BASKET_SHADOW
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
		      AND paypal_uid=cPguid
          AND TYPE = 0;

        DELETE FROM YA_WARRANTY_BASKET_shadow
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
		      AND paypal_uid=cPguid;

        DELETE FROM ya_checkout_data_shadow
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
		      AND paypal_uid=cPguid;

        DELETE FROM YA_NEW_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
          AND TYPE = 0;

        DELETE FROM YA_WARRANTY_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_checkout_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_giftcard_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        IF iPship_profile_id <> -1 THEN
          BEGIN
            UPDATE YA_ADDRESS
            SET preferred_ship = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_ship = 'Y'
              AND site_id = iPsite_id
              AND created_by_checkout_session = 'N';

            UPDATE YA_ADDRESS
            SET preferred_ship = 'Y'
            WHERE
              address_id = iPship_profile_id
              AND shopper_id = cPshopper_id;
          END;
        END IF;

        IF LENGTH(vcPcoupon_code) > 0 THEN
          BEGIN
            UPDATE YA_COUPON
            SET coupon_used = 'Y'
            WHERE
              coupon_code = vcPcoupon_code
              AND
                (
                  (
                    shopper_id = cPshopper_id
                    AND all_shoppers NOT IN ('Y','U')
                  ) -- Y: all shoppers, U: unique
                  OR all_shoppers = 'O'
                );
          END;
        END IF;

        IF nPcredit_amount > 0 THEN
          BEGIN
            Pkg_Fe_Orderaccess2.DebitCreditBySite(cPshopper_id, nPcredit_amount, iPorder_num, cLcurrency, iPsite_id, iLdebit_credit_return, cPtransaction_id, iPsite_id);
          END;
        END IF;

        IF LENGTH(vcPlimited_sku_csv) > 0 THEN
          BEGIN
            UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
          END;
        END IF;

        UPDATE ya_paypal_ec_order_mapping
        SET
          order_num = iPorder_num,
          updated_datetime = SYSDATE
        WHERE payment_txn_id = cPguid;

      EXCEPTION WHEN OTHERS THEN
        BEGIN
          iPorder_num := -1;
          ROLLBACK;
          RETURN;
        END;
      END;
    END IF;
    COMMIT;
    RETURN;
  END InsertPaypalECOrderXml;

  PROCEDURE InsertPDOrderXml (
    cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  )
  AS
    iLstatus INT;
    iLalipal_status INT;
    iLexist INT;
    iLdebit_credit_return INT;
    iLseq_currval INT;
    iLseq_diff INT;
    iLbuffer_code INT;    
  BEGIN
    BEGIN
      SELECT status, alipay_status
      INTO iLstatus, iLalipal_status
      FROM ya_paydollar_order_mapping
      WHERE payment_uid = cPguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;


    IF iLstatus IN (-1,1) AND iLalipal_status IN (-1,0) THEN
      BEGIN
        SELECT SEQ_order.NEXTVAL INTO iPorder_num FROM DUAL;

        INSERT INTO ya_order
          (
            ORDER_NUM,
            shopper_id,
            site_id,
            coupon_code,
            order_xml,
            encryptionKey
          )
        VALUES
          (
            iPorder_num,
            cPshopper_id,
            iPsite_id,
            vcPcoupon_code,
            clobPorder_xml,
            iPencryptionKey_id
          );

        -- update buffer campaign
        -- 60001: US, 60002: Global
        /*
        IF iPsite_id = 1 THEN
          iLbuffer_code := 60001;
        ELSIF iPsite_id = 7 THEN
          iLbuffer_code := 60002;
        END IF;

        INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
        SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, iLbuffer_code
        FROM YA_NEW_BASKET_SHADOW nb
          INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code in (SELECT cl.campaign_code FROM ya_campaign_lookup cl WHERE cl.campaign_type = 2)
        WHERE nb.shopper_id = cPshopper_id
          AND nb.type = 0
          AND nb.site_id = iPsite_id
          AND EXISTS (
            SELECT 1
            FROM ya_limited_quantity lq
            WHERE lq.sku = nb.sku AND lq.site_id IN (99, iPsite_id)
            AND lq.frontend_quantity > 0
          );
        */
        
        -- for automatic clearance tool buffering
        -- 50001: US, 50002: Global
        IF iPsite_id = 1 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM YA_NEW_BASKET_SHADOW nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50001
          WHERE nb.shopper_id = cPshopper_id
			      AND nb.paypal_uid = cPguid
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        ELSIF iPsite_id = 7 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM YA_NEW_BASKET_SHADOW nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50002
          WHERE nb.shopper_id = cPshopper_id
			      AND nb.paypal_uid = cPguid
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        END IF;
		

		    DELETE FROM YA_NEW_BASKET_SHADOW
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
		      AND paypal_uid=cPguid
          AND TYPE = 0;

        DELETE FROM YA_WARRANTY_BASKET_shadow
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
		      AND paypal_uid=cPguid;

        DELETE FROM ya_checkout_data_shadow
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
		      AND paypal_uid=cPguid;

        DELETE FROM YA_NEW_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
          AND TYPE = 0;

        DELETE FROM YA_WARRANTY_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_checkout_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_giftcard_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        IF iPship_profile_id <> -1 THEN
          BEGIN
            UPDATE YA_ADDRESS
            SET preferred_ship = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_ship = 'Y'
              AND site_id = iPsite_id
              AND created_by_checkout_session = 'N';

            UPDATE YA_ADDRESS
            SET preferred_ship = 'Y'
            WHERE
              address_id = iPship_profile_id
              AND shopper_id = cPshopper_id;
          END;
        END IF;

        IF LENGTH(vcPcoupon_code) > 0 THEN
          BEGIN
            UPDATE YA_COUPON
            SET coupon_used = 'Y'
            WHERE
              coupon_code = vcPcoupon_code
              AND
                (
                  (
                    shopper_id = cPshopper_id
                    AND all_shoppers NOT IN ('Y','U')
                  ) -- Y: all shoppers, U: unique
                  OR all_shoppers = 'O'
                );
          END;
        END IF;

        IF nPcredit_amount > 0 THEN
          BEGIN
            Pkg_Fe_Orderaccess2.DebitCreditBySite(cPshopper_id, nPcredit_amount, iPorder_num, 'USD', iPsite_id, iLdebit_credit_return, cPtransaction_id, iPsite_id);
          END;
        END IF;

        IF LENGTH(vcPlimited_sku_csv) > 0 THEN
          BEGIN
            UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
          END;
        END IF;

        UPDATE ya_paydollar_order_mapping
        SET
          order_num = iPorder_num,
          updated_datetime = SYSDATE
        WHERE payment_uid = cPguid;

      EXCEPTION WHEN OTHERS THEN
        BEGIN
          iPorder_num := -1;
          ROLLBACK;
          RETURN;
        END;
      END;
    END IF;
    COMMIT;
    RETURN;
  END InsertPDOrderXml;
  
  PROCEDURE InsertPPECOrderXmlEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  )
  AS
    cLguid CHAR(32);
    iLstatus INT;
    iLpaypal_status INT;
    iLexist INT;
    iLdebit_credit_return INT;
    iLseq_currval INT;
    iLseq_diff INT;
    iLbuffer_code INT;
    cLcurrency CHAR(3);
  BEGIN
    BEGIN
      SELECT paypal_uid
      INTO cLguid
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;

    BEGIN
      SELECT order_status, ec_payment_status
      INTO iLstatus, iLpaypal_status
      FROM ya_paypal_ec_order_mapping
      WHERE payment_txn_id = cPtransaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;
	
	-- fetch the currency
	IF nPcredit_amount > 0 THEN
	  BEGIN
		SELECT currency
		INTO cLcurrency
		FROM ya_checkout_data
		WHERE paypal_uid = cPtransaction_id;
	  EXCEPTION
		WHEN NO_DATA_FOUND THEN
          BEGIN
			-- Safe guard unless the currency cannot be fetched in the ya_checkout_data by paypal_uid
			SELECT currency_code
			INTO cLcurrency
			FROM ya_paypal_ec_get_details 
			WHERE order_mapping_id IN (select id from ya_paypal_ec_order_mapping where payment_txn_id = cLguid);
		  END;
	  END;
	END IF;
	
    IF iLstatus IN (3,4) AND iLpaypal_status IN (2,8) THEN
      BEGIN
        SELECT SEQ_order.NEXTVAL INTO iPorder_num FROM DUAL;

        INSERT INTO ya_order
          (
            ORDER_NUM,
            shopper_id,
            site_id,
            coupon_code,
            order_xml,
            encryptionKey
          )
        VALUES
          (
            iPorder_num,
            cPshopper_id,
            iPsite_id,
            vcPcoupon_code,
            clobPorder_xml,
            iPencryptionKey_id
          );

        -- update buffer campaign
        -- 60001: US, 60002: Global
/*
        IF iPsite_id = 1 THEN
          iLbuffer_code := 60001;
        ELSIF iPsite_id = 7 THEN
          iLbuffer_code := 60002;
        END IF;
        INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
        SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, iLbuffer_code
        FROM ya_new_basket nb
          INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code in (SELECT cl.campaign_code FROM ya_campaign_lookup cl WHERE cl.campaign_type = 2)
        WHERE nb.shopper_id = cPshopper_id
          AND nb.type = 0
          AND nb.site_id = iPsite_id
          AND EXISTS (
            SELECT 1
            FROM ya_limited_quantity lq
            WHERE lq.sku = nb.sku AND ((lq.site_id <> 10 AND lq.site_id IN (99, iPsite_id)) OR (lq.site_id = iPsite_id AND iPsite_id = 10))
            AND lq.frontend_quantity > 0
          );
*/
        -- for automatic clearance tool buffering
        -- 50001: US, 50002: Global
        IF iPsite_id = 1 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM ya_new_basket nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50001
          WHERE nb.shopper_id = cPshopper_id
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        ELSIF iPsite_id = 7 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM ya_new_basket nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50002
          WHERE nb.shopper_id = cPshopper_id
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        END IF;
		
        DELETE FROM YA_NEW_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
          AND TYPE = 0;

        DELETE FROM YA_WARRANTY_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_checkout_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_giftcard_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        IF iPbill_profile_id <> -1 THEN
          BEGIN
            UPDATE YA_ADDRESS
            SET preferred_bill = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_bill = 'Y'
              AND created_by_checkout_session = 'N';

            UPDATE YA_ADDRESS
            SET preferred_bill = 'Y'
            WHERE
              shopper_id = cPshopper_id
              AND address_id = iPbill_profile_id;
          END;
        END IF;

        IF iPship_profile_id <> -1 THEN
          BEGIN
            UPDATE YA_ADDRESS
            SET preferred_ship = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_ship = 'Y'
              AND site_id = iPsite_id
              AND created_by_checkout_session = 'N';

            UPDATE YA_ADDRESS
            SET preferred_ship = 'Y'
            WHERE
              address_id = iPship_profile_id
              AND shopper_id = cPshopper_id;
          END;
        END IF;

        IF LENGTH(vcPcoupon_code) > 0 THEN
          BEGIN
            UPDATE YA_COUPON
            SET coupon_used = 'Y'
            WHERE
              coupon_code = vcPcoupon_code
              AND
                (
                  (
                    shopper_id = cPshopper_id
                    AND all_shoppers NOT IN ('Y','U')
                  ) -- Y: all shoppers, U: unique
                  OR all_shoppers = 'O'
                );
          END;
        END IF;

        IF nPcredit_amount > 0 THEN
          BEGIN
            Pkg_Fe_Orderaccess2.DebitCreditBySite(cPshopper_id, nPcredit_amount, iPorder_num, cLcurrency, iPsite_id, iLdebit_credit_return, cPtransaction_id, iPsite_id);
          END;
        END IF;

        IF LENGTH(vcPlimited_sku_csv) > 0 THEN
          BEGIN
            UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
          END;
        END IF;

        UPDATE ya_paypal_ec_order_mapping
        SET
          order_num = iPorder_num,
          updated_datetime = SYSDATE
        WHERE payment_txn_id = cLguid;

      EXCEPTION WHEN OTHERS THEN
        BEGIN
          iPorder_num := -1;
          ROLLBACK;
          RETURN;
        END;
      END;
    END IF;
    COMMIT;
    RETURN;
  END InsertPPECOrderXmlEncrypted;

  PROCEDURE InsertPDOrderXmlEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2,
    clobPorder_xml IN CLOB,
    iPbill_profile_id IN INT,
    iPship_profile_id IN INT,
    iPcc_profile_id IN INT,
    nPcredit_amount IN NUMBER,
    vcPlimited_sku_csv IN VARCHAR2,
    vcPlimited_qty_csv IN VARCHAR2,
    iPlang_type IN INT,
    iPencryptionKey_id IN INT,
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  )
  AS
    cLguid CHAR(32);
    iLstatus INT;
    iLalipay_status INT;
    iLexist INT;
    iLdebit_credit_return INT;
    iLseq_currval INT;
    iLseq_diff INT;
    iLbuffer_code INT;
  BEGIN
    BEGIN
      SELECT alipay_uid
      INTO cLguid
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;

    BEGIN
      SELECT status, ALIPAY_STATUS
      INTO iLstatus, iLalipay_status
      FROM ya_paydollar_order_mapping
      WHERE payment_uid = cLguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;


    IF iLstatus IN (-1,1) AND iLalipay_status IN (-1,0) THEN
      BEGIN
        SELECT SEQ_order.NEXTVAL INTO iPorder_num FROM DUAL;

        INSERT INTO ya_order
          (
            ORDER_NUM,
            shopper_id,
            site_id,
            coupon_code,
            order_xml,
            encryptionKey
          )
        VALUES
          (
            iPorder_num,
            cPshopper_id,
            iPsite_id,
            vcPcoupon_code,
            clobPorder_xml,
            iPencryptionKey_id
          );
          
        -- update buffer campaign
        -- 60001: US, 60002: Global
        /*
        IF iPsite_id = 1 THEN
          iLbuffer_code := 60001;
        ELSIF iPsite_id = 7 THEN
          iLbuffer_code := 60002;
        END IF;

        INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
        SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, iLbuffer_code
        FROM ya_new_basket nb
          INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code in (SELECT cl.campaign_code FROM ya_campaign_lookup cl WHERE cl.campaign_type = 2)
        WHERE nb.shopper_id = cPshopper_id
          AND nb.type = 0
          AND nb.site_id = iPsite_id
          AND EXISTS (
            SELECT 1
            FROM ya_limited_quantity lq
            WHERE lq.sku = nb.sku AND lq.site_id IN (99, iPsite_id)
            AND lq.frontend_quantity > 0
          );
        */

        -- for automatic clearance tool buffering
        -- 50001: US, 50002: Global
        IF iPsite_id = 1 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM ya_new_basket nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50001
          WHERE nb.shopper_id = cPshopper_id
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        ELSIF iPsite_id = 7 THEN
          INSERT INTO ya_campaign_order (order_num, order_id, sku, quantity, campaign_code)
          SELECT iPorder_num, iPorder_num, nb.sku, nb.quantity, c.campaign_code
          FROM ya_new_basket nb
            INNER JOIN ya_campaign c ON nb.sku = c.sku AND c.campaign_code = 50002
          WHERE nb.shopper_id = cPshopper_id
            AND nb.type = 0
            AND nb.site_id = iPsite_id;
        END IF;
		
        DELETE FROM YA_NEW_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
          AND TYPE = 0;

        DELETE FROM YA_WARRANTY_BASKET
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_checkout_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        DELETE FROM ya_giftcard_data
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;

        IF iPship_profile_id <> -1 THEN
          BEGIN
            UPDATE YA_ADDRESS
            SET preferred_ship = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_ship = 'Y'
              AND site_id = iPsite_id
              AND created_by_checkout_session = 'N';

            UPDATE YA_ADDRESS
            SET preferred_ship = 'Y'
            WHERE
              address_id = iPship_profile_id
              AND shopper_id = cPshopper_id;
          END;
        END IF;

        IF LENGTH(vcPcoupon_code) > 0 THEN
          BEGIN
            UPDATE YA_COUPON
            SET coupon_used = 'Y'
            WHERE
              coupon_code = vcPcoupon_code
              AND
                (
                  (
                    shopper_id = cPshopper_id
                    AND all_shoppers NOT IN ('Y','U')
                  ) -- Y: all shoppers, U: unique
                  OR all_shoppers = 'O'
                );
          END;
        END IF;

        IF nPcredit_amount > 0 THEN
          BEGIN
            Pkg_Fe_Orderaccess2.DebitCreditBySite(cPshopper_id, nPcredit_amount, iPorder_num, 'USD', iPsite_id, iLdebit_credit_return, cPtransaction_id, iPsite_id);
          END;
        END IF;

        IF LENGTH(vcPlimited_sku_csv) > 0 THEN
          BEGIN
            UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
          END;
        END IF;

        UPDATE ya_paydollar_order_mapping
        SET
          order_num = iPorder_num,
          updated_datetime = SYSDATE
        WHERE payment_uid = cLguid;

      EXCEPTION WHEN OTHERS THEN
        BEGIN
          iPorder_num := -1;
          ROLLBACK;
          RETURN;
        END;
      END;
    END IF;
    COMMIT;
    RETURN;
  END InsertPDOrderXmlEncrypted;
  
 /*uses by paypal */
PROCEDURE GetShadowOrderWithWarranty (
	cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur, -- GetBasket refCur7
    curPresult8 OUT refCur,
    curPresult9 OUT refCur,
    curPresult10 OUT refCur,
    curPresult11 OUT refCur,
    curPresult12 OUT refCur
  )
  AS
    iLcountry_id INT;
    vcLcoupon_code VARCHAR2(32);
    iLdummy INT;
  BEGIN
    BEGIN
      SELECT ship_to_country_id
      INTO iLcountry_Id
      FROM ya_checkout_data_shadow
      WHERE
        shopper_id = cPshopper_id
        AND	site_id = iPsite_id
		AND paypal_uid=cPguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLcountry_id := -1;
    END;

    -- GetBasket INTO curPresult1 to curPresult6
    Pkg_Fe_Basketaccess2.GetShadowBasketWithWarranty(
      cPguid,
	  cPshopper_id,
      iPsite_id,
      iPlang_id,
      0,
      iLcountry_id,
      curPresult1,
      curPresult2,
      curPresult3,
      curPresult4,
      curPresult5,
      curPresult6,
      curPresult7
      );

    BEGIN
      SELECT trim(coupon_code)
      INTO vcLcoupon_code
      FROM ya_checkout_data_shadow
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id
		AND paypal_uid=cPguid;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      vcLcoupon_code := '';
    END;

    -- get coupon constraint type 1
    OPEN curPresult8 FOR
    SELECT constraint_value
    FROM YA_COUPON_CONSTRAINT
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 1;

    -- get coupon constraint type 2
    OPEN curPresult9 FOR
    SELECT constraint_value
    FROM YA_COUPON_CONSTRAINT
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 2;

    -- get coupon constraint type 3
    OPEN curPresult10 FOR
    SELECT constraint_value
    FROM YA_COUPON_CONSTRAINT
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 3;

    OPEN curPresult11 FOR
    SELECT
      c.coupon_code,
      coupon_description,
      dollar_coupon_value,
      percentage_coupon_value,
      order_amount_trigger,
      item_sku_trigger,
      expiration_date,
      shopper_id,
      all_shoppers,
      coupon_used,
      coupon_type_id,
      site_id,
      corporate_domain
    FROM
      YA_COUPON c
      LEFT OUTER JOIN YA_COUPON_CORPORATE cc ON
        c.coupon_code = cc.coupon_code
    WHERE c.coupon_code = vcLcoupon_code;


    OPEN curPresult12 FOR
    SELECT
      sale_id,
      customer_firstname,
      customer_lastname,
      customer_email,
      customer_comment,
      shipping_method_id,
      split_shipment,
      ship_to_firstname,
      ship_to_lastname,
      ship_to_address_one,
      ship_to_address_two,
      ship_to_city,
      ship_to_state_id,
      ship_to_state,
      ship_to_zip,
      ship_to_country_id,
      ship_to_day_phone,
      ship_to_eve_phone,
      ship_to_fax_number,
      ship_to_mobile_phone,
      ship_to_email,
      payment_method_id,
      bill_to_firstname,
      bill_to_lastname,
      bill_to_address_one,
      bill_to_address_two,
      bill_to_city,
      bill_to_state_id,
      bill_to_state,
      bill_to_zip,
      bill_to_country_id,
      bill_to_phone,
      bill_to_email,
      coupon_code,
      CAST(credit_amount AS FLOAT),
      null,
      cc_type_id,
      cc_expiration_month,
      cc_expiration_year,
      bank_name,
      bank_phone,
      currency,
      ship_profile_id,
      bill_profile_id,
      cc_profile_id,
      message_type,
      sender,
      receiver,
      date_of_delivery,
      content,
      font,
      colour,
      lang,
  	  cc_numberencrypted,
  	  encryptionkey
    FROM
      ya_checkout_data_shadow c
      LEFT OUTER JOIN ya_giftcard_data g ON
        c.shopper_id = g.shopper_id
        AND c.site_id = g.site_id
		AND c.paypal_uid=cPguid
    WHERE
      c.shopper_id = cPshopper_id
      AND c.site_id = iPsite_id
	  AND c.paypal_uid=cPguid;

    RETURN;
  END GetShadowOrderWithWarranty;

  /* used by PayDollar */
  PROCEDURE GetShadowPDOrderWithWarranty (
	cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur, -- GetBasket refCur7
    curPresult8 OUT refCur,
    curPresult9 OUT refCur,
    curPresult10 OUT refCur,
    curPresult11 OUT refCur,
    curPresult12 OUT refCur
  )
  AS
    iLcountry_id INT;
    vcLcoupon_code VARCHAR2(32);
    iLdummy INT;
  BEGIN
    BEGIN
      SELECT ship_to_country_id
      INTO iLcountry_Id
      FROM ya_checkout_data_shadow
      WHERE
        shopper_id = cPshopper_id
        AND	site_id = iPsite_id
		AND paypal_uid=cPguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLcountry_id := -1;
    END;

    -- GetBasket INTO curPresult1 to curPresult6
    Pkg_Fe_Basketaccess2.GetShadowBasketWithWarranty(
      cPguid,
	  cPshopper_id,
      iPsite_id,
      iPlang_id,
      0,
      iLcountry_id,
      curPresult1,
      curPresult2,
      curPresult3,
      curPresult4,
      curPresult5,
      curPresult6,
      curPresult7
      );

    BEGIN
      SELECT trim(coupon_code)
      INTO vcLcoupon_code
      FROM ya_checkout_data_shadow
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id
		AND paypal_uid=cPguid;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      vcLcoupon_code := '';
    END;

    -- get coupon constraint type 1
    OPEN curPresult8 FOR
    SELECT constraint_value
    FROM YA_COUPON_CONSTRAINT
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 1;

    -- get coupon constraint type 2
    OPEN curPresult9 FOR
    SELECT constraint_value
    FROM YA_COUPON_CONSTRAINT
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 2;

    -- get coupon constraint type 3
    OPEN curPresult10 FOR
    SELECT constraint_value
    FROM YA_COUPON_CONSTRAINT
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 3;

    OPEN curPresult11 FOR
    SELECT
      c.coupon_code,
      coupon_description,
      dollar_coupon_value,
      percentage_coupon_value,
      order_amount_trigger,
      item_sku_trigger,
      expiration_date,
      shopper_id,
      all_shoppers,
      coupon_used,
      coupon_type_id,
      site_id,
      corporate_domain
    FROM
      YA_COUPON c
      LEFT OUTER JOIN YA_COUPON_CORPORATE cc ON
        c.coupon_code = cc.coupon_code
    WHERE c.coupon_code = vcLcoupon_code;


    OPEN curPresult12 FOR
    SELECT
      sale_id,
      customer_firstname,
      customer_lastname,
      customer_email,
      customer_comment,
      shipping_method_id,
      split_shipment,
      ship_to_firstname,
      ship_to_lastname,
      ship_to_address_one,
      ship_to_address_two,
      ship_to_city,
      ship_to_state_id,
      ship_to_state,
      ship_to_zip,
      ship_to_country_id,
      ship_to_day_phone,
      ship_to_eve_phone,
      ship_to_fax_number,
      ship_to_mobile_phone,
      ship_to_email,
      payment_method_id,
      bill_to_firstname,
      bill_to_lastname,
      bill_to_address_one,
      bill_to_address_two,
      bill_to_city,
      bill_to_state_id,
      bill_to_state,
      bill_to_zip,
      bill_to_country_id,
      bill_to_phone,
      bill_to_email,
      coupon_code,
      CAST(credit_amount AS FLOAT),
      null,
      cc_type_id,
      cc_expiration_month,
      cc_expiration_year,
      bank_name,
      bank_phone,
      currency,
      ship_profile_id,
      bill_profile_id,
      cc_profile_id,
      message_type,
      sender,
      receiver,
      date_of_delivery,
      content,
      font,
      colour,
      lang,
  	  cc_numberencrypted,
  	  encryptionkey
    FROM
      ya_checkout_data_shadow c
      LEFT OUTER JOIN ya_giftcard_data g ON
        c.shopper_id = g.shopper_id
        AND c.site_id = g.site_id
		AND c.paypal_uid=cPguid
    WHERE
      c.shopper_id = cPshopper_id
      AND c.site_id = iPsite_id
	  AND c.paypal_uid=cPguid;

    RETURN;
  END GetShadowPDOrderWithWarranty;
  
PROCEDURE GetShadowOrderWithWarrantyYS (
	cPguid IN CHAR,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult13 OUT refCur, --Get Shopper obj
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur, -- GetBasket refCur7
    curPresult8 OUT refCur,
    curPresult9 OUT refCur,
    curPresult10 OUT refCur,
    curPresult11 OUT refCur,
    curPresult12 OUT refCur,
	curPresult14 OUT refCur
  )
  AS
    iLcountry_id INT;
    vcLcoupon_code VARCHAR2(32);
    iLdummy INT;
  BEGIN
    BEGIN
      SELECT ship_to_country_id
      INTO iLcountry_Id
      FROM ya_checkout_data_shadow
      WHERE
        shopper_id = cPshopper_id
        AND	site_id = iPsite_id
		AND paypal_uid=cPguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLcountry_id := -1;
    END;

	--Get Shopper Detail
	Pkg_FE_ShopperAccess.GetShopperDataByShopperIdYS(
	  cPshopper_id,iPsite_id, curPresult13);
    -- GetBasket INTO curPresult1 to curPresult7
    Pkg_Fe_Basketaccess2.GetShadowBasketWithWarranty(
      cPguid,
	  cPshopper_id,
      iPsite_id,
      iPlang_id,
      0,
      iLcountry_id,
      curPresult1,
      curPresult2,
      curPresult3,
      curPresult4,
      curPresult5,
      curPresult6,
      curPresult7
      );

    BEGIN
      SELECT trim(coupon_code)
      INTO vcLcoupon_code
      FROM ya_checkout_data_shadow
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id
		AND paypal_uid=cPguid;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      vcLcoupon_code := '';
    END;
	--GetCoupon INTO curPresult7 to curPresult11
	Pkg_Fe_Couponaccess.GetCouponBySite(
	  vcLcoupon_code,
	  iPsite_id,
	  curPresult8,
	  curPresult9,
	  curPresult10,
	  curPresult11,
	  curPresult12
	  );

    OPEN curPresult14 FOR
    SELECT
      sale_id,
      customer_firstname,
      customer_lastname,
      customer_email,
      customer_comment,
      shipping_method_id,
      split_shipment,
      ship_to_firstname,
      ship_to_lastname,
      ship_to_address_one,
      ship_to_address_two,
      ship_to_city,
      ship_to_state_id,
      ship_to_state,
      ship_to_zip,
      ship_to_country_id,
      ship_to_day_phone,
      ship_to_eve_phone,
      ship_to_fax_number,
      ship_to_mobile_phone,
      ship_to_email,
      payment_method_id,
      bill_to_firstname,
      bill_to_lastname,
      bill_to_address_one,
      bill_to_address_two,
      bill_to_city,
      bill_to_state_id,
      bill_to_state,
      bill_to_zip,
      bill_to_country_id,
      bill_to_phone,
      bill_to_email,
      coupon_code,
      CAST(credit_amount AS FLOAT),
      null,
      cc_type_id,
      cc_expiration_month,
      cc_expiration_year,
      bank_name,
      bank_phone,
      currency,
      ship_profile_id,
      bill_profile_id,
      cc_profile_id,
      message_type,
      sender,
      receiver,
      date_of_delivery,
      content,
      font,
      colour,
      lang,
  	  cc_numberencrypted,
  	  encryptionkey
    FROM
      ya_checkout_data_shadow c
      LEFT OUTER JOIN ya_giftcard_data g ON
        c.shopper_id = g.shopper_id
        AND c.site_id = g.site_id
		AND c.paypal_uid=cPguid
    WHERE
      c.shopper_id = cPshopper_id
      AND c.site_id = iPsite_id
	  AND c.paypal_uid=cPguid;

    RETURN;
  END GetShadowOrderWithWarrantyYS;
  
  PROCEDURE GetOrderWithWarrantyEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
	curPresult13 OUT refCur, -- GetShopper refCur1
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur, -- GetBasket refCur7
    curPresult8 OUT refCur, -- GetCoupon refCur1
    curPresult9 OUT refCur, -- GetCoupon refCur2
    curPresult10 OUT refCur, -- GetCoupon refCur3
    curPresult11 OUT refCur, -- GetCoupon refCur4
    curPresult12 OUT refCur, -- GetCoupon refCur5
	curPresult14 OUT refCur
  )
  AS
    iLcountry_id INT;
    vcLcoupon_code VARCHAR2(32);
    iLdummy INT;
  BEGIN
    BEGIN
      SELECT ship_to_country_id
      INTO iLcountry_Id
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND	site_id = iPsite_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLcountry_id := -1;
    END;
	--Get Shopper Detail
	Pkg_FE_ShopperAccess.GetShopperDataByShopperIdYS(
	  cPshopper_id,iPsite_id, curPresult13);

    -- GetBasket INTO curPresult1 to curPresult7
    Pkg_Fe_Basketaccess2.GetBasketWithWarranty(
      cPshopper_id,
      iPsite_id,
      iPlang_id,
      0,
      iLcountry_id,
      curPresult1,
      curPresult2,
      curPresult3,
      curPresult4,
      curPresult5,
      curPresult6,
      curPresult7
      );

    BEGIN
      SELECT trim(coupon_code)
      INTO vcLcoupon_code
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      vcLcoupon_code := '';
    END;
	--GetCoupon INTO curPresult8 to curPresult12
	Pkg_Fe_Couponaccess.GetCouponBySite(
	  vcLcoupon_code,
	  iPsite_id,
	  curPresult8,
	  curPresult9,
	  curPresult10,
	  curPresult11,
	  curPresult12
	  );

    OPEN curPresult14 FOR
    SELECT
      sale_id,
      customer_firstname,
      customer_lastname,
      customer_email,
      customer_comment,
      shipping_method_id,
      split_shipment,
      ship_to_firstname,
      ship_to_lastname,
      ship_to_address_one,
      ship_to_address_two,
      ship_to_city,
      ship_to_state_id,
      ship_to_state,
      ship_to_zip,
      ship_to_country_id,
      ship_to_day_phone,
      ship_to_eve_phone,
      ship_to_fax_number,
      ship_to_mobile_phone,
      ship_to_email,
      payment_method_id,
      bill_to_firstname,
      bill_to_lastname,
      bill_to_address_one,
      bill_to_address_two,
      bill_to_city,
      bill_to_state_id,
      bill_to_state,
      bill_to_zip,
      bill_to_country_id,
      bill_to_phone,
      bill_to_email,
      coupon_code,
      CAST(credit_amount AS FLOAT),
      null,
      cc_type_id,
      cc_expiration_month,
      cc_expiration_year,
      bank_name,
      bank_phone,
      currency,
      ship_profile_id,
      bill_profile_id,
      cc_profile_id,
      message_type,
      sender,
      receiver,
      date_of_delivery,
      content,
      font,
      colour,
      lang,
  	  cc_numberencrypted,
  	  encryptionkey
    FROM
      ya_checkout_data c
      LEFT OUTER JOIN ya_giftcard_data g ON
        c.shopper_id = g.shopper_id
        AND c.site_id = g.site_id
    WHERE
      c.shopper_id = cPshopper_id
      AND c.site_id = iPsite_id;

    RETURN;
  END GetOrderWithWarrantyEncrypted;

  PROCEDURE GetOrderEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult13 OUT refCur, -- GetShopper refCur1
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
	  curPresult7 OUT refCur, -- GetBasket refCur7 (optional)
    curPresult8 OUT refCur, -- GetCoupon refCur1
    curPresult9 OUT refCur, -- GetCoupon refCur2
    curPresult10 OUT refCur, -- GetCoupon refCur3
    curPresult11 OUT refCur, -- GetCoupon refCur4
    curPresult12 OUT refCur, -- GetCoupon refCur5
	  curPresult14 OUT refCur
  )
  AS
    iLcountry_id INT;
    vcLcoupon_code VARCHAR2(32);
    iLdummy INT;
  BEGIN
    BEGIN
      SELECT ship_to_country_id
      INTO iLcountry_Id
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND	site_id = iPsite_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iLcountry_id := -1;
    END;

    -- GetBasket INTO curPresult1 to curPresult6
    Pkg_Fe_Basketaccess2.GetBasketYS(
      cPshopper_id,
      iPsite_id,
      iPlang_id,
      0,
      iLcountry_id,
      curPresult13,
      curPresult1,
      curPresult2,
      curPresult3,
      curPresult4,
      curPresult5,
      curPresult6
      );

    BEGIN
      SELECT trim(coupon_code)
      INTO vcLcoupon_code
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      vcLcoupon_code := '';
    END;

	--GetCoupon INTO curPresult8 to curPresult12
	Pkg_Fe_Couponaccess.GetCouponBySite(
	  vcLcoupon_code,
	  iPsite_id,
	  curPresult8,
	  curPresult9,
	  curPresult10,
	  curPresult11,
	  curPresult12
	  );

    OPEN curPresult14 FOR
    SELECT
      sale_id,
      customer_firstname,
      customer_lastname,
      customer_email,
      customer_comment,
      shipping_method_id,
      split_shipment,
      ship_to_firstname,
      ship_to_lastname,
      ship_to_address_one,
      ship_to_address_two,
      ship_to_city,
      ship_to_state_id,
      ship_to_state,
      ship_to_zip,
      ship_to_country_id,
      ship_to_day_phone,
      ship_to_eve_phone,
      ship_to_fax_number,
      ship_to_mobile_phone,
      ship_to_email,
      payment_method_id,
      bill_to_firstname,
      bill_to_lastname,
      bill_to_address_one,
      bill_to_address_two,
      bill_to_city,
      bill_to_state_id,
      bill_to_state,
      bill_to_zip,
      bill_to_country_id,
      bill_to_phone,
      bill_to_email,
      coupon_code,
      CAST(credit_amount AS FLOAT),
      null,
      cc_type_id,
      cc_expiration_month,
      cc_expiration_year,
      bank_name,
      bank_phone,
      currency,
      ship_profile_id,
      bill_profile_id,
      cc_profile_id,
      message_type,
      sender,
      receiver,
      date_of_delivery,
      content,
      font,
      colour,
      lang,
  	  cc_numberencrypted,
  	  encryptionkey
    FROM
      ya_checkout_data c
      LEFT OUTER JOIN ya_giftcard_data g ON
        c.shopper_id = g.shopper_id
        AND c.site_id = g.site_id
    WHERE
      c.shopper_id = cPshopper_id
      AND c.site_id = iPsite_id;

    RETURN;
  END GetOrderEncrypted;


  PROCEDURE GetOrderXml (
    iPorder_num IN INT,
    clobPorder_xml OUT CLOB
  )
  AS
  BEGIN
    SELECT order_xml
    INTO clobPorder_xml
    FROM ya_order
    WHERE order_num = iPorder_num;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    clobPorder_xml := '';
  END GetOrderXml;



  PROCEDURE GetOrderFromBackend (
    iPorder_num IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur
  )
  AS
    iLorder_id INT;
  BEGIN
    BEGIN
      SELECT id
      INTO iLorder_id
      FROM backend_adm.order_info
      WHERE origin_order_id = TO_CHAR(iPorder_num);
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLorder_id := -1;
    END;

    OPEN curPresult1 FOR
    SELECT origin_id
    FROM backend_adm.order_info
    WHERE id = iLorder_id;

    OPEN curPresult2 FOR
    SELECT
      ol.id,
      ol.prod_id,
      ol.qnty,
      ol.unit_price,
      ol.parent_id,
      ol.shipment_unit,
      ol.misc_info,
      ol.avlb,
      ol.is_preorder,
      ol.relative_delivery_day
    FROM backend_adm.order_line ol
    WHERE ol.order_info_id = iLorder_id
	AND (ol.parent_id=-1 or ol.parent_id=ol.prod_id)
    ORDER BY ol.id;

    OPEN curPresult3 FOR
    SELECT 
      oi.origin_order_id,
      oi.sales_id,
      oi.origin_id,
      oi.category,
      oi.order_dt,
      oi.cust_id,
      oi.cust_first_name,
      oi.cust_last_name,
      oi.cust_email,
      si.method,
      si.first_name,
      si.last_name,
      si.addr_1,
      si.addr_2,
      si.city,
      si.state_code,
      si.state,
      si.zip,
      si.country,
      si.day_phone,
      si.evening_phone,
      si.fax,
      si.mobile,
      si.email,
      bi.method,
      bi.first_name,
      bi.last_name,
      bi.addr_1,
      bi.addr_2,
      bi.city,
      bi.state_code,
      bi.state,
      bi.zip,
      bi.country,
      bi.email,
      bi.auth_code,
      bi.auth_amt,
      bi.avs_code,
      bi.cc_num,
      bi.cc_type,
      bi.cc_exp_month,
      bi.cc_exp_year,
      bi.bank_name,
      bi.bank_phone,
      oi.cust_cmt,
      bi.ref_id,
      oi.ref_id,
      bi.coupon,
      bi.coupon_amt,
      bi.credit_amt,
      oi.cmt,
      oi.origin_version,
      oi.split_shipment,
      bi.phone,
      bi.shipment_amt,
      bi.handling_amt,
      bi.special_handling,
      bi.tax,
      bi.currency,
      bi.encryption_key,
      bi.cc_num_encrypted
    FROM
      backend_adm.order_info oi, 
      (select * from billing_info where order_info_id = iLorder_id) bi,
      (select * from shipping_info where order_info_id = iLorder_id) si
--      backend_adm.shipping_info si, 
--      backend_adm.billing_info bi
    WHERE 1=1
    AND oi.id = iLorder_id
    AND oi.id = si.order_info_id
    AND bi.order_info_id = si.order_info_id;

    RETURN;
  END GetOrderFromBackend;


  PROCEDURE CheckCouponUsage (
    cPshopper_id IN CHAR,
    vcPcoupon_code IN VARCHAR,
    iPreturn OUT INT
  )
  AS
	isHSBC	INT;
  BEGIN
	SELECT NVL(INSTR(vcPcoupon_code, 'TIPSWAP%'),0) INTO isHSBC FROM dual;
	IF (isHSBC>0) THEN
		BEGIN
			SELECT COUNT(1)
			INTO iPreturn
			FROM ya_order
			WHERE
				shopper_id = cPshopper_id
				AND coupon_code LIKE 'TIPSWAP%';
		END;
	ELSE
		BEGIN
			IF (vcPcoupon_code IS NULL) THEN
				BEGIN
					SELECT COUNT(1)
					INTO iPreturn
					FROM ya_order
					WHERE
						shopper_id = cPshopper_id
						AND
						(coupon_code IS NULL OR ASCII(coupon_code)=0) ;
				END;
			ELSE
				BEGIN
					SELECT COUNT(1)
					INTO iPreturn
					FROM ya_order
					WHERE
						shopper_id = cPshopper_id
						AND coupon_code = vcPcoupon_code;
				END;
			END IF;
		END;
	END IF;
	RETURN;
  END CheckCouponUsage;


  PROCEDURE GetOrderCount (
    cPshopper_id IN CHAR,
    iPcount OUT INT
  )
  AS
    iLBE_count INT;
    iLFE_count INT;
  BEGIN
    SELECT COUNT(origin_order_id)
    INTO iLBE_count
    FROM Backend_adm.order_info
    WHERE cust_id = cPshopper_id;

    SELECT COUNT(order_num)
    INTO iLFE_count
    FROM ya_order
    WHERE
      shopper_id = cPshopper_id
      AND order_num NOT IN
        (
          SELECT origin_order_id
          FROM Backend_adm.order_info
          WHERE cust_id = cPshopper_id
					AND length(trim(origin_order_id)) > 1
        );

    iPcount := iLFE_count + iLBE_count;
    RETURN;
  END GetOrderCount;

  PROCEDURE GetPreCheckoutDataEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  )
  AS
    iLpay_method INT;
    nvcPbill_addr_one NVARCHAR2(255);
    iLship_profile INT;
    iLbill_profile INT;
    iLcc_profile INT;
    iLtype_id INT := 1;
  BEGIN
    DELETE FROM ya_giftcard_data
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    BEGIN
      SELECT
        c.payment_method_id,
        c.bill_to_address_one
      INTO
        iLpay_method,
        nvcPbill_addr_one
      FROM ya_checkout_data c
      WHERE
        c.shopper_id = cPshopper_id
        AND c.site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        iLpay_method := NULL;
        nvcPbill_addr_one := NULL;
      END;
    END;

    -- Payment Method lookup
    --  UNKNOWN = -1
    --  CREDIT_CARD = 1
    --  MONEY_ORDER = 2
    --  COD = 5
    --  YESASIA_CREDIT = 8
    --  PAYPAL = 12

    -- redirect to ORDER review page IF checkout data filled IN all required data
    IF iLpay_method IS NOT NULL AND iLpay_method <> -1 AND (iLpay_method <> 1 OR (iLpay_method = 1 AND nvcPbill_addr_one IS NOT NULL AND LENGTH(nvcPbill_addr_one) > 0)) THEN
      BEGIN
        RETURN;
      END;
    END IF;

    BEGIN
      SELECT sa.address_id
      INTO iLship_profile
      FROM YA_ADDRESS sa
      WHERE
        sa.preferred_ship = 'Y'
        AND sa.shopper_id = cPshopper_id
        AND sa.country_id IN (SELECT c1.country_id FROM YA_SITE_CANSHIP_COUNTRY c1 WHERE site_id = iPsite_id)
        AND sa.created_by_checkout_session = 'N'
        AND ROWNUM = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLship_profile := NULL;
    END;

    BEGIN
      SELECT ba.address_id
      INTO iLbill_profile
      FROM YA_ADDRESS ba
      WHERE
        ba.preferred_bill = 'Y'
        AND ba.shopper_id = cPshopper_id
        AND ba.created_by_checkout_session = 'N'
        AND ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLbill_profile := NULL;
    END;

    IF iPsite_id = 1 OR iPsite_id = 7 OR iPsite_id = 10 OR iPsite_id = 14 THEN
    BEGIN
      SELECT cc.profile_id
      INTO iLcc_profile
      FROM YA_CREDIT_CARD_PROFILE cc
      WHERE
        cc.preferred = 'Y'
        AND cc.shopper_id = cPshopper_id
        AND cc.card_type_id IN (1,2,3,6)
        AND cc.created_by_checkout_session = 'N'
        AND ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLcc_profile := NULL;
    END;
    ELSIF iPsite_id = 13 THEN
    BEGIN
      SELECT cc.profile_id
      INTO iLcc_profile
      FROM YA_CREDIT_CARD_PROFILE cc
      WHERE
        cc.preferred = 'Y'
        AND cc.shopper_id = cPshopper_id
        AND cc.card_type_id IN (1,2)
        AND cc.created_by_checkout_session = 'N'
        AND ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLcc_profile := NULL;
    END;    
    ELSE
      iLcc_profile := NULL;
    END IF;

    IF iPsite_id = 12 THEN
      iLtype_id := 2;
    END IF;
    
    Pkg_Fe_Shopperaccess.GetShopperDataByShopperId(cPshopper_id, curPresult1);

    IF iLship_profile IS NOT NULL AND iLbill_profile IS NOT NULL AND iLcc_profile IS NOT NULL THEN
      BEGIN
        OPEN curPresult2 FOR
        SELECT
          firstname,
          lastname,
          address1,
          address2,
          city,
          state,
          zip,
          country_id,
          day_phone,
          email,
          address_id,
          state_id
        FROM YA_ADDRESS
        WHERE
          shopper_id = cPshopper_id
          AND address_id = iLship_profile;

        OPEN curPresult3 FOR
        SELECT
          firstname,
          lastname,
          address1,
          address2,
          city,
          state,
          zip,
          country_id,
          day_phone,
          email,
          address_id,
          state_id
        FROM YA_ADDRESS
        WHERE
          shopper_id = cPshopper_id
          AND address_id = iLbill_profile;

        OPEN curPresult4 FOR
        SELECT
          profile_id,
          card_type_id,
          card_number,
          expiration_month,
          expiration_year,
          firstname_on_card,
          lastname_on_card,
    		  card_numberencrypted,
    		  encryptionkey
        FROM YA_CREDIT_CARD_PROFILE
        WHERE
          shopper_id = cPshopper_id
          AND profile_id = iLcc_profile;
      END;
    END IF;

    COMMIT;
    RETURN;

  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END GetPreCheckoutDataEncrypted;

  PROCEDURE CreateCheckoutDataEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPship_to_firstname IN NVARCHAR2,
    nvcPship_to_lastname IN NVARCHAR2,
    nvcPship_to_address_one IN NVARCHAR2,
    nvcPship_to_address_two IN NVARCHAR2,
    nvcPship_to_city IN NVARCHAR2,
    iPship_to_state_id IN INT,
    nvcPship_to_state IN NVARCHAR2,
    nvcPship_to_zip IN NVARCHAR2,
    iPship_to_country_id IN INT,
    nvcPship_to_phone IN NVARCHAR2,
    nvcPship_to_email IN NVARCHAR2,
    iPship_address_id IN INT,
    iPpayment_method IN INT,
    nvcPbill_to_address_one IN NVARCHAR2,
    nvcPbill_to_address_two IN NVARCHAR2,
    nvcPbill_to_city IN NVARCHAR2,
    iPbill_to_state_id IN INT,
    nvcPbill_to_state IN NVARCHAR2,
    nvcPbill_to_zip IN NVARCHAR2,
    iPbill_to_country_id IN INT,
    nvcPbill_to_phone IN NVARCHAR2,
    nvcPbill_to_email IN NVARCHAR2,
    iPbill_address_id IN INT,
    iPcard_profile_id IN INT,
    iPcard_type_id IN INT,
    vcPcard_number IN VARCHAR2,
    iPcard_exp_month IN INT,
    iPcard_exp_year IN INT,
    nvcPcard_firstname IN NVARCHAR2,
    nvcPcard_lastname IN NVARCHAR2,
    vcPcard_numberEncrypted IN VARCHAR2,
    iPencryptionKey_id IN INT,
	  cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
    iLship_method INT;
    deciLcredit_amount DECIMAL(18,2);
  BEGIN    
    IF iPsite_id = 1 THEN -- US site
      iLship_method := 16; -- Standard
    ELSIF iPsite_id = 7 THEN -- Global Site      
      IF iPship_to_country_id = 98 THEN -- Hong Kong
        iLship_method := 15; -- Express
      ELSE
        iLship_method := 12; -- Standard
      END IF;
    ELSIF iPsite_id = 10 THEN -- YesStyle Site    
      iLship_method := 49; -- Standard
	  ELSIF iPsite_id = 11 THEN -- YesStyle China      
      iLship_method := 53; -- Standard
	  ELSIF iPsite_id = 12 THEN -- Hallmark      
      iLship_method := 53; -- Standard
    ELSIF iPsite_id = 13 THEN -- YesStyle Australia
      iLship_method := 49; -- Standard
    ELSIF iPsite_id = 14 THEN -- YesStyle Hong Kong
      iLship_method := 49; -- Standard
    ELSE
      iLship_method := -1;
    END IF;

    Pkg_Fe_Creditaccess.GetCurrentBalanceBySite(deciLcredit_amount, cPshopper_id, iPsite_id, cPcurrency);

    DELETE FROM ya_checkout_data
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    INSERT INTO ya_checkout_data
      (
        shopper_id,
        site_id,
        customer_firstname,
        customer_lastname,
        customer_email,
        shipping_method_id,
        ship_to_firstname,
        ship_to_lastname,
        ship_to_address_one,
        ship_to_address_two,
        ship_to_city,
        ship_to_state_id,
        ship_to_state,
        ship_to_zip,
        ship_to_country_id,
        ship_to_day_phone,
        ship_to_email,
        payment_method_id,
        bill_to_firstname,
        bill_to_lastname,
        bill_to_address_one,
        bill_to_address_two,
        bill_to_city,
        bill_to_state_id,
        bill_to_state,
        bill_to_zip,
        bill_to_country_id,
        bill_to_phone,
        bill_to_email,
        cc_type_id,
        cc_expiration_month,
        cc_expiration_year,
        currency,
        bill_profile_id,
        ship_profile_id,
        cc_profile_id,
        credit_amount,
        created_datetime,
        last_updated_datetime,
    	  cc_numberencrypted,
    	  encryptionkey

      )
    VALUES
      (
        cPshopper_id,
        iPsite_id,
        nvcPcustomer_firstname,
        nvcPcustomer_lastname,
        nvcPcustomer_email,
        iLship_method,
        nvcPship_to_firstname,
        nvcPship_to_lastname,
        nvcPship_to_address_one,
        nvcPship_to_address_two,
        nvcPship_to_city,
        iPship_to_state_id,
        nvcPship_to_state,
        nvcPship_to_zip,
        iPship_to_country_id,
        nvcPship_to_phone,
        nvcPship_to_email,
        iPpayment_method,
        nvcPcard_firstname,
        nvcPcard_lastname,
        nvcPbill_to_address_one,
        nvcPbill_to_address_two,
        nvcPbill_to_city,
        iPbill_to_state_id,
        nvcPbill_to_state,
        nvcPbill_to_zip,
        iPbill_to_country_id,
        nvcPbill_to_phone,
        nvcPbill_to_email,
        iPcard_type_id,
        iPcard_exp_month,
        iPcard_exp_year,
        cPcurrency,
        iPbill_address_id,
        iPship_address_id,
        iPcard_profile_id,
        deciLcredit_amount,
        SYSDATE,
        SYSDATE,
        vcPcard_numberEncrypted,
        iPencryptionKey_id
      );
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END CreateCheckoutDataEncrypted;


  PROCEDURE UpdateShoppingInfo (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPshipping_method_id IN INT,
    iPsplit_shipment IN INT
  )
  AS
  BEGIN
    UPDATE ya_checkout_data
    SET
      shipping_method_id = iPshipping_method_id,
      split_shipment = iPsplit_shipment,
      last_updated_datetime = SYSDATE
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateShoppingInfo;

  PROCEDURE UpdateShippingAddress (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPship_to_firstname IN NVARCHAR2,
    nvcPship_to_lastname IN NVARCHAR2,
    nvcPship_to_address_one IN NVARCHAR2,
    nvcPship_to_address_two IN NVARCHAR2,
    nvcPship_to_city IN NVARCHAR2,
    iPship_to_state_id IN INT,
    nvcPship_to_state IN NVARCHAR2,
    nvcPship_to_zip IN NVARCHAR2,
    iPship_to_country_id IN INT,
    nvcPship_to_phone IN NVARCHAR2,
    nvcPship_to_email IN NVARCHAR2,
    iPaddress_id IN INT,
    cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
    iLsale_id INT;
    iLstored_shipping_method_id INT;
    cLstored_shopper_id CHAR(32);
    iLshipping_method_id INT;
  BEGIN
    iLsale_id := -1; -- Unknown sale id

    -- Check whether checkout data already exists
    BEGIN
      SELECT
        shipping_method_id,
        shopper_id
      INTO
        iLstored_shipping_method_id,
        cLstored_shopper_id
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLstored_shipping_method_id := -1;
      cLstored_shopper_id := '';
    END;


    IF (cLstored_shopper_id IS NOT NULL) THEN -- That means checkout data exists
      BEGIN
        -- Resolve Conflicts BETWEEN Country AND Shipping Method Id
        IF (iPsite_id = 1) THEN
          IF (iPship_to_country_id = 226 AND iLstored_shipping_method_id = 11) THEN
            -- Canadian shipping method + Ship to US
            UPDATE ya_checkout_data
            SET shipping_method_id = 16 -- Reset the method to Standard
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id = 38 AND iLstored_shipping_method_id <> 11) THEN
            -- Ship to Canada + non-Canadian shipping method
            UPDATE ya_checkout_data
            SET shipping_method_id = 11 -- Reset shipping method to Canadian
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iLstored_shipping_method_id IS NULL OR iLstored_shipping_method_id = -1) THEN
            IF (iPship_to_country_id = 226) THEN
              UPDATE ya_checkout_data
              SET shipping_method_id = 16 -- SET shipping method to Standard
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            ELSIF (iPship_to_country_id = 38) THEN
              UPDATE ya_checkout_data
              SET shipping_method_id = 11 -- SET shipping method to Canadian
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            END IF;
          END IF;
        ELSIF (iPsite_id = 7) THEN
          IF (iPship_to_country_id = 98 AND iLstored_shipping_method_id <> 15) THEN
            -- IF ship to HK the only eligible method is Express
            UPDATE ya_checkout_data
            SET shipping_method_id = 15
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id = 115 AND iLstored_shipping_method_id <> 12) THEN
            -- IF ship to Korea the only eligible method is Standard
            UPDATE ya_checkout_data
            SET shipping_method_id = 12
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id <> 98 AND iPship_to_country_id <> 115
            AND iLstored_shipping_method_id <> 12 AND iLstored_shipping_method_id <> 15) THEN
            -- IF ship to Global site AND <> HK AND Korea default to Standard
            UPDATE ya_checkout_data
            SET shipping_method_id = 12
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id <> 98 AND iPship_to_country_id <> 115
            AND iLstored_shipping_method_id <> 12 AND iLstored_shipping_method_id <> 15) THEN
            -- IF ship to Global site AND <> HK AND Korea default to Standard
            UPDATE ya_checkout_data
            SET shipping_method_id = 12
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iLstored_shipping_method_id IS NULL) THEN
            -- Shipping method has not been SET yet
            IF (iPship_to_country_id = 98) THEN
              -- IF ship HK default to Express
              UPDATE ya_checkout_data
              SET shipping_method_id = 15 -- SET shipping method to Express
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            ELSE
              -- Including Korea
              UPDATE ya_checkout_data
              SET shipping_method_id = 12 -- SET shipping method to Standard
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            END IF;
          END IF;
        ELSIF (iPsite_id = 10) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 49 -- SET shipping method to Express
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 11) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 53
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 12) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 53
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 13) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 49
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 14) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 49
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        END IF;

        UPDATE ya_checkout_data
        SET
          ship_to_firstname = nvcPship_to_firstname,
          ship_to_lastname = nvcPship_to_lastname,
          ship_to_address_one = nvcPship_to_address_one,
          ship_to_address_two = nvcPship_to_address_two,
          ship_to_city = nvcPship_to_city,
          ship_to_state_id = iPship_to_state_id,
          ship_to_state = nvcPship_to_state,
          ship_to_zip = nvcPship_to_zip,
          ship_to_country_id = iPship_to_country_id,
          ship_to_day_phone = nvcPship_to_phone,
          ship_to_email = nvcPship_to_email,
          ship_profile_id = iPaddress_id,
          last_updated_datetime = SYSDATE()
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;
      END;
    ELSE
      BEGIN
        IF (iPsite_id = 10 or iPsite_id = 13 or iPsite_id = 14) THEN
          iLshipping_method_id := 49; -- Standard
        ELSIF (iPsite_id = 11 or iPsite_id = 12) THEN
          iLshipping_method_id := 53; -- Standard
        ELSE
          CASE iPship_to_country_id
            WHEN 226 THEN -- US
              iLshipping_method_id := 16; -- Standard
            WHEN 38 THEN -- Canada
              iLshipping_method_id := 11; -- Canadian
            WHEN 98 THEN -- Hong Kong
              iLshipping_method_id := 15; -- Express
            ELSE 
              iLshipping_method_id := 12;
          END CASE;
        END IF;

        INSERT INTO ya_checkout_data
          (
            shopper_id,
            site_id,
            sale_id,
            customer_firstname,
            customer_lastname,
            customer_email,
            ship_to_firstname,
            ship_to_lastname,
            ship_to_address_one,
            ship_to_address_two,
            ship_to_city,
            ship_to_state_id,
            ship_to_state,
            ship_to_zip,
            ship_to_country_id,
            ship_to_day_phone,
            ship_to_email,
            ship_profile_id,
            shipping_method_id,
            currency
          )
        VALUES
          (
            cPshopper_id,
            iPsite_id,
            iLsale_id,
            nvcPcustomer_firstname,
            nvcPcustomer_lastname,
            nvcPcustomer_email,
            nvcPship_to_firstname,
            nvcPship_to_lastname,
            nvcPship_to_address_one,
            nvcPship_to_address_two,
            nvcPship_to_city,
            iPship_to_state_id,
            nvcPship_to_state,
            nvcPship_to_zip,
            iPship_to_country_id,
            nvcPship_to_phone,
            nvcPship_to_email,
            iPaddress_id,
            iLshipping_method_id,
            cPcurrency
          );
      END;
    END IF;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateShippingAddress;

  PROCEDURE UpdateShippingAddressYS (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPship_to_firstname IN NVARCHAR2,
    nvcPship_to_lastname IN NVARCHAR2,
    nvcPship_to_address_one IN NVARCHAR2,
    nvcPship_to_address_two IN NVARCHAR2,
    nvcPship_to_city IN NVARCHAR2,
    iPship_to_state_id IN INT,
    nvcPship_to_state IN NVARCHAR2,
    nvcPship_to_zip IN NVARCHAR2,
    iPship_to_country_id IN INT,
    nvcPship_to_phone IN NVARCHAR2,
    nvcPship_to_evephone IN NVARCHAR2,
    nvcPship_to_email IN NVARCHAR2,
    iPaddress_id IN INT,
    cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
    iLsale_id INT;
    iLstored_shipping_method_id INT;
    cLstored_shopper_id CHAR(32);
    iLshipping_method_id INT;
  BEGIN
    iLsale_id := -1; -- Unknown sale id

    -- Check whether checkout data already exists
    BEGIN
      SELECT
        shipping_method_id,
        shopper_id
      INTO
        iLstored_shipping_method_id,
        cLstored_shopper_id
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLstored_shipping_method_id := -1;
      cLstored_shopper_id := '';
    END;


    IF (cLstored_shopper_id IS NOT NULL) THEN -- That means checkout data exists
      BEGIN
        -- Resolve Conflicts BETWEEN Country AND Shipping Method Id
        IF (iPsite_id = 1) THEN
          IF (iPship_to_country_id = 226 AND iLstored_shipping_method_id = 11) THEN
            -- Canadian shipping method + Ship to US
            UPDATE ya_checkout_data
            SET shipping_method_id = 16 -- Reset the method to Standard
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id = 38 AND iLstored_shipping_method_id <> 11) THEN
            -- Ship to Canada + non-Canadian shipping method
            UPDATE ya_checkout_data
            SET shipping_method_id = 11 -- Reset shipping method to Canadian
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iLstored_shipping_method_id IS NULL OR iLstored_shipping_method_id = -1) THEN
            IF (iPship_to_country_id = 226) THEN
              UPDATE ya_checkout_data
              SET shipping_method_id = 16 -- SET shipping method to Standard
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            ELSIF (iPship_to_country_id = 38) THEN
              UPDATE ya_checkout_data
              SET shipping_method_id = 11 -- SET shipping method to Canadian
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            END IF;
          END IF;
        ELSIF (iPsite_id = 7) THEN
          IF (iPship_to_country_id = 98 AND iLstored_shipping_method_id <> 15) THEN
            -- IF ship to HK the only eligible method is Express
            UPDATE ya_checkout_data
            SET shipping_method_id = 15
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id = 115 AND iLstored_shipping_method_id <> 12) THEN
            -- IF ship to Korea the only eligible method is Standard
            UPDATE ya_checkout_data
            SET shipping_method_id = 12
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id <> 98 AND iPship_to_country_id <> 115
            AND iLstored_shipping_method_id <> 12 AND iLstored_shipping_method_id <> 15) THEN
            -- IF ship to Global site AND <> HK AND Korea default to Standard
            UPDATE ya_checkout_data
            SET shipping_method_id = 12
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iPship_to_country_id <> 98 AND iPship_to_country_id <> 115
            AND iLstored_shipping_method_id <> 12 AND iLstored_shipping_method_id <> 15) THEN
            -- IF ship to Global site AND <> HK AND Korea default to Standard
            UPDATE ya_checkout_data
            SET shipping_method_id = 12
            WHERE
              shopper_id = cPshopper_id
              AND site_id = iPsite_id;
          ELSIF (iLstored_shipping_method_id IS NULL) THEN
            -- Shipping method has not been SET yet
            IF (iPship_to_country_id = 98) THEN
              -- IF ship HK default to Express
              UPDATE ya_checkout_data
              SET shipping_method_id = 15 -- SET shipping method to Express
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            ELSE
              -- Including Korea
              UPDATE ya_checkout_data
              SET shipping_method_id = 12 -- SET shipping method to Standard
              WHERE
                shopper_id = cPshopper_id
                AND site_id = iPsite_id;
            END IF;
          END IF;
        ELSIF (iPsite_id = 10) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 49 -- SET shipping method to Express
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 11) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 53 -- SET shipping method to Express
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 12) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 53 -- SET shipping method to Express
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 13) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 49 -- SET shipping method to Express
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        ELSIF (iPsite_id = 14) THEN
          UPDATE ya_checkout_data
          SET shipping_method_id = 49 -- SET shipping method to Express
          WHERE
            shopper_id = cPshopper_id
            AND site_id = iPsite_id;
        END IF;

        UPDATE ya_checkout_data
        SET
          ship_to_firstname = nvcPship_to_firstname,
          ship_to_lastname = nvcPship_to_lastname,
          ship_to_address_one = nvcPship_to_address_one,
          ship_to_address_two = nvcPship_to_address_two,
          ship_to_city = nvcPship_to_city,
          ship_to_state_id = iPship_to_state_id,
          ship_to_state = nvcPship_to_state,
          ship_to_zip = nvcPship_to_zip,
          ship_to_country_id = iPship_to_country_id,
          ship_to_day_phone = nvcPship_to_phone,
          ship_to_eve_phone = nvcPship_to_evephone,
          ship_to_email = nvcPship_to_email,
          ship_profile_id = iPaddress_id,
          last_updated_datetime = SYSDATE()
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id;
      END;
    ELSE
      BEGIN
        IF (iPsite_id = 10 or iPsite_id = 13 or iPsite_id = 14) THEN
          iLshipping_method_id := 49; -- Standard		
        ELSIF (iPsite_id = 11 or iPsite_id = 12) THEN
          iLshipping_method_id := 53; -- Standard
        ELSE
          CASE iPship_to_country_id
            WHEN 226 THEN -- US
              iLshipping_method_id := 16; -- Standard
            WHEN 38 THEN -- Canada
              iLshipping_method_id := 11; -- Canadian
            WHEN 98 THEN -- Hong Kong
              iLshipping_method_id := 15; -- Express
            ELSE 
              iLshipping_method_id := 12;
          END CASE;
        END IF;

        INSERT INTO ya_checkout_data
          (
            shopper_id,
            site_id,
            sale_id,
            customer_firstname,
            customer_lastname,
            customer_email,
            ship_to_firstname,
            ship_to_lastname,
            ship_to_address_one,
            ship_to_address_two,
            ship_to_city,
            ship_to_state_id,
            ship_to_state,
            ship_to_zip,
            ship_to_country_id,
            ship_to_day_phone,
			      SHIP_TO_EVE_PHONE,
            ship_to_email,
            ship_profile_id,
            shipping_method_id,
            currency
          )
        VALUES
          (
            cPshopper_id,
            iPsite_id,
            iLsale_id,
            nvcPcustomer_firstname,
            nvcPcustomer_lastname,
            nvcPcustomer_email,
            nvcPship_to_firstname,
            nvcPship_to_lastname,
            nvcPship_to_address_one,
            nvcPship_to_address_two,
            nvcPship_to_city,
            iPship_to_state_id,
            nvcPship_to_state,
            nvcPship_to_zip,
            iPship_to_country_id,
            nvcPship_to_phone,
            nvcPship_to_evephone,
            nvcPship_to_email,
            iPaddress_id,
            iLshipping_method_id,
            cPcurrency
          );
      END;
    END IF;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateShippingAddressYS;

  PROCEDURE UpdateBillAddress (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    nvcPcustomer_firstname IN NVARCHAR2,
    nvcPcustomer_lastname IN NVARCHAR2,
    nvcPcustomer_email IN NVARCHAR2,
    nvcPbill_to_address_one IN NVARCHAR2,
    nvcPbill_to_address_two IN NVARCHAR2,
    nvcPbill_to_city IN NVARCHAR2,
    iPbill_to_state_id IN INT,
    nvcPbill_to_state IN NVARCHAR2,
    nvcPbill_to_zip IN NVARCHAR2,
    iPbill_to_country_id IN INT,
    nvcPbill_to_email IN NVARCHAR2,
    iPaddress_id IN INT,
    cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
    iLsale_id INT;
    iLexist INT;
  BEGIN
    iLsale_id := -1; -- Unknown Sale Id

    BEGIN
      SELECT 1
      INTO iLexist
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLexist := -1;
    END;

    IF iLexist > 0 THEN
      UPDATE ya_checkout_data
      SET
        bill_to_address_one = nvcPbill_to_address_one,
        bill_to_address_two = nvcPbill_to_address_two,
        bill_to_city = nvcPbill_to_city,
        bill_to_state_id = iPbill_to_state_id,
        bill_to_state = nvcPbill_to_state,
        bill_to_zip = nvcPbill_to_zip,
        bill_to_country_id = iPbill_to_country_id,
        bill_to_email = nvcPbill_to_email,
        bill_profile_id = iPaddress_id,
        last_updated_datetime = SYSDATE()
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    ELSE
      INSERT INTO ya_checkout_data
        (
          shopper_id,
          site_id,
          sale_id,
          customer_firstname,
          customer_lastname,
          customer_email,
          bill_to_address_one,
          bill_to_address_two,
          bill_to_city,
          bill_to_state_id,
          bill_to_state,
          bill_to_zip,
          bill_to_country_id,
          bill_to_email,
          bill_profile_id,
          currency
        )
      VALUES
        (
          cPshopper_id,
          iPsite_id,
          iLsale_id,
          nvcPcustomer_firstname,
          nvcPcustomer_lastname,
          nvcPcustomer_email,
          nvcPbill_to_address_one,
          nvcPbill_to_address_two,
          nvcPbill_to_city,
          iPbill_to_state_id,
          nvcPbill_to_state,
          nvcPbill_to_zip,
          iPbill_to_country_id,
          nvcPbill_to_email,
          iPaddress_id,
          cPcurrency
        );
    END IF;

    COMMIT;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    ROLLBACK;
  END UpdateBillAddress;




  PROCEDURE UpdateCreditCardPaymentInfo (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPprofile_id IN INT,
    iPmethod_id IN INT,
    iPtype_id IN INT,
    vcPcard_number IN VARCHAR2,
    iPexp_month IN INT,
    iPexp_year IN INT,
    nvcPfirstname IN NVARCHAR2,
    nvcPlastname IN NVARCHAR2,
    vcPcoupon_code IN VARCHAR2,
    nPcredit_amount IN NUMBER
  )
  AS
    iLexist INT;
  BEGIN
    IF iPprofile_id <> -1 THEN
      UPDATE YA_CREDIT_CARD_PROFILE
      SET
        expiration_month = iPexp_month,
        expiration_year = iPexp_year
      WHERE
        profile_id = iPprofile_id
        AND shopper_id = cPshopper_id;
    END IF;

    UPDATE ya_checkout_data
    SET
      payment_method_id = iPmethod_id,
      coupon_code = vcPcoupon_code,
      credit_amount = nPcredit_amount,
      cc_profile_id = iPprofile_id,
      cc_type_id = iPtype_id,
      cc_expiration_month = iPexp_month,
      cc_expiration_year = iPexp_year,
      bill_to_firstname = nvcPfirstname,
      bill_to_lastname = nvcPlastname,
      bill_to_phone = '',
      last_updated_datetime = SYSDATE()
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateCreditCardPaymentInfo;



  PROCEDURE UpdateCCPaymentInfoEncrypted (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPprofile_id IN INT,
    iPmethod_id IN INT,
    iPtype_id IN INT,
    vcPcard_number IN VARCHAR2,
    iPexp_month IN INT,
    iPexp_year IN INT,
    nvcPfirstname IN NVARCHAR2,
    nvcPlastname IN NVARCHAR2,
    vcPcoupon_code IN VARCHAR2,
    nPcredit_amount IN NUMBER,
    vcPcard_numberEncrypted IN VARCHAR2,
    iPencryption_keyId IN INT
  )
  AS
    iLexist INT;
  BEGIN
    IF iPprofile_id <> -1 THEN
      UPDATE YA_CREDIT_CARD_PROFILE
      SET
        expiration_month = iPexp_month,
        expiration_year = iPexp_year
      WHERE
        profile_id = iPprofile_id
        AND shopper_id = cPshopper_id;
    END IF;

    UPDATE ya_checkout_data
    SET
      payment_method_id = iPmethod_id,
      coupon_code = vcPcoupon_code,
      credit_amount = nPcredit_amount,
      cc_profile_id = iPprofile_id,
      cc_type_id = iPtype_id,
      cc_expiration_month = iPexp_month,
      cc_expiration_year = iPexp_year,
      bill_to_firstname = nvcPfirstname,
      bill_to_lastname = nvcPlastname,
      bill_to_phone = '',
      last_updated_datetime = SYSDATE(),
      cc_numberEncrypted = vcPcard_numberEncrypted,
      encryptionKey = iPencryption_keyId
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateCCPaymentInfoEncrypted;



  PROCEDURE UpdatePaymentInfoPhone (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPmethod_id IN INT,
    nvcPphone IN NVARCHAR2,
    vcPcoupon_code IN VARCHAR2,
    nPcredit_amount IN NUMBER
  )
  AS
  BEGIN
    UPDATE ya_checkout_data
    SET
      payment_method_id = iPmethod_id,
      coupon_code = vcPcoupon_code,
      credit_amount = nPcredit_amount,
      bill_to_phone = nvcPphone,
      bill_profile_id = -1,
      bill_to_firstname = '',
      bill_to_lastname = '',
      bill_to_address_one = '',
      bill_to_address_two = '',
      bill_to_city = '',
      bill_to_country_id = -1,
      bill_to_email = '',
      bill_to_state = '',
      bill_to_state_id = -1,
      bill_to_zip = '',
      cc_expiration_month = NULL,
      cc_expiration_year = NULL,
      cc_type_id = NULL,
      cc_profile_id = NULL,
      cc_numberencrypted = NULL,
      encryptionkey = NULL,
      last_updated_datetime = SYSDATE()
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

  END UpdatePaymentInfoPhone;



  PROCEDURE CopyShipAddressFromAddressBook (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPaddress_id IN INT,
  	iPlang_id IN INT
  )
  AS
    iLsale_id INT;
    iLexist INT;
    iLexistAddress INT;
  BEGIN
    iLsale_id := -1;

    BEGIN
      SELECT 1
      INTO iLexist
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLexist := -1;
    END;

    IF iLexist > 0 THEN

		BEGIN
		  SELECT 1
		  INTO iLexistAddress
		  FROM YA_ADDRESS
		  WHERE
			address_id = iPaddress_id;
		EXCEPTION WHEN NO_DATA_FOUND THEN
		  iLexistAddress := -1;
		END;

		IF iLexistAddress > 0
		THEN
			UPDATE ya_checkout_data cd
			SET
				(
				ship_to_address_one,
				ship_to_address_two,
				ship_to_city,
				ship_to_state_id,
				ship_to_state,
				ship_to_zip,
				ship_to_country_id,
				ship_to_email,
				ship_profile_id,
				last_updated_datetime
				)
			=
				(
				SELECT
					address1,
					address2,
					city,
					state_id,
					state,
					zip,
					country_id,
					email,
					address_id,
					SYSDATE
				FROM
					YA_ADDRESS
				WHERE
					shopper_id = cPshopper_id
					AND
					address_id = iPaddress_id
				)
			WHERE
				shopper_id = cPshopper_id
				AND
				site_id = iPsite_id;
		END IF;
   ELSE
      INSERT INTO ya_checkout_data
        (
          shopper_id,
          site_id,
          sale_id,
          customer_firstname,
          customer_lastname,
          customer_email,
          ship_to_address_one,
          ship_to_address_two,
          ship_to_city,
          ship_to_state_id,
          ship_to_state,
          ship_to_zip,
          ship_to_country_id,
          ship_to_email,
          ship_profile_id
        )
      SELECT
        cPshopper_id,
        iPsite_id,
        iLsale_id,
        s.firstname,
        s.lastname,
        s.email,
        a.address1,
        a.address2,
        a.city,
        a.state_id,
        a.state,
        a.zip,
        a.country_id,
        a.email,
        iPaddress_id
      FROM
        YA_SHOPPER s,
        YA_ADDRESS a
      WHERE
        s.shopper_id = cPshopper_id
        AND s.shopper_id = a.shopper_id
        AND a.address_id = iPaddress_id;
    END IF;
	COMMIT;
	EXCEPTION WHEN OTHERS THEN
		ROLLBACK;
  END CopyShipAddressFromAddressBook;


  PROCEDURE CopyBillAddressFromAddressBook (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPaddress_id IN INT,
   	iPlang_id IN INT
 )
  AS
    iLsale_id INT;
    iLexist INT;
    iLexistAddress INT;
  BEGIN
    iLsale_id := -1;

    BEGIN
      SELECT 1
      INTO iLexist
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLexist := -1;
    END;

    IF iLexist > 0 THEN

		BEGIN
		  SELECT 1
		  INTO iLexistAddress
		  FROM YA_ADDRESS
		  WHERE
			address_id = iPaddress_id;
		EXCEPTION WHEN NO_DATA_FOUND THEN
		  iLexistAddress := -1;
		END;

		IF iLexistAddress > 0
		THEN
			UPDATE ya_checkout_data cd
			SET
				(
				bill_to_address_one,
				bill_to_address_two,
				bill_to_city,
				bill_to_state_id,
				bill_to_state,
				bill_to_zip,
				bill_to_country_id,
				bill_to_email,
				bill_profile_id,
				last_updated_datetime
				)
			=
				(
				SELECT
					address1,
					address2,
					city,
					state_id,
					state,
					zip,
					country_id,
					email,
					address_id,
					SYSDATE
				FROM
					YA_ADDRESS
				WHERE
					shopper_id = cPshopper_id
					AND
					address_id = iPaddress_id
				)
			WHERE
				shopper_id = cPshopper_id
				AND
				site_id = iPsite_id;
		END IF;
    ELSE
      INSERT INTO ya_checkout_data
        (
          shopper_id,
          site_id,
          sale_id,
          customer_firstname,
          customer_lastname,
          customer_email,
          bill_to_address_one,
          bill_to_address_two,
          bill_to_city,
          bill_to_state_id,
          bill_to_state,
          bill_to_zip,
          bill_to_country_id,
          bill_to_email,
          bill_profile_id
        )
      SELECT
        cPshopper_id,
        iPsite_id,
        iLsale_id,
        s.firstname,
        s.lastname,
        s.email,
        a.address1,
        a.address2,
        a.city,
        a.state_id,
        a.state,
        a.zip,
        a.country_id,
        a.email,
        iPaddress_id
      FROM
        YA_SHOPPER s,
        YA_ADDRESS a
      WHERE
        s.shopper_id = cPshopper_id
        AND s.shopper_id = a.shopper_id
        AND a.address_id = iPaddress_id;
    END IF;
	COMMIT;
	EXCEPTION WHEN OTHERS THEN
		ROLLBACK;
  END CopyBillAddressFromAddressBook;


  PROCEDURE UpdateCouponCode (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    vcPcoupon_code IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_checkout_data
    SET
      coupon_code = vcPcoupon_code,
      last_updated_datetime = SYSDATE()
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateCouponCode;


  PROCEDURE UpdateApplicationCredit (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    deciPcredit_amount IN DECIMAL
  )
  AS
  BEGIN
    UPDATE ya_checkout_data
    SET credit_amount = deciPcredit_amount
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateApplicationCredit;

  PROCEDURE UpdateCheckOutCurrency (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPcurrency IN CHAR
  )
  AS
  BEGIN
    Update ya_checkout_data
    SET currency=cPcurrency
	WHERE shopper_id=cPshopper_id and site_id=iPsite_id;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    ELSE
      BEGIN
        COMMIT;
      END;
    END IF;

    RETURN;
  END UpdateCheckOutCurrency;
  
  PROCEDURE UpdatePaymentInfo (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPcc_uid IN CHAR,
    nvcPcust_comment IN NVARCHAR2,
    nvcPbank_name IN NVARCHAR2,
    nvcPbank_phone IN NVARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_checkout_data
    SET
      cc_uid = cPcc_uid,
      customer_comment = nvcPcust_comment,
      bank_name = nvcPbank_name,
      bank_phone = nvcPbank_phone,
      last_updated_datetime = SYSDATE()
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;

  END UpdatePaymentInfo;  

  PROCEDURE GetShopperIdByCcUId (
    cPshopper_id OUT CHAR,
    cPcc_uid IN CHAR
  )
  AS
  BEGIN
    BEGIN
      SELECT
        shopper_id INTO cPshopper_id
      FROM
        ya_checkout_data
      WHERE
        cc_uid = cPcc_uid;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          cPshopper_id := null;
    END;
  END GetShopperIdByCcUId;    

  END Pkg_Fe_Orderaccess2;
/
 