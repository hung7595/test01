CREATE OR REPLACE package Pkg_fe_MyAccountAddressAccess
As
  PROCEDURE AddAddress(
    cPshopper_id IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN VARCHAR2,
    cPphone IN VARCHAR2,
    cPevePhone IN VARCHAR2,
    cPfax IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPlang_id IN INT,
    iPsite_id IN INT,
    iPaddress_id IN INT
  );
  PROCEDURE UpdateAddress(
    iPprofile_id IN INT,
    cPshopper_id IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN VARCHAR2,
    cPphone IN VARCHAR2,
    cPevePhone IN VARCHAR2,
    cPfax IN VARCHAR2,
    cPemail IN VARCHAR2
  );
END Pkg_fe_MyAccountAddressAccess;
/
CREATE OR REPLACE package body Pkg_fe_MyAccountAddressAccess
IS
  PROCEDURE AddAddress(
    cPshopper_id IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN VARCHAR2,
    cPphone IN VARCHAR2,
    cPevePhone IN VARCHAR2,
    cPfax IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPlang_id IN INT,
    iPsite_id IN INT,
    iPaddress_id IN INT
  )
  AS
    iLaddress_current INT;
  BEGIN
    IF iPaddress_id < 0 THEN
      SELECT seq_address.nextval INTO iLaddress_current FROM dual;
    ELSE
      iLaddress_current := iPaddress_id;
    END IF;

    INSERT INTO ya_address (address_id, lang_id, shopper_id, address_profile_name, firstname,
      lastname, address1, address2, city, city_id, state, state_id, zip, country_id, day_phone, eve_phone, fax_number, email, site_id, rowguid)
    VALUES
      (iLaddress_current, 1, cPshopper_id, cPprofile_name, cPfirstname, cPlastname, cPaddress1,
      cPaddress2, cPcity, iPcity_id, cPstate, iPstate_id, cPzip, iPcountry_id, cPphone, cPevePhone, cPfax, cPemail, iPsite_id, sys_guid());

    INSERT INTO ya_address (address_id, lang_id, shopper_id, address_profile_name, firstname,
      lastname, address1, address2, city, city_id, state, state_id, zip, country_id, day_phone, eve_phone, fax_number, email, site_id, rowguid)
    VALUES
      (iLaddress_current, 2, cPshopper_id, cPprofile_name, cPfirstname, cPlastname, cPaddress1,
      cPaddress2, cPcity, iPcity_id,  cPstate, iPstate_id, cPzip, iPcountry_id, cPphone, cPevePhone, cPfax, cPemail, iPsite_id, sys_guid());

    INSERT INTO ya_address (address_id, lang_id, shopper_id, address_profile_name, firstname,
      lastname, address1, address2, city, city_id, state, state_id, zip, country_id, day_phone, eve_phone, fax_number, email, site_id, rowguid)
    VALUES
      (iLaddress_current, 3, cPshopper_id, cPprofile_name, cPfirstname, cPlastname, cPaddress1,
      cPaddress2, cPcity, iPcity_id,  cPstate, iPstate_id, cPzip, iPcountry_id, cPphone, cPevePhone, cPfax, cPemail, iPsite_id, sys_guid());

    INSERT INTO ya_address (address_id, lang_id, shopper_id, address_profile_name, firstname,
      lastname, address1, address2, city, city_id, state, state_id, zip, country_id, day_phone, eve_phone, fax_number, email, site_id, rowguid)
    VALUES
      (iLaddress_current, 4, cPshopper_id, cPprofile_name, cPfirstname, cPlastname, cPaddress1,
      cPaddress2, cPcity, iPcity_id,  cPstate, iPstate_id, cPzip, iPcountry_id, cPphone, cPevePhone, cPfax, cPemail, iPsite_id, sys_guid());

    INSERT INTO ya_address (address_id, lang_id, shopper_id, address_profile_name, firstname,
      lastname, address1, address2, city, city_id, state, state_id, zip, country_id, day_phone, eve_phone, fax_number, email, site_id, rowguid)
    VALUES
      (iLaddress_current, 5, cPshopper_id, cPprofile_name, cPfirstname, cPlastname, cPaddress1,
      cPaddress2, cPcity, iPcity_id,  cPstate, iPstate_id, cPzip, iPcountry_id, cPphone, cPevePhone, cPfax, cPemail, iPsite_id, sys_guid());
    COMMIT;
  END AddAddress;

  PROCEDURE UpdateAddress(
    iPprofile_id IN INT,
    cPshopper_id IN VARCHAR2,
    cPprofile_name IN VARCHAR2,
    cPlastname IN VARCHAR2,
    cPfirstname IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN VARCHAR2,
    cPphone IN VARCHAR2,
    cPevePhone IN VARCHAR2,
    cPfax IN VARCHAR2,
    cPemail IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_address SET address_profile_name = cPprofile_name, firstname = cPfirstname,
      lastname = cPlastname, address1 = cPaddress1, address2 = cPaddress2,
      city = cPcity, city_id = iPcity_id, state = cPstate, state_id = iPstate_id, zip = cPzip, country_id = iPcountry_id,
      day_phone = cPphone, fax_number = cPfax, email = cPemail, eve_phone = cPevePhone
    WHERE shopper_id = cPshopper_id AND address_id = iPprofile_id;
    COMMIT;
  END UpdateAddress;
END Pkg_fe_MyAccountAddressAccess;
/
 