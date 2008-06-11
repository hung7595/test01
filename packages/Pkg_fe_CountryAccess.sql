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
               c.country_name
        FROM ya_country_lang cl,
             ya_country c,
             ya_country_lang cs
        WHERE c.country_id = cl.country_id
          AND c.country_id = cs.country_id
          AND cl.lang_id = iPlang_id
          AND (c.us_canship = 'Y' OR c.tw_canship = 'Y')
          AND cs.lang_id = 1
          AND cl.lang_id = iPlang_id
        ORDER BY cs.country_name;
      END;
    ELSE
      BEGIN
        OPEN curPgetCountry FOR
        SELECT cl.country_id,
               c.country_name
        FROM ya_country_lang cl,
             ya_country c,
             ya_country_lang cs
        WHERE c.country_id = cl.country_id
          AND c.country_id = cs.country_id
          AND cs.lang_id = 1
          AND cl.lang_id = iPlang_id
          AND CASE iPsite_id
                WHEN 1 THEN c.us_canship
                WHEN 7 THEN c.tw_canship
                WHEN 10 THEN c.YS_CANSHIP
              END = 'Y'
        ORDER BY cs.country_name;
      END;
    END IF;
  RETURN;
  END GetCountryList;
END Pkg_fe_CountryAccess;

/
