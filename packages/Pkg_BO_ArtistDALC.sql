CREATE OR REPLACE PACKAGE Pkg_BO_ArtistDALC
AS
  TYPE refCur IS REF CURSOR;

  /* proc_bo_GetMultiArtistInfo */
  PROCEDURE GetMultiArtistInfo (
    curPresult OUT refCur,
    iPartist_id1 IN INT DEFAULT NULL,
    iPartist_id2 IN INT DEFAULT NULL,
    iPartist_id3 IN INT DEFAULT NULL,
    iPartist_id4 IN INT DEFAULT NULL,
    iPartist_id5 IN INT DEFAULT NULL,
    iPartist_id6 IN INT DEFAULT NULL,
    iPartist_id7 IN INT DEFAULT NULL,
    iPartist_id8 IN INT DEFAULT NULL,
    iPartist_id9 IN INT DEFAULT NULL,
    iPartist_id10 IN INT DEFAULT NULL,
    iPartist_id11 IN INT DEFAULT NULL,
    iPartist_id12 IN INT DEFAULT NULL,
    iPartist_id13 IN INT DEFAULT NULL,
    iPartist_id14 IN INT DEFAULT NULL,
    iPartist_id15 IN INT DEFAULT NULL,
    iPartist_id16 IN INT DEFAULT NULL,
    iPartist_id17 IN INT DEFAULT NULL,
    iPartist_id18 IN INT DEFAULT NULL,
    iPartist_id19 IN INT DEFAULT NULL,
    iPartist_id20 IN INT DEFAULT NULL
  );

  /* proc_bo_GetArtistInfo */
  PROCEDURE GetArtistInfo (
    iPartist_id IN INT,
    curPresult OUT refCur
  );
END Pkg_BO_ArtistDALC;
/
CREATE OR REPLACE PACKAGE BODY Pkg_BO_ArtistDALC
AS
  PROCEDURE GetMultiArtistInfo (
    curPresult OUT refCur,
    iPartist_id1 IN INT DEFAULT NULL,
    iPartist_id2 IN INT DEFAULT NULL,
    iPartist_id3 IN INT DEFAULT NULL,
    iPartist_id4 IN INT DEFAULT NULL,
    iPartist_id5 IN INT DEFAULT NULL,
    iPartist_id6 IN INT DEFAULT NULL,
    iPartist_id7 IN INT DEFAULT NULL,
    iPartist_id8 IN INT DEFAULT NULL,
    iPartist_id9 IN INT DEFAULT NULL,
    iPartist_id10 IN INT DEFAULT NULL,
    iPartist_id11 IN INT DEFAULT NULL,
    iPartist_id12 IN INT DEFAULT NULL,
    iPartist_id13 IN INT DEFAULT NULL,
    iPartist_id14 IN INT DEFAULT NULL,
    iPartist_id15 IN INT DEFAULT NULL,
    iPartist_id16 IN INT DEFAULT NULL,
    iPartist_id17 IN INT DEFAULT NULL,
    iPartist_id18 IN INT DEFAULT NULL,
    iPartist_id19 IN INT DEFAULT NULL,
    iPartist_id20 IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      al1.firstname_u AS en_artist_firstname,
      al2.firstname_u AS b5_artist_firstname,
      al3.firstname_u AS jp_artist_firstname,
      al4.firstname_u AS kr_artist_firstname,
      al5.firstname_u AS gb_artist_firstname,
      al1.lastname_u AS en_artist_lastname,
      al2.lastname_u AS b5_artist_lastname,
      al3.lastname_u AS jp_artist_lastname,
      al4.lastname_u AS kr_artist_lastname,
      al5.lastname_u AS gb_artist_lastname,
      al1.akaname_u AS en_artist_akaname,
      al2.akaname_u AS b5_artist_akaname,
      al3.akaname_u AS jp_artist_akaname,
      al4.akaname_u AS kr_artist_akaname,
      al5.akaname_u AS gb_artist_akaname,
      al_img.name_img_loc,
      NVL(al_img.name_img_width, -1),
      NVL(al_img.name_img_height, -1),
      NVL(a.origin_country_id, 0),
      NVL(al_img.lang_id, 0),
      al1.prefix,
      al2.prefix,
      al3.prefix,
      al4.prefix,
      al5.prefix,
      al1.suffix,
      al2.suffix,
      al3.suffix,
      al4.suffix,
      al5.suffix,
      a.artist_id
    FROM
      ya_artist a
      LEFT JOIN ya_artist_lang al1 ON a.artist_id = al1.artist_id AND al1.lang_id = 1
      LEFT JOIN ya_artist_lang al2 ON a.artist_id = al2.artist_id AND al2.lang_id = 2
      LEFT JOIN ya_artist_lang al3 ON a.artist_id = al3.artist_id AND al3.lang_id = 3
      LEFT JOIN ya_artist_lang al4 ON a.artist_id = al4.artist_id AND al4.lang_id = 4
      LEFT JOIN ya_artist_lang al5 ON a.artist_id = al5.artist_id AND al5.lang_id = 5
      LEFT JOIN ya_artist_lang al_img ON a.artist_id = al_img.artist_id AND al_img.lang_id in (select lang_id from ya_artist_lang where artist_id=al_img.artist_id and preferred_flag='Y' AND ROWNUM = 1)
    WHERE
      a.artist_id IN
        (
          iPartist_id1,
          iPartist_id2,
          iPartist_id3,
          iPartist_id4,
          iPartist_id5,
          iPartist_id6,
          iPartist_id7,
          iPartist_id8,
          iPartist_id9,
          iPartist_id10,
          iPartist_id11,
          iPartist_id12,
          iPartist_id13,
          iPartist_id14,
          iPartist_id15,
          iPartist_id16,
          iPartist_id17,
          iPartist_id18,
          iPartist_id19,
          iPartist_id20
        );
    RETURN;
  END GetMultiArtistInfo;



  PROCEDURE GetArtistInfo (
    iPartist_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      al1.firstname_u AS en_artist_firstname,
      al2.firstname_u AS b5_artist_firstname,
      al3.firstname_u AS jp_artist_firstname,
      al4.firstname_u AS kr_artist_firstname,
      al5.firstname_u AS gb_artist_firstname,
      al1.lastname_u AS en_artist_lastname,
      al2.lastname_u AS b5_artist_lastname,
      al3.lastname_u AS jp_artist_lastname,
      al4.lastname_u AS kr_artist_lastname,
      al5.lastname_u AS gb_artist_lastname,
      al1.akaname_u AS en_artist_akaname,
      al2.akaname_u AS b5_artist_akaname,
      al3.akaname_u AS jp_artist_akaname,
      al4.akaname_u AS kr_artist_akaname,
      al5.akaname_u AS gb_artist_akaname,
      al_img.name_img_loc,
      NVL(al_img.name_img_width, -1),
      NVL(al_img.name_img_height, -1),
      NVL(a.origin_country_id, 0),
      NVL(al_img.lang_id, 0),
      al1.prefix,
      al2.prefix,
      al3.prefix,
      al4.prefix,
      al5.prefix,
      al1.suffix,
      al2.suffix,
      al3.suffix,
      al4.suffix,
      al5.suffix,
      a.artist_id
    FROM
      ya_artist a,
      ya_artist_lang al1,
      ya_artist_lang al2,
      ya_artist_lang al3,
      ya_artist_lang al4,
      ya_artist_lang al5,
      (
        SELECT *
        FROM
          ya_artist_lang
        WHERE
          artist_id = iPartist_id
          AND upper(preferred_flag) = 'Y'
          AND ROWNUM = 1
       ) al_img
    WHERE
      1 = 1
      AND a.artist_id = iPartist_id
      AND a.artist_id = al_img.artist_id(+)
      AND a.artist_id = al1.artist_id(+)
      AND (al1.lang_id(+) = 1)
      AND a.artist_id = al2.artist_id(+)
      AND (al2.lang_id(+) = 2)
      AND a.artist_id = al3.artist_id(+)
      AND (al3.lang_id(+) = 3)
      AND a.artist_id = al4.artist_id(+)
      AND (al4.lang_id(+) = 4)
      AND a.artist_id = al5.artist_id(+)
      AND (al5.lang_id(+) = 5);

    RETURN;
  END GetArtistInfo;
END Pkg_BO_ArtistDALC;
/

