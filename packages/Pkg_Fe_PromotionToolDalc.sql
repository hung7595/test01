CREATE OR REPLACE PACKAGE "PKG_FE_PROMOTIONTOOLDALC"
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetMirrorPageLotSet (
    iPpageId IN INT,
    iPsiteId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetMirrorLotEntrySet (
    iPpageId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE CreateMirrorPageLot (
    iPpageId IN INT,
    iPlotPosition IN INT,
    iPlotTypeId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPnewLotId OUT INT
  );

  PROCEDURE ResetMirrorPageLotPubStatus (
    iPlotId IN INT,
    iPsiteId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  );

  PROCEDURE InsertMirrorLotEntry (
    iPlotId IN INT,
    iPsiteId IN INT,
    iPentryPosition IN INT,
    dPstartDate IN DATE,
    dPendDate IN DATE,
    iPentryTypeId IN INT,
    cPenContent IN VARCHAR2,
    cPenTarget IN VARCHAR2,
    cPenIcon IN VARCHAR2,
    iPenSku IN INT,
    cPb5Content IN VARCHAR2,
    cPb5Target IN VARCHAR2,
    cPb5Icon IN VARCHAR2,
    iPb5Sku IN INT,
    cPjpContent IN VARCHAR2,
    cPjpTarget IN VARCHAR2,
    cPjpIcon IN VARCHAR2,
    iPjpSku IN INT,
    cPkrContent IN VARCHAR2,
    cPkrTarget IN VARCHAR2,
    cPkrIcon IN VARCHAR2,
    iPkrSku IN INT,
    cPgbContent IN VARCHAR2,
    cPgbTarget IN VARCHAR2,
    cPgbIcon IN VARCHAR2,
    iPgbSku IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPnewEntryId OUT INT
  );

  PROCEDURE DeleteMirrorLotEntry (
    iPentryId IN INT,
    iPlotId IN INT,
    iPsiteId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  );

  PROCEDURE UpdateMirrorLotEntry (
    iPentryId IN INT,
    dPstartDate IN DATE,
    dPendDate IN DATE,
    iPentryTypeId IN INT,
    cPenContent IN VARCHAR2,
    cPenTarget IN VARCHAR2,
    cPenIcon IN VARCHAR2,
    iPenSku IN INT,
    cPb5Content IN VARCHAR2,
    cPb5Target IN VARCHAR2,
    cPb5Icon IN VARCHAR2,
    iPb5Sku IN INT,
    cPjpContent IN VARCHAR2,
    cPjpTarget IN VARCHAR2,
    cPjpIcon IN VARCHAR2,
    iPjpSku IN INT,
    cPkrContent IN VARCHAR2,
    cPkrTarget IN VARCHAR2,
    cPkrIcon IN VARCHAR2,
    iPkrSku IN INT,
    cPgbContent IN VARCHAR2,
    cPgbTarget IN VARCHAR2,
    cPgbIcon IN VARCHAR2,
    iPgbSku IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  );

  PROCEDURE PublishMirrorPageLot (
    iPlotId IN INT,
    iPsiteId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  );

  PROCEDURE ReorderMirrorLotEntry (
    iPentryPos IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPentryId IN INT,
    iPcount OUT INT
  );

  PROCEDURE GetMirrorPendingPageSet (
    iPsiteId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetPendingPageLot (
    iPpageId IN INT,
    iPsiteId IN INT,
    curPresult OUT refCur
  );
  
  PROCEDURE CopyMirrorPage (
    iPfromPageId IN INT,
    iPtoPageId IN INT,
    iPfromSiteId IN INT,
    iPtoSiteId IN INT,
    cPlastUpdateUser IN VARCHAR2
  );  
END PKG_FE_PROMOTIONTOOLDALC;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_PROMOTIONTOOLDALC"
IS
  PROCEDURE GetMirrorPageLotSet (
    iPpageId IN INT,
    iPsiteId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      pl.lot_id,
      pl.lot_position,
      pl.lot_type_id,
      CASE
	      WHEN iPsiteId = 1 THEN pl.us_published
	      WHEN iPsiteId = 7 THEN pl.gb_published
	      WHEN iPsiteId = 10 THEN pl.ys_published
	      WHEN iPsiteId = 11 THEN pl.yscn_published
	      WHEN iPsiteId = 13 THEN pl.ysau_published
	    END CASE
    FROM
      ya_mirror_page_lot pl
    WHERE
      pl.page_id = iPpageId
      AND pl.current_revision = 'Y'
    ORDER BY pl.lot_position;
  END GetMirrorPageLotSet;

  PROCEDURE GetMirrorLotEntrySet (
    iPpageId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
      SELECT
        pl.lot_id,
        le.entry_id,
        le.entry_position,
        le.entry_type_id,
        nvl(lel.sku,-1),
        nvl(lel.icon_url,''),
        nvl(lel.target_url,''),
        nvl(lel.content,''),
        nvl(le.start_date, to_date('1900-1-1', 'yyyy-mm-dd')),
        nvl(le.end_date, to_date('1900-1-1', 'yyyy-mm-dd'))
      FROM
        ya_mirror_page_lot pl,
        ya_mirror_lot_entry le,
        ya_mirror_lot_entry_lang lel
      WHERE
        le.lot_id = pl.lot_id
        AND lel.entry_id = le.entry_id
        AND pl.page_id = iPpageId
        AND le.site_id = iPsiteId
        AND lel.lang_id = iPlangId
        AND pl.current_revision = 'Y'
        AND le.current_revision = 'Y'
      ORDER BY pl.lot_position, le.entry_type_id, le.entry_position;
    RETURN;
  END GetMirrorLotEntrySet;

  PROCEDURE CreateMirrorPageLot (
    iPpageId IN INT,
    iPlotPosition IN INT,
    iPlotTypeId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPnewLotId OUT INT
  )
  AS
    iLnewLotId INT;
  BEGIN
    BEGIN
      SELECT lot_id
        INTO iLnewLotId
      FROM ya_mirror_page_lot
      WHERE
        page_id = iPpageId
        AND lot_position = iPlotPosition;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iLnewLotId := -1;
        END;
    END;

    IF iLnewLotId = -1 THEN
    BEGIN
      SELECT SEQ_mirror_page_lot.nextval INTO iLnewLotId FROM dual;
      INSERT INTO ya_mirror_page_lot
        (lot_id, page_id, lot_position, lot_type_id, last_updated_user, last_updated_datetime, current_revision
        , us_published, gb_published, ys_published, yscn_published, ysau_published)
      VALUES
        (iLnewLotId, iPpageId, iPlotPosition, iPlotTypeId, cPlastUpdateUser, sysdate, 'Y'
        , 'Y', 'Y', 'Y', 'Y', 'Y');
      iPnewLotId := iLnewLotId;
    END;
    ELSE
    BEGIN
      iPnewLotId := -1;
    END;
    END IF;
  END CreateMirrorPageLot;

  PROCEDURE ResetMirrorPageLotPubStatus (
    iPlotId IN INT,
    iPsiteId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  )
  AS
  BEGIN
    IF iPsiteId = 1 THEN
    BEGIN
      UPDATE ya_mirror_page_lot
      SET
        us_published = 'N'
        , last_updated_user = cPlastUpdateUser
        , last_updated_datetime = sysdate
      WHERE
        lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 7 THEN
    BEGIN
      UPDATE ya_mirror_page_lot
      SET
        gb_published = 'N'
        , last_updated_user = cPlastUpdateUser
        , last_updated_datetime = sysdate
      WHERE
        lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 10 THEN
    BEGIN
      UPDATE ya_mirror_page_lot
      SET
        ys_published = 'N'
        , last_updated_user = cPlastUpdateUser
        , last_updated_datetime = sysdate
      WHERE
        lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 11 THEN
    BEGIN
      UPDATE ya_mirror_page_lot
      SET
        yscn_published = 'N'
        , last_updated_user = cPlastUpdateUser
        , last_updated_datetime = sysdate
      WHERE
        lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 13 THEN
    BEGIN
      UPDATE ya_mirror_page_lot
      SET
        ysau_published = 'N'
        , last_updated_user = cPlastUpdateUser
        , last_updated_datetime = sysdate
      WHERE
        lot_id = iPlotId;
    END;
    END IF;

    iPcount := SQL%ROWCOUNT;
    RETURN;
  END ResetMirrorPageLotPubStatus;

  PROCEDURE InsertMirrorLotEntry (
    iPlotId IN INT,
    iPsiteId IN INT,
    iPentryPosition IN INT,
    dPstartDate IN DATE,
    dPendDate IN DATE,
    iPentryTypeId IN INT,
    cPenContent IN VARCHAR2,
    cPenTarget IN VARCHAR2,
    cPenIcon IN VARCHAR2,
    iPenSku IN INT,
    cPb5Content IN VARCHAR2,
    cPb5Target IN VARCHAR2,
    cPb5Icon IN VARCHAR2,
    iPb5Sku IN INT,
    cPjpContent IN VARCHAR2,
    cPjpTarget IN VARCHAR2,
    cPjpIcon IN VARCHAR2,
    iPjpSku IN INT,
    cPkrContent IN VARCHAR2,
    cPkrTarget IN VARCHAR2,
    cPkrIcon IN VARCHAR2,
    iPkrSku IN INT,
    cPgbContent IN VARCHAR2,
    cPgbTarget IN VARCHAR2,
    cPgbIcon IN VARCHAR2,
    iPgbSku IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPnewEntryId OUT INT
  )
  AS
    iLnewEntryId INT;
  BEGIN
    -- reordering the entries which have entry_position > @entry_postion
    UPDATE ya_mirror_lot_entry
    SET
      entry_position = entry_position+1,
      last_updated_user = cPlastUpdateUser,
      last_updated_datetime = sysdate
    WHERE
      lot_id = iPlotId
      AND site_id = iPsiteId
      AND entry_position >= iPentryPosition
      AND current_revision = 'Y'
      AND entry_type_id = iPentryTypeId;

    SELECT SEQ_mirror_lot_entry.nextval INTO iLnewEntryId FROM dual;

    -- insert a new entry
    INSERT INTO ya_mirror_lot_entry
      (entry_id, lot_id, site_id, entry_position, start_date, end_date, entry_type_id
        , last_updated_user, last_updated_datetime, current_revision)
    VALUES
      (iLnewEntryId, iPlotId, iPsiteId, iPentryPosition, dPstartDate, dPendDate, iPentryTypeId
        , cPlastUpdateUser, sysdate, 'Y');

    INSERT INTO ya_mirror_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    VALUES
      (iLnewEntryId, 1, iPenSku, cPenIcon, cPenTarget, cPenContent);

    INSERT INTO ya_mirror_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    VALUES
      (iLnewEntryId, 2, iPb5Sku, cPb5Icon, cPb5Target, cPb5Content);

    INSERT INTO ya_mirror_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    VALUES
      (iLnewEntryId, 3, iPjpSku, cPjpIcon, cPjpTarget, cPjpContent);

    INSERT INTO ya_mirror_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    VALUES
      (iLnewEntryId, 4, iPkrSku, cPkrIcon, cPkrTarget, cPkrContent);

    INSERT INTO ya_mirror_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    VALUES
      (iLnewEntryId, 5, iPgbSku, cPgbIcon, cPgbTarget, cPgbContent);

    iPnewEntryId := iLnewEntryId;
    RETURN;
  END InsertMirrorLotEntry;

  PROCEDURE DeleteMirrorLotEntry (
    iPentryId IN INT,
    iPlotId IN INT,
    iPsiteId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  )
  AS
  BEGIN
    -- reordering the entries which have entry_position > @entry_postion
    UPDATE ya_mirror_lot_entry
    SET
      entry_position = entry_position-1,
      last_updated_user = cPlastUpdateUser,
      last_updated_datetime = sysdate
    WHERE
      lot_id = iPlotId
      AND site_id = iPsiteId
      AND current_revision = 'Y'
      AND entry_position > (SELECT le2.entry_position
                            FROM ya_mirror_lot_entry le2
                            WHERE
                              le2.entry_id = iPentryId);

    DELETE
    FROM
      ya_mirror_lot_entry
    WHERE
      entry_id = iPentryId;

    DELETE
    FROM
      ya_mirror_lot_entry_lang
    WHERE
      entry_id = iPentryId;

    iPcount := SQL%ROWCOUNT;
    RETURN;
  END DeleteMirrorLotEntry;

  PROCEDURE UpdateMirrorLotEntry (
    iPentryId IN INT,
    dPstartDate IN DATE,
    dPendDate IN DATE,
    iPentryTypeId IN INT,
    cPenContent IN VARCHAR2,
    cPenTarget IN VARCHAR2,
    cPenIcon IN VARCHAR2,
    iPenSku IN INT,
    cPb5Content IN VARCHAR2,
    cPb5Target IN VARCHAR2,
    cPb5Icon IN VARCHAR2,
    iPb5Sku IN INT,
    cPjpContent IN VARCHAR2,
    cPjpTarget IN VARCHAR2,
    cPjpIcon IN VARCHAR2,
    iPjpSku IN INT,
    cPkrContent IN VARCHAR2,
    cPkrTarget IN VARCHAR2,
    cPkrIcon IN VARCHAR2,
    iPkrSku IN INT,
    cPgbContent IN VARCHAR2,
    cPgbTarget IN VARCHAR2,
    cPgbIcon IN VARCHAR2,
    iPgbSku IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  )
  AS
  BEGIN
    UPDATE ya_mirror_lot_entry
    SET
      start_date = dPstartDate,
      end_date = dPendDate,
      entry_type_id = iPentryTypeId,
      last_updated_user = cPlastUpdateUser,
      last_updated_datetime = SYSDATE
    WHERE
      entry_id = iPentryId;

    UPDATE ya_mirror_lot_entry_lang
    SET
      content = cPenContent,
      target_url = cPenTarget,
      icon_url = cPenIcon,
      sku = iPenSku
    WHERE
      entry_id = iPentryId
      AND lang_id = 1;

    UPDATE ya_mirror_lot_entry_lang
    SET
      content = cPb5Content,
      target_url = cPb5Target,
      icon_url = cPb5Icon,
      sku = iPb5Sku
    WHERE
      entry_id = iPentryId
      AND lang_id = 2;

    UPDATE ya_mirror_lot_entry_lang
    SET
      content = cPjpContent,
      target_url = cPjpTarget,
      icon_url = cPjpIcon,
      sku = iPjpSku
    WHERE
      entry_id = iPentryId
      AND lang_id = 3;

    UPDATE ya_mirror_lot_entry_lang
    SET
      content = cPkrContent,
      target_url = cPkrTarget,
      icon_url = cPkrIcon,
      sku = iPkrSku
    WHERE
      entry_id = iPentryId
      AND lang_id = 4;

    UPDATE ya_mirror_lot_entry_lang
    SET
      content = cPgbContent,
      target_url = cPgbTarget,
      icon_url = cPgbIcon,
      sku = iPgbSku
    WHERE
      entry_id = iPentryId
      AND lang_id = 5;

    iPcount := SQL%ROWCOUNT;
    RETURN;
  End UpdateMirrorLotEntry;

  PROCEDURE PublishMirrorPageLot (
    iPlotId IN INT,
    iPsiteId IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPcount OUT INT
  )
  AS
    iLlotId INT;
  BEGIN
    BEGIN
      If iPsiteId = 1 Then
      BEGIN
        SELECT lot_id
          INTO iLlotId
        FROM ya_mirror_page_lot
        WHERE
          current_revision = 'Y'
          AND lot_id = iPlotId
          AND us_published = 'N';
      END;
      ELSIF iPsiteId = 7 Then
      BEGIN
        SELECT lot_id
          INTO iLlotId
        FROM ya_mirror_page_lot
        WHERE
          current_revision = 'Y'
          AND lot_id = iPlotId
          AND gb_published = 'N';
      END;
      ELSIF iPsiteId = 10 Then
      BEGIN
        SELECT lot_id
          INTO iLlotId
        FROM ya_mirror_page_lot
        WHERE
          current_revision = 'Y'
          AND lot_id = iPlotId
          AND ys_published = 'N';
      END;
      ELSIF iPsiteId = 11 Then
      BEGIN
        SELECT lot_id
          INTO iLlotId
        FROM ya_mirror_page_lot
        WHERE
          current_revision = 'Y'
          AND lot_id = iPlotId
          AND yscn_published = 'N';
      END;
      ELSIF iPsiteId = 13 Then
      BEGIN
        SELECT lot_id
          INTO iLlotId
        FROM ya_mirror_page_lot
        WHERE
          current_revision = 'Y'
          AND lot_id = iPlotId
          AND ysau_published = 'N';
      END;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iLlotId := -1;
          RETURN;
        END;
    END;

    -- ya_lot_entry_lang
    DELETE FROM
      ya_lot_entry_lang
    WHERE
      entry_id IN
        (
          SELECT le.entry_id
          FROM
            ya_lot_entry le
          WHERE
            le.lot_id = iPlotId
            AND le.site_id = iPsiteId
        );

    -- delete ya_lot_entry
    DELETE FROM
      ya_lot_entry
    WHERE
      lot_id = iPlotId
      AND site_id = iPsiteId;

    -- delete ya_page_lot
    DELETE FROM
      ya_page_lot
    WHERE
      lot_id = iPlotId;

    -- insert ya_page_lot
    INSERT INTO ya_page_lot
    ( lot_id, page_id, lot_position, lot_type_id )
    SELECT lot_id, page_id, lot_position, lot_type_id
    FROM
      ya_mirror_page_lot
    WHERE
      lot_id = iPlotId;

    -- insert ya_lot_entry
    INSERT INTO ya_lot_entry
      (entry_id, lot_id, site_id, entry_position, start_date, end_date, entry_type_id)
    SELECT
      entry_id,
      lot_id,
      site_id,
      entry_position,
      start_date,
      end_date,
      entry_type_id
    FROM
      ya_mirror_lot_entry
    WHERE
      lot_id = iPlotId
      AND site_id = iPsiteId
      AND current_revision = 'Y';

    -- insert ya_lot_entry_lang
    INSERT INTO ya_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    SELECT
      lel.entry_id, lel.lang_id, lel.sku, lel.icon_url, lel.target_url, lel.content
    FROM
      ya_mirror_lot_entry_lang lel,
      ya_mirror_lot_entry le
    WHERE
      le.entry_id = lel.entry_id
      AND le.lot_id = iPlotId
      AND le.site_id = iPsiteId
      AND le.current_revision = 'Y';

    -- -- perform revision control
    UPDATE ya_mirror_lot_entry
    SET
      current_revision = 'P' -- 'P' for processing, should not exist afterwards
    WHERE
      lot_id = iPlotId
      AND site_id = iPsiteId
      AND current_revision = 'Y';

    INSERT INTO ya_mirror_lot_entry
      (entry_id, lot_id, site_id, entry_position, start_date, end_date, entry_type_id, last_updated_user, last_updated_datetime, current_revision)
    SELECT
      SEQ_mirror_lot_entry.nextval, lot_id, site_id, entry_position, start_date, end_date, entry_type_id, cPlastUpdateUser, sysdate, 'Y'
    FROM
      ya_mirror_lot_entry le
    WHERE
      le.lot_id = iPlotId
      AND le.site_id = iPsiteId
      AND current_revision = 'P';

    INSERT INTO ya_mirror_lot_entry_lang
      (entry_id, lang_id, sku, icon_url, target_url, content)
    SELECT
      le_new.entry_id, lel.lang_id, lel.sku, lel.icon_url, lel.target_url, lel.content
    FROM
      ya_mirror_lot_entry_lang lel
      , ya_mirror_lot_entry le_new
      , ya_mirror_lot_entry le_old
    WHERE
      lel.entry_id = le_old.entry_id
      AND le_new.lot_id = le_old.lot_id
      AND le_new.site_id = le_old.site_id
      AND le_new.entry_position = le_old.entry_position
      AND le_new.entry_type_id = le_old.entry_type_id
      AND le_old.lot_id = iPlotId
      AND le_old.site_id = iPsiteId
      AND le_old.current_revision = 'P'
      AND le_new.current_revision = 'Y';

    UPDATE ya_mirror_lot_entry
    SET
      current_revision = 'N'
    WHERE
      lot_id = iPlotId
      AND site_id = iPsiteId
      AND current_revision = 'P';

    -- update publication status
    If iPsiteId = 1 Then
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET us_published = 'Y'
      WHERE
        current_revision = 'Y'
        AND lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 7 Then
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET gb_published = 'Y'
      WHERE
        current_revision = 'Y'
        AND lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 10 Then
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET ys_published = 'Y'
      WHERE
        current_revision = 'Y'
        AND lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 11 Then
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET yscn_published = 'Y'
      WHERE
        current_revision = 'Y'
        AND lot_id = iPlotId;
    END;
    ELSIF iPsiteId = 13 Then
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET ysau_published = 'Y'
      WHERE
        current_revision = 'Y'
        AND lot_id = iPlotId;
    END;
    END IF;

    iPcount := SQL%ROWCOUNT;
    RETURN;
  END PublishMirrorPageLot;

  PROCEDURE ReorderMirrorLotEntry (
    iPentryPos IN INT,
    cPlastUpdateUser IN VARCHAR2,
    iPentryId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    UPDATE ya_mirror_lot_entry
    SET
      entry_position = iPentryPos
      , last_updated_user = cPlastUpdateUser
      , last_updated_datetime = sysdate
    WHERE
      entry_id = iPentryId;

    iPcount := SQL%ROWCOUNT;
  END ReorderMirrorLotEntry;

  PROCEDURE GetMirrorPendingPageSet (
    iPsiteId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT * FROM (
      SELECT DISTINCT p.id, p.path,

      CASE
      WHEN iPsiteId=1 THEN mpl.us_published
      WHEN iPsiteId=7 THEN mpl.gb_published
      WHEN iPsiteId=10 THEN mpl.ys_published
      WHEN iPsiteId=11 THEN mpl.yscn_published
      WHEN iPsiteId=13 THEN mpl.ysau_published
      END published

      FROM
        ya_mirror_lot_entry mle
        , ya_mirror_page_lot mpl
        , ya_content_filename p
      WHERE
        mle.lot_id = mpl.lot_id
        AND p.id = mpl.page_id
        AND mle.site_id = iPsiteId

    ) WHERE published = 'N' ORDER BY id;
  END GetMirrorPendingPageSet;

  PROCEDURE GetPendingPageLot (
    iPpageId IN INT,
    iPsiteId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT * FROM (
      SELECT lot_id,
        CASE
          WHEN iPsiteId = 1 THEN us_published
          WHEN iPsiteId = 7 THEN gb_published
          WHEN iPsiteId = 10 THEN ys_published
          WHEN iPsiteId = 11 THEN yscn_published
          WHEN iPsiteId = 13 THEN ysau_published
        END published
      FROM ya_mirror_page_lot
      WHERE
        page_id = iPpageId
        AND current_revision = 'Y'
      ORDER BY lot_position ASC
    ) WHERE published = 'N';
  END GetPendingPageLot;

  PROCEDURE CopyMirrorPage (
    iPfromPageId IN INT,
    iPtoPageId IN INT,
    iPfromSiteId IN INT,
    iPtoSiteId IN INT,
    cPlastUpdateUser IN VARCHAR2
  )
  AS
  BEGIN
    -- delete page lot_entry(s) of the target page
    DELETE
    FROM
      ya_mirror_lot_entry_lang
    WHERE
      entry_id IN
      (
        SELECT entry_id
        FROM
          ya_mirror_page_lot pl,
          ya_mirror_lot_entry le
        WHERE
          pl.page_id = iPtoPageId
          AND le.site_id = iPtoSiteId
          AND le.lot_id = pl.lot_id
          AND le.current_revision = 'Y'
          AND pl.current_revision = 'Y'
      );

    DELETE
    FROM
      ya_mirror_lot_entry
    WHERE
      entry_id IN
      (
        SELECT entry_id
        FROM
          ya_mirror_page_lot pl,
          ya_mirror_lot_entry le
        WHERE
          pl.page_id = iPtoPageId
          AND le.site_id = iPtoSiteId
          AND le.lot_id = pl.lot_id
          AND le.current_revision = 'Y'
          AND pl.current_revision = 'Y'
      );

    -- copy from [@from_page_id, @from_site_id] to [@to_page_id, @to_site_id] [ ya_mirror_lot_entry]
    INSERT INTO ya_mirror_lot_entry
      (entry_id, lot_id, site_id, entry_position, start_date, END_date, entry_type_id, last_updated_user, last_updated_datetime, current_revision)
    SELECT
      SEQ_mirror_lot_entry.nextval, pl_to.lot_id, iPtoSiteId, le_from.entry_position, le_from.start_date, le_from.END_date, le_from.entry_type_id, cPlastUpdateUser, sysdate, 'Y'
    FROM
      ya_mirror_lot_entry le_from,
      ya_mirror_page_lot pl_from,
      ya_mirror_page_lot pl_to
    WHERE
      le_from.lot_id = pl_from.lot_id
      AND pl_to.lot_position = pl_from.lot_position
      AND pl_to.lot_type_id = pl_from.lot_type_id
      AND pl_to.page_id = iPtoPageId
      AND pl_to.current_revision = 'Y'
      AND le_from.site_id = iPfromSiteId
      AND le_from.current_revision = 'Y'
      AND pl_from.page_id = iPfromPageId
      AND pl_from.current_revision = 'Y';

    -- copy from [@from_page_id, @from_site_id] to [@to_page_id, @to_site_id] [ ya_mirror_lot_entry_lang]
    INSERT INTO ya_mirror_lot_entry_lang
    (entry_id, lang_id, sku, icon_url, target_url, content)
    SELECT
      le_to.entry_id, lel.lang_id, lel.sku, lel.icon_url, lel.target_url, lel.content
    FROM
      ya_mirror_lot_entry_lang lel,
      ya_mirror_lot_entry le_from,
      ya_mirror_lot_entry le_to,
      ya_mirror_page_lot pl_from,
      ya_mirror_page_lot pl_to
    WHERE
      lel.entry_id = le_from.entry_id
      AND pl_to.lot_position = pl_from.lot_position
      AND pl_to.lot_type_id = pl_from.lot_type_id
      AND le_to.entry_position = le_from.entry_position
      AND le_to.entry_type_id = le_from.entry_type_id
      AND pl_to.lot_id = le_to.lot_id
      AND pl_to.page_id = iPtoPageId
      AND le_to.site_id = iPtoSiteId
      AND pl_from.lot_id = le_from.lot_id
      AND pl_from.page_id = iPfromPageId
      AND le_from.site_id = iPfromSiteId
      AND le_from.current_revision = 'Y'
      AND le_to.current_revision = 'Y'
      AND pl_from.current_revision = 'Y'
      AND pl_to.current_revision = 'Y';

    -- update the publication status
    IF iPtoSiteId = 1 THEN
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET
        us_published  = 'N'
      WHERE
        current_revision = 'Y'
        AND page_id = iPtoPageId
        AND lot_id in (
          SELECT pl.lot_id
          FROM
            ya_mirror_page_lot pl,
            ya_mirror_lot_entry le
          WHERE
            page_id = iPtoPageId
            AND pl.current_revision = 'Y'
            AND le.lot_id = pl.lot_id
            AND le.site_id = iPtoSiteId
            AND le.current_revision = 'Y'
          );
    END;
    ELSIF iPtoSiteId = 7 THEN
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET
        gb_published  = 'N'
      WHERE
        current_revision = 'Y'
        AND page_id = iPtoPageId
        AND lot_id in (
          SELECT pl.lot_id
          FROM
            ya_mirror_page_lot pl,
            ya_mirror_lot_entry le
          WHERE
            page_id = iPtoPageId
            AND pl.current_revision = 'Y'
            AND le.lot_id = pl.lot_id
            AND le.site_id = iPtoSiteId
            AND le.current_revision = 'Y'
          );
    END;
    ELSIF iPtoSiteId = 10 THEN
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET
        ys_published  = 'N'
      WHERE
        current_revision = 'Y'
        AND page_id = iPtoPageId
        AND lot_id in (
          SELECT pl.lot_id
          FROM
            ya_mirror_page_lot pl,
            ya_mirror_lot_entry le
          WHERE
            page_id = iPtoPageId
            AND pl.current_revision = 'Y'
            AND le.lot_id = pl.lot_id
            AND le.site_id = iPtoSiteId
            AND le.current_revision = 'Y'
          );
    END;
    ELSIF iPtoSiteId = 10 THEN
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET
        ys_published  = 'N'
      WHERE
        current_revision = 'Y'
        AND page_id = iPtoPageId
        AND lot_id in (
          SELECT pl.lot_id
          FROM
            ya_mirror_page_lot pl,
            ya_mirror_lot_entry le
          WHERE
            page_id = iPtoPageId
            AND pl.current_revision = 'Y'
            AND le.lot_id = pl.lot_id
            AND le.site_id = iPtoSiteId
            AND le.current_revision = 'Y'
          );
    END;
    ELSIF iPtoSiteId = 11 THEN
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET
        yscn_published  = 'N'
      WHERE
        current_revision = 'Y'
        AND page_id = iPtoPageId
        AND lot_id in (
          SELECT pl.lot_id
          FROM
            ya_mirror_page_lot pl,
            ya_mirror_lot_entry le
          WHERE
            page_id = iPtoPageId
            AND pl.current_revision = 'Y'
            AND le.lot_id = pl.lot_id
            AND le.site_id = iPtoSiteId
            AND le.current_revision = 'Y'
          );
    END;
    ELSIF iPtoSiteId = 13 THEN
    BEGIN
      UPDATE
        ya_mirror_page_lot
      SET
        ysau_published  = 'N'
      WHERE
        current_revision = 'Y'
        AND page_id = iPtoPageId
        AND lot_id in (
          SELECT pl.lot_id
          FROM
            ya_mirror_page_lot pl,
            ya_mirror_lot_entry le
          WHERE
            page_id = iPtoPageId
            AND pl.current_revision = 'Y'
            AND le.lot_id = pl.lot_id
            AND le.site_id = iPtoSiteId
            AND le.current_revision = 'Y'
          );
    END;
    END IF;
  END CopyMirrorPage;

END PKG_FE_PROMOTIONTOOLDALC;
/