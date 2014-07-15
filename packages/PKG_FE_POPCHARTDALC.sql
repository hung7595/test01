CREATE OR REPLACE PACKAGE PKG_FE_POPCHARTDALC
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetContentFileName (
    iPfileId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetPopChartPublishStatus (
    iPfileId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetPopChartByFileId (
    iPfileId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetPopChartByPopChartId (
    iPpopChartId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE GetPopChartDateRangeByFileId (
    iPfileId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE PublishContent (
    iPfileId IN INT,
    iPcount OUT INT
  );

  PROCEDURE UpdatePopChartDateRange (
    iPfileId IN INT,
    dPstartDt IN DATE,
    dPendDt IN DATE,
    iPcount OUT INT
  );

  PROCEDURE AddPopChartData (
    iPfileId IN INT,
    iPlotLoc IN INT,
    cPlastPos IN NVARCHAR2,
    cPdescImgLoc IN NVARCHAR2,
    iPdescImgWidth IN INT,
    iPdescImgHeight IN INT,
    cPtitle IN NVARCHAR2,
    iPcount OUT INT
  );

  PROCEDURE UpdatePopChartData (
    iPpopChartId IN INT,
    iPfileId IN INT,
    iPlotLoc IN INT,
    cPlastPos IN NVARCHAR2,
    cPdescImgLoc IN NVARCHAR2,
    iPdescImgWidth IN INT,
    iPdescImgHeight IN INT,
    cPtitle IN NVARCHAR2,
    iPcount OUT INT
  );

  PROCEDURE DeletePopChartData (
    iPpopChartId IN INT,
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPcount OUT INT
  );

  PROCEDURE UpdatePopChartSku (
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPsku IN INT,
    iPprodLotId IN INT,
    iPcount OUT INT
  );

  PROCEDURE GetArtistList (
    iPfileId IN INT,
    curPresult OUT refCur
  );

  PROCEDURE AddArtist (
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPartistId IN INT,
    iPcount OUT INT
  );

  PROCEDURE DeleteArtist (
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPcount OUT INT
  );
END PKG_FE_POPCHARTDALC;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_POPCHARTDALC
IS
  PROCEDURE GetContentFileName (
    iPfileId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT path
    FROM
      ya_content_filename
    WHERE
      id = iPfileId;
    RETURN;
  END GetContentFileName;

  PROCEDURE GetPopChartPublishStatus (
    iPfileId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT publish_flag
    FROM
      ya_content_publish
    WHERE
      file_id = iPfileId;
    RETURN;
  END GetPopChartPublishStatus;

  PROCEDURE GetPopChartByFileId (
    iPfileId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT pc.popchart_id, pc.file_id, pc.lot_location, pc.last_position, pc.desc_img_loc
      , pc.desc_img_width, pc.desc_img_height, pl.sku, pl.prod_lot_id
    FROM
      ya_mirror_popchart pc
      LEFT OUTER JOIN ya_mirror_product_lot pl ON pc.lot_location = pl.lot_location AND pc.file_id = pl.file_id
    WHERE
      pc.file_id = iPfileId
    ORDER BY pc.lot_location;
    RETURN;
  END GetPopChartByFileId;

  PROCEDURE GetPopChartByPopChartId (
    iPpopChartId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT popchart_id, lang_id, title_desc
    FROM
      ya_mirror_popchart_lang
    WHERE
      popchart_id = iPpopChartId
    ORDER BY
      lang_id;
    RETURN;
  END GetPopChartByPopChartId;

  PROCEDURE GetPopChartDateRangeByFileId (
    iPfileId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT pci.id, pci.file_id, pci.start_dt, pci.end_dt
    FROM
      ya_mirror_popchart_info pci
    WHERE
      pci.file_id = iPfileId;
    RETURN;
  END GetPopChartDateRangeByFileId;

  PROCEDURE PublishContent (
    iPfileId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    DELETE FROM ya_prod_lot_lang
    WHERE prod_lot_id IN (SELECT prod_lot_id FROM ya_product_lot WHERE file_id = iPfileId);

    DELETE FROM ya_product_lot WHERE file_id = iPfileId;

    DELETE FROM ya_popchart_lang
    WHERE popchart_id IN (SELECT popchart_id
                          FROM ya_text_lot
                          WHERE popchart_id IN (SELECT popchart_id FROM ya_popchart WHERE file_id = iPfileId));

    DELETE FROM ya_popchart WHERE file_id = iPfileId;

    INSERT INTO ya_product_lot (prod_lot_id,file_id,sku,dept_id,lot_location,active,priority,updated_user,updated_date)
    SELECT prod_lot_id,file_id,sku,dept_id,lot_location,active,priority,updated_user,updated_date
      FROM ya_mirror_product_lot
      WHERE file_id = iPfileId;

    INSERT INTO ya_prod_lot_lang (prod_lot_id,lang_id,desc_img_loc,desc_img_width,desc_img_height,description,preferred_flag, remark)
    SELECT prod_lot_id,lang_id,desc_img_loc,desc_img_width,desc_img_height,description,preferred_flag, remark
      FROM ya_mirror_prod_lot_lang
      WHERE prod_lot_id IN (SELECT prod_lot_id FROM ya_mirror_product_lot WHERE file_id = iPfileId);

    INSERT INTO ya_popchart (popchart_id,file_id,lot_location,last_position,desc_img_loc,desc_img_width,desc_img_height)
    SELECT popchart_id,file_id,lot_location,last_position,desc_img_loc,desc_img_width,desc_img_height
      FROM ya_mirror_popchart
      WHERE file_id = iPfileId;

    INSERT INTO ya_popchart_lang (popchart_id,lang_id,title_desc)
    SELECT popchart_id,lang_id,title_desc
      FROM ya_mirror_popchart_lang
      WHERE popchart_id IN (SELECT popchart_id FROM ya_mirror_popchart WHERE file_id = iPfileId);

    DELETE FROM ya_popchart_info WHERE file_id = iPfileId;

    INSERT INTO ya_popchart_info(id, file_id, start_dt, end_dt)
    SELECT id, file_id, start_dt, end_dt
      FROM ya_mirror_popchart_info
      WHERE file_id = iPfileId;

    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
    INSERT INTO ya_content_publish (file_id,publish_flag,update_dt) VALUES (iPfileId,'Y',sysdate);

    iPcount := SQL%ROWCOUNT;
  END PublishContent;

  PROCEDURE UpdatePopChartDateRange (
    iPfileId IN INT,
    dPstartDt IN DATE,
    dPendDt IN DATE,
    iPcount OUT INT
  )
  AS
    iLexist INT;
    iLpopChartId INT;
  BEGIN
    BEGIN
      SELECT COUNT(1) INTO iLexist FROM ya_mirror_popchart_info
      WHERE file_id = iPfileId;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLexist := 0;
    END;

    IF iLexist = 0 THEN
    BEGIN
      SELECT SEQ_mirror_popchart_info.nextval INTO iLpopChartId FROM dual;

      INSERT INTO ya_mirror_popchart_info(id, file_id, start_dt, end_dt)
      VALUES(iLpopChartId, iPfileId, dPstartDt, dPendDt);
    END;
    ELSE
    BEGIN
      UPDATE ya_mirror_popchart_info
      SET start_dt = dPstartDt, end_dt = dPendDt
      WHERE file_id = iPfileId;
    END;
    END IF;
    iPcount := SQL%ROWCOUNT;
  END UpdatePopChartDateRange;

  PROCEDURE AddPopChartData (
    iPfileId IN INT,
    iPlotLoc IN INT,
    cPlastPos IN NVARCHAR2,
    cPdescImgLoc IN NVARCHAR2,
    iPdescImgWidth IN INT,
    iPdescImgHeight IN INT,
    cPtitle IN NVARCHAR2,
    iPcount OUT INT
  )
  AS
    iLpopChartId INT;
  BEGIN
    SELECT SEQ_mirror_popchart.nextval INTO iLpopChartId FROM dual;

    INSERT INTO ya_mirror_popchart(popchart_id,file_id,lot_location,last_position,desc_img_loc,desc_img_height,desc_img_width)
    VALUES (iLpopChartId,iPfileId,iPlotLoc,cPlastPos,cPdescImgLoc,iPdescImgWidth,iPdescImgHeight);

    -- add English only, FE reads English field only.
    INSERT INTO ya_mirror_popchart_lang (popchart_id,lang_id,title_desc)
    VALUES (iLpopChartId,1,cPtitle);

    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
    INSERT INTO ya_content_publish (file_id,publish_flag,update_dt) values (iPfileId,'N',sysdate);

    iPcount := SQL%ROWCOUNT;
  END AddPopChartData;

  PROCEDURE UpdatePopChartData (
    iPpopChartId IN INT,
    iPfileId IN INT,
    iPlotLoc IN INT,
    cPlastPos IN NVARCHAR2,
    cPdescImgLoc IN NVARCHAR2,
    iPdescImgWidth IN INT,
    iPdescImgHeight IN INT,
    cPtitle IN NVARCHAR2,
    iPcount OUT INT
  )
  AS
  BEGIN
    UPDATE ya_mirror_popchart SET file_id = iPfileId, lot_location = iPlotLoc
      , last_position = cPlastPos, desc_img_loc = cPdescImgLoc
      , desc_img_height = iPdescImgHeight, desc_img_width = iPdescImgWidth
    WHERE popchart_id = iPpopChartId;

    -- add English only, FE reads English field only.
    UPDATE ya_mirror_popchart_lang SET title_desc = cPtitle
    WHERE popchart_id = iPpopChartId AND lang_id = 1;

    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
    INSERT INTO ya_content_publish (file_id,publish_flag,update_dt) values (iPfileId,'N',sysdate);

    iPcount := SQL%ROWCOUNT;
  END UpdatePopChartData;

  PROCEDURE DeletePopChartData (
    iPpopChartId IN INT,
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    DELETE FROM ya_mirror_prod_lot_lang
    WHERE prod_lot_id IN (SELECT prod_lot_id FROM ya_mirror_product_lot
                            WHERE file_id = iPfileId AND lot_location = iPlotLoc);

    DELETE FROM ya_mirror_product_lot
    WHERE file_id = iPfileId AND lot_location = iPlotLoc;

    DELETE FROM ya_mirror_popchart_lang WHERE popchart_id = iPpopChartId;
    DELETE FROM ya_mirror_popchart WHERE popchart_id = iPpopChartId;

    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
    INSERT INTO ya_content_publish (file_id,publish_flag,update_dt) VALUES (iPfileId,'N',sysdate);

    iPcount := SQL%ROWCOUNT;
  END DeletePopChartData;

  PROCEDURE UpdatePopChartSku (
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPsku IN INT,
    iPprodLotId IN INT,
    iPcount OUT INT
  )
  AS
    iLexist INT;
    iLlotId INT;
  BEGIN
    IF iPsku = 0 THEN
    BEGIN
      DELETE FROM ya_mirror_prod_lot_lang
      WHERE prod_lot_id IN (SELECT prod_lot_id FROM ya_mirror_product_lot
                              WHERE file_id = iPfileId AND prod_lot_id = iPprodLotId);
      DELETE FROM ya_mirror_product_lot WHERE file_id = iPfileId AND prod_lot_id = iPprodLotId;
    END;
    ELSE
    BEGIN
      BEGIN
        SELECT COUNT(1) INTO iLexist
        FROM ya_mirror_product_lot
        WHERE file_id = iPfileId
          AND prod_lot_id = iPprodLotId;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          iLexist := 0;
      END;
      IF iLexist = 0 THEN
      BEGIN
        -- insert sku
        SELECT SEQ_YA_MIRROR_PRODUCT_LOT.nextval INTO iLlotId FROM DUAL;
        INSERT INTO ya_mirror_product_lot(prod_lot_id,sku,dept_id,lot_location,active,priority,file_id)
        VALUES (iLlotId,iPsku,1,iPlotLoc,'Y',iPlotLoc,iPfileId);

        INSERT INTO ya_mirror_prod_lot_lang (prod_lot_id,lang_id,description,desc_img_loc,preferred_flag,alt_img_loc,alt_img_link,remark)
        VALUES (iLlotId,1,'','','N','','','');
      END;
      ELSE
      BEGIN
        -- update sku
        UPDATE ya_mirror_product_lot SET sku = iPsku, lot_location = iPlotLoc
        WHERE file_id = iPfileId AND prod_lot_id = iPprodLotId;
      END;
      END IF;
    END;
    END IF;

    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
    INSERT INTO ya_content_publish (file_id,publish_flag,update_dt)
    VALUES (iPfileId,'N',sysdate);

    iPcount := SQL%ROWCOUNT;
  END UpdatePopChartSku;

  PROCEDURE GetArtistList (
    iPfileId IN INT,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT p.sku, a.artist_id, a.lot_locatioin alot, p.lot_location plot
      , al.lastname || ',' || al.firstname || ' ' || al.akaname ename
      , ac.lastname || ac.firstname || ' ' || ac.akaname cname
      , pal.lastname || ',' || pal.firstname || ' ' || pal.akaname pename
      , pac.lastname || pac.firstname || ' ' || pac.akaname pcname
    FROM ya_artist_lot a
      LEFT OUTER JOIN ya_artist_lang al ON a.artist_id = al.artist_id AND al.lang_id = 1
      LEFT OUTER JOIN ya_artist_lang ac ON a.artist_id = ac.artist_id AND ac.lang_id = 2
      LEFT OUTER JOIN ya_mirror_product_lot p ON p.lot_location = a.lot_locatioin AND p.file_id = a.file_id
      LEFT OUTER JOIN ya_product_artist pa ON pa.sku = p.sku
      LEFT OUTER JOIN ya_artist_lang pal ON pal.artist_id = pa.artist_id AND pal.lang_id = 1
      LEFT OUTER JOIN ya_artist_lang pac ON pac.artist_id = pa.artist_id AND pac.lang_id = 2
    WHERE a.file_id = iPfileId
    ORDER BY lot_locatioin;
  END GetArtistList;

  PROCEDURE AddArtist (
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPartistId IN INT,
    iPcount OUT INT
  )
  AS
    iLartistLotId INT;
  BEGIN
    SELECT seq_ya_artist_lot.nextval INTO iLartistLotId FROM DUAL;
    INSERT INTO ya_artist_lot (artist_lot_id,file_id,lot_locatioin, artist_id)
    VALUES (iLartistLotId,iPfileId,iPlotLoc,iPartistId);
    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
    INSERT INTO ya_content_publish (file_id,publish_flag,update_dt) VALUES (iPfileId,'N',sysdate);
    iPcount := SQL%ROWCOUNT;
  END AddArtist;

  PROCEDURE DeleteArtist (
    iPfileId IN INT,
    iPlotLoc IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    DELETE FROM ya_artist_lot WHERE file_id = iPfileId AND lot_locatioin = iPlotLoc;
    iPcount := SQL%ROWCOUNT;
  END DeleteArtist;
END PKG_FE_POPCHARTDALC;
/
