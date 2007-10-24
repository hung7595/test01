/* Reference to ss_adm package Pkg_fe_CountryAccess */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_COUNTRYACCESS
AS
  TYPE refCur IS REF CURSOR;

PROCEDURE GetCountry (
  iPcountry_id		IN	INT,
  iPlang_id		IN	INT,
  curPresult	OUT	refcur
);

/* GetCountryList */
PROCEDURE GetCountryList (
  iPsite_id		IN	INT,
  iPlang_id		IN	INT,
  curPresult	OUT	refcur
);
  
END PKG_FE_MYACC_COUNTRYACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_COUNTRYACCESS
AS
  PROCEDURE GetCountry (
    iPcountry_id		IN	INT,
    iPlang_id		IN	INT,
    curPresult	OUT	refcur
  )
  AS  
  BEGIN
    OPEN curPresult FOR
      SELECT cl.country_id, c.country_name
      FROM ya_country_lang cl,
          (select * from ya_country where country_id = iPcountry_id AND (us_canship = 'Y' OR tw_canship = 'Y')) c
      WHERE c.country_id = cl.country_id
        AND cl.lang_id = iPlang_id;
  RETURN;
  END GetCountry;
  
  PROCEDURE GetCountryList (
    iPsite_id		IN	INT,
    iPlang_id		IN	INT,
    curPresult	OUT	refcur
  )
  AS  
  BEGIN
    IF iPsite_id = 99 THEN   /* All Site */
      BEGIN
        OPEN curPresult FOR
          SELECT cl.country_id, c.country_name
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
        OPEN curPresult FOR
          SELECT cl.country_id, c.country_name
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
                END = 'Y'
          ORDER BY cs.country_name;
      END;
    END IF;
  RETURN;
  END GetCountryList;
  
END PKG_FE_MYACC_COUNTRYACCESS;
/

