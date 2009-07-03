CREATE OR REPLACE package Pkg_fe_CountryAccess
AS
  TYPE refcur IS REF CURSOR;

  PROCEDURE GetCountryList (
    iPsite_id		IN	INT,
    iPlang_id		IN	INT,
    curPgetCountry	OUT	refcur
  );
END Pkg_fe_CountryAccess;
/


CREATE OR REPLACE package body Pkg_fe_CountryAccess
IS
  PROCEDURE GetCountryList (
    iPsite_id		IN	INT,
    iPlang_id		IN	INT,
    curPgetCountry	OUT	refcur
  )
  AS
  BEGIN
    IF iPsite_id = 99 THEN   /* All Site */
      BEGIN
        OPEN curPgetCountry FOR
        SELECT cl.country_id,
               cl.country_name
        FROM ya_country_lang cl,
             ya_country_lang cs,
             ya_site_canship_country sc
        WHERE cl.country_id = cs.country_id
          AND cl.country_id = sc.country_id
          AND cl.lang_id = iPlang_id
          AND cs.lang_id = 1
          AND sc.site_id in (1,7)
        ORDER BY cs.country_name;
      END;
    ELSE
      BEGIN
        OPEN curPgetCountry FOR
        SELECT cl.country_id,
               cl.country_name
        FROM ya_country_lang cl,
             ya_country_lang cs,
             ya_site_canship_country sc
        WHERE cl.country_id = cs.country_id
          AND cl.country_id = sc.country_id
          AND cs.lang_id = 1
          AND cl.lang_id = iPlang_id
          AND sc.site_id = iPsite_id
        ORDER BY cs.country_name;
      END;
    END IF;
  RETURN;
  END GetCountryList;
END Pkg_fe_CountryAccess;

/
