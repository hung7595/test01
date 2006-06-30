CREATE OR REPLACE PACKAGE Pkg_BO_AwardDALC
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetMultiEventsByIds (
    curPresult OUT refCur,
    iPevent_id_1 IN INT DEFAULT NULL,
    iPevent_id_2 IN INT DEFAULT NULL,
    iPevent_id_3 IN INT DEFAULT NULL,
    iPevent_id_4 IN INT DEFAULT NULL,
    iPevent_id_5 IN INT DEFAULT NULL,
    iPevent_id_6 IN INT DEFAULT NULL,
    iPevent_id_7 IN INT DEFAULT NULL,
    iPevent_id_8 IN INT DEFAULT NULL,
    iPevent_id_9 IN INT DEFAULT NULL,
    iPevent_id_10 IN INT DEFAULT NULL,
    iPevent_id_11 IN INT DEFAULT NULL,
    iPevent_id_12 IN INT DEFAULT NULL,
    iPevent_id_13 IN INT DEFAULT NULL,
    iPevent_id_14 IN INT DEFAULT NULL,
    iPevent_id_15 IN INT DEFAULT NULL,
    iPevent_id_16 IN INT DEFAULT NULL,
    iPevent_id_17 IN INT DEFAULT NULL,
    iPevent_id_18 IN INT DEFAULT NULL,
    iPevent_id_19 IN INT DEFAULT NULL,
    iPevent_id_20 IN INT DEFAULT NULL
  );

  PROCEDURE GetEventById (
    iPevent_id IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetMultiTitlesByIds (
    curPresult OUT refCur,
    iPtitle_id_1 IN INT DEFAULT NULL,
    iPtitle_id_2 IN INT DEFAULT NULL,
    iPtitle_id_3 IN INT DEFAULT NULL,
    iPtitle_id_4 IN INT DEFAULT NULL,
    iPtitle_id_5 IN INT DEFAULT NULL,
    iPtitle_id_6 IN INT DEFAULT NULL,
    iPtitle_id_7 IN INT DEFAULT NULL,
    iPtitle_id_8 IN INT DEFAULT NULL,
    iPtitle_id_9 IN INT DEFAULT NULL,
    iPtitle_id_10 IN INT DEFAULT NULL,
    iPtitle_id_11 IN INT DEFAULT NULL,
    iPtitle_id_12 IN INT DEFAULT NULL,
    iPtitle_id_13 IN INT DEFAULT NULL,
    iPtitle_id_14 IN INT DEFAULT NULL,
    iPtitle_id_15 IN INT DEFAULT NULL,
    iPtitle_id_16 IN INT DEFAULT NULL,
    iPtitle_id_17 IN INT DEFAULT NULL,
    iPtitle_id_18 IN INT DEFAULT NULL,
    iPtitle_id_19 IN INT DEFAULT NULL,
    iPtitle_id_20 IN INT DEFAULT NULL
  );
END Pkg_BO_AwardDALC;
/

CREATE OR REPLACE PACKAGE BODY Pkg_BO_AwardDALC
AS
  PROCEDURE GetMultiEventsByIds (
    curPresult OUT refCur,
    iPevent_id_1 IN INT DEFAULT NULL,
    iPevent_id_2 IN INT DEFAULT NULL,
    iPevent_id_3 IN INT DEFAULT NULL,
    iPevent_id_4 IN INT DEFAULT NULL,
    iPevent_id_5 IN INT DEFAULT NULL,
    iPevent_id_6 IN INT DEFAULT NULL,
    iPevent_id_7 IN INT DEFAULT NULL,
    iPevent_id_8 IN INT DEFAULT NULL,
    iPevent_id_9 IN INT DEFAULT NULL,
    iPevent_id_10 IN INT DEFAULT NULL,
    iPevent_id_11 IN INT DEFAULT NULL,
    iPevent_id_12 IN INT DEFAULT NULL,
    iPevent_id_13 IN INT DEFAULT NULL,
    iPevent_id_14 IN INT DEFAULT NULL,
    iPevent_id_15 IN INT DEFAULT NULL,
    iPevent_id_16 IN INT DEFAULT NULL,
    iPevent_id_17 IN INT DEFAULT NULL,
    iPevent_id_18 IN INT DEFAULT NULL,
    iPevent_id_19 IN INT DEFAULT NULL,
    iPevent_id_20 IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      ae.region_id,
      ae.priority,
      ae.type_id,
      ael_en.name,
      NVL(ael_b5.name, ael_en.name),
      NVL(ael_jp.name, ael_en.name),
      NVL(ael_kr.name, ael_en.name),
      NVL(ael_gb.name, ael_en.name),
      ae.award_event_id
    FROM
      ya_award_event ae
      INNER JOIN ya_award_lookup award_region ON
        (
          award_region.type = 3
          AND award_region.award_lookup_id = ae.region_id
        )
      INNER JOIN ya_award_lookup award_type ON
        (
          award_type.type = 4
          AND award_type.award_lookup_id = ae.type_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_en ON
        (
          ael_en.lang_id = 1
          AND ael_en.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_b5 ON
        (
          ael_b5.lang_id = 2
          AND ael_b5.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_jp ON
        (
          ael_jp.lang_id = 3
          AND ael_jp.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_kr ON
        (
          ael_kr.lang_id = 4
          AND ael_kr.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_gb ON
        (
          ael_gb.lang_id = 5
          AND ael_gb.award_event_id = ae.award_event_id
        )
    WHERE
      ae.award_event_id IN
        (
          iPevent_id_1,
          iPevent_id_2,
          iPevent_id_3,
          iPevent_id_4,
          iPevent_id_5,
          iPevent_id_6,
          iPevent_id_7,
          iPevent_id_8,
          iPevent_id_7,
          iPevent_id_8,
          iPevent_id_9,
          iPevent_id_10,
          iPevent_id_11,
          iPevent_id_12,
          iPevent_id_13,
          iPevent_id_14,
          iPevent_id_15,
          iPevent_id_16,
          iPevent_id_17,
          iPevent_id_18,
          iPevent_id_19,
          iPevent_id_20
        );
    RETURN;
  END GetMultiEventsByIds;


  PROCEDURE GetEventById (
    iPevent_id IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
     OPEN curPresult FOR
    SELECT
      ae.region_id,
      ae.priority,
      ae.type_id,
      ael_en.name,
      NVL(ael_b5.name, ael_en.name),
      NVL(ael_jp.name, ael_en.name),
      NVL(ael_kr.name, ael_en.name),
      NVL(ael_gb.name, ael_en.name),
      ae.award_event_id
    FROM
      ya_award_event ae
      INNER JOIN ya_award_lookup award_region ON
        (
          award_region.type = 3
          AND award_region.award_lookup_id = ae.region_id
        )
      INNER JOIN ya_award_lookup award_type ON
        (
          award_type.type = 4
          AND award_type.award_lookup_id = ae.type_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_en ON
        (
          ael_en.lang_id = 1
          AND ael_en.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_b5 ON
        (
          ael_b5.lang_id = 2
          AND ael_b5.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_jp ON
        (
          ael_jp.lang_id = 3
          AND ael_jp.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_kr ON
        (
          ael_kr.lang_id = 4
          AND ael_kr.award_event_id = ae.award_event_id
        )
      LEFT OUTER JOIN ya_award_event_lang ael_gb ON
        (
          ael_gb.lang_id = 5
          AND ael_gb.award_event_id = ae.award_event_id
        )
    WHERE
      ae.award_event_id = iPevent_id;
    RETURN;
  END GetEventById;



  PROCEDURE GetMultiTitlesByIds (
    curPresult OUT refCur,
    iPtitle_id_1 IN INT DEFAULT NULL,
    iPtitle_id_2 IN INT DEFAULT NULL,
    iPtitle_id_3 IN INT DEFAULT NULL,
    iPtitle_id_4 IN INT DEFAULT NULL,
    iPtitle_id_5 IN INT DEFAULT NULL,
    iPtitle_id_6 IN INT DEFAULT NULL,
    iPtitle_id_7 IN INT DEFAULT NULL,
    iPtitle_id_8 IN INT DEFAULT NULL,
    iPtitle_id_9 IN INT DEFAULT NULL,
    iPtitle_id_10 IN INT DEFAULT NULL,
    iPtitle_id_11 IN INT DEFAULT NULL,
    iPtitle_id_12 IN INT DEFAULT NULL,
    iPtitle_id_13 IN INT DEFAULT NULL,
    iPtitle_id_14 IN INT DEFAULT NULL,
    iPtitle_id_15 IN INT DEFAULT NULL,
    iPtitle_id_16 IN INT DEFAULT NULL,
    iPtitle_id_17 IN INT DEFAULT NULL,
    iPtitle_id_18 IN INT DEFAULT NULL,
    iPtitle_id_19 IN INT DEFAULT NULL,
    iPtitle_id_20 IN INT DEFAULT NULL
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      t.priority,
      t_en.name,
      NVL(t_b5.name, t_en.name),
      NVL(t_jp.name, t_en.name),
      NVL(t_kr.name, t_en.name),
      NVL(t_gb.name, t_en.name),
      t.award_lookup_id
    FROM
      ya_award_lookup t
      LEFT OUTER JOIN ya_award_lookup_lang t_en ON
        (
          t_en.award_lookup_id = t.award_lookup_id
          AND t_en.lang_id = 1
        )
      LEFT OUTER JOIN ya_award_lookup_lang t_b5 ON
        (
          t_b5.award_lookup_id = t.award_lookup_id
          AND t_b5.lang_id = 2
        )
      LEFT OUTER JOIN ya_award_lookup_lang t_jp ON
        (
          t_jp.award_lookup_id = t.award_lookup_id
          AND t_jp.lang_id = 3
        )
      LEFT OUTER JOIN ya_award_lookup_lang t_kr ON
        (
          t_kr.award_lookup_id = t.award_lookup_id
          AND t_kr.lang_id = 4
        )
      LEFT OUTER JOIN ya_award_lookup_lang t_gb ON
        (
          t_gb.award_lookup_id = t.award_lookup_id
          AND t_gb.lang_id = 5
        )
    WHERE
      t.award_lookup_id IN
        (
          iPtitle_id_1,
          iPtitle_id_2,
          iPtitle_id_3,
          iPtitle_id_4,
          iPtitle_id_5,
          iPtitle_id_6,
          iPtitle_id_7,
          iPtitle_id_8,
          iPtitle_id_9,
          iPtitle_id_10,
          iPtitle_id_11,
          iPtitle_id_12,
          iPtitle_id_13,
          iPtitle_id_14,
          iPtitle_id_15,
          iPtitle_id_16,
          iPtitle_id_17,
          iPtitle_id_18,
          iPtitle_id_19,
          iPtitle_id_20
        );
    RETURN;
  END GetMultiTitlesByIds;
END Pkg_BO_AwardDALC;
/

