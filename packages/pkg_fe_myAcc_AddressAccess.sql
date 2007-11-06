/* Reference to ss_adm package Pkg_FE_AddressBookAccess */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_ADDRESSACCESS
AS
  TYPE refCur IS REF CURSOR;

/* GetAddressById */
PROCEDURE GetAddressById (
  cPshopper_id IN CHAR,
  iPaddress_id IN INT,
  iPlangId IN INT,
  curPresult OUT refCur
);

/* GetAddressByShopperId */
PROCEDURE GetAddressByShopperId (
  cPshopper_id IN CHAR,
  iPlangId IN INT,
  curPresult OUT refCur
);

/* AddAddress */
PROCEDURE CreateAddress (
  cPshopper_id IN CHAR,    
  cPprofile_name IN VARCHAR2,
  iPsite_id IN INT,
  cPfirst_name IN VARCHAR2,
  cPlast_name IN VARCHAR2,
  cPaddress1 IN VARCHAR2,
  cPaddress2 IN VARCHAR2,
  cPcity IN VARCHAR2,
  iPstate_id IN INT,
  cPstate IN VARCHAR2,
  cPzip IN VARCHAR2,
  iPcountry_id IN INT,
  cPday_phone IN VARCHAR2,
  cPeve_phone IN VARCHAR2,
  cPfax_number IN VARCHAR2,
  cPmobile_phone IN VARCHAR2,
  cPemail IN VARCHAR2,
  cPpreferred_ship IN CHAR,
  cPpreferred_bill IN CHAR,    
  iPaddress_id IN OUT INT,
  iProw_affacted OUT INT    
);

/* UpdateAddress */
PROCEDURE UpdateAddress (
  iPaddress_id IN INT,
  cPshopper_id IN CHAR,
  cPprofile_name IN VARCHAR2,
  iPsite_id IN INT,
  cPfirst_name IN VARCHAR2,
  cPlast_name IN VARCHAR2,
  cPaddress1 IN VARCHAR2,
  cPaddress2 IN VARCHAR2,
  cPcity IN VARCHAR2,
  iPstate_id IN INT,
  cPstate IN VARCHAR2,  
  cPzip IN VARCHAR2,
  iPcountry_id IN INT,
  cPday_phone IN VARCHAR2,
  cPeve_phone IN VARCHAR2,
  cPfax_number IN VARCHAR2,
  cPmobile_phone IN VARCHAR2,
  cPemail IN VARCHAR2,
  cPpreferred_ship IN CHAR,
  cPpreferred_bill IN CHAR,    
  iPlang_id IN INT,
  iProw_affacted OUT INT    
);

PROCEDURE DeleteAddress (
  iPaddress_id IN INT,
  iProw_affacted OUT INT  
);
  
END PKG_FE_MYACC_ADDRESSACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_ADDRESSACCESS
AS

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
      FROM ya_address
      WHERE shopper_id = cPshopper_id
      AND address_id = iPaddress_id
      AND lang_id = iPlangId
      AND ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        iLrecordExists := 0;
    END;
    
    OPEN curPresult FOR
    SELECT
      address_id,
      site_id,
      shopper_id,
      address_profile_name,
      firstname,
      lastname,
      address1,
      address2,
      city,
      state_id,
      state,
      zip,
      a.country_id,
      country_name,
      day_phone,
      eve_phone,      
      mobile_phone,
      fax_number,
      email,
      preferred_ship,
      preferred_bill
    FROM ya_address a
    LEFT JOIN ya_country_lang cl ON a.country_id = cl.country_id AND a.lang_id = cl.lang_id
    WHERE shopper_id = cPshopper_id
    AND address_id = iPaddress_id
    AND a.lang_id = (
      CASE
        WHEN iLrecordExists = 1 THEN iPlangId
        ELSE 1
      END
    );
    
    RETURN;
  END GetAddressById;
  
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
      FROM ya_address
      WHERE shopper_id = cPshopper_id
      AND lang_id = iPlangId
      AND ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        iLrecordExists := 0;
    END;

      OPEN curPresult FOR
      SELECT
      address_id,
      site_id,
      shopper_id,
      address_profile_name,
      firstname,
      lastname,
      address1,
      address2,
      city,
      state_id,
      state,
      zip,
      a.country_id,
      country_name,
      day_phone,
      eve_phone,      
      mobile_phone,
      fax_number,
      email,
      preferred_ship,
      preferred_bill
      FROM ya_address a
      LEFT JOIN ya_country_lang cl ON a.country_id = cl.country_id AND a.lang_id = cl.lang_id
      WHERE
      shopper_id = cPshopper_id
      AND a.lang_id = (
        CASE
        WHEN iLrecordExists = 1 THEN iPlangId
        ELSE 1
        END
      )
      ORDER BY address_id;

    RETURN;
  END GetAddressByShopperId;

  PROCEDURE CreateAddress (  
    cPshopper_id IN CHAR,    
    cPprofile_name IN VARCHAR2,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,    
    iPstate_id IN INT,
    cPstate IN VARCHAR2,
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPpreferred_ship IN CHAR,
    cPpreferred_bill IN CHAR,    
    iPaddress_id IN OUT INT,
    iProw_affacted OUT INT  
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
  
    iProw_affacted := 0;
  
    -- Get 
    IF iPaddress_id < 0 THEN
      SELECT SEQ_address.nextval INTO iPaddress_id FROM DUAL;
    ELSE
      SELECT SEQ_address.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPaddress_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ADDRESS INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_address.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ADDRESS INCREMENT BY 1';
      END IF;
    END IF;

    -- Insert
    BEGIN
      INSERT
      INTO ya_address
        (
          address_id, shopper_id, address_profile_name, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, preferred_ship, preferred_bill, site_id, lang_id
        )
      VALUES
        (
          iPaddress_id, cPshopper_id, cPprofile_name, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, cPpreferred_ship, cPpreferred_bill, iPsite_id, 1
        );

      INSERT
      INTO ya_address
        (
          address_id, shopper_id, address_profile_name, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, preferred_ship, preferred_bill, site_id, lang_id
        )
      VALUES
        (
          iPaddress_id, cPshopper_id, cPprofile_name, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, cPpreferred_ship, cPpreferred_bill, iPsite_id, 2
        );

      INSERT
      INTO ya_address
        (
          address_id, shopper_id, address_profile_name, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, preferred_ship, preferred_bill, site_id, lang_id
        )
      VALUES
        (
          iPaddress_id, cPshopper_id, cPprofile_name, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, cPpreferred_ship, cPpreferred_bill, iPsite_id, 3
        );

      INSERT
      INTO ya_address
        (
          address_id, shopper_id, address_profile_name, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, preferred_ship, preferred_bill, site_id, lang_id
        )
      VALUES
        (
          iPaddress_id, cPshopper_id, cPprofile_name, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, cPpreferred_ship, cPpreferred_bill, iPsite_id, 4
        );

      INSERT
      INTO ya_address
        (
          address_id, shopper_id, address_profile_name, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, preferred_ship, preferred_bill, site_id, lang_id
        )
      VALUES
        (
          iPaddress_id, cPshopper_id, cPprofile_name, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, cPpreferred_ship, cPpreferred_bill, iPsite_id, 5
        );

      INSERT
      INTO ya_address
        (
          address_id, shopper_id, address_profile_name, firstname, lastname, address1, address2, city, state, state_id,
          zip, country_id, day_phone, eve_phone, fax_number, mobile_phone, email, preferred_ship, preferred_bill, site_id, lang_id
        )
      VALUES
        (
          iPaddress_id, cPshopper_id, cPprofile_name, cPfirst_name, cPlast_name, cPaddress1, cPaddress2, cPcity,
          cPstate, iPstate_id, cPzip, iPcountry_id, cPday_phone, cPeve_phone, cPfax_number,
          cPmobile_phone, cPemail, cPpreferred_ship, cPpreferred_bill, iPsite_id, 6
        );

      -- Commit
      IF sqlcode = 0 THEN        
        iProw_affacted := SQL%ROWCOUNT;
        COMMIT;
      ELSE        
        ROLLBACK;          
      END IF;
    
    END;
    RETURN;
  END CreateAddress;
  
  PROCEDURE UpdateAddress (    
    iPaddress_id IN INT,
    cPshopper_id IN CHAR,
    cPprofile_name IN VARCHAR2,
    iPsite_id IN INT,
    cPfirst_name IN VARCHAR2,
    cPlast_name IN VARCHAR2,
    cPaddress1 IN VARCHAR2,
    cPaddress2 IN VARCHAR2,
    cPcity IN VARCHAR2,
    iPstate_id IN INT,
    cPstate IN VARCHAR2,  
    cPzip IN VARCHAR2,
    iPcountry_id IN INT,
    cPday_phone IN VARCHAR2,
    cPeve_phone IN VARCHAR2,
    cPfax_number IN VARCHAR2,
    cPmobile_phone IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPpreferred_ship IN CHAR,
    cPpreferred_bill IN CHAR,    
    iPlang_id IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN  
    iProw_affacted := 0;
  
    UPDATE ya_address
    SET
      shopper_id = cPshopper_id,
      address_profile_name = cPprofile_name,
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
      preferred_ship = cPpreferred_ship, 
      preferred_bill = cPpreferred_bill,      
      site_id = iPsite_id
    WHERE address_id = iPaddress_id;
    
    -- Commit
    IF sqlcode = 0 THEN
      iProw_affacted := SQL%ROWCOUNT;
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
        
    RETURN;
  END UpdateAddress;
  
  PROCEDURE DeleteAddress (
    iPaddress_id IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    iProw_affacted := 0;
  
    DELETE FROM ya_address    
    WHERE address_id = iPaddress_id;
    
    -- Commit
    IF sqlcode = 0 THEN      
      iProw_affacted := SQL%ROWCOUNT;
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
        
    RETURN;
  END DeleteAddress;
  

END PKG_FE_MYACC_ADDRESSACCESS;
/

