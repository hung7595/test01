CREATE OR REPLACE package Pkg_fe_PromotionToolAccess
AS

  TYPE curGgetPromotionLots IS ref CURSOR;
  PROCEDURE GetLots (
    iPpageId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPgetPromotionLots OUT curGgetPromotionLots
  );

  PROCEDURE GetLots_Mirror (
    iPpageId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPgetPromotionLots OUT curGgetPromotionLots
  );
END Pkg_fe_PromotionToolAccess;
/

CREATE OR REPLACE package body Pkg_fe_PromotionToolAccess
IS

  PROCEDURE GetLots (
    iPpageId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPgetPromotionLots OUT curGgetPromotionLots
  )
  AS
      dtLcurrentDate DATE;
  BEGIN
      SELECT SYSDATE INTO dtLcurrentDate FROM dual;

      OPEN curPgetPromotionLots FOR
      SELECT
        pl.page_id,
        pl.lot_id,
        pl.lot_position,
        pl.lot_type_id,
        le.entry_id,
        le.entry_position,
        le.entry_type_id,
        NVL(lel.sku,-1),
        lel.icon_url,
        lel.target_url,
        lel.content
      FROM
        ya_page_lot pl,
        ya_lot_entry le,
        ya_lot_entry_lang lel
      WHERE
        le.lot_id = pl.lot_id
        AND lel.entry_id = le.entry_id
        AND pl.page_id = iPpageId
        AND le.site_id = iPsiteId
        AND dtLcurrentDate BETWEEN NVL(le.start_date, dtLcurrentDate) AND NVL(le.end_date, dtLcurrentDate)
        AND lel.lang_id = iPlangId
      ORDER BY
        pl.lot_position,
        le.entry_position;
    RETURN;
  END GetLots;



  PROCEDURE GetLots_Mirror (
    iPpageId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPgetPromotionLots OUT curGgetPromotionLots
  )
  AS
      dtLcurrentDate DATE;
  BEGIN
      SELECT SYSDATE INTO dtLcurrentDate FROM dual;

      OPEN curPgetPromotionLots FOR
      SELECT
        pl.page_id,
        pl.lot_id,
        pl.lot_position,
        pl.lot_type_id,
        le.entry_id,
        le.entry_position,
        le.entry_type_id,
        NVL(lel.sku,-1),
        lel.icon_url,
        lel.target_url,
        lel.content
      FROM
        ya_mirror_page_lot pl,
        ya_mirror_lot_entry le,
        ya_mirror_lot_entry_lang lel
      WHERE
        le.lot_id = pl.lot_id
        AND lel.entry_id = le.entry_id
        AND pl.page_id = iPpageId
        AND le.site_id = iPsiteId
        AND dtLcurrentDate BETWEEN NVL(le.start_date, dtLcurrentDate) AND NVL(le.end_date, dtLcurrentDate)
        AND lel.lang_id = iPlangId
        AND pl.current_revision = 'Y'
        AND le.current_revision = 'Y'
      ORDER BY
        pl.lot_position,
        le.entry_position;
    RETURN;
  END GetLots_Mirror;
END Pkg_fe_PromotionToolAccess;
/

