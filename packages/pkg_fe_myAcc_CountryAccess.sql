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
      SELECT cl.country_id, cl.country_name
      FROM ya_country_lang cl,
          ya_country c,
          ya_site_canship_country sc
      WHERE c.country_id = iPcountry_id
        AND c.country_id = cl.country_id
        AND c.country_id = sc.country_id
        AND sc.site_id in (1,7)
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
          SELECT cl.country_id, cl.country_name
          FROM ya_country_lang cl,
              ya_country c,
              ya_country_lang cs,
              ya_site_canship_country sc
          WHERE c.country_id = cl.country_id
            AND c.country_id = cs.country_id
            AND c.country_id = sc.country_id
            AND sc.site_id in (1,7)
            AND cs.lang_id = 1
            AND cl.lang_id = iPlang_id
          ORDER BY cs.country_name;
      END;
    ELSE
      BEGIN
        OPEN curPresult FOR
          SELECT cl.country_id, cl.country_name
          FROM ya_country_lang cl,
              ya_country c,
              ya_country_lang cs,
              ya_site_canship_country sc
          WHERE c.country_id = cl.country_id
            AND c.country_id = cs.country_id
            AND c.country_id = sc.country_id
            AND sc.site_id = iPsite_id
            AND cs.lang_id = 1
            AND cl.lang_id = iPlang_id
          ORDER BY cs.country_name;
      END;
    END IF;
  RETURN;
  END GetCountryList;
  
END PKG_FE_MYACC_COUNTRYACCESS;
/

