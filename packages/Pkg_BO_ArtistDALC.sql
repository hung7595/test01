CREATE OR REPLACE package Pkg_bo_AttributeDalc
AS
  TYPE curGgetAttribute IS REF CURSOR;
  PROCEDURE GetAttributes (
    curPgetAttributes	OUT	curGgetAttribute,
    iPattribute_id1	IN	INT DEFAULT NULL,
    iPattribute_id2	IN	INT DEFAULT NULL,
    iPattribute_id3	IN	INT DEFAULT NULL,
    iPattribute_id4	IN	INT DEFAULT NULL,
    iPattribute_id5	IN	INT DEFAULT NULL,
    iPattribute_id6	IN	INT DEFAULT NULL,
    iPattribute_id7	IN	INT DEFAULT NULL,
    iPattribute_id8	IN	INT DEFAULT NULL,
    iPattribute_id9	IN	INT DEFAULT NULL,
    iPattribute_id10	IN	INT DEFAULT NULL,
    iPattribute_id11	IN	INT DEFAULT NULL,
    iPattribute_id12	IN	INT DEFAULT NULL,
    iPattribute_id13	IN	INT DEFAULT NULL,
    iPattribute_id14	IN	INT DEFAULT NULL,
    iPattribute_id15	IN	INT DEFAULT NULL,
    iPattribute_id16	IN	INT DEFAULT NULL,
    iPattribute_id17	IN	INT DEFAULT NULL,
    iPattribute_id18	IN	INT DEFAULT NULL,
    iPattribute_id19	IN	INT DEFAULT NULL,
    iPattribute_id20	IN	INT DEFAULT NULL
  );

  PROCEDURE GetAttribute (
    iPattribute_id IN  INT,
    curPgetAttribute  OUT curGgetAttribute
  );
END Pkg_bo_AttributeDalc;
/
CREATE OR REPLACE package body Pkg_bo_AttributeDalc
IS
--body ---+
  PROCEDURE GetAttributes (
    curPgetAttributes	OUT	curGgetAttribute,
    iPattribute_id1	IN	INT DEFAULT NULL,
    iPattribute_id2	IN	INT DEFAULT NULL,
    iPattribute_id3	IN	INT DEFAULT NULL,
    iPattribute_id4	IN	INT DEFAULT NULL,
    iPattribute_id5	IN	INT DEFAULT NULL,
    iPattribute_id6	IN	INT DEFAULT NULL,
    iPattribute_id7	IN	INT DEFAULT NULL,
    iPattribute_id8	IN	INT DEFAULT NULL,
    iPattribute_id9	IN	INT DEFAULT NULL,
    iPattribute_id10	IN	INT DEFAULT NULL,
    iPattribute_id11	IN	INT DEFAULT NULL,
    iPattribute_id12	IN	INT DEFAULT NULL,
    iPattribute_id13	IN	INT DEFAULT NULL,
    iPattribute_id14	IN	INT DEFAULT NULL,
    iPattribute_id15	IN	INT DEFAULT NULL,
    iPattribute_id16	IN	INT DEFAULT NULL,
    iPattribute_id17	IN	INT DEFAULT NULL,
    iPattribute_id18	IN	INT DEFAULT NULL,
    iPattribute_id19	IN	INT DEFAULT NULL,
    iPattribute_id20	IN	INT DEFAULT NULL
  )
AS
BEGIN
  OPEN curPgetAttributes FOR
    SELECT
      CAST(attribute_type_id as INT) AS attribute_type_id,
      al1.attribute_name AS en_attribute_name,
      al2.attribute_name AS b5_attribute_name,
      al3.attribute_name AS jp_attribute_name,
      al4.attribute_name AS kr_attribute_name,
      al5.attribute_name AS gb_attribute_name,
      a.img_loc AS img_loc,
      CAST(NVL(a.img_height, 0) AS INT) AS img_height,
      CAST(NVL(a.img_width, 0) AS INT) AS img_width,
      a.attribute_id

    FROM ya_attribute a,
      (
      SELECT * FROM ya_attribute_lang al1
      WHERE al1.lang_id = 1
      ) al1,
      (
      SELECT * FROM ya_attribute_lang al2
      WHERE al2.lang_id = 2
      ) al2,
      (
      SELECT * FROM ya_attribute_lang al3
      WHERE al3.lang_id = 3
      ) al3,
      (
      SELECT * FROM ya_attribute_lang al4
      WHERE al4.lang_id = 4
      ) al4,
      (
      SELECT * FROM ya_attribute_lang al5
      WHERE al5.lang_id = 5
      ) al5

    WHERE
      a.attribute_id = al1.attribute_id (+)
      AND (a.attribute_id = al2.attribute_id (+))
      AND (a.attribute_id = al3.attribute_id (+))
      AND (a.attribute_id = al4.attribute_id (+))
      AND (a.attribute_id = al5.attribute_id (+))
      AND a.attribute_id IN (
        iPattribute_id1,
        iPattribute_id2,
        iPattribute_id3,
        iPattribute_id4,
        iPattribute_id5,
        iPattribute_id6,
        iPattribute_id7,
        iPattribute_id8,
        iPattribute_id9,
        iPattribute_id10,
        iPattribute_id11,
        iPattribute_id12,
        iPattribute_id13,
        iPattribute_id14,
        iPattribute_id15,
        iPattribute_id16,
        iPattribute_id17,
        iPattribute_id18,
        iPattribute_id19,
        iPattribute_id20
        );
RETURN;
END GetAttributes;


  PROCEDURE GetAttribute (
    iPattribute_id IN  INT,
    curPgetAttribute  OUT curGgetAttribute
    )

    AS
    BEGIN

      OPEN curPgetAttribute FOR
        SELECT
          CAST(a.attribute_type_id AS int) as "attribute_type_id",
          al1.attribute_name as "en_attribute_name",
          al2.attribute_name as "b5_attribute_name",
          al3.attribute_name as "jp_attribute_name",
          al4.attribute_name as "kr_attribute_name",
          al5.attribute_name as "gb_attribute_name",
          a.img_loc as "img_loc",
          CAST(NVL(a.img_height, 0) AS int) as "img_height",
          CAST(NVL(a.img_width, 0) AS int) as "img_width",
          a.attribute_id
        FROM ya_attribute a,
         (
         SELECT * FROM ya_attribute_lang al1
         WHERE (al1.lang_id = 1)
         ) al1,
         (
         SELECT * FROM ya_attribute_lang al2
         WHERE (al2.lang_id = 2)
         ) al2,
         (
         SELECT * FROM ya_attribute_lang al3
         WHERE (al3.lang_id = 3)
         ) al3,
         (
         SELECT * FROM ya_attribute_lang al4
         WHERE (al4.lang_id = 4)
         ) al4,
         (
         SELECT * FROM  ya_attribute_lang al5
         WHERE (al5.lang_id = 5)
         ) al5
       WHERE (al1.attribute_id (+) = a.attribute_id)
         AND ((al2.attribute_id (+) = a.attribute_id))
         AND ((al3.attribute_id (+) = a.attribute_id))
         AND ((al4.attribute_id (+) = a.attribute_id))
         AND ((al5.attribute_id (+) = a.attribute_id))
         AND (a.attribute_id  = iPattribute_id);
       RETURN;
     END GetAttribute;

-- +---body
END Pkg_bo_AttributeDalc;
/

