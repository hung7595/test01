CREATE OR REPLACE PACKAGE Pkg_Fe_Publisheraccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE GetPublisherSetByDept (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPpublisher OUT curG
  );
END Pkg_Fe_Publisheraccess;
/



CREATE OR REPLACE PACKAGE BODY Pkg_Fe_Publisheraccess
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
            pl2.publisher_name AS publisher_name, pl2.publisher_name_u AS publisher_name_u,
            pl1.publisher_name AS e_publisher_name, pl1.publisher_name_u AS e_publisher_name_u,
            NVL(p.country_id, 0) AS country_id
          FROM YA_PUBLISHER p
          INNER JOIN YA_PUBLISHER_ARTIST pa ON pa.publisher_id = p.publisher_id AND pa.artist_id = iPartistId
          INNER JOIN
            (
              SELECT pl.publisher_id, pl.lang_id, pl.publisher_name, pl.publisher_name_u
              FROM YA_PUBLISHER_LANG pl
              INNER JOIN YA_PUBLISHER_DEPT pd ON pd.publisher_id=pl.publisher_id AND dept_id = iPdeptId
              WHERE pl.lang_id = 1
            ) pl1 ON p.publisher_id = pl1.publisher_id
          LEFT JOIN
            (
               SELECT pl.publisher_id, pl.lang_id, pl.publisher_name, pl.publisher_name_u
               FROM YA_PUBLISHER_LANG pl
               INNER JOIN YA_PUBLISHER_DEPT pd ON pd.publisher_id=pl.publisher_id AND dept_id = iPdeptId
               WHERE pl.lang_id = iPlangId
            ) pl2 ON pl1.publisher_id = pl2.publisher_id
          ORDER BY UPPER(pl2.publisher_name), UPPER(pl1.publisher_name);
      ELSE
        OPEN curPpublisher FOR
          SELECT p.publisher_id,
             pl2.publisher_name AS publisher_name, pl2.publisher_name_u AS publisher_name_u,
             pl1.publisher_name AS e_publisher_name, pl1.publisher_name_u AS e_publisher_name_u,
             NVL(p.country_id, 0) AS country_id
          FROM
            YA_PUBLISHER p
          INNER JOIN
            (
               SELECT pl.publisher_id, pl.lang_id, pl.publisher_name, pl.publisher_name_u
               FROM YA_PUBLISHER_LANG pl
               INNER JOIN YA_PUBLISHER_DEPT pd ON pd.publisher_id=pl.publisher_id AND dept_id = iPdeptId
               WHERE
               pl.lang_id = 1
            ) pl1 ON p.publisher_id = pl1.publisher_id
         LEFT JOIN
            (
               SELECT pl.publisher_id, pl.lang_id, pl.publisher_name, pl.publisher_name_u
               FROM YA_PUBLISHER_LANG pl
               INNER JOIN YA_PUBLISHER_DEPT pd ON pd.publisher_id=pl.publisher_id AND dept_id = iPdeptId
               WHERE
               pl.lang_id = iPlangId
            ) pl2 ON pl1.publisher_id = pl2.publisher_id
          ORDER BY UPPER(pl2.publisher_name), UPPER(pl1.publisher_name);
      END IF;
  END GetPublisherSetByDept;
END Pkg_Fe_Publisheraccess;
/
