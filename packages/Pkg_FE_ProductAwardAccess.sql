
REM START SS_ADM PKG_FE_PRODUCTAWARDACCESS

CREATE OR REPLACE PACKAGE "PKG_FE_PRODUCTAWARDACCESS" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetNominateDirectors (
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetAwardYearsByRevAccGroup (
    iPrev_group IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetAwardYearsByEventId (
    iPevent_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  );
END Pkg_FE_ProductAwardAccess;
/

CREATE OR REPLACE PACKAGE BODY "PKG_FE_PRODUCTAWARDACCESS" 
AS
  /* proc_fe_getAwardNominateDirectors */
  PROCEDURE GetNominateDirectors (
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT DISTINCT
      CAST(NVL(a.origin_country_id, 0) AS INT),
      NVL(al.firstname_u, al_en.firstname_u) AS artist_firstname,
      NVL(al.lastname_u, al_en.lastname_u) AS artist_lastname,
      NVL(al.akaname_u, al_en.akaname_u) AS artist_akaname,
      NVL(al.prefix, al_en.prefix) AS prefix,
      NVL(al.suffix, al_en.suffix) AS suffix,
      pa.artist_id
    FROM
      ya_product_award paa,
      ya_product_award_artist part,
      ya_product_artist pa,
      backend_adm.prod_region bpr,
      ya_artist a,
      ya_artist_lang al,
      ya_artist_lang al_en
    WHERE
      paa.sku = part.sku
      AND paa.award_definition_id = part.award_definition_id
      AND paa.status_type_id = part.status_type_id

      AND paa.priority = 1

      AND pa.sku = part.sku
      AND pa.artist_id = part.artist_id
      AND pa.rel_id in (44, 47) --directors

      AND bpr.prod_id = pa.sku
      AND bpr.category_id = 1
      AND bpr.region_id = iPsite_id -- must be equal to YAWeb's siteId
      AND bpr.origin_id = iPsite_id -- must be equal to YAWeb's siteId
      AND bpr.is_enabled = 'Y'

      AND a.artist_id = pa.artist_id
      AND part.artist_id = al.artist_id(+)
      AND al.lang_id(+) = iPlang_id
      AND part.artist_id = al_en.artist_id
      AND al_en.lang_id = 1;
    RETURN;
  END GetNominateDirectors;



  PROCEDURE GetAwardYearsByRevAccGroup (
    iPrev_group IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT DISTINCT
      ad.year,
      rag.product_category_id --rev account group id
    FROM
      backend_adm.prod_region bpr,
      ya_product p,
      ya_product_award pa,
      ya_award_definition ad,
      ya_rev_account_group rag
    WHERE
      rag.product_category_id = iPrev_group
      AND ad.award_definition_id = pa.award_definition_id
      AND
        (
          p.sku = pa.sku
          AND p.account_id = rag.rev_account_id
        )
      AND
        (
          bpr.prod_id = pa.sku
          AND bpr.category_id = 1
          AND bpr.region_id = iPsite_id -- must be equal to YAWeb's siteId
          AND bpr.origin_id = iPsite_id -- must be equal to YAWeb's siteId
          AND bpr.is_enabled = 'Y'
        )
      AND pa.priority = 1
    ORDER BY
      ad.year DESC;
    RETURN;
  END GetAwardYearsByRevAccGroup;


  /*proc_fe_getAvailableYearsByEventId*/
  PROCEDURE GetAwardYearsByEventId (
    iPevent_id IN INT,
    iPsite_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT DISTINCT
      year,
      event_id --rev account group id
    FROM
      ya_award_definition ad,
      ya_product_award pa,
      backend_adm.prod_region bpr
    WHERE
      ad.event_id = iPevent_id
      AND ad.award_definition_id = pa.award_definition_id
      AND
        (
          bpr.prod_id = pa.sku
          AND bpr.category_id = 1
          AND bpr.region_id = iPsite_id -- must be equal to YAWeb's siteId
          AND bpr.origin_id = iPsite_id -- must be equal to YAWeb's siteId
          AND bpr.is_enabled = 'Y'
        )
      AND pa.priority = 1
    ORDER BY
      ad.year DESC;
    RETURN;
  END GetAwardYearsByEventId;
END Pkg_FE_ProductAwardAccess;
/
 
REM END SS_ADM PKG_FE_PRODUCTAWARDACCESS
