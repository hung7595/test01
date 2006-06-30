CREATE OR REPLACE PACKAGE Pkg_fe_PublisherAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE GetPublisherSetByDept (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPpublisher OUT curG
  );
END Pkg_fe_PublisherAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_PublisherAccess
IS
  PROCEDURE GetPublisherSetByDept (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPpublisher OUT curG
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

      IF (iPartistId > 0)   THEN
        OPEN curPpublisher FOR
          SELECT p.publisher_id,
             pl1.publisher_name AS e_publisher_name, pl1.publisher_name_u AS e_publisher_name_u,
             pl2.publisher_name AS publisher_name, pl2.publisher_name_u AS publisher_name_u,
             NVL(p.country_id, 0) AS country_id

          FROM ya_publisher p
          INNER JOIN ya_publisher_artist pa ON pa.publisher_id = p.publisher_id AND pa.artist_id = iPartistId
          INNER JOIN (
             SELECT pl.publisher_id, pl.lang_id, pl.publisher_name, pl.publisher_name_u
             FROM ya_publisher_lang pl
             INNER JOIN ya_publisher_dept pd ON pd.publisher_id=pl.publisher_id AND dept_id = iPdeptId
/*
                AND
                ((CASE cLsitePrefix
                WHEN 'us' THEN pd.us_enabled
                WHEN 'us_ws' THEN pd.us_ws_enabled
                WHEN 'jp' THEN pd.jp_enabled
                WHEN 'jp_ws' THEN pd.jp_ws_enabled
                WHEN 'hk' THEN pd.hk_enabled
                WHEN 'hk_ws' THEN pd.hk_ws_enabled
                WHEN 'tw' THEN pd.tw_enabled
                WHEN 'tw_ws' THEN pd.tw_ws_enabled
                ELSE 'Y'  END)='Y')
*/
             WHERE
             pl.lang_id IN (1, iPlangId)
          ) pl1 ON pl1.publisher_id = p.publisher_id AND  pl1.lang_id=1
          LEFT JOIN ya_publisher_lang pl2 ON p.publisher_id=pl2.publisher_id AND pl2.lang_id=iPlangId
          ORDER BY upper(pl2.publisher_name), upper(pl1.publisher_name);
      ELSE
        OPEN curPpublisher FOR
          SELECT p.publisher_id,
             pl1.publisher_name AS e_publisher_name, pl1.publisher_name_u AS e_publisher_name_u,
             pl2.publisher_name AS publisher_name, pl2.publisher_name_u AS publisher_name_u,
             NVL(p.country_id, 0) AS country_id

          FROM ya_publisher p
          INNER JOIN (
             SELECT pl.publisher_id, pl.lang_id, pl.publisher_name, pl.publisher_name_u
             FROM ya_publisher_lang pl
             INNER JOIN ya_publisher_dept pd ON pd.publisher_id=pl.publisher_id AND dept_id = iPdeptId
/*
                AND
                ((CASE cLsitePrefix
                WHEN 'us' THEN pd.us_enabled
                WHEN 'us_ws' THEN pd.us_ws_enabled
                WHEN 'jp' THEN pd.jp_enabled
                WHEN 'jp_ws' THEN pd.jp_ws_enabled
                WHEN 'hk' THEN pd.hk_enabled
                WHEN 'hk_ws' THEN pd.hk_ws_enabled
                WHEN 'tw' THEN pd.tw_enabled
                WHEN 'tw_ws' THEN pd.tw_ws_enabled
                ELSE 'Y'  END)='Y')
*/
             WHERE
             pl.lang_id IN (1, iPlangId)
          ) pl1 ON pl1.publisher_id = p.publisher_id AND  pl1.lang_id=1
          LEFT JOIN ya_publisher_lang pl2 ON p.publisher_id=pl2.publisher_id AND pl2.lang_id=iPlangId
          ORDER BY upper(pl2.publisher_name), upper(pl1.publisher_name);
      END IF;
  END GetPublisherSetByDept;
END Pkg_fe_PublisherAccess;
/

