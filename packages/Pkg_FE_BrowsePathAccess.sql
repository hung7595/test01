CREATE OR REPLACE PACKAGE Pkg_FE_BrowsePathAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE FillBrowsePath (
    iPdept_id IN INT,
    iPattribute_id IN INT,
    iPartist_id IN INT,
    iPlang_id IN INT,
    iPpublisher_id IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG,
    curPresult3 OUT curG,
    curPresult4 OUT curG
  );
END Pkg_FE_BrowsePathAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_BrowsePathAccess
IS
  PROCEDURE FillBrowsePath (
    iPdept_id IN INT,
    iPattribute_id IN INT,
    iPartist_id IN INT,
    iPlang_id IN INT,
    iPpublisher_id IN INT,
    curPresult1 OUT curG,
    curPresult2 OUT curG,
    curPresult3 OUT curG,
    curPresult4 OUT curG
  )
  AS
  BEGIN
    /* Get Attribute Info */
    OPEN curPresult1 FOR
    SELECT
      al.attribute_id,
      NVL(al.attribute_name, ale.attribute_name) AS attribute_name
    FROM
      ya_attribute_lang al,
      ya_attribute_lang ale
    WHERE
      al.attribute_id = iPattribute_id
      AND al.lang_Id = iPlang_id
      AND ale.attribute_id = iPattribute_id
      AND ale.lang_Id = 1;

    /* Get Department Path */
    OPEN curPresult2 FOR
    SELECT
      dp.dept_id,
      NVL(dl.dept_name, dle.dept_name) AS dept_name,
      '' as page_location
    FROM
      ya_browse_dept_path dp,
      ya_dept dpt,
      ya_dept_lang dle,
      ya_dept_lang dl
    WHERE
      dp.terminal_dept_id = iPdept_id
      AND dl.lang_id = iPlang_id
      AND dle.lang_id = 1 /* English */
      AND dp.dept_id = dle.dept_id
      AND dp.dept_id = dl.dept_id
      AND dp.dept_id = dpt.dept_id
      ORDER BY dp.node_sequence_id DESC;

    /* Get Artist Path */
    OPEN curPresult3 FOR
    SELECT
      CASE a.origin_country_id
        WHEN 44 THEN 'C' /* C=Chinese, J=Japanese, K=Korean, W=Western */
        WHEN 98 THEN 'C'
        WHEN 191 THEN 'C'
        WHEN 209 THEN 'C'
        WHEN 109 THEN 'J'
        WHEN 114 THEN 'K'
        WHEN 115 THEN 'K'
        ELSE 'W'
      END AS artist_origin,
      NVL(a.gender, 'O') AS gender,
      NVL(SUBSTR(LTRIM(ale.lastname_u), 0, 1), 'A') AS alphabetical_group,
      CASE
        WHEN (al.lastname_u || al.firstname_u || al.akaname_u) IS NULL
        THEN ale.lastname_u
        ELSE al.lastname_u
      END AS lastname,
      CASE
        WHEN (al.lastname_u || al.firstname_u || al.akaname_u) IS NULL
        THEN ale.firstname_u
        ELSE al.firstname_u
      END AS firstname,
      CASE
        WHEN (al.lastname_u || al.firstname_u || al.akaname_u) IS NULL
        THEN ale.akaname_u
        ELSE al.akaname_u
      END AS akaname,
      CAST(a.origin_country_id AS INT) AS origin_country_id
    FROM ya_artist a,
         ya_artist_lang al,
         ya_artist_lang ale
    WHERE
      a.artist_id = al.artist_id
      AND a.artist_id = ale.artist_id
      AND ale.lang_id = 1 /* English */
      AND al.lang_id = iPlang_id
      AND a.artist_id = iPartist_id;

    /* Get Publisher Info */
    OPEN curPresult4 FOR
    SELECT al.publisher_id, NVL(al.publisher_name_u, ale.publisher_name_u) as publisher_name
      FROM ya_publisher_lang al,
           ya_publisher_lang ale
     WHERE al.publisher_id = iPpublisher_id
       AND al.lang_id = iPlang_id
       AND ale.publisher_id = iPpublisher_id
       AND ale.lang_id = 1 /* English */;

  END FillBrowsePath;
END Pkg_FE_BrowsePathAccess;
/

