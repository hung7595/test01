CREATE OR REPLACE PACKAGE Pkg_test_thread_abort
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE GetAllObjectNames (
    curPresult1 OUT curG,
    curPresult2 OUT curG
   );


  PROCEDURE GetArtistSetByInitial (
    cPinitial IN CHAR,
    iPdept_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPgender IN CHAR,
    curPresult1 OUT curG
  );

  PROCEDURE GetBackToStockProductList (
    curPgetAward  OUT curG,
    iPdept_id   IN  INT,
    iPpast_days   IN  INT,
    iPsite_id   IN  INT DEFAULT 1
  );
END Pkg_test_thread_abort;
/

CREATE OR REPLACE PACKAGE BODY Pkg_test_thread_abort
IS
  PROCEDURE GetBackToStockProductList (
    curPgetAward  OUT curG,
    iPdept_id   IN  INT,
    iPpast_days   IN  INT,
    iPsite_id   IN  INT DEFAULT 1
  )
  AS
  BEGIN
    IF iPsite_id = 1 THEN
      BEGIN
        OPEN curPgetAward FOR
        SELECT
          DISTINCT dept.sku
        FROM
          ya_prod_dept dept,
          ProductAvailability avail,
          ya_product p
        WHERE
          dept.sku = avail.ProductId
          AND dept.sku = p.sku
          AND dept.dept_id = iPdept_id
          AND avail.originId = 1
          AND avail.Category = 1
          AND avail.lastNonSellableDate is NOT null
          AND ROUND(SYSDATE - iPpast_days) < avail.lastNonSellableDate
          AND (avail.lastSellableDate < avail.lastNonSellableDate
          OR  avail.lastSellableDate is null)
          AND dept.sku NOT IN
          (
            SELECT a.sku
            FROM  ya_adult_product a
          )
          AND p.release_date < (TO_DATE(SYSDATE) + ( 1 * iPpast_days * - 1 ) );
      END;
    ELSE
      BEGIN
        OPEN curPgetAward FOR
        SELECT
          DISTINCT dept.sku
        FROM
          ya_prod_dept dept,
          ProductAvailability avail,
          ya_product p
        WHERE
          dept.sku = avail.ProductId
          AND dept.sku = p.sku
          AND dept.dept_id = iPdept_id
          AND avail.originId = 7
          AND avail.Category = 1
          AND avail.lastNonSellableDate IS NOT NULL
          AND ROUND(SYSDATE - iPpast_days) < avail.lastNonSellableDate
          AND (avail.lastSellableDate  < avail.lastNonSellableDate OR avail.lastSellableDate IS NULL)
          AND dept.sku NOT IN
          (
            SELECT a.sku FROM ya_adult_product a
          )
          AND p.release_date < (TO_DATE(SYSDATE) + ( 1 * iPpast_days * - 1 ) );
      END;
    END IF;
  RETURN;
  END GetBackToStockProductList;







  PROCEDURE GetAllObjectNames (
    curPresult1 OUT curG,
    curPresult2 OUT curG
   )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT OBJECT_NAME
    FROM all_objects;

    OPEN curPresult2 FOR
    SELECT OBJECT_NAME
    FROM all_objects
    WHERE ROWNUM < 1000;
  END;

  PROCEDURE GetArtistSetByInitial (
    cPinitial IN CHAR,
    iPdept_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPgender IN CHAR,
    curPresult1 OUT curG
  )
  AS
    cLsearch_str VARCHAR2(15);
    iLdept_id2 INT := 6;
  BEGIN
    IF (cPinitial='#') THEN
      BEGIN
        cLsearch_str := '^[0-9].*';
      END;
    ELSE
      IF (cPinitial='*') THEN
        BEGIN
          cLsearch_str := '^[0-9a-zA-Z].*';
        END;
      ELSE
        IF (cPinitial='^') THEN
          cLsearch_str := '^[a-zA-Z].*';
        ELSE
          cLsearch_str := '^[' || UPPER(cPinitial) || '].*';
        END IF;
      END IF;
    END IF;

    IF iPsite_id = 1 THEN
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          a.artist_id,
          al.firstname_u as e_firstname_u,
          al.lastname_u as e_lastname_u,
          al.akaname_u as e_akaname_u,
          al2.firstname_u,
          al2.lastname_u,
          al2.akaname_u,
          al3.name_img_loc,
          NVL(al3.name_img_width, -1),
          NVL(al3.name_img_height, -1),
          NVL(a.origin_country_id, 0),
          NVL(al3.lang_id, 0),
          al2.prefix,
          al2.suffix,
          al.prefix,
          al.suffix,
          ''
          FROM
            ya_artist a
            INNER JOIN ya_artist_dept ad ON
              ad.artist_id = a.artist_id
              AND ad.dept_id = iPdept_id
              AND us_enabled = 'Y'
            inner join ya_artist_lang al ON
              al.artist_id = a.artist_id
              AND al.lang_id=1
              AND a.artist_id=al.artist_id
              AND al.lang_id IN (1, iPlang_id)
              AND regexp_like(upper(al.lastname_u || al.firstname_u || al.akaname_u), cLsearch_str)
            LEFT JOIN ya_artist_lang al2 ON
              a.artist_id=al2.artist_id
              AND al2.lang_id=iPlang_id
            LEFT JOIN ya_artist_lang al3 ON
              a.artist_id=al3.artist_id
              AND al3.lang_id IN
                (
                  SELECT lang_id
                  FROM ya_artist_lang
                  WHERE artist_id=al3.artist_id
                  AND preferred_flag='Y'
                  AND ROWNUM=1
                )
          WHERE
            a.gender = cPgender
          ORDER by
            (al.lastname_u || al.firstname_u || al.akaname_u);
       END;
    ELSE
      BEGIN
        OPEN curPresult1 FOR
        SELECT
          a.artist_id,
          al.firstname_u as e_firstname_u,
          al.lastname_u as e_lastname_u,
          al.akaname_u as e_akaname_u,
          al2.firstname_u,
          al2.lastname_u,
          al2.akaname_u,
          al3.name_img_loc,
          NVL(al3.name_img_width, -1),
          NVL(al3.name_img_height, -1),
          NVL(a.origin_country_id, 0),
          NVL(al3.lang_id, 0),
          al2.prefix,
          al2.suffix,
          al.prefix,
          al.suffix,
          ''
          FROM
            ya_artist a
            INNER JOIN ya_artist_dept ad ON
              ad.artist_id = a.artist_id
              AND ad.dept_id = iPdept_id
              AND tw_enabled = 'Y'
            inner join ya_artist_lang al ON
              al.artist_id = a.artist_id
              AND al.lang_id=1
              AND a.artist_id=al.artist_id
              AND al.lang_id IN (1, iPlang_id)
              AND regexp_like(upper(al.lastname_u || al.firstname_u || al.akaname_u), cLsearch_str)
            LEFT JOIN ya_artist_lang al2 ON
              a.artist_id=al2.artist_id
              AND al2.lang_id=iPlang_id
            LEFT JOIN ya_artist_lang al3 ON
              a.artist_id=al3.artist_id
              AND al3.lang_id IN
                (
                  SELECT lang_id
                  FROM ya_artist_lang
                  WHERE artist_id=al3.artist_id
                  AND preferred_flag='Y'
                  AND ROWNUM=1
                )
          WHERE
            a.gender = cPgender
          ORDER by
            (al.lastname_u ||  al.firstname_u || al.akaname_u);
        END;
    END IF;


  END GetArtistSetByInitial;
END Pkg_test_thread_abort;
/

