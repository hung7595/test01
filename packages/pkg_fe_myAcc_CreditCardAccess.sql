/* Reference to ss_adm package Pkg_Fe_Creditcardaccess */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_CREDITCARDACCESS
AS
  TYPE refCur IS REF CURSOR;

/* GetShopperCreditCardEncrypted */
PROCEDURE GetCreditCardById (
  iPprofile_id IN INT,  
  cPshopper_id IN CHAR,
  iPsite_id IN INT,
  curPresult OUT refcur
);

/* GetShopperCreditCardEncrypted */
PROCEDURE GetCreditCardByShopperId (
  cPshopper_id IN CHAR,
  iPsite_id IN INT,
  curPresult OUT refcur
);

/* CreateCCProfileEncrypted */
PROCEDURE CreateCreditCard (
  cPshopper_id IN CHAR,
  iPsite_id IN INT,
  cPprofile_name IN VARCHAR2,
  iPtype_id IN INT,    
  iPexp_month IN INT,
  iPexp_year IN INT,
  cPfirst_name IN VARCHAR2,
  cPlast_name IN VARCHAR2,
  cPcard_number IN VARCHAR2,
  cPcard_number_encrypted IN VARCHAR2,
  iPencryption_key IN INT,
  cPpreferred IN CHAR,
  iPprofile_id IN OUT INT,
  iProw_affacted OUT INT
);

PROCEDURE UpdateCreditCard (
  iPprofile_id IN INT,
  cPshopper_id IN CHAR,
  iPsite_id IN INT,
  cPprofile_name IN VARCHAR2,
  iPtype_id IN INT,  
  iPexp_month IN INT,
  iPexp_year IN INT,
  cPfirst_name IN VARCHAR2,
  cPlast_name IN VARCHAR2,
  cPcard_number IN VARCHAR2,
  cPcard_number_encrypted IN VARCHAR2,
  iPencryption_key IN INT,
  cPpreferred IN CHAR,  
  iProw_affacted OUT INT
);

PROCEDURE UpdateCreditCardWOCardNum (
  iPprofile_id IN INT,
  cPshopper_id IN CHAR,
  iPsite_id IN INT,
  cPprofile_name IN VARCHAR2,
  iPtype_id IN INT,  
  iPexp_month IN INT,
  iPexp_year IN INT,
  cPfirst_name IN VARCHAR2,
  cPlast_name IN VARCHAR2,
  cPpreferred IN CHAR,  
  iProw_affacted OUT INT
);

PROCEDURE DeleteCreditCard (
  iPprofile_id IN INT,
  iProw_affacted OUT INT
);
  
END PKG_FE_MYACC_CREDITCARDACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_CREDITCARDACCESS
AS

  PROCEDURE GetCreditCardById (
    iPprofile_id IN INT,  
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refcur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT profile_id, shopper_id, card_profile_name, card_number, firstname_on_card, lastname_on_card,
        card_type_id, card_numberencrypted, encryptionkey, expiration_month, expiration_year, preferred
    FROM YA_CREDIT_CARD_PROFILE
    WHERE profile_id = iPprofile_id AND shopper_id = cPshopper_id
    AND card_type_id IN (1,2,3,6)
    ORDER BY preferred DESC nulls last;
    RETURN;
  END GetCreditCardById;

  PROCEDURE GetCreditCardByShopperId (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    curPresult OUT refcur
  )
  AS
  BEGIN
    OPEN curPresult FOR
        SELECT profile_id, shopper_id, card_profile_name, card_number, firstname_on_card, lastname_on_card,
        card_type_id, card_numberencrypted, encryptionkey, expiration_month, expiration_year, preferred
        FROM YA_CREDIT_CARD_PROFILE
        WHERE shopper_id = cPshopper_id
        AND card_type_id IN (1,2,3,6)
        ORDER BY preferred DESC nulls last;
    RETURN;
  END GetCreditCardByShopperId;

  PROCEDURE CreateCreditCard (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPprofile_name IN VARCHAR2,
    iPtype_id IN INT,    
    iPexp_month IN INT,
    iPexp_year IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPcard_number IN VARCHAR2,
    cPcard_number_encrypted IN VARCHAR2,
    iPencryption_key IN INT,
    cPpreferred IN CHAR,
    iPprofile_id IN OUT INT,
    iProw_affacted OUT INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
  
    iProw_affacted := 0;
  
    IF iPprofile_id IS NULL OR iPprofile_id < 0 THEN
      SELECT seq_credit_card_profile.NEXTVAL INTO iPprofile_id FROM DUAL;
    ELSE
      SELECT SEQ_credit_card_profile.NEXTVAL INTO iLseq_currval FROM dual;
      iLseq_diff := iPprofile_id - iLseq_currval;
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
      card_profile_name,      
      card_type_id,
      card_number,
      expiration_month,
      expiration_year,
      firstname_on_card,
      lastname_on_card, 
      card_numberencrypted, 
      encryptionkey,
      preferred
      )
    VALUES
      (
      iPprofile_id,
      cPshopper_id,
      iPsite_id,
      cPprofile_name,
      iPtype_id,
      cPcard_number,
      iPexp_month,
      iPexp_year,
      cPfirst_name,
      cPlast_name,
      cPcard_number_encrypted,
      iPencryption_key,
      cPpreferred
      );      
    iProw_affacted := SQL%ROWCOUNT;
      
    -- Disable others default
    IF (cPpreferred = 'Y') THEN
      UPDATE YA_CREDIT_CARD_PROFILE SET preferred = 'N' 
      WHERE shopper_id = cPshopper_id AND site_id = iPsite_id AND profile_id <> iPprofile_id;    
    END IF;
        
    -- Commit
    IF sqlcode = 0 THEN      
      
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
    
    RETURN;
  END CreateCreditCard;
      
  PROCEDURE UpdateCreditCard (
    iPprofile_id IN INT,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPprofile_name IN VARCHAR2,
    iPtype_id IN INT,  
    iPexp_month IN INT,
    iPexp_year IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPcard_number IN VARCHAR2,
    cPcard_number_encrypted IN VARCHAR2,
    iPencryption_key IN INT,
    cPpreferred IN CHAR,  
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    iProw_affacted := 0;
    
    UPDATE YA_CREDIT_CARD_PROFILE SET
      shopper_id =cPshopper_id,
      site_id = iPsite_id,
      card_profile_name = cPprofile_name,      
      card_type_id = iPtype_id,
      card_number = cPcard_number,
      expiration_month = iPexp_month,
      expiration_year = iPexp_year,
      firstname_on_card = cPfirst_name,
      lastname_on_card = cPlast_name, 
      card_numberencrypted = cPcard_number_encrypted, 
      encryptionkey = iPencryption_key,
      preferred = cPpreferred
    WHERE profile_id = iPprofile_id;    
    
    iProw_affacted := SQL%ROWCOUNT;
    
    -- Disable others default
    IF (cPpreferred = 'Y') THEN
      UPDATE YA_CREDIT_CARD_PROFILE SET preferred = 'N' 
      WHERE shopper_id = cPshopper_id AND site_id = iPsite_id AND profile_id <> iPprofile_id;    
    END IF;
        
    -- Commit
    IF sqlcode = 0 THEN
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
    
  END UpdateCreditCard;
    
  PROCEDURE UpdateCreditCardWOCardNum (
    iPprofile_id IN INT,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPprofile_name IN VARCHAR2,
    iPtype_id IN INT,  
    iPexp_month IN INT,
    iPexp_year IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPpreferred IN CHAR,  
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    iProw_affacted := 0;
    
    UPDATE YA_CREDIT_CARD_PROFILE SET
      shopper_id =cPshopper_id,
      site_id = iPsite_id,
      card_profile_name = cPprofile_name,      
      card_type_id = iPtype_id,
      expiration_month = iPexp_month,
      expiration_year = iPexp_year,
      firstname_on_card = cPfirst_name,
      lastname_on_card = cPlast_name, 
      preferred = cPpreferred
    WHERE profile_id = iPprofile_id;    
    
    iProw_affacted := SQL%ROWCOUNT;
    
    -- Disable others default
    IF (cPpreferred = 'Y') THEN
      UPDATE YA_CREDIT_CARD_PROFILE SET preferred = 'N' 
      WHERE shopper_id = cPshopper_id AND site_id = iPsite_id AND profile_id <> iPprofile_id;    
    END IF;
        
    -- Commit
    IF sqlcode = 0 THEN
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
    
  END UpdateCreditCardWOCardNum;

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

END PKG_FE_MYACC_CREDITCARDACCESS;
/

