CREATE OR REPLACE package Pkg_fe_MyAccountCCardAccess
As
  PROCEDURE AddCreditCard (
    cPshopper_id IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    iPcard_type IN INT,
    cPcard_num IN VARCHAR2,
    iPExpMonth IN INT,
    iPExpYear IN INT,
    cPpreferred IN VARCHAR2,
    iPprofile_id IN INT
  );
  PROCEDURE UpdateCreditCard (
    iPprofile_id IN INT,
    cPshopper_id IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    iPcard_type IN INT,
    cPcard_num IN VARCHAR2,
    iPExpMonth IN INT,
    iPExpYear IN INT,
    cPpreferred IN VARCHAR2
  );
END Pkg_fe_MyAccountCCardAccess;
/

CREATE OR REPLACE package body Pkg_fe_MyAccountCCardAccess
IS
  PROCEDURE AddCreditCard(
    cPshopper_id IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    iPcard_type IN INT,
    cPcard_num IN VARCHAR2,
    iPExpMonth IN INT,
    iPExpYear IN INT,
    cPpreferred IN VARCHAR2,
    iPprofile_id IN INT
  )
  AS
    iLprofile_current INT;
  BEGIN
    IF iPprofile_id < 0 THEN
      SELECT seq_credit_card_profile.NEXTVAL INTO iLprofile_current FROM dual;
    ELSE
      iLprofile_current := iPprofile_id;
    END IF;

    IF cPpreferred = 'Y' Then
      UPDATE ya_credit_card_profile SET preferred = 'N' WHERE shopper_id = cPshopper_id;
    END IF;

    INSERT INTO ya_credit_card_profile (profile_id, shopper_id, card_profile_name, firstname_on_card,
      lastname_on_card, card_type_id, expiration_month, expiration_year, preferred, card_number, last_five_digits)
    VALUES
      (iLprofile_current, cPshopper_id, cPprofile_name, cPfirstname, cPlastname, iPcard_type, iPExpMonth, iPExpYear, cPpreferred, cPcard_num, SUBSTR(cPcard_num, LENGTH(cPcard_num)-4, 5));

    COMMIT;
  END AddCreditCard;

  PROCEDURE UpdateCreditCard(
    iPprofile_id IN INT,
    cPshopper_id IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    iPcard_type IN INT,
    cPcard_num IN VARCHAR2,
    iPExpMonth IN INT,
    iPExpYear IN INT,
    cPpreferred IN VARCHAR2
  )
  AS
  BEGIN
    IF cPpreferred = 'Y' Then
      UPDATE ya_credit_card_profile SET preferred = 'N' WHERE shopper_id = cPshopper_id;
    END IF;

    UPDATE ya_credit_card_profile SET card_profile_name = cPprofile_name, firstname_on_card = cPfirstname,
      lastname_on_card = cPlastname, card_type_id = iPcard_type,
      expiration_month = iPExpMonth, expiration_year = iPExpYear, preferred = cPpreferred
    WHERE shopper_id = cPshopper_id AND profile_id = iPprofile_id;

    IF LENGTH(cPcard_num) > 0 THEN
      UPDATE ya_credit_card_profile SET card_number = cPcard_num, last_five_digits = SUBSTR(cPcard_num, LENGTH(cPcard_num)-4, 5)
      WHERE shopper_id = cPshopper_id AND profile_id = iPprofile_id;
    END IF;
    COMMIT;
  END UpdateCreditCard;
END Pkg_fe_MyAccountCCardAccess;
/

