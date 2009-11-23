CREATE OR REPLACE PACKAGE Pkg_FE_GiftCertAccess
AS
  /* proc_fe_CreateGiftCert */
  PROCEDURE CreateGiftCert (
    cPcert_code IN VARCHAR2,
    iPsite_id IN INT,
    iPorder_num IN INT,
    iPsku IN INT,
    deciPcert_amount IN DECIMAL,
    dtPcreated_datetime IN DATE,
    dtPexpiration_datetime IN DATE,
    cPpurchaser_shopper_id IN CHAR,
    iPreturn OUT INT
  );

  PROCEDURE ActiveGiftCert (
    iPsite_id IN INT,
    cPrecipient_shopper_id IN VARCHAR2,
    cPredemption_id IN VARCHAR2,
    iPcredit_type IN INT,
    cPcurrency_code IN VARCHAR2,
    iPerror_code OUT INT
  );
  
END Pkg_FE_GiftCertAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_GiftCertAccess
AS
  PROCEDURE CreateGiftCert (
    cPcert_code IN VARCHAR2,
    iPsite_id IN INT,
    iPorder_num IN INT,
    iPsku IN INT,
    deciPcert_amount IN DECIMAL,
    dtPcreated_datetime IN DATE,
    dtPexpiration_datetime IN DATE,
    cPpurchaser_shopper_id IN CHAR,
    iPreturn OUT INT
  )
  AS
    iLcert_count INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLcert_count
    FROM ya_gift_cert
    WHERE cert_code = cPcert_code;

    -- Check for duplicate cert code
    -- If found throw an exception
    IF (iLcert_count > 0) THEN
      BEGIN
        iPreturn := -1;
      END;
    ELSE
      BEGIN
        INSERT INTO ya_gift_cert
          (
            cert_code,
            site_id,
            order_num,
            sku,
            cert_amount,
            created_datetime,
            expiration_date,
            purchaser_shopper_id
          )
        VALUES
          (
            cPcert_code,
            iPsite_id,
            iPorder_num,
            iPsku,
            deciPcert_amount,
            dtPcreated_datetime,
            dtPexpiration_datetime,
            cPpurchaser_shopper_id
          );
        COMMIT;
        iPreturn := 1;
      END;
    END IF;

    RETURN;
  END CreateGiftCert;

  PROCEDURE ActiveGiftCert (
    iPsite_id IN INT,
    cPrecipient_shopper_id IN VARCHAR2,
    cPredemption_id IN VARCHAR2,
    iPcredit_type IN INT,
    cPcurrency_code IN VARCHAR2,
    iPerror_code OUT INT
  )
  AS
    iLrecord_found INT;
    cLcredit_code VARCHAR2(50);
    cLcert_code VARCHAR2(50);
    nLcert_amount NUMBER;
  BEGIN

    --Step 1 Check record exists
    BEGIN
      SELECT count(1)
      INTO iLrecord_found
      FROM ya_gift_cert
      WHERE redemption_id = cPredemption_id
      AND redemption_datetime is NULL
      AND cert_used = 'N'
      AND bogus = 'N'
      AND expiration_date >= SYSDATE;
    END;

    IF iLrecord_found = 0 THEN
      iPerror_code := -10;
      RETURN;
    END IF;

    BEGIN
      SELECT count(1)
      INTO iLrecord_found
      FROM ya_shopper
      WHERE member_type <> 3
      AND shopper_id = cPrecipient_shopper_id;
    END;

    IF iLrecord_found = 0 THEN
      iPerror_code := -20;
      RETURN;
    END IF;
    
    --Step 2 - Load Basic Information
    BEGIN
      SELECT cert_code, cert_amount
      INTO cLcert_code, nLcert_amount
      FROM ya_gift_cert
      WHERE redemption_id = cPredemption_id;
    END;

    --Step 3 - Update ya_gift_cert's status(redemption_datetime, cert_used, recipient_shopper_id)
    BEGIN
      UPDATE ya_gift_cert
      SET redemption_datetime = SYSDATE,
      cert_used = 'Y',
      recipient_shopper_id = cPrecipient_shopper_id
      WHERE redemption_id = cPredemption_id;
    END;

    --Step 5
    BEGIN
      Pkg_fe_ManagementCreditAccess.CreateCreditByShopperId(
      iPsite_id, cPrecipient_shopper_id, iPcredit_type, cPcurrency_code, nLcert_amount, cLcert_code, cLcredit_code, iPerror_code);
    END;

    --Only need to handle rollbak as step 5 already handle case of commit
    IF iPerror_code <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;
 
--    DBMS_OUTPUT.put_line(iPerror_code); 
  END ActiveGiftCert;  

END Pkg_FE_GiftCertAccess;
/

