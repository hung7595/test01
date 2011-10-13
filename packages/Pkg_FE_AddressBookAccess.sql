CREATE OR REPLACE PACKAGE Pkg_FE_AddressBookAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE UpdateAddressProfileName (
    iPaddress_id IN INT,
    cPprofile_name IN VARCHAR2
  );
  
  /* proc_fe_GetAddressBook */
  PROCEDURE GetAddressByShopperId (
    cPshopper_id IN CHAR,
    iPlangId IN INT,
    curPresult OUT refCur
  );

  /* proc_fe_GetAddress */
  PROCEDURE GetAddressById (
    cPshopper_id IN CHAR,
    iPaddress_id IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  );
  /* proc_fe_AddAddress */
  PROCEDURE AddAddress (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPaddress_Id IN OUT INT
  );

  /* proc_fe_UpdateAddress */
  PROCEDURE UpdateAddress (
    iPaddress_id IN INT,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPlangId IN INT
  );
  /* proc_fe_AddAddress */
  PROCEDURE AddAddressYS (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPaddress_Id IN OUT INT
  );

  /* proc_fe_UpdateAddress */
  PROCEDURE UpdateAddressYS (
    iPaddress_id IN INT,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPlangId IN INT
  );
  PROCEDURE GetChineseAddress (
    curPresult OUT refCur
  );
  
  PROCEDURE GetChineseAddressProvinces (
    curPresult OUT refCur
  );
  
END Pkg_FE_AddressBookAccess;
/
CREATE OR REPLACE PACKAGE BODY Pkg_FE_AddressBookAccess
AS
  PROCEDURE UpdateAddressProfileName (
    iPaddress_id IN INT,
    cPprofile_name IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_address
    SET
      ADDRESS_PROFILE_NAME = cPprofile_name
    WHERE
      address_id = iPaddress_id;

    COMMIT;
    RETURN;  
  END UpdateAddressProfileName;
  
  PROCEDURE GetAddressByShopperId (
    cPshopper_id IN CHAR,
    iPlangId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      firstname,lastname,address1,address2,city,
      state,zip,country_id,day_phone,eve_phone,
      fax_number,mobile_phone,email,address_id,
      state_id,city_id
    FROM ya_address
    WHERE shopper_id = cPshopper_id
      AND created_by_checkout_session = 'N'
    ORDER BY address_id;

    RETURN;
  END GetAddressByShopperId;

  PROCEDURE GetAddressById (
    cPshopper_id IN CHAR,
    iPaddress_id IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      firstname,lastname,address1,address2,city,
      state,zip,country_id,day_phone,eve_phone,
      fax_number,mobile_phone,email,address_id,
      state_id,city_id
    FROM ya_address
    WHERE
      shopper_id = cPshopper_id
      AND address_id = iPaddress_id;
    RETURN;
  END GetAddressById;

  PROCEDURE AddAddress (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPaddress_Id IN OUT INT
  )
  AS
  BEGIN
    SELECT SEQ_address.nextval INTO iPaddress_Id FROM DUAL;

    BEGIN
      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, 
          created_by_checkout_session
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, -1, 'N'
        );

      COMMIT;
    END;
    RETURN;
  END AddAddress;


  PROCEDURE UpdateAddress (
    iPaddress_id IN INT,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPlangId IN INT
  )
  AS
  BEGIN
    UPDATE ya_address
    SET
      shopper_id = cPshopper_id,
      firstname = cPfirst_name,
      lastname = cPlast_name,
      address1 = cPaddress1,
      address2 = cPaddress2,
      city = cPcity,
      state = cPstate,
      state_id = iPstate_id,
      zip = cPzip,
      country_id = iPcountry_id,
      day_phone = cPday_phone,
      eve_phone = cPeve_phone,
      fax_number = cPfax_number,
      mobile_phone = cPmobile_phone,
      email = cPemail,
      site_id = iPsite_id
    WHERE
      address_id = iPaddress_id;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;
    COMMIT;
    RETURN;
  END UpdateAddress;

  PROCEDURE AddAddressYS (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPaddress_Id IN OUT INT
  )
  AS
  BEGIN
    SELECT SEQ_address.nextval INTO iPaddress_Id FROM DUAL;

    BEGIN
      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id,
          created_by_checkout_session
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, -1, iPcity_id, 'N'
        );

      COMMIT;
    END;
    RETURN;
  END AddAddressYS;

  PROCEDURE UpdateAddressYS (
    iPaddress_id IN INT,
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPcity_id IN INT,
    cPstate IN VARCHAR2,
    iPstate_id IN INT,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    iPlangId IN INT
  )
  AS
  BEGIN
    UPDATE ya_address
    SET
      shopper_id = cPshopper_id,
      firstname = cPfirst_name,
      lastname = cPlast_name,
      address1 = cPaddress1,
      address2 = cPaddress2,
      city = cPcity,
      state = cPstate,
      state_id = iPstate_id,
      zip = cPzip,
      country_id = iPcountry_id,
      day_phone = cPday_phone,
      eve_phone = cPeve_phone,
      fax_number = cPfax_number,
      mobile_phone = cPmobile_phone,
      email = cPemail,
      site_id = iPsite_id,
      city_id = iPcity_id
    WHERE
      address_id = iPaddress_id;

    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;
    COMMIT;
    RETURN;
  END UpdateAddressYS;
  
  PROCEDURE GetChineseAddress (
    curPresult OUT refCur
  )
  AS
  BEGIN
  OPEN curPresult FOR
    SELECT l1.code_id,l1.meaning,l2.code_id,l2.meaning 
    FROM ya_lookup_lang l1, ya_lookup_lang l2, ya_chinese_address_rel, ya_lookup 
    WHERE l2.type_id = 124 
      AND l1.type_id=123 
      AND provinces_id=l1.code_id 
      AND city_id=l2.code_id 
      AND ya_lookup.ENABLED='Y' 
      AND ya_lookup.TYPE_ID=124 
      AND ya_lookup.CODE_ID=l2.CODE_ID
    ORDER BY l1.code_id, l2.code_id;
    RETURN;
  END GetChineseAddress;
  
  PROCEDURE GetChineseAddressProvinces (
    curPresult OUT refCur
  )
  AS
  BEGIN
  OPEN curPresult FOR
    SELECT l1.code_id,l1.meaning 
    FROM ya_lookup_lang l1, ya_lookup 
    WHERE l1.type_id=123 
      AND ya_lookup.ENABLED='Y' 
      AND ya_lookup.TYPE_ID=123 
      AND ya_lookup.CODE_ID=l1.CODE_ID
    ORDER BY l1.code_id;
    RETURN;
  END GetChineseAddressProvinces;
END Pkg_FE_AddressBookAccess;
/
 