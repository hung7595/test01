CREATE OR REPLACE PACKAGE Pkg_BO_PublisherDALC
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetPublisherById (
    iPpublisher_id IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetPublishersByIds (
    curPresult OUT refCur,
    iPpublisher_id1 IN INT DEFAULT NULL,
    iPpublisher_id2 IN INT DEFAULT NULL,
    iPpublisher_id3 IN INT DEFAULT NULL,
    iPpublisher_id4 IN INT DEFAULT NULL,
    iPpublisher_id5 IN INT DEFAULT NULL,
    iPpublisher_id6 IN INT DEFAULT NULL,
    iPpublisher_id7 IN INT DEFAULT NULL,
    iPpublisher_id8 IN INT DEFAULT NULL,
    iPpublisher_id9 IN INT DEFAULT NULL,
    iPpublisher_id10 IN INT DEFAULT NULL,
    iPpublisher_id11 IN INT DEFAULT NULL,
    iPpublisher_id12 IN INT DEFAULT NULL,
    iPpublisher_id13 IN INT DEFAULT NULL,
    iPpublisher_id14 IN INT DEFAULT NULL,
    iPpublisher_id15 IN INT DEFAULT NULL,
    iPpublisher_id16 IN INT DEFAULT NULL,
    iPpublisher_id17 IN INT DEFAULT NULL,
    iPpublisher_id18 IN INT DEFAULT NULL,
    iPpublisher_id19 IN INT DEFAULT NULL,
    iPpublisher_id20 IN INT DEFAULT NULL
  );
END Pkg_BO_PublisherDALC;
/

CREATE OR REPLACE PACKAGE BODY Pkg_BO_PublisherDALC
AS
  PROCEDURE GetPublisherById (
    iPpublisher_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      pl1.publisher_name,
      pl2.publisher_name,
      pl3.publisher_name,
      pl4.publisher_name,
      pl5.publisher_name,
      pu.publisher_id
    FROM
      ya_publisher pu
      LEFT OUTER JOIN ya_publisher_lang pl1 ON
        pl1.publisher_id = pu.publisher_id
        AND pl1.lang_id = 1
      LEFT OUTER JOIN ya_publisher_lang pl2 ON
        pl2.publisher_id = pu.publisher_id
        AND pl2.lang_id = 2
      LEFT OUTER JOIN ya_publisher_lang pl3 ON
        pl3.publisher_id = pu.publisher_id
        AND pl3.lang_id = 3
      LEFT OUTER JOIN ya_publisher_lang pl4 ON
        pl4.publisher_id = pu.publisher_id
        AND pl4.lang_id = 4
      LEFT OUTER JOIN ya_publisher_lang pl5 ON
        pl5.publisher_id = pu.publisher_id
        AND pl5.lang_id = 5
    WHERE
      pu.publisher_id = iPpublisher_id;
    RETURN;
  END GetPublisherById;


  PROCEDURE GetPublishersByIds (
    curPresult OUT refCur,
    iPpublisher_id1 IN INT DEFAULT NULL,
    iPpublisher_id2 IN INT DEFAULT NULL,
    iPpublisher_id3 IN INT DEFAULT NULL,
    iPpublisher_id4 IN INT DEFAULT NULL,
    iPpublisher_id5 IN INT DEFAULT NULL,
    iPpublisher_id6 IN INT DEFAULT NULL,
    iPpublisher_id7 IN INT DEFAULT NULL,
    iPpublisher_id8 IN INT DEFAULT NULL,
    iPpublisher_id9 IN INT DEFAULT NULL,
    iPpublisher_id10 IN INT DEFAULT NULL,
    iPpublisher_id11 IN INT DEFAULT NULL,
    iPpublisher_id12 IN INT DEFAULT NULL,
    iPpublisher_id13 IN INT DEFAULT NULL,
    iPpublisher_id14 IN INT DEFAULT NULL,
    iPpublisher_id15 IN INT DEFAULT NULL,
    iPpublisher_id16 IN INT DEFAULT NULL,
    iPpublisher_id17 IN INT DEFAULT NULL,
    iPpublisher_id18 IN INT DEFAULT NULL,
    iPpublisher_id19 IN INT DEFAULT NULL,
    iPpublisher_id20 IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      pl1.publisher_name,
      pl2.publisher_name,
      pl3.publisher_name,
      pl4.publisher_name,
      pl5.publisher_name,
      pu.publisher_id
    FROM
      ya_publisher pu
      LEFT OUTER JOIN ya_publisher_lang pl1 ON
        pl1.publisher_id = pu.publisher_id
        AND pl1.lang_id = 1
      LEFT OUTER JOIN ya_publisher_lang pl2 ON
        pl2.publisher_id = pu.publisher_id
        AND pl2.lang_id = 2
      LEFT OUTER JOIN ya_publisher_lang pl3 ON
        pl3.publisher_id = pu.publisher_id
        AND pl3.lang_id = 3
      LEFT OUTER JOIN ya_publisher_lang pl4 ON
        pl4.publisher_id = pu.publisher_id
        AND pl4.lang_id = 4
      LEFT OUTER JOIN ya_publisher_lang pl5 ON
        pl5.publisher_id = pu.publisher_id
        AND pl5.lang_id = 5
    WHERE
      pu.publisher_id IN
        (
          iPpublisher_id1,
          iPpublisher_id2,
          iPpublisher_id3,
          iPpublisher_id4,
          iPpublisher_id5,
          iPpublisher_id6,
          iPpublisher_id7,
          iPpublisher_id8,
          iPpublisher_id9,
          iPpublisher_id10,
          iPpublisher_id11,
          iPpublisher_id12,
          iPpublisher_id13,
          iPpublisher_id14,
          iPpublisher_id15,
          iPpublisher_id16,
          iPpublisher_id17,
          iPpublisher_id18,
          iPpublisher_id19,
          iPpublisher_id20
        );
    RETURN;
  END GetPublishersByIds;
END Pkg_BO_PublisherDALC;
/

