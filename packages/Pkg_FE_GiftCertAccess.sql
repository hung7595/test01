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
END Pkg_FE_GiftCertAccess;
/

