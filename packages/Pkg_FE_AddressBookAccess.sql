CREATE OR REPLACE PACKAGE Pkg_FE_AddressBookAccess
AS
  TYPE refCur IS REF CURSOR;

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
  PROCEDURE GetAddressByShopperId (
    cPshopper_id IN CHAR,
    iPlangId IN INT,
    curPresult OUT refCur
  )
  AS
    iLrecordExists INT := 0;
  BEGIN
    BEGIN
      SELECT 1 INTO iLrecordExists
      FROM
        ya_address
      WHERE
        shopper_id = cPshopper_id
        AND lang_id = iPlangId
        AND ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        iLrecordExists := 0;
    END;

    IF iLrecordExists = 1 THEN
      OPEN curPresult FOR
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
        eve_phone,
        fax_number,
        mobile_phone,
        email,
        address_id,
        state_id,
        city_id
      FROM ya_address
      WHERE
        shopper_id = cPshopper_id
        AND lang_id  = iPlangId
      ORDER BY address_id;
    ELSE
      OPEN curPresult FOR
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
        eve_phone,
        fax_number,
        mobile_phone,
        email,
        address_id,
        state_id,
        city_id
      FROM ya_address
      WHERE
        shopper_id = cPshopper_id
        AND lang_id  = 1
      ORDER BY address_id;
    END IF;
    RETURN;
  END GetAddressByShopperId;


  PROCEDURE GetAddressById (
    cPshopper_id IN CHAR,
    iPaddress_id IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  )
  AS
    iLrecordExists INT := 0;
  BEGIN
    BEGIN
      SELECT 1 INTO iLrecordExists
      FROM
        ya_address
      WHERE
        shopper_id = cPshopper_id
        AND address_id = iPaddress_id
        AND lang_id = iPlangId
        AND ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        iLrecordExists := 0;
    END;

    IF iLrecordExists = 1 THEN
      OPEN curPresult FOR
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
        eve_phone,
        fax_number,
        mobile_phone,
        email,
        address_id,
        state_id,
        city_id
      FROM ya_address
      WHERE
        shopper_id = cPshopper_id
        AND address_id = iPaddress_id
        AND lang_id = iPlangId;
    ELSE
      OPEN curPresult FOR
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
        eve_phone,
        fax_number,
        mobile_phone,
        email,
        address_id,
        state_id,
        city_id
      FROM ya_address
      WHERE
        shopper_id = cPshopper_id
        AND address_id = iPaddress_id
        AND lang_id = 1;
    END IF;
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
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPaddress_Id < 0 THEN
      SELECT SEQ_address.nextval INTO iPaddress_Id FROM DUAL;
    ELSE
      SELECT SEQ_address.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPaddress_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ADDRESS INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_address.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ADDRESS INCREMENT BY 1';
      END IF;
    END IF;

    BEGIN
      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 1
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 2
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 3
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 4
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 5
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 6
        );

      COMMIT;
/*
    EXCEPTION WHEN others THEN
      IF SQLCODE <> 0 THEN
        BEGIN
          ROLLBACK;
          iPaddress_Id := -1;
        END;
      END IF;
*/
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
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPaddress_Id < 0 THEN
      SELECT SEQ_address.nextval INTO iPaddress_Id FROM DUAL;
    ELSE
      SELECT SEQ_address.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPaddress_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ADDRESS INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_address.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ADDRESS INCREMENT BY 1';
      END IF;
    END IF;

    BEGIN
      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 1, iPcity_id
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 2, iPcity_id
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 3, iPcity_id
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 4, iPcity_id
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 5, iPcity_id
        );

      INSERT
      INTO ya_address
        (
          address_id , shopper_id, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, site_id, lang_id, city_id
        )
      VALUES
        (
          iPaddress_Id , cPshopper_id, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, iPsite_id, 6, iPcity_id
        );

      COMMIT;
/*
    EXCEPTION WHEN others THEN
      IF SQLCODE <> 0 THEN
        BEGIN
          ROLLBACK;
          iPaddress_Id := -1;
        END;
      END IF;
*/
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
select l1.code_id,l1.meaning,l2.code_id,l2.meaning 
from ya_lookup_lang l1, ya_lookup_lang l2, ya_chinese_address_rel, ya_lookup 
where l2.type_id = 124 and l1.type_id=123 and provinces_id=l1.code_id and city_id=l2.code_id 
and ya_lookup.ENABLED='Y' and ya_lookup.TYPE_ID=124 and ya_lookup.CODE_ID=l2.CODE_ID
order by l1.code_id, l2.code_id;

    RETURN;
    
  END GetChineseAddress;
    PROCEDURE GetChineseAddressProvinces (
    curPresult OUT refCur
  )
  AS
  BEGIN
  OPEN curPresult FOR
select l1.code_id,l1.meaning 
from ya_lookup_lang l1, ya_lookup 
where l1.type_id=123 and ya_lookup.ENABLED='Y' and ya_lookup.TYPE_ID=123 and ya_lookup.CODE_ID=l1.CODE_ID
order by l1.code_id;

    RETURN;
  END GetChineseAddressProvinces;
END Pkg_FE_AddressBookAccess;
/
 