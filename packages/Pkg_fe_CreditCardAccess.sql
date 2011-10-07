CREATE OR REPLACE PACKAGE Pkg_Fe_Creditcardaccess
AS
  TYPE refcur IS REF CURSOR;
  
  PROCEDURE GetShopperCreditCardEncrypted (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    curPresult	OUT	refcur
  );
  PROCEDURE CreateCCProfileEncrypted (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    iPtypeId		IN	INT,
    cPcardNumber	IN	VARCHAR2,
    iPexpMonth		IN	INT,
    iPexpYear		IN	INT,
    cPfirstname		IN	VARCHAR2,
    cPlastname		IN	VARCHAR2,
    cPcardNumberEncrypted	IN	VARCHAR2,
    cPencryptionKey  IN	INT,
    iPprofileId IN OUT INT
  );
  PROCEDURE DeleteCreditCard (
  iPprofile_id IN INT,
  iProw_affacted OUT INT
  );
END Pkg_Fe_Creditcardaccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_Fe_Creditcardaccess
IS
  PROCEDURE GetShopperCreditCardEncrypted (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    curPresult	OUT	refcur
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult FOR
        SELECT profile_id, card_type_id, null,
          expiration_month, expiration_year, firstname_on_card, lastname_on_card, card_numberencrypted, encryptionkey
        FROM YA_CREDIT_CARD_PROFILE
        WHERE shopper_id = cPshopperId
          AND card_type_id IN (1,2,3,6)
        ORDER BY preferred DESC nulls last;
      END;
    ELSIF iPsiteId = 18 THEN
      BEGIN
        OPEN curPresult FOR
        SELECT profile_id, card_type_id, null,
          expiration_month, expiration_year, firstname_on_card, lastname_on_card, card_numberencrypted, encryptionkey
        FROM YA_CREDIT_CARD_PROFILE
        WHERE shopper_id = cPshopperId
          AND card_type_id IN (1,2)
        ORDER BY preferred DESC nulls last;
      END;
    ELSE
      BEGIN
        OPEN curPresult FOR
        SELECT profile_id, card_type_id, null,
          expiration_month, expiration_year, firstname_on_card, lastname_on_card, card_numberencrypted, encryptionkey
        FROM YA_CREDIT_CARD_PROFILE
        WHERE shopper_id = cPshopperId
          AND card_type_id IN (1,2,3,6)
        ORDER BY preferred DESC nulls last;
      END;
    END IF;
    RETURN;
  END GetShopperCreditCardEncrypted;

  PROCEDURE CreateCCProfileEncrypted (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    iPtypeId		IN	INT,
    cPcardNumber	IN	VARCHAR2,
    iPexpMonth		IN	INT,
    iPexpYear		IN	INT,
    cPfirstname		IN	VARCHAR2,
    cPlastname		IN	VARCHAR2,
    cPcardNumberEncrypted	IN	VARCHAR2,
    cPencryptionKey  IN	INT,
    iPprofileId IN OUT	INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPprofileId IS NULL OR iPprofileId < 0 THEN
      SELECT seq_credit_card_profile.NEXTVAL INTO iPprofileId FROM DUAL;
    ELSE
      SELECT SEQ_credit_card_profile.NEXTVAL INTO iLseq_currval FROM dual;
      iLseq_diff := iPprofileId - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_credit_card_profile INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_credit_card_profile.NEXTVAL INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_credit_card_profile INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO YA_CREDIT_CARD_PROFILE
      (
      profile_id,
      shopper_id,
      site_id,
      card_type_id,
      expiration_month,
      expiration_year,
      firstname_on_card,
      lastname_on_card, 
      card_numberencrypted, 
      encryptionkey
      )
    VALUES
      (
      iPprofileId,
      cPshopperId,
      iPsiteId,
      iPtypeId,
      iPexpMonth,
      iPexpYear,
      cPfirstname,
      cPlastname,
      cPcardNumberEncrypted,
      cPencryptionKey
      );
    COMMIT;
  RETURN;
  END CreateCCProfileEncrypted;  
  
  PROCEDURE DeleteCreditCard (
    iPprofile_id IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    iProw_affacted := 0;
  
    DELETE FROM YA_CREDIT_CARD_PROFILE    
    WHERE profile_id = iPprofile_id;
    
    -- Commit
    IF sqlcode = 0 THEN      
      iProw_affacted := SQL%ROWCOUNT;
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
        
    RETURN;
  END DeleteCreditCard;  
END Pkg_Fe_Creditcardaccess;
/
