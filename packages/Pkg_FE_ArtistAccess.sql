CREATE OR REPLACE PACKAGE Pkg_FE_ArtistAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE GetArtistSetByDept (
    iPdeptId IN INT,
    iPpublisherId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    cPgender IN CHAR,
    curPartist OUT curG
    --@gender : M - Male, F - Female, G - Group, C -- Toys Character
  );

  PROCEDURE IsShowBrowsePage (
    iPartistId IN INT,
    iPshowBit OUT INT
  );

  PROCEDURE GetArtistPool (
    iPlangId IN INT,
    iPdeptId IN INT,
    curPartist OUT curG
  );

  PROCEDURE GetArtistHighlightPool (
    iPlangId IN INT,
    curPartist OUT curG
  );

  PROCEDURE GetArtistBio (
    iPartistId IN INT,
    iPlangId IN INT,
    curPartist OUT curG
  );

  PROCEDURE GetArtistByFrontPageId (
    iPfileId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE FillArtistData (
    cPartistCsv IN VARCHAR2,
    iPlangId IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetArtistSetByInitial (
    cPinitial IN CHAR,
    iPdept_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPgender IN CHAR,
    curPresult1 OUT curG
  );

  PROCEDURE GetPopularArtistByInitial (
    cPinitial IN CHAR,
    iPdept_id IN INT,
    iPsite_id IN INT,
    cPgender IN CHAR, /* gender: M- Male, F- Female, G- Group */
    curPresult1 OUT curG
  );

  PROCEDURE GetDeptIDListByArtistID (
    iPartist_id IN INT,
    iPsite_id IN INT,
    curPresult1 OUT curG
  );

  PROCEDURE GetArtistPreferableDept (
    iPartist_id IN INT,
    iPsite_id IN INT,
    iPdept_id OUT INT
  );

  PROCEDURE GetArtistDeptInfo (
    iPartist_id IN INT,
    iProot_dept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult1 OUT curG
  );
END Pkg_FE_ArtistAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_ArtistAccess
IS
  /* proc_fe_get_frontpage_artist */
  PROCEDURE GetArtistByFrontPageId (
    iPfileId IN INT,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT lot_locatioin, artist_id
    FROM ya_artist_lot
    WHERE file_id = iPfileId
    ORDER BY lot_locatioin;
  RETURN;
  END GetArtistByFrontPageId;


  PROCEDURE FillArtistData (
    cPartistCsv IN VARCHAR2,
    iPlangId IN INT,
    curPresult1 OUT curG
  )
  AS
    iLstartpos INT;
    iLendpos INT;
    iLtemp INT;
    cLartistCsv VARCHAR2(500);
    iLsequenceid INT;
    icounter INT;
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_artist_int_table';

    iLstartpos := 1;
    iCounter := 1;
    cLartistCsv := cPartistCsv;
    iLtemp := NVL(LENGTH(RTRIM(cLartistCsv)),0);

    IF(iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLartistCsv, ',');
        WHILE  iLendpos  >  0
        LOOP
        BEGIN
          INSERT INTO temp_artist_int_table (COLUMN1, COLUMN2) VALUES (iCounter, CAST(substr(cLartistCsv,1,iLendpos-1) AS int));
          cLartistCsv := SUBSTR(cLartistCsv, iLendpos+1);
          iLendpos := INSTR(cLartistCsv, ',');
          iCounter := iCounter + 1;
        END;
        END LOOP;

      INSERT INTO temp_artist_int_table (COLUMN1, COLUMN2) VALUES (iCounter, CAST(cLartistCsv AS int));
      END;
    END IF;

    OPEN curPresult1 FOR
    SELECT
      a.artist_id,
      al.firstname_u as artist_firstname,
      al.lastname_u as artist_lastname,
      al.akaname_u as artist_akaname,
      al2.firstname_u as artist_firstname,
      al2.lastname_u as artist_lastname,
      al2.akaname_u as artist_akaname,
      al3.name_img_loc,
      NVL(al3.name_img_width, -1),
      NVL(al3.name_img_height, -1),
      NVL(a.origin_country_id, 0),
      NVL(al3.lang_id, 0),
      al.prefix,
      al.suffix,
      al2.prefix,
      al2.suffix,
      ''
    FROM
      temp_artist_int_table tp
      INNER JOIN ya_artist a ON tp.COLUMN2 = a.artist_id
      INNER JOIN ya_artist_lang al ON a.artist_id = al.artist_id
      LEFT JOIN ya_artist_lang al2 ON a.artist_id = al2.artist_id AND al2.lang_id = 1
      LEFT JOIN ya_artist_lang al3 ON a.artist_id = al3.artist_id AND al3.lang_id IN
        (
          SELECT lang_id
          FROM ya_artist_lang
          WHERE
            artist_id = al3.artist_id
            AND preferred_flag = 'Y'
            AND ROWNUM = 1
        )
    WHERE
      1 = 1
      AND al.lang_id = iPlangId
    ORDER BY tp.COLUMN1 ASC;
  RETURN;
  END FillArtistData;


  /* proc_fe_GetArtistsByInitial */
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
/*
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
    cLsite_prefix VARCHAR2(10);
    iLdept_id2 INT := 6;
  BEGIN
    cLsite_prefix :=
    CASE iPsite_id
      WHEN 1 THEN 'us'
      WHEN 2 THEN 'us_ws'
      WHEN 3 THEN 'jp'
      WHEN 4 THEN 'jp_ws'
      WHEN 5 THEN 'hk'
      WHEN 6 THEN 'hk_ws'
      WHEN 7 THEN 'tw'
      WHEN 8 THEN 'tw_ws'
    ELSE 'us'
    END;

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

    -- outlet section = outlet + books dept
    IF iPdept_id = 4350 THEN
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
          INNER JOIN
          (
            SELECT al.lang_id, al.artist_id, al.firstname_u, al.lastname_u, al.akaname_u, al.suffix, al.prefix
            FROM
              ya_artist_lang al
              INNER JOIN ya_artist_dept ad ON ad.artist_id=al.artist_id AND dept_id IN (iPdept_id, iLdept_id2) AND
                (
                  (
                    CASE cLsite_prefix
                      WHEN 'us'     THEN ad.us_enabled
                      WHEN 'us_ws'  THEN ad.us_ws_enabled
                      WHEN 'jp'     THEN ad.jp_enabled
                      WHEN 'jp_ws'  THEN ad.jp_ws_enabled
                      WHEN 'hk'     THEN ad.hk_enabled
                      WHEN 'hk_ws'  THEN ad.hk_ws_enabled
                      WHEN 'tw'     THEN ad.tw_enabled
                      WHEN 'tw_ws'  THEN ad.tw_ws_enabled
                      ELSE 'Y'
                    END
                  ) ='Y'
                )
            WHERE
              1 = 1
              AND al.lang_id IN (1, iPlang_id)
              AND regexp_like(UPPER(al.lastname_u || al.firstname_u || al.akaname_u), cLsearch_str)
          ) al ON al.artist_id = a.artist_id AND al.lang_id=1 AND a.artist_id=al.artist_id AND a.gender=cPgender
          LEFT JOIN ya_artist_lang al2 ON al.artist_id=al2.artist_id AND al2.lang_id=iPlang_id
          LEFT JOIN ya_artist_lang al3 ON al.artist_id=al3.artist_id AND al3.lang_id IN (SELECT lang_id FROM ya_artist_lang WHERE artist_id=al3.artist_id AND preferred_flag='Y' AND ROWNUM = 1)
        ORDER BY
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
            inner join
            (
              SELECT al.lang_id, al.artist_id, al.firstname_u, al.lastname_u, al.akaname_u, al.suffix, al.prefix
              FROM
                ya_artist_lang al
                inner join ya_artist_dept ad ON ad.artist_id=al.artist_id AND dept_id = iPdept_id AND
                (
                  (
                    CASE cLsite_prefix
                      WHEN 'us' THEN ad.us_enabled
                      WHEN 'us_ws' THEN ad.us_ws_enabled
                      WHEN 'jp' THEN ad.jp_enabled
                      WHEN 'jp_ws' THEN ad.jp_ws_enabled
                      WHEN 'hk' THEN ad.hk_enabled
                      WHEN 'hk_ws' THEN ad.hk_ws_enabled
                      WHEN 'tw' THEN ad.tw_enabled
                      WHEN 'tw_ws' THEN ad.tw_ws_enabled
                      ELSE 'Y'
                    END
                  ) ='Y'
                )
              WHERE
                1 = 1
                AND al.lang_id IN (1, iPlang_id)
                AND regexp_like(upper(al.lastname_u || al.firstname_u || al.akaname_u), cLsearch_str)
            ) al ON al.artist_id = a.artist_id AND  al.lang_id=1 AND  a.artist_id=al.artist_id AND a.gender=cPgender
            LEFT JOIN ya_artist_lang al2 ON al.artist_id=al2.artist_id AND al2.lang_id=iPlang_id
            LEFT JOIN ya_artist_lang al3 ON
              al.artist_id=al3.artist_id
              AND al3.lang_id IN (SELECT lang_id FROM ya_artist_lang WHERE artist_id=al3.artist_id AND preferred_flag='Y' AND ROWNUM=1)
          ORDER by (al.lastname_u || al.firstname_u || al.akaname_u);
      END;
    END IF;
  END GetArtistSetByInitial;
*/

  PROCEDURE GetPopularArtistByInitial (
    cPinitial IN CHAR,
    iPdept_id IN INT,
    iPsite_id IN INT,
    cPgender IN CHAR, /* gender: M- Male, F- Female, G- Group */
    curPresult1 OUT curG
  )
  AS
    cLsearch_str VARCHAR2(15);
    cLsearch_str_lower VARCHAR2(15);
    cLsite_prefix VARCHAR2(10);
    iLdept_id2 INT;
  BEGIN
    cLsite_prefix :=
    CASE iPsite_id
      WHEN 1 THEN 'us'
      WHEN 2 THEN 'us_ws'
      WHEN 3 THEN 'jp'
      WHEN 4 THEN 'jp_ws'
      WHEN 5 THEN 'hk'
      WHEN 6 THEN 'hk_ws'
      WHEN 7 THEN 'tw'
      WHEN 8 THEN 'tw_ws'
      ELSE 'us'
    END;

    IF (cPinitial = '#') THEN
      BEGIN
        cLsearch_str := '^[0-9].*';
      END;
    ELSE
      IF (cPinitial = '*') THEN
        BEGIN
      cLsearch_str := '^[0-9A-Z].*';
        END;
      ELSE
        BEGIN
      cLsearch_str := '^[' || cPinitial || '].*';
        END;
      END IF;
    END IF;

    IF iPdept_id = 4350 THEN /* outlet section = outlet + books dept */
      BEGIN
        iLdept_id2 := 6;
      END;
    END IF;

    cLsearch_str_lower := lower(cLsearch_str);

    OPEN curPresult1 FOR
    SELECT a.artist_id,al.lastname_u || al.firstname_u || al.akaname_u
    FROM
      ya_artist a,
      ya_popular_artist pa,
      ya_artist_dept ad,
      ya_artist_lang al
    WHERE pa.artist_id = a.artist_id
    AND pa.dept_id IN (iPdept_id, iLdept_id2)
    AND a.gender = cPgender
    AND ad.artist_id = a.artist_id
    AND ad.dept_id = pa.dept_id
    AND ((CASE cLsite_prefix
      WHEN 'us' THEN ad.us_enabled
      WHEN 'us_ws' THEN ad.us_ws_enabled
      WHEN 'jp' THEN ad.jp_enabled
      WHEN 'jp_ws' THEN ad.jp_ws_enabled
      WHEN 'hk' THEN ad.hk_enabled
      WHEN 'hk_ws' THEN ad.hk_ws_enabled
      WHEN 'tw' THEN ad.tw_enabled
      WHEN 'tw_ws' THEN ad.tw_ws_enabled
      ELSE 'Y'  END)='Y')
    AND al.artist_id = a.artist_id
    AND al.lang_id = 1
    AND
      (
        regexp_like((al.lastname_u || al.firstname_u || al.akaname_u), cLsearch_str)
        OR regexp_like((al.lastname_u || al.firstname_u || al.akaname_u), cLsearch_str_lower)
      )
    ORDER BY al.lastname_u || al.firstname_u || al.akaname_u;
    RETURN;
  END GetPopularArtistByInitial;


  PROCEDURE GetDeptIDListByArtistID (
    iPartist_id IN INT,
    iPsite_id IN INT,
    curPresult1 OUT curG
  )
  AS
    cLsite_prefix VARCHAR2(10);
  BEGIN
    cLsite_prefix :=
      CASE iPsite_id
      WHEN 1 THEN 'us'
      WHEN 2 THEN 'us_ws'
      WHEN 3 THEN 'jp'
      WHEN 4 THEN 'jp_ws'
      WHEN 5 THEN 'hk'
      WHEN 6 THEN 'hk_ws'
      WHEN 7 THEN 'tw'
      WHEN 8 THEN 'tw_ws'
      ELSE 'us'
      END;

    OPEN curPresult1 FOR
    SELECT dept_id
    FROM ya_artist_dept ad
    WHERE ad.artist_id = iPartist_id
    AND ad.dept_id <> 0
    AND ((CASE cLsite_prefix
      WHEN 'us' THEN ad.us_enabled
      WHEN 'us_ws' THEN ad.us_ws_enabled
      WHEN 'jp' THEN ad.jp_enabled
      WHEN 'jp_ws' THEN ad.jp_ws_enabled
      WHEN 'hk' THEN ad.hk_enabled
      WHEN 'hk_ws' THEN ad.hk_ws_enabled
      WHEN 'tw' THEN ad.tw_enabled
      WHEN 'tw_ws' THEN ad.tw_ws_enabled
      ELSE 'Y'  END)='Y')
    ORDER BY ad.dept_id;
    RETURN;
  END GetDeptIDListByArtistID;


  PROCEDURE GetArtistPreferableDept (
    iPartist_id IN INT,
    iPsite_id IN INT,
    iPdept_id OUT INT
  )
  AS
  BEGIN
    IF iPsite_id = 1 THEN
      BEGIN
--        OPEN curPresult1 FOR
        SELECT
          dept_id
        INTO
          iPdept_id
        FROM
          (
            SELECT
              pd.dept_id
            FROM
              ya_prod_dept pd,
              ya_product_artist pa
            WHERE
              pd.sku = pa.sku
              AND pa.artist_id = iPartist_id
              AND pd.us_enabled = 'Y'
              AND dept_id IN
                (
                  83,7,106,163,164,97,160,161,848,162,
                  91,165,166,2941,167,156,168,169,170,
                  4407,5,1344,10,4360,3923,3588,3591,
                  6391,7153,9945,7448,7314,7711,7936
                )
            GROUP BY pd.dept_id
            ORDER BY COUNT(1) DESC, pd.dept_id
          )
        WHERE ROWNUM = 1;
      END;
    ELSE
      BEGIN
--        OPEN curPresult1 FOR
        SELECT
          dept_id
        INTO
          iPdept_id
        FROM
          (
            SELECT
              pd.dept_id
            FROM
              ya_prod_dept pd,
              ya_product_artist pa
            WHERE
              pd.sku = pa.sku
              AND pa.artist_id = iPartist_id
              AND pd.tw_enabled = 'Y'
              AND dept_id IN
              (
                83,7,106,163,164,97,160,161,848,162,
                91,165,166,2941,167,156,168,169,170,
                4407,5,1344,10,4360,3923,3588,3591,
                6391,7153,9945,7448,7314,7711,7936
              )
            GROUP BY pd.dept_id
            ORDER BY COUNT(1) DESC, pd.dept_id
          )
        WHERE ROWNUM = 1;
      END;
    END IF;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    iPdept_id := -1;
  END GetArtistPreferableDept;


  PROCEDURE GetArtistDeptInfo (
    iPartist_id IN INT,
    iProot_dept_id IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPresult1 OUT curG
  )
  AS
    cLsite_prefix VARCHAR2(10);
  BEGIN
  /* Gets the child departments info of any root department(music, videos etc) of a given artist */
    cLsite_prefix :=
      CASE iPsite_id
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'us_ws'
        WHEN 3 THEN 'jp'
        WHEN 4 THEN 'jp_ws'
        WHEN 5 THEN 'hk'
        WHEN 6 THEN 'hk_ws'
        WHEN 7 THEN 'tw'
        WHEN 8 THEN 'tw_ws'
        ELSE 'us'
      END;

    OPEN curPresult1 FOR
    SELECT
      ad.artist_id,
      ad.dept_id,
      ad.us_enabled,
      ad.hk_enabled,
      ad.jp_enabled,
      ad.tw_enabled,
      ad.us_ws_enabled,
      NVL(dl.dept_name, dl2.dept_name)
    FROM
      ya_artist_dept ad
      LEFT OUTER JOIN ya_dept_lang dl ON
        ad.dept_id = dl.dept_id
        AND dl.lang_id = iPlang_id
      LEFT OUTER JOIN ya_dept_lang dl2 ON
        dl2.dept_id = dl.dept_id
        AND dl2.lang_id = 1
    WHERE
      ad.artist_id = iPartist_id
      AND ad.dept_id IN
        (
          SELECT dept_id
          FROM ya_dept_rel
          WHERE parent_dept_id = iProot_dept_id
        )
      AND
      (
        (
          CASE cLsite_prefix
            WHEN 'us' THEN ad.us_enabled
            WHEN 'us_ws' THEN ad.us_ws_enabled
            WHEN 'jp' THEN ad.jp_enabled
            WHEN 'jp_ws' THEN ad.jp_ws_enabled
            WHEN 'hk' THEN ad.hk_enabled
            WHEN 'hk_ws' THEN ad.hk_ws_enabled
            WHEN 'tw' THEN ad.tw_enabled
            WHEN 'tw_ws' THEN ad.tw_ws_enabled
            ELSE 'Y'
          END
        ) = 'Y'
      );

    RETURN;
  END GetArtistDeptInfo;

  PROCEDURE GetArtistBio (
    iPartistId IN INT,
    iPlangId IN INT,
    curPartist OUT curG
  )
  AS
  BEGIN
    OPEN curPartist FOR
    SELECT a.artist_id, fullname AS fullname,
      bio AS bio, img_loc AS img_loc, img_width, img_height
      FROM ya_artist_image a, ya_artist_lang c
     WHERE a.artist_id = c.artist_id
       AND a.type      = 4
       AND a.artist_id = iPartistId
       AND c.lang_id   = iPlangId;
  END GetArtistBio;

  PROCEDURE GetArtistHighlightPool (
    iPlangId IN INT,
    curPartist OUT curG
  )
  AS
  BEGIN
    OPEN curPartist FOR
    SELECT a.artist_id,fullname AS fullname,
      bio AS bio, img_loc AS img_loc, img_width, img_height
      FROM ya_artist_image a, ya_toys_character_pool b, ya_artist_lang c
     WHERE a.artist_id = b.artist_id
       AND a.artist_id = c.artist_id
       AND a.type      = 5
       AND c.lang_id   = iPlangId
     ORDER BY b.priority;
  END GetArtistHighlightPool;

  PROCEDURE GetArtistPool (
    iPlangId IN INT,
    iPdeptId IN INT,
    curPartist OUT curG
  )
  AS
  BEGIN
    IF (iPdeptId > 0) THEN
      OPEN curPartist FOR
      SELECT a.artist_id,
        fullname as fullname,
        bio as bio,
        img_loc as img_loc,
        img_width, img_height
      FROM ya_artist_image a, ya_artist_lang c, ya_artist_dept d
      WHERE a.artist_id=c.artist_id AND a.artist_id = d.artist_id
      AND a.type=5 AND c.lang_id=iPlangId AND d.dept_id = iPdeptId;
    ELSE
      OPEN curPartist FOR
      SELECT a.artist_id,
        fullname as fullname,
        bio as bio,
        img_loc as img_loc,
        img_width, img_height
      FROM ya_artist_image a, ya_artist_lang c
      WHERE a.artist_id=c.artist_id
      AND a.type=5 AND c.lang_id=iPlangId;
    END IF;
  END GetArtistPool;

  PROCEDURE IsShowBrowsePage (
    iPartistId IN INT,
    iPshowBit OUT INT
  )
  AS
  BEGIN
    SELECT 1 INTO iPshowBit
     FROM ya_toys_browse_page
    WHERE artist_id = iPartistId;

  EXCEPTION
    WHEN no_data_found THEN
      iPshowBit := 0;
  END IsShowBrowsePage;


  PROCEDURE GetArtistSetByDept (
    iPdeptId IN INT,
    iPpublisherId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    cPgender IN CHAR,
    curPartist OUT curG
    --@gender : M - Male, F - Female, G - Group, C -- Toys Character
  )
  AS
    cLsitePrefix VARCHAR2(10);
  BEGIN

    SELECT CASE iPsiteId
      WHEN 1 THEN 'us'
      WHEN 2 THEN 'us_ws'
      WHEN 3 THEN 'jp'
      WHEN 4 THEN 'jp_ws'
      WHEN 5 THEN 'hk'
      WHEN 6 THEN 'hk_ws'
      WHEN 7 THEN 'tw'
      WHEN 8 THEN 'tw_ws'
      ELSE 'us'
      END INTO cLsitePrefix FROM dual;

    IF (iPpublisherId > 0) THEN
      OPEN curPartist FOR
      SELECT a.artist_id, al.firstname_u AS e_firstname_u,  al.lastname_u AS e_lastname_u,
        al.akaname_u AS e_akaname_u,
       al2.firstname_u,  al2.lastname_u,  al2.akaname_u,
       al3.name_img_loc, NVL(al3.name_img_width, -1), NVL(al3.name_img_height, -1),
       NVL(a.origin_country_id, 0), NVL(al3.lang_id, 0),
       al2.prefix, al2.suffix,  al.prefix, al.suffix
           FROM ya_artist a
           INNER JOIN ya_publisher_artist pa ON a.artist_id = pa.artist_id
            AND pa.publisher_id = iPpublisherId
           INNER JOIN (
              SELECT al.lang_id, al.artist_id, al.firstname_u, al.lastname_u, al.akaname_u,
                al.suffix, al.prefix
              FROM ya_artist_lang al
              INNER JOIN ya_artist_dept ad ON ad.artist_id=al.artist_id AND dept_id = iPdeptId AND
                 ((CASE cLsitePrefix
                 WHEN 'us' THEN ad.us_enabled
                 WHEN 'us_ws' THEN ad.us_ws_enabled
                 WHEN 'jp' THEN ad.jp_enabled
                 WHEN 'jp_ws' THEN ad.jp_ws_enabled
                 WHEN 'hk' THEN ad.hk_enabled
                 WHEN 'hk_ws' THEN ad.hk_ws_enabled
                 WHEN 'tw' THEN ad.tw_enabled
                 WHEN 'tw_ws' THEN ad.tw_ws_enabled
                 ELSE 'Y'  END)='Y')
              WHERE
              al.lang_id IN (1, iPlangId)
           ) al ON al.artist_id = a.artist_id AND  al.lang_id=1 AND a.gender=cPgender
           LEFT JOIN ya_artist_lang al2 ON al.artist_id=al2.artist_id AND al2.lang_id=iPlangId
           /*
           LEFT JOIN ya_artist_lang al3 ON al.artist_id=al3.artist_id AND al3.lang_id IN
           (SELECT lang_id FROM ya_artist_lang WHERE artist_id=al3.artist_id
             AND preferred_flag='Y' AND ROWNUM = 1)
           */
           -- experimental code to replace the commented code above
           LEFT JOIN (
            SELECT name_img_loc, name_img_width, name_img_height, lang_id, artist_id
            FROM ya_artist_lang
            WHERE preferred_flag='Y'
           ) al3 ON al.artist_id=al3.artist_id AND ROWNUM = 1
           ORDER BY al.lastname_u || al.firstname_u || al.akaname_u;
    ELSE
      OPEN curPartist FOR
      SELECT a.artist_id, al.firstname_u AS e_firstname_u,  al.lastname_u AS e_lastname_u,
        al.akaname_u AS e_akaname_u,
       al2.firstname_u,  al2.lastname_u,  al2.akaname_u,
       al3.name_img_loc, NVL(al3.name_img_width, -1), NVL(al3.name_img_height, -1),
       NVL(a.origin_country_id, 0), NVL(al3.lang_id, 0),
       al2.prefix, al2.suffix,  al.prefix, al.suffix
           FROM ya_artist a
           INNER JOIN (
              SELECT al.lang_id, al.artist_id, al.firstname_u, al.lastname_u, al.akaname_u,
                al.suffix, al.prefix
              FROM ya_artist_lang al
              INNER JOIN ya_artist_dept ad ON ad.artist_id=al.artist_id AND dept_id = iPdeptId AND
                 ((CASE cLsitePrefix
                 WHEN 'us' THEN ad.us_enabled
                 WHEN 'us_ws' THEN ad.us_ws_enabled
                 WHEN 'jp' THEN ad.jp_enabled
                 WHEN 'jp_ws' THEN ad.jp_ws_enabled
                 WHEN 'hk' THEN ad.hk_enabled
                 WHEN 'hk_ws' THEN ad.hk_ws_enabled
                 WHEN 'tw' THEN ad.tw_enabled
                 WHEN 'tw_ws' THEN ad.tw_ws_enabled
                 ELSE 'Y'  END)='Y')
              WHERE
              al.lang_id IN (1, iPlangId)
           ) al ON al.artist_id = a.artist_id AND  al.lang_id=1 AND a.gender=cPgender
           LEFT JOIN ya_artist_lang al2 ON al.artist_id=al2.artist_id AND al2.lang_id=iPlangId
/*           LEFT JOIN ya_artist_lang al3 ON al.artist_id=al3.artist_id AND al3.lang_id IN
           (SELECT lang_id FROM ya_artist_lang WHERE artist_id=al3.artist_id
             AND preferred_flag='Y' AND ROWNUM = 1)
*/
           -- experimental code to replace the commented code above
           LEFT JOIN (
            SELECT name_img_loc, name_img_width, name_img_height, lang_id, artist_id
            FROM ya_artist_lang
            WHERE preferred_flag='Y'
           ) al3 ON al.artist_id=al3.artist_id AND ROWNUM = 1
           ORDER BY al.lastname_u || al.firstname_u || al.akaname_u;
    END IF;
  END GetArtistSetByDept;

END Pkg_FE_ArtistAccess;
/

