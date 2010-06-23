create or replace PACKAGE Pkg_FE_CountryBlockAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetCountryBlockBySku (
    curPsku OUT refCur
  );
  PROCEDURE GetCountryBlockBySupplier (
    curPsupplier OUT refCur
  );
  PROCEDURE GetCountryBlockByRevAcc (
    curPrevAccount OUT refCur
  );
  PROCEDURE GetCountryBlockByAttr (
    curPAttribute OUT refCur
  );
  PROCEDURE GetCountryBlockByBrand (
    curPAttribute OUT refCur
  );
  END Pkg_FE_CountryBlockAccess;
/
create or replace PACKAGE BODY Pkg_FE_CountryBlockAccess
IS
  PROCEDURE GetCountryBlockBySku (
    curPsku OUT refCur
  )
  AS
  BEGIN
    OPEN curPsku FOR
	  select site_id,prod_id,COUNTRY_ID from ya_ban_ship_country_prod order by site_id, prod_id,country_id;
  END GetCountryBlockBySku;
  
  PROCEDURE GetCountryBlockBySupplier (
    curPsupplier OUT refCur
  )
  AS
  BEGIN
    OPEN curPsupplier FOR
	  select site_id,SUPPLIER_ID,COUNTRY_ID from ya_ban_ship_country_supplier order by site_id, supplier_id,country_id;
  END GetCountryBlockBySupplier;
  
  PROCEDURE GetCountryBlockByRevAcc (
    curPrevAccount OUT refCur
  )
  AS
  BEGIN
    OPEN curPrevAccount FOR
	  select site_id,ACCOUNT_ID,COUNTRY_ID from ya_ban_ship_country_account order by site_id, account_id,country_id;
  END GetCountryBlockByRevAcc;
  
  PROCEDURE GetCountryBlockByAttr (
    curPAttribute OUT refCur
  )
  AS
  BEGIN
   OPEN curPAttribute FOR
          select site_id,ATTRIBUTE_ID,COUNTRY_ID from ya_ban_ship_country_attr order by site_id,attribute_id,country_id;
  END GetCountryBlockByAttr;

  PROCEDURE GetCountryBlockByBrand (
    curPAttribute OUT refCur
  )
  AS
  BEGIN
   OPEN curPAttribute FOR
          select site_id,brand_id,country_id from ya_ban_ship_country_brand order by site_id,brand_id,country_id;
  END GetCountryBlockByBrand;
  
  END Pkg_FE_CountryBlockAccess;
/