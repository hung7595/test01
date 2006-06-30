CREATE OR REPLACE package Pkg_fe_CreditCardAccess
AS
  TYPE refcur IS ref CURSOR;
  PROCEDURE GetShopperCreditCard (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    curPresult	OUT	refcur
  );
  PROCEDURE CreateCreditCardProfile (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    iPtypeId		IN	INT,
    cPcardNumber	IN	VARCHAR2,
    iPexpMonth		IN	INT,
    iPexpYear		IN	INT,
    cPfirstname		IN	VARCHAR2,
    cPlastname		IN	VARCHAR2,
    iPprofileId IN OUT INT
  );
END Pkg_fe_CreditCardAccess;
/

CREATE OR REPLACE package body Pkg_fe_CreditCardAccess
IS
  PROCEDURE GetShopperCreditCard (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    curPresult	OUT	refcur
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
      BEGIN
        OPEN curPresult FOR
        SELECT profile_id, card_type_id, card_number,
          expiration_month, expiration_year, firstname_on_card, lastname_on_card
        FROM ya_credit_card_profile
        WHERE shopper_id = cPshopperId
          AND card_type_id IN (1,2,3)
        ORDER BY preferred DESC nulls last;
      END;
    ELSE
      BEGIN
        OPEN curPresult FOR
        SELECT profile_id, card_type_id, card_number,
          expiration_month, expiration_year, firstname_on_card, lastname_on_card
        FROM ya_credit_card_profile
        WHERE shopper_id = cPshopperId
          AND card_type_id IN (1,2,3,6)
        ORDER BY preferred DESC nulls last;
      END;
    END IF;
    RETURN;
  END GetShopperCreditCard;

  PROCEDURE CreateCreditCardProfile (
    cPshopperId		IN	CHAR,
    iPsiteId		IN	INT,
    iPtypeId		IN	INT,
    cPcardNumber	IN	VARCHAR2,
    iPexpMonth		IN	INT,
    iPexpYear		IN	INT,
    cPfirstname		IN	VARCHAR2,
    cPlastname		IN	VARCHAR2,
    iPprofileId IN OUT	INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPprofileId IS NULL OR iPprofileId < 0 THEN
      SELECT seq_credit_card_profile.nextval INTO iPprofileId FROM DUAL;
    ELSE
      SELECT SEQ_credit_card_profile.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPprofileId - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_credit_card_profile INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_credit_card_profile.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_credit_card_profile INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_credit_card_profile
      (
      profile_id,
      shopper_id,
      site_id,
      card_type_id,
      card_number,
      expiration_month,
      expiration_year,
      firstname_on_card,
      lastname_on_card
      )
    VALUES
      (
      iPprofileId,
      cPshopperId,
      iPsiteId,
      iPtypeId,
      cPcardNumber,
      iPexpMonth,
      iPexpYear,
      cPfirstname,
      cPlastname
      );
    COMMIT;
  RETURN;
  END CreateCreditCardProfile;
END Pkg_fe_CreditCardAccess;
/

