CREATE OR REPLACE PACKAGE Pkg_FE_PromotionContentAccess
AS
  TYPE refCur IS REF CURSOR;

  /* proc_fe_GetPromotionContent */
  PROCEDURE GetPromotionContent (
    iPweb IN INT,
    iPrecord_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPencoding IN VARCHAR2,
    iPget_all IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  );

  PROCEDURE GetPromotionContent_Mirror (
    iPweb IN INT,
    iPrecord_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPencoding IN VARCHAR2,
    iPget_all IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  );

  /* proc_fe_storyboard_get_content */
  PROCEDURE GetStoryBoardContent (
    iPsku IN INT,
    iPtype IN INT,
    cPparam IN VARCHAR2,
    curPresult OUT refCur
  );

  /* proc_fe_storyboard_get_prod_lang */
  PROCEDURE GetStoryBoard (
    iPsku IN  INT,
    iPtype IN INT,
    iPlang_id IN INT,
    curPresult OUT refCur
  );

  /* new sp to solve the complicated GetPromotionContent sp */
  PROCEDURE GetPromotionContentCombination (
    curPresult OUT refCur
  );

  PROCEDURE GetPromotionContentByID (
    iPid IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult OUT refCur
  );
END Pkg_FE_PromotionContentAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_PromotionContentAccess
AS
  PROCEDURE GetPromotionContent (
    iPweb IN INT,
    iPrecord_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPencoding IN VARCHAR2,
    iPget_all IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  )
  AS
  BEGIN
    IF (iPweb <> 1) THEN
      BEGIN
        IF (iPrecord_id = -1 AND iPlang_id = -1) THEN
          BEGIN
            OPEN curPresult1 FOR
            SELECT
              proi.id,
              proi.combination_id,
              pc.site_id,
              proi.keyword,
              ppc.id
            FROM
              ya_promotion_iden proi
              INNER JOIN ya_promotion_content pc ON
                (
                  proi.id = pc.id
                  AND pc.lang_id = 1
                )
              LEFT OUTER JOIN ya_promotion_content ppc ON
                (
                  ppc.id = proi.id
                  AND ppc.lang_id = 1
                )
            ORDER BY proi.id DESC;
          END;
        ELSE
          IF (iPlang_id = -1) THEN -- poccess record id
            BEGIN
              OPEN curPresult1 FOR
              SELECT
                content,
                i.keyword
              FROM
                ya_promotion_content c,
                ya_promotion_iden i
              WHERE
                c.id = i.id
                AND c.id = iPrecord_id
              ORDER BY c.lang_ID;
            END;
          ELSE -- has both record id and lang id
            BEGIN
              OPEN curPresult1 FOR
              SELECT
                c.content,
                i.keyword
              FROM
                ya_promotion_content c,
                ya_promotion_iden  i
              WHERE
                c.id = i.id
                AND c.id = iPrecord_id
                AND lang_id = iPlang_id;
            END;
          END IF;
        END IF;
      END;
    ELSE
      IF (iPweb = 1) THEN -- select the content depends on siteID, langID and encoding
        BEGIN
          IF (iPrecord_id = -1) THEN
            BEGIN
              IF (iPget_all = -1) THEN
                BEGIN
                  OPEN curPresult1 FOR
                  SELECT content
                  FROM
                    ya_promotion_content pc,
                    ya_promotion_iden proi
                  WHERE
                    REGEXP_INSTR (
                                   lower(cPencoding),
                                   lower(REPLACE(REPLACE(proi.combination_id, '|', '\|'), '%', '([^|]*\|)*'))
                                 ) > 0
                    AND proi.id = pc.id
                    AND pc.lang_id = iPlang_id
                    AND
                      (
                        pc.site_id = iPsite_id
                        OR pc.site_id = 99
                      );
                END;
              ELSE
                IF (iPget_all = 1) THEN
                  BEGIN
                    OPEN curPresult1 FOR
                    SELECT content
                    FROM
                      ya_promotion_content pc,
                      ya_promotion_iden proi
                    WHERE
                      REGEXP_INSTR (
                                     (lower(cPencoding)||'loc=header'),
                                     lower(REPLACE(REPLACE(proi.combination_id, '|', '\|'), '%', '([^|]*\|)*'))
                                   ) > 0
                      AND proi.id = pc.id
                      AND pc.lang_id = iPlang_id
                      AND
                        (
                          pc.site_id = iPsite_id
                          OR pc.site_id = 99
                        );

                    OPEN curPresult2 FOR
                    SELECT content
                    FROM
                      ya_promotion_content pc,
                      ya_promotion_iden proi
                    WHERE
                      REGEXP_INSTR (
                                     (lower(cPencoding)||'loc=footer'),
                                     lower(REPLACE(REPLACE(proi.combination_id, '|', '\|'), '%', '([^|]*\|)*'))
                                   ) > 0
                      AND proi.id = pc.id
                      AND pc.lang_id = iPlang_id
                      AND
                        (
                          pc.site_id = iPsite_id
                          OR pc.site_id = 99
                        );
                  END;
                END IF;
              END IF;
            END;
          END IF;
        END;
      END IF;
    END IF;

    RETURN;
  END GetPromotionContent;



  PROCEDURE GetPromotionContent_Mirror (
    iPweb IN INT,
    iPrecord_id IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    cPencoding IN VARCHAR2,
    iPget_all IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  )
  AS
  BEGIN
    IF (iPweb <> 1) THEN
      BEGIN
        IF (iPrecord_id = -1 AND iPlang_id = -1) THEN
          BEGIN
            OPEN curPresult1 FOR
            SELECT
              proi.id,
              proi.combination_id,
              pc.site_id,
              proi.keyword,
              ppc.id
            FROM
              ya_promotion_iden proi
              INNER JOIN ya_mirror_promotion_content pc ON
                (
                  proi.id = pc.id
                  AND pc.lang_id = 1
                )
              LEFT OUTER JOIN ya_promotion_content ppc ON
                (
                  ppc.id = proi.id
                  AND ppc.lang_id = 1
                )
            ORDER BY proi.id DESC;
          END;
        ELSE
          IF (iPlang_id = -1) THEN -- poccess record id
            BEGIN
              OPEN curPresult1 FOR
              SELECT
                content,
                i.keyword
              FROM
                ya_mirror_promotion_content c,
                ya_promotion_iden i
              WHERE
                c.id = i.id
                AND c.id = iPrecord_id
              ORDER BY c.lang_ID;
            END;
          ELSE -- has both record id and lang id
            BEGIN
              OPEN curPresult1 FOR
              SELECT
                c.content,
                i.keyword
              FROM
                ya_mirror_promotion_content c,
                ya_promotion_iden  i
              WHERE
                c.id = i.id
                AND c.id = iPrecord_id
                AND lang_id = iPlang_id;
            END;
          END IF;
        END IF;
      END;
    ELSE
      IF (iPweb = 1) THEN -- select the content depends on siteID, langID and encoding
        BEGIN
          IF (iPrecord_id = -1) THEN
            BEGIN
              IF (iPget_all = -1) THEN
                BEGIN
                  OPEN curPresult1 FOR
                  SELECT content
                  FROM
                    ya_mirror_promotion_content pc,
                    ya_promotion_iden proi
                  WHERE
                    REGEXP_INSTR (
                                   cPencoding,
                                   lower(REPLACE(REPLACE(proi.combination_id, '|', '\|'), '%', '([^|]*\|)*'))
                                 ) > 0
                    AND proi.id = pc.id
                    AND pc.lang_id = iPlang_id
                    AND
                      (
                        pc.site_id = iPsite_id
                        OR pc.site_id = 99
                      );
                END;
              ELSE
                IF (iPget_all = 1) THEN
                  BEGIN
                    OPEN curPresult1 FOR
                    SELECT content
                    FROM
                      ya_mirror_promotion_content pc,
                      ya_promotion_iden proi
                    WHERE
                      REGEXP_INSTR (
                                     (cPencoding||'loc=header'),
                                     lower(REPLACE(REPLACE(proi.combination_id, '|', '\|'), '%', '([^|]*\|)*'))
                                   ) > 0
                      AND proi.id = pc.id
                      AND pc.lang_id = iPlang_id
                      AND
                        (
                          pc.site_id = iPsite_id
                          OR pc.site_id = 99
                        );

                    OPEN curPresult2 FOR
                    SELECT content
                    FROM
                      ya_mirror_promotion_content pc,
                      ya_promotion_iden proi
                    WHERE
                      REGEXP_INSTR (
                                     (cPencoding||'loc=footer'),
                                     lower(REPLACE(REPLACE(proi.combination_id, '|', '\|'), '%', '([^|]*\|)*'))
                                   ) > 0
                      AND proi.id = pc.id
                      AND pc.lang_id = iPlang_id
                      AND
                        (
                          pc.site_id = iPsite_id
                          OR pc.site_id = 99
                        );
                  END;
                END IF;
              END IF;
            END;
          END IF;
        END;
      END IF;
    END IF;

    RETURN;
  END GetPromotionContent_Mirror;



  PROCEDURE GetStoryBoardContent (
    iPsku IN INT,
    iPtype IN INT,
    cPparam IN VARCHAR2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    IF cPparam IS NOT NULL THEN
      OPEN curPresult FOR
      SELECT html_content
      FROM ya_storyboard_content
      WHERE
        sku = iPsku
        AND type = iPtype
        AND cPparam = parameter;
    ELSE
      OPEN curPresult FOR
      SELECT html_content
      FROM ya_storyboard_content
      WHERE
        sku = iPsku
        AND type = iPtype
        AND parameter IS NULL;
    END IF;
    RETURN;
  END GetStoryBoardContent;



  PROCEDURE GetStoryBoard (
    iPsku IN  INT,
    iPtype IN INT,
    iPlang_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      contentkey,
      content
    FROM ya_storyboard_lang
    WHERE
      sku = iPsku
      AND lang_id = iPlang_id
      AND type = iPtype;
    RETURN;
  END GetStoryBoard;




  PROCEDURE GetPromotionContentCombination (
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT id, combination_id
    FROM ya_promotion_iden;
    RETURN;
  END GetPromotionContentCombination;

  PROCEDURE GetPromotionContentByID (
    iPid IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT content
    FROM
      ya_promotion_content pc
    WHERE
      pc.id = iPid
      AND  pc.lang_id = iPlang_id
      AND (pc.site_id = iPsite_id OR pc.site_id = 99);
    RETURN;
  END GetPromotionContentByID;

END Pkg_FE_PromotionContentAccess;
/

