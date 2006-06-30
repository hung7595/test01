CREATE OR REPLACE PACKAGE Pkg_fe_OrderAccess_tklam
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_InsertSalesCode */
  PROCEDURE InsertSaleCode (
    iPorder_num IN INT,
    vcPsales_code IN VARCHAR2
  );

  /* sp_debit_credit */
  PROCEDURE DebitCredit (
    cPshopper_id IN VARCHAR2,
    deciPdebit_amount IN DECIMAL,
    iPorder_num IN INT,
    cPcurrency IN CHAR DEFAULT 'USD',
    iPreturn OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );

  /* proc_fe_UpdateLimitedQuantity */
  PROCEDURE UpdateLimitedQuantity (
    vcPsku_csv IN VARCHAR2,
    vcPqty_csv IN VARCHAR2,
    iPsite_id IN INT
  );

  /* proc_fe_InsertOrderXml */
  PROCEDURE InsertOrderXml (
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
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );

  /* proc_fe_InsertPaypalOrderXml */
  PROCEDURE InsertPaypalOrderXml (
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
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  );

  /* proc_fe_GetOrder */
  PROCEDURE GetOrder (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur,
    curPresult8 OUT refCur,
    curPresult9 OUT refCur,
    curPresult10 OUT refCur,
    curPresult11 OUT refCur
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

  /* proc_fe_GetPreCheckoutData */
  PROCEDURE GetPreCheckoutData (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur,
    curPresult4 OUT refCur
  );

  /* proc_fe_CreateCheckoutData */
  PROCEDURE CreateCheckoutData (
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
    nvcPcard_lastname IN NVARCHAR2
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
    cPcurrency CHAR DEFAULT 'USD'
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
END Pkg_fe_OrderAccess_tklam;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_OrderAccess_tklam
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

  PROCEDURE DebitCredit (
    cPshopper_id IN VARCHAR2,
    deciPdebit_amount IN DECIMAL,
    iPorder_num IN INT,
    cPcurrency IN CHAR DEFAULT 'USD',
    iPreturn OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
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
    FROM ya_frontend_credit_system
    WHERE
      shopper_id = cPshopper_id
      AND currency = cPcurrency;

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
          ya_frontend_credit_system fcs
        WHERE
          fcs.current_balance > 0
          AND fcs.shopper_id = cPshopper_id
          AND fcs.currency = cPcurrency
        ORDER BY fcs.transaction_datetime ASC;


        FETCH curLdeduct_cursor INTO iLcredit_id, decilcurrent_balance;
        WHILE (curLdeduct_cursor%FOUND) AND (deciPdebit_amount > 0) LOOP
          BEGIN
            -- Calculate deduct amount for each line
            -- Find deducted amount for the account (cert)
            IF deciPdebit_amount >= deciLcurrent_balance THEN
              BEGIN
                deciLdeduct_amount := deciLcurrent_balance;
              END;
            ELSE
              BEGIN
                deciLdeduct_amount := deciPdebit_amount;
              END;
            END IF;

            -- Decrement debit amount (until < 0)
            deciLdebit_amount := deciPdebit_amount - deciLcurrent_balance;

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
            UPDATE ya_frontend_credit_system
            SET current_balance = deciLcurrent_balance - deciLdeduct_amount
            WHERE credit_id = iLcredit_id;

            FETCH curLdeduct_cursor INTO iLcredit_id, deciLcurrent_balance;
          END;
        END LOOP;
        CLOSE curLdeduct_cursor;
        COMMIT;
        iPreturn := 1;
      END;
    END IF;
    RETURN;
  EXCEPTION WHEN others THEN
    BEGIN
      ROLLBACK;
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





        -- START - Obtained the SKU AND QTY
        -----------------------------------
        SELECT (l.frontend_quantity - iLcurrent_qty), l.action_id
        INTO iLcurrent_qty, iLaction
        FROM ya_limited_quantity l
        WHERE
          l.sku = iLcurrent_sku
          AND (l.site_id = iPsite_id OR l.site_id = 99);

        SELECT site_id
        INTO iLapply_site_id
        FROM
          (
            SELECT site_id
            FROM ya_limited_quantity l
            WHERE
              l.sku = iLcurrent_sku
              AND (l.site_id = iPsite_id OR l.site_id = 99)
            ORDER BY l.site_id
          )
        WHERE ROWNUM = 1;


        -- UPDATE frontend quantity
        UPDATE ya_limited_quantity
        SET
          frontend_quantity = iLcurrent_qty,
          FE_last_change_datetime = SYSDATE
        WHERE
          sku = iLcurrent_sku
          AND site_id = iLapply_site_id;


        IF iLcurrent_qty <= 0  THEN
          BEGIN
            IF iLaction  = 1 THEN
              IF iLapply_site_id = 1 THEN
                UPDATE ya_product
                SET us_availability_id = 60
                WHERE sku = iLcurrent_sku;
              ELSE
                IF iLapply_site_id = 7 THEN
                  UPDATE ya_product
                  SET tw_availability_id = 60
                  WHERE sku = iLcurrent_sku;
                ELSE
                  IF iLapply_site_id = 99 THEN
                    UPDATE ya_product
                    SET
                      us_availability_id = 60,
                      tw_availability_id = 60
                    WHERE sku = iLcurrent_sku;
                  END IF;
                END IF;
              END IF;
            END IF;

            IF iLaction = 2 THEN
              IF iLapply_site_id = 1 THEN
                UPDATE ya_product
                SET
                  us_sale_price = NULL,
                  us_sale_start = NULL,
                  us_sale_end = NULL
                WHERE sku = iLcurrent_sku;
              ELSE
                IF iLapply_site_id = 7 THEN
                  UPDATE ya_product
                  SET
                    tw_sale_price = NULL,
                    tw_sale_start = NULL,
                    tw_sale_end = NULL
                  WHERE sku = iLcurrent_sku;
                ELSE
                  IF iLapply_site_id = 99 THEN
                    UPDATE ya_product
                    SET
                      us_sale_price = NULL,
                      us_sale_start = NULL,
                      us_sale_end = NULL,
                      tw_sale_price = NULL,
                      tw_sale_start = NULL,
                      tw_sale_end = NULL
                    WHERE sku = iLcurrent_sku;
                  END IF;
                END IF;
              END IF;
            END IF;


            /* mark cansell, enabled */
            IF iLaction = 3 THEN
              IF iLapply_site_id = 1 THEN
                UPDATE ya_product
                SET
                  us_cansell = 'N',
                  us_enabled = 'N'
                WHERE
                  sku = iLcurrent_sku;
              ELSE
                IF iLapply_site_id = 7 THEN
                  UPDATE ya_product
                  SET
                    tw_cansell = 'N',
                    tw_enabled = 'N'
                  WHERE
                    sku = iLcurrent_sku;
                ELSE
                  IF iLapply_site_id = 99 THEN
                    UPDATE ya_product
                    SET
                      us_cansell = 'N',
                      us_enabled = 'N',
                      tw_cansell = 'N',
                      tw_enabled = 'N'
                    WHERE
                      sku = iLcurrent_sku;
                  END IF;
                END IF;
              END IF;
            END IF;

            /* mark out of print */
            IF iLaction  = 4 THEN
              IF iLapply_site_id = 1 THEN
                UPDATE ya_product
                SET us_availability_id = 70
                WHERE sku = iLcurrent_sku;
              ELSE
                IF iLapply_site_id = 7 THEN
                  UPDATE ya_product
                  SET tw_availability_id = 70
                  WHERE sku = iLcurrent_sku;
                ELSE
                  IF iLapply_site_id = 99 THEN
                    UPDATE ya_product
                    SET
                      us_availability_id = 70,
                      tw_availability_id = 70
                    WHERE sku = iLcurrent_sku;
                  END IF;
                END IF;
              END IF;
            END IF;


            /* mark 7 days */
            IF iLaction  = 5 THEN
              IF iLapply_site_id = 1 THEN
                UPDATE ya_product
                SET us_availability_id = 20
                WHERE sku = iLcurrent_sku;
              ELSE
                IF iLapply_site_id = 7 THEN
                  UPDATE ya_product
                  SET tw_availability_id = 20
                  WHERE sku = iLcurrent_sku;
                ELSE
                  IF iLapply_site_id = 99 THEN
                    UPDATE ya_product
                    SET
                      us_availability_id = 20,
                      tw_availability_id = 20
                    WHERE sku = iLcurrent_sku;
                  END IF;
                END IF;
              END IF;
            END IF;


            /* mark 14 days */
            IF iLaction  = 6 THEN
              IF iLapply_site_id = 1 THEN
                UPDATE ya_product
                SET us_availability_id = 30
                WHERE sku = iLcurrent_sku;
              ELSE
                IF iLapply_site_id = 7 THEN
                  UPDATE ya_product
                  SET tw_availability_id = 30
                  WHERE sku = iLcurrent_sku;
                ELSE
                  IF iLapply_site_id = 99 THEN
                    UPDATE ya_product
                    SET
                      us_availability_id = 30,
                      tw_availability_id = 30
                    WHERE sku = iLcurrent_sku;
                  END IF;
                END IF;
              END IF;
            END IF;

            INSERT INTO ya_limited_quantity_action
              (
                sku,
                site_id,
                action_id,
                action_datetime
              )
            VALUES
              (
                iLcurrent_sku,
                iLapply_site_id,
                iLaction,
                SYSDATE
              );
          END;
        END IF;
        ------
        -- END

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

    EXCEPTION
      WHEN others THEN
        BEGIN
          ROLLBACK;
        END;

    COMMIT;
    RETURN;
  END UpdateLimitedQuantity;



  PROCEDURE InsertOrderXml (
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
    iPorder_num IN OUT INT,
    cPtransaction_id IN VARCHAR2 DEFAULT NULL
  )
  AS
    iLexist INT;
    iLdebit_credit_return INT;
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPorder_num IS NULL OR iPorder_num < 0 THEN
      SELECT SEQ_order.nextval INTO iPorder_num FROM DUAL;
    ELSE
      SELECT SEQ_order.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPorder_num - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_order INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_order.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_order INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_order
      (
        ORDER_NUM,
        shopper_id,
        site_id,
        coupon_code,
        order_xml
      )
    VALUES
      (
        iPorder_num,
        cPshopper_id,
        iPsite_id,
        vcPcoupon_code,
        clobPorder_xml
      );

    -- ORDER sales information
    SELECT COUNT(1)
    INTO iLexist
    FROM
      ya_new_basket b
      INNER JOIN ya_bargain_product p ON
        b.sku = p.sku
        AND b.site_id = p.site_id
    WHERE
      b.shopper_id = cPshopper_id
      AND b.site_id = iPsite_id
      AND b.type = 0;

    IF (iLexist > 0) THEN
      BEGIN
        INSERT INTO ya_order_sales_detail
          (
            order_num,
            sku,
            remark
          )
        SELECT
          iPorder_num,
          b.sku,
          availability
        FROM
          ya_new_basket b
          INNER JOIN ya_bargain_product p ON
            b.sku = p.sku
            AND p.site_id = iPsite_id
          INNER JOIN backend_adm.productavailability pa ON
            b.sku = pa.productid
            AND pa.regionid = iPsite_id
            AND pa.category = 1
        WHERE
          b.shopper_id = cPshopper_id
          AND b.site_id = iPsite_id
          AND b.type = 0;
      END;
    END IF;

    -- remove basket's items
    DELETE FROM ya_new_basket
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id
      AND type = 0;

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
        UPDATE ya_address
        SET preferred_bill = 'N'
        WHERE
          shopper_id = cPshopper_id
          AND preferred_bill = 'Y';

        UPDATE ya_address
        SET preferred_bill = 'Y'
        WHERE
          address_id = iPbill_profile_id
          AND shopper_id = cPshopper_id;
      END;
    END IF;


    IF (iPship_profile_id <> -1) THEN
      BEGIN
        UPDATE ya_address
        SET preferred_ship = 'N'
        WHERE
          shopper_id = cPshopper_id
          AND preferred_ship = 'Y'
          AND site_id = iPsite_id;

        UPDATE ya_address
        SET preferred_ship = 'Y'
        WHERE
          address_id = iPship_profile_id
          AND shopper_id = cPshopper_id;
      END;
    END IF;


    IF (iPcc_profile_id <> -1) THEN
      BEGIN
        UPDATE ya_credit_card_profile
        SET preferred = 'N'
        WHERE
          preferred = 'Y'
          AND shopper_id = cPshopper_id;

        UPDATE ya_credit_card_profile
        SET preferred = 'Y'
        WHERE
          profile_id = iPcc_profile_id
          AND shopper_id = cPshopper_id;
      END;
    END IF;


    IF (LENGTH(vcPcoupon_code) > 0) THEN
      BEGIN
        UPDATE ya_coupon
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
        Pkg_fe_OrderAccess_tklam.DebitCredit(cPshopper_id, nPcredit_amount, iPorder_num, cPcurrency, iLdebit_credit_return, cPtransaction_id);
      END;
    END IF;

    IF (LENGTH(vcPlimited_sku_csv) > 0) THEN
      BEGIN
        UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
      END;
    END IF;

  EXCEPTION
    WHEN others THEN
      BEGIN
        iPorder_num := -1;
        ROLLBACK;
      END;
  COMMIT;
  END InsertOrderXml;



  PROCEDURE InsertPaypalOrderXml (
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
      SELECT status, paypal_status
      INTO iLstatus, iLpaypal_status
      FROM ya_paypal_order_mapping
      WHERE payment_uid = cLguid;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPorder_num := -1;
          RETURN;
        END;
    END;


    IF iLstatus IN (-1,0,1,8) AND iLpaypal_status IN (-1,1,4) THEN
      BEGIN
        IF iPorder_num IS NULL OR iPorder_num < 0 THEN
          SELECT SEQ_order.nextval INTO iPorder_num FROM DUAL;
        ELSE
          SELECT SEQ_order.nextval INTO iLseq_currval FROM dual;
          iLseq_diff := iPorder_num - iLseq_currval;
          IF iLseq_diff <> 0 THEN
            EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_order INCREMENT BY ' || iLseq_diff;
            SELECT SEQ_order.nextval INTO iLseq_currval FROM dual;
            EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_order INCREMENT BY 1';
          END IF;
        END IF;

        INSERT INTO ya_order
          (
            ORDER_NUM,
            shopper_id,
            site_id,
            coupon_code,
            order_xml
          )
        VALUES
          (
            iPorder_num,
            cPshopper_id,
            iPsite_id,
            vcPcoupon_code,
            clobPorder_xml
          );

        SELECT COUNT(1)
        INTO iLexist
        FROM
          ya_new_basket b
          INNER JOIN ya_bargain_product p ON
            b.sku = p.sku
            AND b.site_id = p.site_id
        WHERE
          b.shopper_id = cPshopper_id
          AND b.site_id = iPsite_id
          AND b.TYPE = 0;

        IF iLexist > 0 THEN
          BEGIN
            INSERT INTO ya_order_sales_detail
              (
                order_num,
                sku,
                remark
              )
            SELECT
              iPorder_num,
              b.sku,
              availability
            FROM
              ya_new_basket b
              INNER JOIN ya_bargain_product p ON
                b.sku = p.sku
                AND p.site_id = iPsite_id
              INNER JOIN backend_adm.productavailability pa ON
                b.sku = pa.productid
                AND pa.regionid = iPsite_id
                AND pa.category = 1
            WHERE
              b.shopper_id = cPshopper_id
              AND b.site_id = iPsite_id
              AND b.type = 0;
          END;
        END IF;

        DELETE FROM ya_new_basket
        WHERE
          shopper_id = cPshopper_id
          AND site_id = iPsite_id
          AND type = 0;

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
            UPDATE ya_address
            SET preferred_bill = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_bill = 'Y';

            UPDATE ya_address
            SET preferred_bill = 'Y'
            WHERE
              shopper_id = cPshopper_id
              AND address_id = iPbill_profile_id;
          END;
        END IF;

        IF iPship_profile_id <> -1 THEN
          BEGIN
            UPDATE ya_address
            SET preferred_ship = 'N'
            WHERE
              shopper_id = cPshopper_id
              AND preferred_ship = 'Y'
              AND site_id = iPsite_id;

            UPDATE ya_address
            SET preferred_ship = 'Y'
            WHERE
              address_id = iPship_profile_id
              AND shopper_id = cPshopper_id;
          END;
        END IF;

        IF iPcc_profile_id <> -1 THEN
          BEGIN
            UPDATE ya_credit_card_profile
            SET preferred = 'N'
            WHERE shopper_id = cPshopper_id;

            UPDATE ya_credit_card_profile
            SET preferred = 'Y'
            WHERE
              profile_id = iPcc_profile_id
              AND shopper_id = cPshopper_id;
          END;
        END IF;

        IF LENGTH(vcPcoupon_code) > 0 THEN
          BEGIN
            UPDATE ya_coupon
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

        INSERT INTO ya_customer_info
          (
            order_num,
            lang_id
          )
        VALUES
          (
            iPorder_num,
            iPlang_type
          );

        IF nPcredit_amount > 0 THEN
          BEGIN
            Pkg_fe_OrderAccess_tklam.DebitCredit(cPshopper_id, nPcredit_amount, iPorder_num, 'USD', iLdebit_credit_return, cPtransaction_id);
          END;
        END IF;

        IF LENGTH(vcPlimited_sku_csv) > 0 THEN
          BEGIN
            UpdateLimitedQuantity(vcPlimited_sku_csv, vcPlimited_qty_csv, iPsite_id);
          END;
        END IF;

        UPDATE ya_paypal_order_mapping
        SET
          order_num = iPorder_num,
          updated_datetime = SYSDATE
        WHERE payment_uid = cLguid;

      EXCEPTION WHEN others THEN
        BEGIN
          iPorder_num := -1;
          ROLLBACK;
          RETURN;
        END;
      END;
    END IF;
    COMMIT;
    RETURN;
  END InsertPaypalOrderXml;



  PROCEDURE GetOrder (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult1 OUT refCur, -- GetBasket refCur1
    curPresult2 OUT refCur, -- GetBasket refCur2
    curPresult3 OUT refCur, -- GetBasket refCur3
    curPresult4 OUT refCur, -- GetBasket refCur4
    curPresult5 OUT refCur, -- GetBasket refCur5
    curPresult6 OUT refCur, -- GetBasket refCur6
    curPresult7 OUT refCur,
    curPresult8 OUT refCur,
    curPresult9 OUT refCur,
    curPresult10 OUT refCur,
    curPresult11 OUT refCur
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
    Pkg_FE_BasketAccess.GetBasket(
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

    -- get coupon constraint type 1
    OPEN curPresult7 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 1;

    -- get coupon constraint type 2
    OPEN curPresult8 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 2;

    -- get coupon constraint type 3
    OPEN curPresult9 FOR
    SELECT constraint_value
    FROM ya_coupon_constraint
    WHERE
      coupon_code = vcLcoupon_code
      AND constraint_type = 3;

    OPEN curPresult10 FOR
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
      ya_coupon c
      LEFT OUTER JOIN ya_coupon_corporate cc ON
        c.coupon_code = cc.coupon_code
    WHERE c.coupon_code = vcLcoupon_code;


    OPEN curPresult11 FOR
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
      cc_number,
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
      lang
    FROM
      ya_checkout_data c
      LEFT OUTER JOIN ya_giftcard_data g ON
        c.shopper_id = g.shopper_id
        AND c.site_id = g.site_id
    WHERE
      c.shopper_id = cPshopper_id
      AND c.site_id = iPsite_id;

    RETURN;
  END GetOrder;



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
      FROM backend_adm.OrderInfo
      WHERE originOrderId = to_char(iPorder_num);
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLorder_id := -1;
    END;

    OPEN curPresult1 FOR
    SELECT originId
    FROM backend_adm.OrderInfo
    WHERE id = iLorder_id;

    OPEN curPresult2 FOR
    SELECT
      ol.id,
      ol.productId,
      ol.quantity,
      ol.unitPrice,
      ol.parentId,
      ol.shipmentUnit,
      ol.miscInfo,
      ol.availability,
      ol.preOrder,
      ol.relativeDeliveryDay
    FROM backend_adm.OrderLine ol
    WHERE ol.orderId = iLorder_id
    ORDER BY ol.id;

    OPEN curPresult3 FOR
    SELECT
      oi.originorderid,
      oi.salesId,
      oi.originId,
      oi.category,
      oi.orderDate,
      oi.customerId,
      oi.customerFirstname,
      oi.customerLastname,
      oi.customerEmail,
      si.method,
      si.firstname,
      si.lastname,
      si.address1,
      si.address2,
      si.city,
      si.stateCode,
      si.state,
      si.zip,
      si.country,
      si.dayPhone,
      si.eveningPhone,
      si.fax,
      si.mobile,
      si.email,
      bi.method,
      bi.firstname,
      bi.lastname,
      bi.address1,
      bi.address2,
      bi.city,
      bi.statecode,
      bi.state,
      bi.zip,
      bi.country,
      bi.email,
      bi.authCode,
      bi.authAmt,
      bi.avsCode,
      bi.ccNum,
      bi.ccType,
      bi.ccExpMo,
      bi.ccExpYear,
      bi.bankName,
      bi.bankPhone,
      oi.customerComment,
      bi.refId,
      oi.refId,
      bi.coupon,
      bi.couponAmt,
      bi.creditAmt,
      oi."COMMENT",
      oi.originVersion,
      oi.splitShipment,
      bi.phone,
      bi.shipmentAmt,
      bi.handlingAmt,
      specialHandling,
      bi.tax,
      bi.currency
    FROM
      backend_adm.OrderInfo oi
      INNER JOIN backend_adm.ShippingInfo si ON
        oi.id = si.orderId
      INNER JOIN backend_adm.BillingInfo bi ON
        oi.id = bi.orderId
    WHERE oi.id = iLorder_id;

    RETURN;
  END GetOrderFromBackend;


  PROCEDURE CheckCouponUsage (
    cPshopper_id IN CHAR,
    vcPcoupon_code IN VARCHAR,
    iPreturn OUT INT
  )
  AS
	isHSBC	int;
  BEGIN
	SELECT nvl(instr(vcPcoupon_code, 'TIPSWAP%'),0) INTO isHSBC FROM dual;
	IF (isHSBC>0) THEN
		BEGIN
			SELECT COUNT(1)
			INTO iPreturn
			FROM ya_order
			WHERE
				shopper_id = cPshopper_id
				AND coupon_code like 'TIPSWAP%';
		END;
	ELSE
		BEGIN
			IF (vcPcoupon_code is null) THEN
				BEGIN
					SELECT COUNT(1)
					INTO iPreturn
					FROM ya_order
					WHERE
						shopper_id = cPshopper_id
						AND
						(coupon_code is null OR ascii(coupon_code)=0) ;
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
    SELECT COUNT(originOrderId)
    INTO iLBE_count
    FROM Backend_adm.OrderInfo
    WHERE customerId = cPshopper_id;

    SELECT COUNT(order_num)
    INTO iLFE_count
    FROM ya_order
    WHERE
      shopper_id = cPshopper_id
      AND order_num NOT IN
        (
          SELECT originOrderId
          FROM Backend_adm.OrderInfo
          WHERE customerId = cPshopper_id
        );

    iPcount := iLFE_count + iLBE_count;
    RETURN;
  END GetOrderCount;



  PROCEDURE GetPreCheckoutData (
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

    -- Payment Method Lookup
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

    -- Credit Card Type Lookup
    --  VISA = 1
    --  MASTER = 2
    --  AMEX = 3
    --  DISCOVER = 4
    --  DINERS = 5
    --  JCB = 6
    IF iPsite_id = 1 THEN
      BEGIN
        SELECT sa.address_id
        INTO iLship_profile
        FROM ya_address sa
        WHERE
          sa.preferred_ship = 'Y'
          AND sa.shopper_id = cPshopper_id
          AND sa.country_id IN (38,226)
          AND lang_id = iPlang_id
          AND ROWNUM = 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          iLship_profile := NULL;
      END;
    ELSE
      BEGIN
        SELECT sa.address_id
        INTO iLship_profile
        FROM ya_address sa
        WHERE
          sa.preferred_ship = 'Y'
          AND sa.shopper_id = cPshopper_id
          AND sa.country_id NOT IN (38, 226)
          AND lang_id = iPlang_id
          AND ROWNUM = 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          iLship_profile := NULL;
      END;
    END IF;

    BEGIN
      SELECT ba.address_id
      INTO iLbill_profile
      FROM ya_address ba
      WHERE
        ba.preferred_bill = 'Y'
        AND ba.shopper_id = cPshopper_id
        AND lang_id = iPlang_id
        AND ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLbill_profile := NULL;
    END;

    IF iPsite_id = 1 THEN
      BEGIN
        SELECT cc.profile_id
        INTO iLcc_profile
        FROM ya_credit_card_profile cc
        WHERE
          cc.preferred = 'Y'
          AND cc.shopper_id = cPshopper_id
          AND cc.card_type_id IN (1,2,3)
          AND ROWNUM = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLcc_profile := NULL;
      END;
    ELSE
      BEGIN
        SELECT cc.profile_id
        INTO iLcc_profile
        FROM ya_credit_card_profile cc
        WHERE
          cc.preferred = 'Y'
          AND cc.shopper_id = cPshopper_id
          AND cc.card_type_id IN (1,2,3,6)
          AND ROWNUM = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLcc_profile := NULL;
      END;
    END IF;

    Pkg_FE_ShopperAccess.GetShopperDataByShopperId(cPshopper_id, curPresult1);

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
        FROM ya_address
        WHERE
          shopper_id = cPshopper_id
          AND lang_id = iPlang_id
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
        FROM ya_address
        WHERE
          shopper_id = cPshopper_id
          AND lang_id = iPlang_id
          AND address_id = iLbill_profile;

        OPEN curPresult4 FOR
        SELECT
          profile_id,
          card_type_id,
          card_number,
          expiration_month,
          expiration_year,
          firstname_on_card,
          lastname_on_card
        FROM ya_credit_card_profile
        WHERE
          shopper_id = cPshopper_id
          AND profile_id = iLcc_profile;
      END;
    END IF;

    COMMIT;
    RETURN;

  EXCEPTION WHEN others THEN
    ROLLBACK;
  END GetPreCheckoutData;



  PROCEDURE CreateCheckoutData (
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
    nvcPcard_lastname IN NVARCHAR2
  )
  AS
    iLship_method INT;
    deciLcredit_amount DECIMAL(18,2);
  BEGIN
    -- US site
    IF iPsite_id = 1 THEN
      IF iPship_to_country_id = 226 THEN -- United States
        iLship_method := 16; -- Standard
      ELSIF iPship_to_country_id = 38 THEN -- Canada
        iLship_method := 11; -- Canadian
      END IF;
    ELSE
      -- Global Site
      IF iPship_to_country_id = 98 THEN -- Hong Kong
          iLship_method := 15; -- Express
      ELSE
        iLship_method := 12; -- Standard
      END IF;
    END IF;

    Pkg_FE_CreditAccess.GetCurrentBalance(deciLcredit_amount, cPshopper_id, 'USD');

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
        cc_number,
        cc_type_id,
        cc_expiration_month,
        cc_expiration_year,
        currency,
        bill_profile_id,
        ship_profile_id,
        cc_profile_id,
        credit_amount,
        created_datetime,
        last_updated_datetime
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
        vcPcard_number,
        iPcard_type_id,
        iPcard_exp_month,
        iPcard_exp_year,
        'USD',
        iPbill_address_id,
        iPship_address_id,
        iPcard_profile_id,
        deciLcredit_amount,
        SYSDATE,
        SYSDATE
      );
    COMMIT;
  EXCEPTION WHEN others THEN
    ROLLBACK;
  END CreateCheckoutData;


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
  EXCEPTION WHEN others THEN
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
        CASE iPship_to_country_id
          WHEN 226 THEN -- US
            iLshipping_method_id := 16; -- Standard
          WHEN 38 THEN -- Canada
            iLshipping_method_id := 11; -- Canadian
          WHEN 98 THEN -- Hong Kong
            iLshipping_method_id := 15; -- Express
          ELSE iLshipping_method_id := 12;
        END CASE;

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
  EXCEPTION WHEN others THEN
    ROLLBACK;
  END UpdateShippingAddress;



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
    cPcurrency CHAR DEFAULT 'USD'
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
      UPDATE ya_credit_card_profile
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
      cc_number = vcPcard_number,
      cc_expiration_month = iPexp_month,
      cc_expiration_year = iPexp_year,
      bill_to_firstname = nvcPfirstname,
      bill_to_lastname = nvcPlastname,
      bill_to_phone = '',
      last_updated_datetime = SYSDATE()
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id;


    -- Citibank Promotion
    -- UPDATE coupon code according to the list of card prefix
    BEGIN
      SELECT 1
      INTO iLexist
      FROM ya_checkout_data
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id
        AND
          (
            cc_number LIKE '4791100%'
            OR cc_number LIKE '4791101%'
            OR cc_number LIKE '4791103%'
            OR cc_number LIKE '4791102%'
            OR cc_number LIKE '4791110%'
            OR cc_number LIKE '4791113%'
            OR cc_number LIKE '4028560%'
            OR cc_number LIKE '4028%'
            OR cc_number LIKE '54109600%'
            OR cc_number LIKE '54109601%'
            OR cc_number LIKE '54020400%'
            OR cc_number LIKE '54020401%'
            OR cc_number LIKE '5520040%'
          );
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLexist := -1;
    END;

    IF iLexist > 0 THEN
      UPDATE ya_checkout_data
      SET coupon_code = 'CITIBANK_0728'
      WHERE
        shopper_id = cPshopper_id
        AND site_id = iPsite_id;
    END IF;

    COMMIT;
  EXCEPTION WHEN others THEN
    ROLLBACK;
  END UpdateCreditCardPaymentInfo;



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
      cc_expiration_month = null,
      cc_expiration_year = null,
      cc_number = null,
      cc_type_id = null,
      cc_profile_id = null,
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
/*
      UPDATE
      (
        SELECT
          cd.ship_to_address_one cd_address1,
          a.address1 a_address1,
          cd.ship_to_address_two cd_address2,
          a.address2 a_address2,
          cd.ship_to_city cd_city,
          a.city a_city,
          cd.ship_to_state_id cd_state_id,
          a.state_id a_state_id,
          cd.ship_to_state cd_state,
          a.state a_state,
          cd.ship_to_zip cd_zip,
          a.zip a_zip,
          cd.ship_to_country_id cd_country_id,
          a.country_id a_country_id,
          cd.ship_to_email cd_email,
          a.email a_email,
          cd.ship_profile_id cd_profile_id,
          cd.last_updated_datetime cd_last_updated
        FROM
          ya_address a,
          ya_checkout_data cd
        WHERE
		  a.lang_id = iPlang_id
          AND cd.shopper_id = cPshopper_id
          AND cd.site_id = iPsite_id
          AND cd.shopper_id = a.shopper_id
          AND cd.site_id = a.site_id
          AND a.address_id = iPaddress_id
      )
      SET
        cd_address1 = a_address1,
        cd_address2 = a_address2,
        cd_city = a_city,
        cd_state_id = a_state_id,
        cd_state = a_state,
        cd_zip = a_zip,
        cd_country_id = a_country_id,
        cd_email = a_email,
        cd_profile_id = iPaddress_id,
        cd_last_updated = SYSDATE();
*/
		BEGIN
		  SELECT 1
		  INTO iLexistAddress
		  FROM ya_address
		  WHERE
			address_id = iPaddress_id
			AND
			lang_id = iPlang_id
			AND
			rownum = 1;
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
					ya_address
				WHERE
					shopper_id = cPshopper_id
					AND
					address_id = iPaddress_id
					AND
					lang_id = iPlang_id
					AND
					rownum = 1
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
        ya_shopper s,
        ya_address a
      WHERE
        s.shopper_id = cPshopper_id
        AND s.shopper_id = a.shopper_id
        AND a.address_id = iPaddress_id;
    END IF;
	COMMIT;
	EXCEPTION WHEN others THEN
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
/*
      UPDATE
      (
        SELECT
          cd.bill_to_address_one cd_address1,
          a.address1 a_address1,
          cd.bill_to_address_two cd_address2,
          a.address2 a_address2,
          cd.bill_to_city cd_city,
          a.city a_city,
          cd.bill_to_state_id cd_state_id,
          a.state_id a_state_id,
          cd.bill_to_state cd_state,
          a.state a_state,
          cd.bill_to_zip cd_zip,
          a.zip a_zip,
          cd.bill_to_country_id cd_country_id,
          a.country_id a_country_id,
          cd.bill_to_email cd_email,
          a.email a_email,
          cd.bill_profile_id cd_profile_id,
          cd.last_updated_datetime cd_last_updated
        FROM
          ya_address a,
          ya_checkout_data cd
        WHERE
		  a.lang_id = iPlang_id
          AND cd.shopper_id = cPshopper_id
          AND cd.site_id = iPsite_id
          AND cd.shopper_id = a.shopper_id
          AND cd.site_id = a.site_id
          AND a.address_id = iPaddress_id
      )
      SET
        cd_address1 = a_address1,
        cd_address2 = a_address2,
        cd_city = a_city,
        cd_state_id = a_state_id,
        cd_state = a_state,
        cd_zip = a_zip,
        cd_country_id = a_country_id,
        cd_email = a_email,
        cd_profile_id = iPaddress_id,
        cd_last_updated = SYSDATE();
*/
		BEGIN
		  SELECT 1
		  INTO iLexistAddress
		  FROM ya_address
		  WHERE
			address_id = iPaddress_id
			AND
			lang_id = iPlang_id
			AND
			rownum = 1;
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
					ya_address
				WHERE
					shopper_id = cPshopper_id
					AND
					address_id = iPaddress_id
					AND
					lang_id = iPlang_id
					AND
					rownum = 1
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
        ya_shopper s,
        ya_address a
      WHERE
        s.shopper_id = cPshopper_id
        AND s.shopper_id = a.shopper_id
        AND a.address_id = iPaddress_id;
    END IF;
	COMMIT;
	EXCEPTION WHEN others THEN
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
  EXCEPTION WHEN others THEN
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
  EXCEPTION WHEN others THEN
    ROLLBACK;
  END UpdateApplicationCredit;
END Pkg_fe_OrderAccess_tklam;
/

