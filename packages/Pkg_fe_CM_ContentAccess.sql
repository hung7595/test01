
  CREATE OR REPLACE PACKAGE "PKG_FE_CM_CONTENTACCESS" 
AS
  TYPE  refCur IS REF CURSOR;

  PROCEDURE GetTimeStampFromDatabase (
    curPresult1 OUT refCur
  );

  PROCEDURE GetProductJPDesc (
    iPsku IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetTextLotByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetTextLotByLotId (
    iPlotId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetImageLotByLotId (
    iPlotId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetImageLotByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetProductLotByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetContentPublishByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetContentNameByKeyword (
    cPKeyword IN VARCHAR2,
    curPresult1 OUT refCur
  );

  PROCEDURE GetContentNameById (
    iPfileId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetUnPublishPage (
    curPresult1 OUT refCur
  );

  PROCEDURE GetInvalidHighlights (
    curPresult1 OUT refCur
  );

  PROCEDURE AddContentPage (
    iPsiteId IN INT,
	cPpageName IN VARCHAR2,
	cPpageLocation IN VARCHAR2,
	cPpublished IN CHAR,
	cPupdatedUsesr IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPfileId OUT INT
  );

  PROCEDURE UpdContentPage (
    iPfileId IN INT,
    iPsiteId IN INT,
	cPpageName IN VARCHAR2,
	cPpageLocation IN VARCHAR2,
	cPupdatedUsesr IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  );

  PROCEDURE DelContentPage (
    iPfileId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdProductLotDesc (
    iPproductLotId IN INT,
    iPlangId IN INT,
	cPdesc IN VARCHAR2,
	cPupdatedUser IN VARCHAR2,
    iProw_affacted OUT INT
  );

  PROCEDURE GetProductLotDesc (
    iPproductLotId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );

  PROCEDURE GetProductLotByProdLotID (
    iPproductLotId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur
  );

  PROCEDURE AddProductLot (
    iPfileId IN INT,
    iPsku IN INT,
    iPdeptId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPproductLotId OUT INT
  );

  PROCEDURE AddProductLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPsescImgWidth IN INT,
	iPsescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
	cPaltImgLoc IN VARCHAR2,
	iPaltImgWidth IN INT,
	iPaltImgHeight IN INT,
	cPaltImgLink IN VARCHAR2,
	cPremark IN VARCHAR2,
    iProw_affacted OUT INT

  );

  PROCEDURE AddImageLot (
    iPfileId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPimageLotId OUT INT
  );

  PROCEDURE AddImageLotLang (
    iPimageLotId IN INT,
    iPlangId IN INT,
	cPimageLoc IN VARCHAR2,
	iPimageWidth IN INT,
	iPimageHeight IN INT,
	cPalt IN VARCHAR2,
	cPlinkUrl IN VARCHAR2,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  );

  PROCEDURE AddTextLot (
    iPfileId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPtextLotId OUT INT
  );

  PROCEDURE AddTextLotLang (
    iPtextLotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPdescImgWidth IN INT,
	iPdescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdProductLot (
    iPlotId IN INT,
    iPsku IN INT,
    iPdeptId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdProductLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPdescImgWidth IN INT,
	iPdescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
	iPaltImgLoc IN VARCHAR2,
	iPaltImgWidth IN INT,
	iPaltImgHeight IN INT,
	cPaltImgLink IN VARCHAR2,
	cPremark IN VARCHAR2,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdImageLot (
    iPimageLotId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdImageLotLang (
    iPimageLotId IN INT,
    iPlangId IN INT,
	cPimageLoc IN VARCHAR2,
	iPimageWidth IN INT,
	iPimageHeight IN INT,
	cPalt IN VARCHAR2,
	cPlinkUrl IN VARCHAR2,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdTextLot (
    iPlotId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPtextLotId OUT INT
  );

  PROCEDURE UpdTextLotLang (
    iPtextLotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPdescImgWidth IN INT,
	iPdescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  );

  PROCEDURE DelProductLot (
    iPlotId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE DelProductLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE DelTextLot (
    iPlotId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE DelTextLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE DelImageLot (
    iPlotId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE DelImageLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE AddContentPublish (
    iPfileId IN INT,
	cPpublishFlag IN CHAR,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  );

  PROCEDURE UpdContentPublish (
    iPfileId IN INT,
	cPpublishFlag IN CHAR,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  );

  PROCEDURE DelContentPublish (
    iPfileId IN INT,
    iProw_affacted OUT INT
  );

  PROCEDURE PubContentPage (
    iPfileId IN INT,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  );

END Pkg_fe_CM_ContentAccess;
/








CREATE OR REPLACE PACKAGE BODY "PKG_FE_CM_CONTENTACCESS" 
IS

  PROCEDURE GetTimeStampFromDatabase (
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  select sysdate as time from dual;
  END GetTimeStampFromDatabase;


  PROCEDURE GetProductJPDesc (
    iPsku IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT
	    d1.description AS desc_en,
	    d2.description AS desc_b5,
	    d3.description AS desc_jp,
	    d4.description AS desc_kr,
	    d5.description AS desc_gb
	  FROM
	    ya_product p
	    LEFT JOIN ya_prod_lang pl1 ON (pl1.sku = p.sku AND pl1.lang_id = 1)
	    LEFT JOIN ya_prod_lang pl2 ON (pl2.sku = p.sku AND pl2.lang_id = 2)
	    LEFT JOIN ya_prod_lang pl3 ON (pl3.sku = p.sku AND pl3.lang_id = 3)
	    LEFT JOIN ya_prod_lang pl4 ON (pl4.sku = p.sku AND pl4.lang_id = 4)
	    LEFT JOIN ya_prod_lang pl5 ON (pl5.sku = p.sku AND pl5.lang_id = 5)
	    LEFT JOIN ya_description d1 ON (d1.description_id = case when pl1.tw_description_id is not null then pl1.tw_description_id when pl1.us_description_id is not null then pl1.us_description_id when pl1.jp_description_id is not null then pl1.jp_description_id end)
	    LEFT JOIN ya_description d2 ON (d2.description_id = case when pl2.tw_description_id is not null then pl2.tw_description_id when pl2.us_description_id is not null then pl2.us_description_id when pl2.jp_description_id is not null then pl2.jp_description_id end)
	    LEFT JOIN ya_description d3 ON (d3.description_id = case when pl3.tw_description_id is not null then pl3.tw_description_id when pl3.us_description_id is not null then pl3.us_description_id when pl3.jp_description_id is not null then pl3.jp_description_id end)
	    LEFT JOIN ya_description d4 ON (d4.description_id = case when pl4.tw_description_id is not null then pl4.tw_description_id when pl4.us_description_id is not null then pl4.us_description_id when pl4.jp_description_id is not null then pl4.jp_description_id end)
	    LEFT JOIN ya_description d5 ON (d5.description_id = case when pl5.tw_description_id is not null then pl5.tw_description_id when pl5.us_description_id is not null then pl5.us_description_id when pl5.jp_description_id is not null then pl5.jp_description_id end)
	  WHERE
	    p.sku = iPsku;

  END GetProductJPDesc;

  PROCEDURE GetTextLotByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT
		  tl.text_lot_id,tl.lot_location,tl.priority,ptll.lang_id, nvl(ptll.description,'') AS description, nvl(ptll.desc_img_loc,'') AS image_loc,
		  nvl(ptll.desc_img_width, -1) AS image_width,
		  nvl(ptll.desc_img_height, -1) AS image_height,
		  nvl(tl.updated_user,'')  AS updated_user,
		  tl.updated_date
	  FROM
		  ya_mirror_text_lot tl
		  LEFT JOIN ya_mirror_text_lot_lang ptll ON tl.text_lot_id = ptll.text_lot_id
	  WHERE tl.file_id = iPfileId
	  ORDER BY tl.lot_location,tl.priority, tl.text_lot_id, ptll.lang_id;

  END GetTextLotByFileId;

  PROCEDURE GetTextLotByLotId (
    iPlotId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT tl.text_lot_id,tl.lot_location,tl.priority,ptll.lang_id, nvl(ptll.description,'') as description, nvl(ptll.desc_img_loc,'') as image_loc, nvl(ptll.desc_img_width, -1) as image_width, nvl(ptll.desc_img_height, -1) as image_height, nvl(tl.updated_user,'')  as updated_user, tl.updated_date
	  FROM ya_mirror_text_lot tl
	    left JOIN ya_mirror_text_lot_lang ptll ON tl.text_lot_id = ptll.text_lot_id
	  WHERE tl.text_lot_id = iPlotId
	  ORDER BY ptll.lang_id;

  END GetTextLotByLotId;

  PROCEDURE GetImageLotByLotId (
    iPlotId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT il.image_lot_id,il.lot_location,il.priority,ill.lang_id,nvl(ill.image_loc,'') as image_loc, nvl(ill.image_width, -1) as image_width, nvl(ill.image_height, -1) as image_height, ill.link_url, nvl(alt,'')  as alt, nvl(il.updated_user,'')  as updated_user,
il.updated_date
	  FROM ya_mirror_image_lot il
	  left JOIN ya_mirror_img_lot_lang ill ON il.image_lot_id = ill.image_lot_id
	  WHERE il.image_lot_id = iPlotId
	  ORDER BY ill.lang_id;

  END GetImageLotByLotId;

  PROCEDURE GetImageLotByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT il.image_lot_id,il.lot_location,il.priority,ill.lang_id,nvl(ill.image_loc,'') AS image_loc, nvl(ill.image_width, -1) AS image_width, nvl(ill.image_height, -1) AS image_height, ill.link_url, nvl(alt,'')  AS alt, nvl(il.updated_user,'')  AS updated_user, il.updated_date
	  FROM ya_mirror_image_lot il
	  LEFT JOIN ya_mirror_img_lot_lang ill ON il.image_lot_id = ill.image_lot_id
	  WHERE il.file_id = iPfileId
      ORDER BY il.lot_location,il.priority, il.image_lot_id, ill.lang_id;

  END GetImageLotByFileId;

  PROCEDURE GetProductLotByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT
	    pl.file_id, pl.prod_lot_id, pl.lot_location, pl.priority, nvl(pll.lang_id,1) AS lang_id,
		pl.sku, nvl(prl.prod_name_u,'') AS prod_name_u , pl.dept_id,
		nvl(pll.description,'') AS description, nvl(pl.updated_user,'')  AS updated_user, pl.updated_date
	  FROM
		ya_mirror_product_lot pl
	  LEFT JOIN ya_mirror_prod_lot_lang pll ON pl.prod_lot_id = pll.prod_lot_id
	  LEFT JOIN ya_prod_lang prl on pl.sku=prl.sku AND pll.lang_id=prl.lang_id
	  WHERE pl.file_id = iPfileId
	  ORDER BY
		pl.lot_location,  pl.priority,pl.prod_lot_id, pll.lang_id;

  END GetProductLotByFileId;

  PROCEDURE GetContentPublishByFileId (
    iPfileId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  Select
	    f.id,path,pi.site_id,pi.location,p.publish_flag
	  FROM ya_content_filename f
	  left join  ya_cm_content_page_info pi on f.id=pi.file_id
	  left join ya_content_publish p on f.id = p.file_id
	  where id=iPfileId;

  END GetContentPublishByFileId;

  PROCEDURE GetContentNameByKeyword (
    cPKeyword IN VARCHAR2,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  Select *
	  FROM ya_content_filename
	  where LOWER(path) like lower('%'||cPKeyword||'%') order by id;
  END GetContentNameByKeyword;

  PROCEDURE GetContentNameById (
    iPfileId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  Select *
	  FROM ya_content_filename
	  where id=iPfileId;

  END GetContentNameById;

  PROCEDURE GetUnPublishPage (
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  Select p.file_id,path,pi.site_id,nvl(pi.location,'') as location,update_dt 
	  FROM ya_content_filename f
	  left join ya_content_publish p on f.id = p.file_id
	  left join  ya_cm_content_page_info pi on p.file_id=pi.file_id
	  where publish_flag='N' order by update_dt desc;

  END GetUnPublishPage;

  PROCEDURE GetInvalidHighlights (
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT distinct pr.PROD_ID
	  FROM
	    prod_region pr,
	    prod_avlb pa,
	    ya_product_lot pl,
	    ya_product p,
	    ya_cm_content_page_info cpi
	  WHERE
	    pa.PROD_ID = pl.sku
	    AND p.sku = pl.sku
	    AND cpi.file_id = pl.file_id
	    AND pa.PROD_ID  = pr.PROD_ID
	    AND pr.CATEGORY_ID = pa.category
	    AND pa.category = 1
	    AND pr.REGION_ID = pa.REGION_ID
	    AND pa.REGION_ID = 7
	    AND pr.ORIGIN_ID = pa.ORIGIN_ID
	    AND pa.ORIGIN_ID = 7
	    AND cpi.site_id IN (7, 99)
	    AND p.is_parent = 'N'
	    AND
	    (
	      pa.AVLB >=60 OR
	      (
	        pr.IS_CAN_SELL = 'N' AND
	        pr.IS_ENABLED = 'N'
	      )
	    )
	UNION ALL
	  SELECT distinct pr.PROD_ID
	  FROM
	    prod_region pr,
	    prod_avlb pa,
	    ya_product_lot pl,
	    ya_product p,
	    ya_cm_content_page_info cpi
	  WHERE
	    pa.PROD_ID = pl.sku
	    AND p.sku = pl.sku
	    AND cpi.file_id = pl.file_id
	    AND pa.PROD_ID  = pr.PROD_ID
	    AND pr.CATEGORY_ID = pa.category
	    AND pa.category = 1
	    AND pr.REGION_ID = pa.REGION_ID
	    AND pa.REGION_ID = 1
	    AND pr.ORIGIN_ID = pa.ORIGIN_ID
	    AND pa.ORIGIN_ID = 1
	    AND cpi.site_id IN (1, 99)
	    AND p.is_parent = 'N'
	    AND
	    (
	      pa.AVLB >=60 OR
	      (
	        pr.IS_CAN_SELL = 'N' AND
	        pr.IS_ENABLED = 'N'
	      )
	    );

  END GetInvalidHighlights;

  PROCEDURE AddContentPage (
    iPsiteId IN INT,
	cPpageName IN VARCHAR2,
	cPpageLocation IN VARCHAR2,
	cPpublished IN CHAR,
	cPupdatedUsesr IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPfileId OUT INT
  )
  AS
    iLexistValue int;
  BEGIN

        iLexistValue := 1;

	WHILE (iLexistValue > 0)
	LOOP
            iLexistValue := 0;
		SELECT seq_ya_content_filename.nextval INTO iPfileId FROM dual;
                select count(*) into iLexistValue from ya_content_filename where id = iPfileId;
	END LOOP;

  INSERT INTO ya_content_filename
    (id,path)
  VALUES
    (iPfileId,cPpageName);


  INSERT INTO ya_content_publish
    (file_id, publish_flag, update_dt)
  VALUES
    (iPfileId, cPpublished, dtPUpdatedDate);

  INSERT INTO ya_cm_content_page_info
    (file_id, site_id, location, updated_user, updated_datetime)
  VALUES
    (iPfileId, iPsiteId, cPpageLocation, cPupdatedUsesr, dtPUpdatedDate);

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddContentPage;

  PROCEDURE UpdContentPage (
    iPfileId IN INT,
    iPsiteId IN INT,
	cPpageName IN VARCHAR2,
	cPpageLocation IN VARCHAR2,
	cPupdatedUsesr IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  )
  AS
  BEGIN

	update ya_content_filename
	set	path=cPpageName
	where id=iPfileId;

	update ya_cm_content_page_info
	set
		site_id=iPsiteId,
		location=cPpageLocation,
		updated_user=cPupdatedUsesr,
		updated_datetime=dtPUpdatedDate
	where file_id=iPfileId;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdContentPage;

  PROCEDURE DelContentPage (
    iPfileId IN INT,
    iProw_affacted OUT INT
  )
  AS
	dtLUpdatedDate DATE;
  BEGIN

    select sysdate into dtLUpdatedDate from dual;

-- ya_content_filename
    DELETE FROM ya_content_filename WHERE id = iPfileId;
-- ya_content_publish
    DELETE FROM ya_content_publish WHERE file_id = iPfileId;
-- ya_cm_content_page_info
    DELETE FROM ya_cm_content_page_info WHERE file_id = iPfileId;
-- ya_mirror_prod_lot_lang
    DELETE FROM ya_mirror_prod_lot_lang
    WHERE
      prod_lot_id IN
      (
        SELECT prod_lot_id
        FROM ya_mirror_product_lot
        WHERE file_id = iPfileId
      );
-- ya_mirror_prod_lot
    DELETE FROM ya_mirror_product_lot WHERE file_id =iPfileId;
-- ya_mirror_text_lot_lang
    DELETE FROM ya_mirror_text_lot_lang
    WHERE
      text_lot_id IN
      (
        SELECT text_lot_id
        FROM ya_mirror_text_lot
        WHERE file_id =iPfileId
      );
-- ya_mirror_text_lot
    DELETE FROM ya_mirror_text_lot WHERE file_id =iPfileId;
-- ya_mirror_img_lot_lang
    DELETE FROM ya_mirror_img_lot_lang
    WHERE
      image_lot_id IN
      (
        SELECT image_lot_id
        FROM ya_mirror_image_lot
        WHERE file_id =iPfileId
      );
-- ya_mirror_image_lot
    DELETE FROM ya_mirror_image_lot WHERE file_id =iPfileId;
-- ya_prod_lot_lang
    DELETE FROM ya_prod_lot_lang
    WHERE
      prod_lot_id IN
      (
        SELECT prod_lot_id
        FROM ya_product_lot
        WHERE file_id =iPfileId
      );
-- ya_prod_lot
    DELETE FROM ya_product_lot WHERE file_id =iPfileId;
-- ya_text_lot_lang
    DELETE FROM ya_text_lot_lang
    WHERE
      text_lot_id IN
      (
        SELECT text_lot_id
        FROM ya_text_lot
        WHERE file_id =iPfileId
      );
-- ya_text_lot
    DELETE FROM ya_text_lot WHERE file_id =iPfileId;
-- ya_img_lot_lang
    DELETE FROM ya_img_lot_lang
    WHERE
      image_lot_id IN
      (
        SELECT image_lot_id
        FROM ya_image_lot
        WHERE file_id =iPfileId
      );
-- ya_image_lot
    DELETE FROM ya_image_lot WHERE file_id =iPfileId;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelContentPage;

  PROCEDURE UpdProductLotDesc (
    iPproductLotId IN INT,
    iPlangId IN INT,
	cPdesc IN VARCHAR2,
	cPupdatedUser IN VARCHAR2,
    iProw_affacted OUT INT
  )
  AS
   iLhaveLang INT;
  BEGIN

	select 0 into iLhaveLang from dual;
    SELECT count(*) into iLhaveLang
    FROM
      ya_mirror_product_lot p,
      ya_mirror_prod_lot_lang pl
    WHERE
      pl.prod_lot_id = p.prod_lot_id
      AND p.prod_lot_id = iPproductLotId
      AND pl.lang_id = iPlangId;

  --found such rows
  IF iLhaveLang > 0 Then
    UPDATE ya_mirror_prod_lot_lang
    SET
      description = cPdesc
    WHERE
      prod_lot_id =  iPproductLotId
      AND lang_id = iPlangId;
  ELSE
    INSERT INTO ya_mirror_prod_lot_lang
    (prod_lot_id, lang_id, description)
    VALUES
    (iPproductLotId, iPlangId, cPdesc);
  END IF;

  UPDATE ya_mirror_product_lot
  SET updated_user = cPupdatedUser
  WHERE prod_lot_id = iPproductLotId;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdProductLotDesc;

  PROCEDURE GetProductLotDesc (
    iPproductLotId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
	  SELECT description
	  FROM ya_mirror_prod_lot_lang
	  WHERE
	    prod_lot_id = iPproductLotId
	    AND lang_id = iPlangId;

  END GetProductLotDesc;

  PROCEDURE GetProductLotByProdLotID (
    iPproductLotId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    curPresult3 OUT refCur
  )
  AS
  BEGIN
    -- ya_mirror_product_lot
    OPEN curPresult1 FOR
	  SELECT
	    pl.file_id,
	    pl.prod_lot_id,
	    pl.lot_location,
	    pl.priority,
	    pl.sku,
	    pl.dept_id,
	    nvl(pl.updated_user,'')  as updated_user,
	    pl.updated_date
	  FROM
	    ya_mirror_product_lot pl
	  WHERE
	    prod_lot_id = iPproductLotId;

	--ya_mirror_prod_lot_lang
    OPEN curPresult2 FOR
	  SELECT
	    nvl(pll.lang_id,1) as lang_id,
	    nvl(pll.description,'') as description
	  FROM
	    ya_mirror_prod_lot_lang pll
	  WHERE
	    prod_lot_id = iPproductLotId
	  ORDER BY lang_id;

    --ya_prod_lang
    OPEN curPresult3 FOR
	  SELECT
	    nvl(prl.prod_name_u,'') as prod_name_u,
	    lang_id
	  FROM
	    ya_prod_lang prl,
	    ya_mirror_product_lot pl
	  WHERE
	    pl.sku = prl.sku
	    AND pl.prod_lot_id = iPproductLotId
	  ORDER BY lang_id;

  END GetProductLotByProdLotID;

  PROCEDURE AddProductLot (
    iPfileId IN INT,
    iPsku IN INT,
    iPdeptId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPproductLotId OUT INT
  )
  AS
    iLexistValue int;
  BEGIN

        iLexistValue := 1;

	WHILE (iLexistValue > 0)
	LOOP
            iLexistValue := 0;
	            select seq_ya_mirror_product_lot.nextval into iPproductLotId from dual;
                select count(*) into iLexistValue from ya_mirror_product_lot where PROD_LOT_ID = iPproductLotId;
	END LOOP;

	If (iPpriority<0) Then
	insert into ya_mirror_product_lot (PROD_LOT_ID, file_id, sku, dept_id, lot_location, active, priority, updated_user, updated_date)
	values (iPproductLotId, iPfileId, iPsku, iPdeptId, iPlotLocation, cPactive, null, cPupdatedUser, dtPUpdatedDate);
	else
		insert into ya_mirror_product_lot (PROD_LOT_ID, file_id, sku, dept_id, lot_location, active, priority, updated_user, updated_date)
		values (iPproductLotId, iPfileId, iPsku, iPdeptId, iPlotLocation, cPactive, iPpriority, cPupdatedUser, dtPUpdatedDate);
	End If;



    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddProductLot;

  PROCEDURE AddProductLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPsescImgWidth IN INT,
	iPsescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
	cPaltImgLoc IN VARCHAR2,
	iPaltImgWidth IN INT,
	iPaltImgHeight IN INT,
	cPaltImgLink IN VARCHAR2,
	cPremark IN VARCHAR2,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
	INSERT INTO ya_mirror_prod_lot_lang (
	  prod_lot_id, lang_id, description, desc_img_loc, desc_img_width, desc_img_height, preferred_flag, alt_img_loc,
	  alt_img_width, alt_img_height, alt_img_link, remark)
	VALUES (
      iPlotId, iPlangId, cPdescription, cPdescImgLoc, iPsescImgWidth, iPsescImgHeight, cPpreferredFlag, cPaltImgLoc,
	  iPaltImgWidth, iPaltImgHeight, cPaltImgLink, cPremark);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddProductLotLang;

  PROCEDURE AddImageLot (
    iPfileId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPimageLotId OUT INT
  )
  AS
    iLexistValue int;
  BEGIN

        iLexistValue := 1;

	WHILE (iLexistValue > 0)
	LOOP
            iLexistValue := 0;
	            select seq_ya_mirror_image_lot.nextval into iPimageLotId from dual;
                select count(*) into iLexistValue from ya_mirror_image_lot where IMAGE_LOT_ID = iPimageLotId;
	END LOOP;

	if iPpriority<0 Then
		INSERT INTO ya_mirror_image_lot (
		  IMAGE_LOT_ID, file_id, lot_location, active, priority, updated_user, updated_date)
		VALUES (
		  iPimageLotId, iPfileId, iPlotLocation, cPactive, null, cPupdatedUser, dtPUpdatedDate);
	else
		INSERT INTO ya_mirror_image_lot (
		  IMAGE_LOT_ID, file_id, lot_location, active, priority, updated_user, updated_date)
		VALUES (
		  iPimageLotId, iPfileId, iPlotLocation, cPactive, iPpriority, cPupdatedUser, dtPUpdatedDate);
	End If;

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddImageLot;

  PROCEDURE AddImageLotLang (
    iPimageLotId IN INT,
    iPlangId IN INT,
	cPimageLoc IN VARCHAR2,
	iPimageWidth IN INT,
	iPimageHeight IN INT,
	cPalt IN VARCHAR2,
	cPlinkUrl IN VARCHAR2,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  )
  AS
  BEGIN

	INSERT INTO ya_mirror_img_lot_lang (
	  image_lot_id, lang_id, image_loc, image_width, image_height, alt, link_url, preferred_flag)
	VALUES (
	  iPimageLotId, iPlangId, cPimageLoc, iPimageWidth, iPimageHeight, cPalt, cPlinkUrl, cPpreferredFlag);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddImageLotLang;

  PROCEDURE AddTextLot (
    iPfileId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPtextLotId OUT INT
  )
  AS
    iLexistValue int;
  BEGIN

        iLexistValue := 1;

	WHILE (iLexistValue > 0)
	LOOP
            iLexistValue := 0;
	            select seq_ya_mirror_text_lot.nextval into iPtextLotId from dual;
                select count(*) into iLexistValue from ya_mirror_text_lot where TEXT_LOT_ID = iPtextLotId;
	END LOOP;

	if iPpriority<0 Then
		INSERT INTO ya_mirror_text_lot (
		  TEXT_LOT_ID, file_id, lot_location, active, priority, updated_user, updated_date)
		VALUES (
		  iPtextLotId, iPfileId, iPlotLocation, cPactive, null, cPupdatedUser, dtPUpdatedDate);
	else
		INSERT INTO ya_mirror_text_lot (
		  TEXT_LOT_ID, file_id, lot_location, active, priority, updated_user, updated_date)
		VALUES (
		  iPtextLotId, iPfileId, iPlotLocation, cPactive, iPpriority, cPupdatedUser, dtPUpdatedDate);
	End If;

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddTextLot;

  PROCEDURE AddTextLotLang (
    iPtextLotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPdescImgWidth IN INT,
	iPdescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  )
  AS
  BEGIN

	INSERT INTO ya_mirror_text_lot_lang (
	  text_lot_id, lang_id, description, desc_img_loc, desc_img_width, desc_img_height, preferred_flag)
	VALUES (
	  iPtextLotId, iPlangId, cPdescription, cPdescImgLoc, iPdescImgWidth, iPdescImgHeight, cPpreferredFlag);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddTextLotLang;

  PROCEDURE UpdProductLot (
    iPlotId IN INT,
    iPsku IN INT,
    iPdeptId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  )
  AS
  BEGIN

	If (iPpriority<0) Then
		update ya_mirror_product_lot
		set
			sku = iPsku,
			dept_id = iPdeptId,
			lot_location = iPlotLocation,
			active = cPactive,
			priority = null,
			updated_user = cPupdatedUser,
			updated_date = dtPUpdatedDate
		where prod_lot_id = iPlotId;
	else
		update ya_mirror_product_lot
		set
			sku = iPsku,
			dept_id = iPdeptId,
			lot_location = iPlotLocation,
			active = cPactive,
			priority = iPpriority,
			updated_user = cPupdatedUser,
			updated_date = dtPUpdatedDate
		where prod_lot_id = iPlotId;
	End If;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdProductLot;

  PROCEDURE UpdProductLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPdescImgWidth IN INT,
	iPdescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
	iPaltImgLoc IN VARCHAR2,
	iPaltImgWidth IN INT,
	iPaltImgHeight IN INT,
	cPaltImgLink IN VARCHAR2,
	cPremark IN VARCHAR2,
    iProw_affacted OUT INT
  )
  AS
  iLcount INT;
  BEGIN

	select count (*) into iLcount from ya_mirror_prod_lot_lang
	WHERE
	    prod_lot_id = iPlotId and
	    lang_id = iPlangId;

	if iLcount>0 Then
	  UPDATE ya_mirror_prod_lot_lang
	  SET
	    description = cPdescription,
	    desc_img_loc = cPdescImgLoc,
	    desc_img_width = iPdescImgWidth,
	    desc_img_height = iPdescImgHeight,
	    preferred_flag = cPpreferredFlag,
	    alt_img_loc = iPaltImgLoc,
	    alt_img_width = iPaltImgWidth,
	    alt_img_height = iPaltImgHeight,
	    alt_img_link = cPaltImgLink,
	    remark = cPremark
	  WHERE
	    prod_lot_id = iPlotId and
	    lang_id = iPlangId;
	else
	  INSERT INTO ya_mirror_prod_lot_lang (
	    prod_lot_id, lang_id, description, desc_img_loc, desc_img_width, desc_img_height, preferred_flag, alt_img_loc,
		alt_img_width, alt_img_height, alt_img_link, remark)
	  VALUES (
	    iPlotId, iPlangId, cPdescription, cPdescImgLoc, iPdescImgWidth, iPdescImgHeight, cPpreferredFlag, iPaltImgLoc,
		iPaltImgWidth, iPaltImgHeight, cPaltImgLink, cPremark);
	End If;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdProductLotLang;

  PROCEDURE UpdImageLot (
    iPimageLotId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  )
  AS
  BEGIN

	If (iPpriority<0) Then
		UPDATE ya_mirror_image_lot
		SET
		    lot_location = iPlotLocation,
		    active = cPactive,
		    priority = null,
		    updated_user = cPupdatedUser,
		    updated_date = dtPUpdatedDate
		WHERE
		    image_lot_id = iPimageLotId;
	else
		UPDATE ya_mirror_image_lot
		SET
		    lot_location = iPlotLocation,
		    active = cPactive,
		    priority = iPpriority,
		    updated_user = cPupdatedUser,
		    updated_date = dtPUpdatedDate
		WHERE
		    image_lot_id = iPimageLotId;
	End If;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdImageLot;

  PROCEDURE UpdImageLotLang (
    iPimageLotId IN INT,
    iPlangId IN INT,
	cPimageLoc IN VARCHAR2,
	iPimageWidth IN INT,
	iPimageHeight IN INT,
	cPalt IN VARCHAR2,
	cPlinkUrl IN VARCHAR2,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  )
  AS
  iLcount INT;
  BEGIN

	select count (*) into iLcount
	from ya_mirror_img_lot_lang
	WHERE
	    image_lot_id = iPimageLotId and
	    lang_id = iPlangId;

	if iLcount>0 Then
	  UPDATE ya_mirror_img_lot_lang
	  SET
	    image_loc = cPimageLoc,
	    image_width = iPimageWidth,
	    image_height = iPimageHeight,
	    alt = cPalt,
	    link_url = cPlinkUrl,
	    preferred_flag = cPpreferredFlag
	  WHERE
	    image_lot_id = iPimageLotId and
	    lang_id = iPlangId;
	else
	  INSERT INTO ya_mirror_img_lot_lang (
		image_lot_id, lang_id, image_loc, image_width, image_height, alt, link_url, preferred_flag)
	  VALUES (
	    iPimageLotId, iPlangId, cPimageLoc, iPimageWidth, iPimageHeight, cPalt, cPlinkUrl, cPpreferredFlag);
	End If;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdImageLotLang;

  PROCEDURE UpdTextLot (
    iPlotId IN INT,
	iPlotLocation IN INT,
	cPactive IN CHAR,
	iPpriority IN INT,
	cPupdatedUser IN VARCHAR2,
	dtPUpdatedDate IN DATE,
    iPtextLotId OUT INT
  )
  AS
  BEGIN

	If (iPpriority<0) Then
		UPDATE ya_mirror_text_lot
		SET
		    lot_location = iPlotLocation,
		    active = cPactive,
		    priority = null,
		    updated_user = cPupdatedUser,
		    updated_date = dtPUpdatedDate
		where
		    text_lot_id = iPlotId;
	else
		UPDATE ya_mirror_text_lot
		SET
		    lot_location = iPlotLocation,
		    active = cPactive,
		    priority = iPpriority,
		    updated_user = cPupdatedUser,
		    updated_date = dtPUpdatedDate
		where
		    text_lot_id = iPlotId;
	End If;

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdTextLot;

  PROCEDURE UpdTextLotLang (
    iPtextLotId IN INT,
    iPlangId IN INT,
	cPdescription IN VARCHAR2,
	cPdescImgLoc IN VARCHAR2,
	iPdescImgWidth IN INT,
	iPdescImgHeight IN INT,
	cPpreferredFlag IN CHAR,
    iProw_affacted OUT INT
  )
  AS
  iLcount INT;
  BEGIN

	select count (*) into iLcount
	from ya_mirror_text_lot_lang
	WHERE
	    text_lot_id = iPtextLotId and
	    lang_id = iPlangId;

	if iLcount>0 Then
	  UPDATE ya_mirror_text_lot_lang
	  SET
	    description = cPdescription,
	    desc_img_loc = cPdescImgLoc,
	    desc_img_width = iPdescImgWidth,
	    desc_img_height = iPdescImgHeight,
	    preferred_flag = cPpreferredFlag
	  WHERE
	    text_lot_id = iPtextLotId and
	    lang_id = iPlangId;
	else
	  INSERT INTO ya_mirror_text_lot_lang (
		text_lot_id, lang_id, description, desc_img_loc, desc_img_width, desc_img_height, preferred_flag)
	  VALUES (
	    iPtextLotId, iPlangId, cPdescription, cPdescImgLoc, iPdescImgWidth, iPdescImgHeight, cPpreferredFlag);
	End If;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdTextLotLang;

  PROCEDURE DelProductLot (
    iPlotId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    delete ya_mirror_product_lot where prod_lot_id = iPlotId;

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelProductLot;

  PROCEDURE DelProductLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    delete ya_mirror_prod_lot_lang where prod_lot_id = iPlotId and lang_id = iPlangId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelProductLotLang;

  PROCEDURE DelTextLot (
    iPlotId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    delete ya_mirror_text_lot where text_lot_id = iPlotId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelTextLot;

  PROCEDURE DelTextLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    delete ya_mirror_text_lot_lang where text_lot_id = iPlotId and lang_id = iPlangId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelTextLotLang;

  PROCEDURE DelImageLot (
    iPlotId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    delete ya_mirror_image_lot where image_lot_id = iPlotId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelImageLot;

  PROCEDURE DelImageLotLang (
    iPlotId IN INT,
    iPlangId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    delete ya_mirror_img_lot_lang where image_lot_id = iPlotId and lang_id = iPlangId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelImageLotLang;

  PROCEDURE AddContentPublish (
    iPfileId IN INT,
	cPpublishFlag IN CHAR,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    INSERT INTO ya_content_publish (
	  file_id, publish_flag, update_dt)
	VALUES (
	  iPfileId, cPpublishFlag, dtPUpdatedDate);
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END AddContentPublish;

  PROCEDURE UpdContentPublish (
    iPfileId IN INT,
	cPpublishFlag IN CHAR,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
	UPDATE ya_content_publish
	SET
	    publish_flag = cPpublishFlag,
	    update_dt = dtPUpdatedDate
	WHERE
	    file_id = iPfileId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END UpdContentPublish;

  PROCEDURE DelContentPublish (
    iPfileId IN INT,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
	DELETE ya_content_publish WHERE file_id = iPfileId;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END DelContentPublish;

  PROCEDURE PubContentPage (
    iPfileId IN INT,
	dtPUpdatedDate IN DATE,
    iProw_affacted OUT INT
  )
  AS
  BEGIN
    DELETE FROM ya_prod_lot_lang
    WHERE prod_lot_id IN
    (
		SELECT prod_lot_id
		FROM ya_product_lot
		WHERE file_id = iPfileId
	);

    DELETE FROM ya_product_lot WHERE file_id = iPfileId;

    DELETE FROM ya_text_lot_lang
    WHERE text_lot_id IN
	(
	    SELECT text_lot_id
		FROM ya_text_lot
		WHERE file_id = iPfileId
	);

    DELETE FROM ya_text_lot WHERE file_id = iPfileId;

    DELETE FROM ya_img_lot_lang
    WHERE image_lot_id IN
	(
	  SELECT image_lot_id
	  FROM ya_image_lot
	  WHERE file_id = iPfileId
	);

    DELETE FROM ya_image_lot WHERE file_id = iPfileId;

    INSERT into ya_product_lot
      (prod_lot_id,file_id,sku,dept_id,lot_location,active,priority,updated_user,updated_date)
    SELECT prod_lot_id,file_id,sku,dept_id,lot_location,
      active,priority,updated_user,updated_date
      FROM ya_mirror_product_lot WHERE file_id = iPfileId;


	INSERT INTO ya_prod_lot_lang
	  (prod_lot_id,lang_id,desc_img_loc,desc_img_width, desc_img_height,description,preferred_flag, remark)
	SELECT prod_lot_id,lang_id,desc_img_loc,desc_img_width, desc_img_height,description,preferred_flag, remark
	  FROM ya_mirror_prod_lot_lang
	  WHERE prod_lot_id IN
	  (SELECT prod_lot_id FROM ya_mirror_product_lot WHERE file_id = iPfileId);

    INSERT INTO ya_text_lot
      (text_lot_id,file_id,lot_location,active,priority,updated_user,updated_date)
    SELECT text_lot_id,file_id,lot_location,active,priority,updated_user,updated_date
      FROM ya_mirror_text_lot WHERE file_id = iPfileId;

    INSERT INTO ya_text_lot_lang
      (text_lot_id,lang_id,desc_img_loc,desc_img_width,desc_img_height,description,preferred_flag)
    SELECT text_lot_id,lang_id,desc_img_loc,desc_img_width, desc_img_height,description,preferred_flag
      FROM ya_mirror_text_lot_lang
      WHERE text_lot_id IN (SELECT text_lot_id FROM ya_mirror_text_lot WHERE file_id = iPfileId);

    INSERT INTO ya_image_lot (image_lot_id,file_id,lot_location,active,priority,updated_user,updated_date)
    SELECT image_lot_id,file_id,lot_location,active,priority,updated_user,updated_date
	  FROM ya_mirror_image_lot WHERE file_id = iPfileId;


    INSERT INTO ya_img_lot_lang (image_lot_id,lang_id,image_loc,image_width,image_height,link_url,alt,preferred_flag)
    SELECT image_lot_id,lang_id,image_loc,image_width,image_height,link_url,alt,preferred_flag
      FROM ya_mirror_img_lot_lang
      WHERE image_lot_id IN (SELECT image_lot_id FROM ya_mirror_image_lot WHERE file_id = iPfileId);

    DELETE FROM ya_content_publish WHERE file_id = iPfileId;

    INSERT into ya_content_publish (file_id,publish_flag,update_dt)
	VALUES (iPfileId,'Y',dtPUpdatedDate);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END PubContentPage;

  END Pkg_fe_CM_ContentAccess;
/
 