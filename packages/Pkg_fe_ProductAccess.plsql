CREATE OR REPLACE PACKAGE "PKG_FE_PRODUCTACCESS" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetProductCountByDepartment (
    iPdeptId IN INT,
    iPcount OUT INT
  );

  PROCEDURE GetPrdCountByArtistDepartment (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPcount OUT INT
  );

  PROCEDURE GetPublisherGroupName (
    iPgroup_id    	IN  INT,
    iPlang_id   	IN  INT,
    cPpublisherName 	OUT VARCHAR2
  );

  PROCEDURE GetAttributeInfo (
    iPattrId  		IN  INT,
    curPgetAttri1 	OUT refCur,
    curPgetAttri2 	OUT refCur
  );

  PROCEDURE GetSupplierName (
    iPsupplier_id 	IN  INT,
    iPlang_id  		IN  INT,
    cPsupplierName 	OUT VARCHAR2
  );

  PROCEDURE GetFrontPageProductLots (
    iPfileId		IN	INT,
    iPlangId		IN	INT,
    iPsiteId		IN	INT,
    curPgetFrontpage	OUT	refCur
  );

  PROCEDURE GetFrontPageProductLots_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPgetFrontpage OUT refCur
  );

  PROCEDURE GetFPProdLotsWOSite (
    iPfileId		IN	INT,
    iPlangId		IN	INT,
    curPgetFrontpage	OUT	refCur
  );

  PROCEDURE GetFPProdLotsWOSite_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    curPgetFrontpage OUT refCur
  );

  PROCEDURE GetProductVideosInformation (
    iPsku		IN	INT,
    curPgetProduct	OUT	refCur
  );

  PROCEDURE GetProductBasePublisher (
    cPshopper_id  		IN 	VARCHAR2,
    iPsite_id  		IN 	INT,
    curPgetProduct1 	OUT 	refCur
  );
  
  PROCEDURE GetProductBase (
    cPsku_csv  		IN 	VARCHAR2,
    iPsite_id  		IN 	INT,
    iPlang_id  		IN 	INT,
    curPgetProduct1 	OUT 	refCur,
    curPgetProduct2 	OUT 	refCur,
    curPgetProduct3 	OUT 	refCur,
    curPgetProduct4 	OUT 	refCur,
    curPgetProduct5 	OUT 	refCur,
    curPgetProduct6 	OUT 	refCur
  );

  PROCEDURE GetDeptIDListBySKU (
    iPsku		IN	INT,
    iPsite_id		IN	INT,
    curPgetDept		OUT	refCur
  );

  PROCEDURE GetDeptIDListByGroupID (
    iPsku		IN	INT,
    iPsite_id		IN	INT,
    curPgetDept		OUT	refCur
  );

  PROCEDURE GetPreferredProductLangBySKU (
    iPsku  		IN 	INT,
    curPgetPreferred 	OUT 	refCur
  );

  PROCEDURE GetSeoEnabledSkuList (
    iPlRange  IN INT,
    iPuRange  IN INT,
    iPsiteId  IN INT,
    curPgetSeo  OUT refCur
  );

  PROCEDURE GetMaxProductSku (
    iPsiteID  IN  INT,
    iPMaxSku  OUT INT
  );

  PROCEDURE GetProductGalleryImages (
    iPsku IN INT,
    iPlangId IN INT,
    curPgetStoryBoard OUT refCur
  );

  PROCEDURE GetPSFirstGalleryImages (
    iPsku IN INT,
    iPlangId IN INT,
    iPsiteId IN INT,
    curPgetPS OUT refCur
  );

  PROCEDURE GetProductGalleryImagesCount (
    iPsku IN INT,
    iPlangId IN INT,
    iPcount OUT INT
  );

  PROCEDURE GetGroupIdByAccountId(
    iPaccountId IN INT,
    iPdivisionId IN INT,
    iPgroupId out INT
  );

  PROCEDURE GetBargainSuppInfoData (
    iPsite_id		IN	INT,
    curPgetBargainSuppInfo	OUT	refCur
  );

  -- YesStyle
  PROCEDURE GetPublisherProductGroup (
    iPpublisherId IN INT,
    iPlangId IN INT,
    curPgetProductGroup OUT refCur
  );
    PROCEDURE GetFrontPageProductLotsByPId (
    iPpublisherId	IN	INT,
    iPDeptId		IN	INT,
    iPlangId		IN	INT,
    iPsiteId		IN	INT,
    curPgetFrontpage	OUT	refCur
  ); /* For get brand page product lot */
END Pkg_Fe_Productaccess;
/
CREATE OR REPLACE PACKAGE BODY "PKG_FE_PRODUCTACCESS" 
IS
  PROCEDURE GetPublisherGroupName (
    iPgroup_id    IN  INT,
    iPlang_id   IN  INT,
    cPpublisherName OUT VARCHAR2
  )
  AS
  BEGIN
    BEGIN
      SELECT publisher_name INTO cPpublisherName
      FROM YA_PUBLISHER_GROUP_LANG
      WHERE publisher_group_id = iPgroup_id
      AND lang_id = iPlang_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        cPpublisherName := NULL;
    END;
    RETURN;
  END GetPublisherGroupName;


  PROCEDURE GetAttributeInfo(
    iPattrId  IN INT,
    curPgetAttri1 OUT refCur,
    curPgetAttri2 OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetAttri1 FOR
      SELECT
        al.attribute_name,
        CAST(al.lang_id AS INT)
      FROM YA_ATTRIBUTE_LANG al
      WHERE al.attribute_id = iPattrId
      AND al.lang_id <= 4
      ORDER BY al.lang_id;

    OPEN curPgetAttri2 FOR
      SELECT
        a.attribute_id,
        CAST(a.attribute_type_id AS INT),
        a.img_loc,
        NVL(a.img_height,0),
        NVL(a.img_width,0)
      FROM YA_ATTRIBUTE a
      WHERE a.attribute_id = iPattrId;
  RETURN;
  END GetAttributeInfo;


/* proc_fe_get_supplier_name */
  PROCEDURE GetSupplierName (
    iPsupplier_id IN  INT,
    iPlang_id   IN  INT,
    cPsupplierName OUT VARCHAR2
    )
  AS
  BEGIN
    BEGIN
      SELECT supplier_name INTO cPsupplierName
      FROM YA_SUPPLIER_LANG
      WHERE supplier_id = iPsupplier_id
      AND lang_id = iPlang_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        cPsupplierName := '';
    END;
  END GetSupplierName;

  PROCEDURE GetFrontPageProductLots (
    iPfileId		IN	INT,
    iPlangId		IN	INT,
    iPsiteId		IN	INT,
    curPgetFrontpage	OUT	refCur
  )
  AS
  BEGIN
    OPEN curPgetFrontpage FOR
        SELECT
          pl.sku,
          pl.lot_location,
          pll.description,
          pl.dept_id,
          '' as desc_img_loc,
          0 as desc_img_width,
          0 as desc_img_height,
          NULL,
          -1,
          pll.remark
        FROM
          YA_PRODUCT_LOT pl
          LEFT OUTER JOIN YA_PROD_LOT_LANG pll ON
            pl.prod_lot_id = pll.prod_lot_id
            AND pll.lang_id = iPlangId
          INNER JOIN prod_region pr ON
            pl.sku = pr.prod_id
		    AND pr.region_id=iPsiteId
        WHERE
          pl.file_id = iPfileId
          AND pr.is_enabled = 'Y'
        ORDER BY pl.lot_location, pl.priority;
  RETURN;
  END;



  PROCEDURE GetFrontPageProductLots_Mirror (
    iPfileId		IN	INT,
    iPlangId		IN	INT,
    iPsiteId		IN	INT,
    curPgetFrontpage	OUT	refCur
  )
  AS
  BEGIN
	  OPEN curPgetFrontpage FOR
        SELECT
          pl.sku,
          pl.lot_location,
          pll.description,
          pl.dept_id,
          PLI.desc_img_loc,
          NVL(PLI.desc_img_width,0),
          NVL(PLI.desc_img_height,0),
          NULL, --dl.dept_name,
          -1, --NVL(ps.dept_id, -1),
          pll.remark
        FROM
          ya_mirror_product_lot pl
          LEFT OUTER JOIN ya_mirror_prod_lot_lang pll ON
            pl.prod_lot_id = pll.prod_lot_id
            AND pll.lang_id = iPlangId
          LEFT OUTER JOIN ya_mirror_prod_lot_lang PLI ON
            PLI.prod_lot_id = pl.prod_lot_id
          INNER JOIN prod_region pr ON
            pl.sku = pr.prod_id
		    AND pr.region_id=iPsiteId
        WHERE
          pl.file_id = iPfileId
          AND pr.is_enabled = 'Y'
        ORDER BY pl.lot_location, pl.priority;
  RETURN;
  END;

	PROCEDURE GetFPProdLotsWOSite (
    iPfileId		IN	INT,
    iPlangId		IN	INT,
    curPgetFrontpage	OUT	refCur
  )
	AS
BEGIN
  OPEN curPgetFrontpage FOR
      SELECT
        pl.sku,
        pl.lot_location,
        pll.description,
        pl.dept_id,
        PLI.desc_img_loc,
        NVL(PLI.desc_img_width,0),
        NVL(PLI.desc_img_height,0),
        NULL, --dl.dept_name,
        -1, --NVL(ps.dept_id, -1),
        pll.remark
      FROM
        YA_PRODUCT_LOT pl
        LEFT OUTER JOIN YA_PROD_LOT_LANG pll ON
          pl.prod_lot_id = pll.prod_lot_id
          AND pll.lang_id = iPlangId
        LEFT OUTER JOIN YA_PROD_LOT_LANG PLI ON
          PLI.prod_lot_id = pl.prod_lot_id
      WHERE
        pl.file_id = iPfileId
      ORDER BY pl.lot_location, pl.priority;
RETURN;
END;

  PROCEDURE GetFPProdLotsWOSite_Mirror (
    iPfileId IN INT,
    iPlangId IN INT,
    curPgetFrontpage OUT refCur
  )
	AS
BEGIN
	OPEN curPgetFrontpage FOR
      SELECT
        pl.sku,
        pl.lot_location,
        pll.description,
        pl.dept_id,
        PLI.desc_img_loc,
        NVL(PLI.desc_img_width,0),
        NVL(PLI.desc_img_height,0),
        NULL, --dl.dept_name,
        -1, --NVL(ps.dept_id, -1),
        pll.remark
      FROM
        ya_mirror_product_lot pl
        LEFT OUTER JOIN ya_mirror_prod_lot_lang pll ON
          pl.prod_lot_id = pll.prod_lot_id
          AND pll.lang_id = iPlangId
        LEFT OUTER JOIN ya_mirror_prod_lot_lang PLI ON
          PLI.prod_lot_id = pl.prod_lot_id
      WHERE
        pl.file_id = iPfileId
      ORDER BY pl.lot_location, pl.priority;
RETURN;
END;


  PROCEDURE GetProductVideosInformation (
    iPsku		IN	INT,
    curPgetProduct	OUT	refCur
  )
  AS
  BEGIN
    OPEN curPgetProduct FOR
    SELECT sample_loc FROM YA_PROD_VIDEO WHERE sku = iPsku;
  RETURN;
  END;

  PROCEDURE GetProductBasePublisher (
    cPshopper_id  IN 	VARCHAR2,
    iPsite_id     IN  INT,
    curPgetProduct1 	OUT 	refCur
  )
  AS
  BEGIN
    OPEN curPgetProduct1 FOR
    SELECT nb.sku, nvl(p.publisher_id, -1)
    FROM ya_product p
      INNER JOIN ya_new_basket nb ON p.sku = nb.sku
    WHERE nb.shopper_id = cPshopper_id
      AND nb.site_id = iPsite_id
      AND nb.type = 0;
  END GetProductBasePublisher;

  PROCEDURE GetProductBase (
      cPsku_csv		IN	VARCHAR2,
      iPsite_id		IN	INT,
      iPlang_id		IN	INT,
      curPgetProduct1	OUT	refCur,
      curPgetProduct2	OUT	refCur,
      curPgetProduct3	OUT	refCur,
      curPgetProduct4	OUT	refCur,
      curPgetProduct5	OUT	refCur,
      curPgetProduct6	OUT	refCur
      )
  AS
      iLstartpos	  	INT := 1;
      iLendpos		  	INT;
      dtLnullDate	  	DATE;
      iLtemp		  	INT;
      iLShipmentUnitConst	INT;
      cLsku_csv			VARCHAR2(2000);
      iCounter			INT;
      iLRegionId    INT;
      iLOriginId    INT;
  BEGIN
    IF iPsite_id = 11 THEN
		  begin
		    iLRegionId := 10;
		    iLOriginId := 10;
		  end;
		ELSE
		  begin
		    iLRegionId := iPsite_id;
		    iLOriginId := iPsite_id;
		  end;
  	END IF;
  	EXECUTE IMMEDIATE 'TRUNCATE TABLE ss_adm.temp_product_int_table';

    dtLnullDate := TO_DATE('01-01-1900','DD-MM-YYYY');
    cLsku_csv := cPsku_csv;
    iLtemp := NVL(LENGTH(RTRIM(cLsku_csv)),0);

    IF(iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLsku_csv, ',');
        WHILE  iLendpos  >  0
        LOOP
          BEGIN
      	  INSERT INTO TEMP_PRODUCT_INT_TABLE
          (
            column1
          )
          VALUES
          (
            CAST(SUBSTR(cLsku_csv,1,iLendpos-1) AS INT)
          );
  	      cLsku_csv := SUBSTR(cLsku_csv, iLendpos+1);
          iLendpos := INSTR(cLsku_csv, ',');
        END;
        END LOOP;

      	INSERT INTO TEMP_PRODUCT_INT_TABLE
        (
          column1
        )
        VALUES
        (
          CAST(cLsku_csv AS INT)
        );
      END;
    END IF;

    /* Attribute Info */
    OPEN curPgetProduct1 FOR
    SELECT
      pa.sku,
      pa.attribute_id,
      a.attribute_type_id,
      NVL(al.attribute_name, ale.attribute_name),
      a.img_loc,
      NVL(a.img_height, 0),
      NVL(a.img_width, 0)
    FROM
      YA_PROD_ATTR pa,
      YA_ATTRIBUTE a,
      YA_ATTRIBUTE_LANG ale,
      YA_ATTRIBUTE_LANG al,
      TEMP_PRODUCT_INT_TABLE p
    WHERE 1=1
    AND p.column1 = pa.sku
    AND pa.attribute_id = a.attribute_id
    AND pa.attribute_id = ale.attribute_id
    AND pa.attribute_id = al.attribute_id
    AND a.attribute_id = ale.attribute_id
    AND a.attribute_id = al.attribute_id
    AND al.lang_id = iPlang_id
    AND ale.lang_id = 1 /* English */
    ORDER BY pa.sku, a.attribute_type_id;

    /* Limited Quantity */
    OPEN curPgetProduct2 FOR
    SELECT
      lq.sku,
      lq.frontend_quantity
    FROM
      YA_LIMITED_QUANTITY lq,
      TEMP_PRODUCT_INT_TABLE p
    WHERE lq.sku = p.column1
    AND lq.site_id IN (99, iLOriginId)
    AND lq.frontend_quantity > 0
    ORDER BY lq.sku;

    /* Get shipment Unit */
    iLShipmentUnitConst := 200; /* in Grams */
    OPEN curPgetProduct3 FOR
    SELECT
      t1.sku,
      CASE
        WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
        ELSE
          CEIL
            (
              NVL
                (
                  CASE
                    WHEN dimension_weight IS NOT NULL AND weight IS NOT NULL THEN
                      CASE
                        WHEN dimension_weight > weight THEN dimension_weight
                        ELSE weight
                      END
                    ELSE weight
                  END,
                  iLShipmentUnitConst
                ) / iLShipmentUnitConst
            )
      END AS shipment_unit
    FROM
      YA_PRODUCT t1
      INNER JOIN TEMP_PRODUCT_INT_TABLE p ON
        t1.sku = p.column1
      LEFT OUTER JOIN YA_SHIPPING_UNIT t2 ON
        t1.sku = t2.sku AND t2.site_id = iLOriginId;

    /* inventory and Availability Info */
    OPEN curPgetProduct4 FOR
    SELECT
      p.sku,
      -1,
      CASE
        WHEN pa.avlb = 0 THEN 99
        ELSE 0
      END,
      pa.avlb
    FROM
      TEMP_PRODUCT_INT_TABLE pt
      INNER JOIN YA_PRODUCT p ON
        pt.column1 = p.sku
      INNER JOIN prod_avlb pa ON
        pt.column1 = pa.prod_id AND pa.region_id = iLRegionId
      INNER JOIN prod_region pr ON
        pt.column1 = pr.prod_id AND pr.region_id = iLRegionId
      LEFT OUTER JOIN YA_AVAILABILITY_OVERRIDE o ON
        pr.supplier_id = o.supplier_id
        AND p.account_id = o.account_id
        AND SYSDATE BETWEEN o.start_date AND o.end_date
        AND pa.avlb < o.availability_id
    WHERE
      pa.region_id = iLRegionId
    ORDER BY pt.column1;

    /* Campaign Code */
    OPEN curPgetProduct5 FOR
    SELECT
      c.sku,
      c.campaign_code
    FROM
      YA_CAMPAIGN c,
      TEMP_PRODUCT_INT_TABLE tp
      --(select * FROM TABLE (cast ( TabData as tabSKUList))) tp
    WHERE c.sku = tp.column1
    ORDER BY tp.column1 DESC;

    OPEN curPgetProduct6 FOR
    SELECT
      tp.column1,
      p.cover_img_loc AS cover_img_loc,
      NVL(p.cover_img_width, 0) AS cover_img_width,
      NVL(p.cover_img_height, 0) AS cover_img_height,
      NVL(pr.is_preorder, 'N') AS preorder,
      NVL(pr.preorder_start, dtLnullDate) AS preorder_start,
      NVL(pr.preorder_end, dtLnullDate) AS preorder_end,
      NVL(pr.list_price, 9999) AS list_price,
      NVL(pr.sale_price, 9999) AS sale_price,
      NVL(pr.sale_price_start, dtLnullDate) AS sale_start,
      NVL(pr.sale_price_end, dtLnullDate) AS sale_end,
      NVL(pl.prod_name, ple.prod_name),
      NVL(p.release_date, dtLnullDate),
      null,
      0,
      0,
      NVL(p.account_id, -1),
      NVL(pr.supplier_id, -1),
      NVL(pr.is_enabled, 'N'),
      NVL(pr.is_can_sell, 'N'),
      NVL(pl.prod_subtitle, ple.prod_subtitle),
      NVL(pl.prod_name_aka, ple.prod_name_aka),
      NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
      0 AS preorder_buffer_day,
      1 AS region_count
    FROM
      TEMP_PRODUCT_INT_TABLE tp,
      YA_PRODUCT p,
      YA_PROD_LANG pl,
      YA_PROD_LANG pl2,
      YA_PROD_LANG ple,
      prod_region pr
    WHERE tp.column1 = p.sku
    AND p.sku=pr.prod_id
    AND pr.region_id=iLRegionId
    AND p.sku = pl.sku (+)
    AND pl.lang_id = iPlang_id
    AND p.sku = pl2.sku (+)
    AND pl2.lang_id IN (
                        SELECT lang_id
                        FROM YA_PROD_LANG
                        WHERE sku = p.sku
                        AND ROWNUM = 1
                        )
    AND p.sku = ple.sku (+)
    AND ple.lang_id = 1 /* English */
    AND p.is_prod_grp_parent = 'N'
    AND pr.region_id = iLRegionId;
  RETURN;
  END GetProductBase;


/* proc_fe_GetDeptIDBySKU */
  PROCEDURE GetDeptIDListBySKU (
    iPsku		IN	INT,
    iPsite_id		IN	INT,
    curPgetDept		OUT	refCur
    )
AS
BEGIN
  OPEN curPgetDept FOR
  SELECT pd.dept_id
  FROM YA_PROD_DEPT pd
    INNER JOIN ya_dept_site ds ON pd.dept_id = ds.dept_id and ds.site_id = iPsite_id
  WHERE sku = iPsku
    AND pd.dept_id <> 0
    AND ds.is_enabled = 'Y'
  ORDER BY pd.dept_id;
RETURN;
END;


/* proc_fe_GetDeptIDByGroupID */
  PROCEDURE GetDeptIDListByGroupID (
    iPsku		IN	INT,
    iPsite_id		IN	INT,
    curPgetDept		OUT	refCur
    )
AS
--    cLsite_prefix	VARCHAR2(10);
BEGIN
  /*
  cLsite_prefix := CASE iPsite_id
		   WHEN 1 THEN 'us'
		   WHEN 2 THEN 'us_ws'
		   WHEN 3 THEN 'jp'
		   WHEN 4 THEN 'jp_ws'
		   WHEN 5 THEN 'hk'
		   WHEN 6 THEN 'hk_ws'
		   WHEN 7 THEN 'tw'
		   WHEN 8 THEN 'tw_ws'
		   ELSE 'us'
		   END;
       */

  OPEN curPgetDept FOR
  SELECT DISTINCT pd.dept_id
  FROM YA_PROD_DEPT pd
    INNER JOIN ya_dept_site ds ON pd.dept_id = ds.dept_id AND ds.site_id = iPsite_id
  WHERE pd.sku IN (SELECT sku FROM YA_PROD_REL WHERE parent_sku = iPsku)
    AND pd.dept_id <> 0
    AND ds.is_enabled = 'Y'
  ORDER BY dept_id;
RETURN;
END;

  PROCEDURE GetPreferredProductLangBySKU (
    iPsku  IN INT,
    curPgetPreferred OUT refCur
    )
AS
BEGIN
  OPEN curPgetPreferred FOR
  SELECT CAST(NVL(lang_id,-1) AS INT) AS lang_id
  FROM YA_PROD_LANG
  WHERE sku = iPsku
  AND ROWNUM = 1;
END;

  PROCEDURE GetSeoEnabledSkuList (
    iPlRange  IN INT,
    iPuRange  IN INT,
    iPsiteId  IN INT,
    curPgetSeo  OUT refCur
    )
AS
BEGIN

      OPEN curPgetSeo FOR
      SELECT prod_id
      FROM prod_region
      WHERE region_id=iPsiteID
	  AND prod_id >= iPlRange
      AND prod_id <= iPuRange
      AND is_enabled = 'Y'
      ORDER BY prod_id DESC;

RETURN;
END;

  PROCEDURE GetMaxProductSku (
    iPsiteID  IN INT,
    iPMaxSku  OUT INT
    )
AS
BEGIN
      SELECT MAX(prod_id) INTO iPMaxSku
      FROM prod_region
      WHERE region_id=iPsiteID
	  AND is_enabled = 'Y';
RETURN;
END;

  PROCEDURE GetProductGalleryImages (
    iPsku IN INT,
    iPlangId IN INT,
    curPgetStoryBoard OUT refCur
  )
  AS
  BEGIN
    /* Get All Image Gallery Of Specified Sku */
    OPEN curPgetStoryBoard FOR
    SELECT
      b.section_id, b.section_name, c.image_id, c.image_path, c.thumb_path,
      d.description, c.priority AS priority, b.priority AS section_priority
    FROM
      YA_PROD_GALLERY a,
      YA_PROD_GALLERY_SECTION b,
      YA_PROD_GALLERY_IMAGE c,
      YA_PROD_GALLERY_DESC d
    WHERE
      a.gallery_id=c.gallery_id
      AND b.section_id=c.section_id
      AND  c.image_id=d.image_id
      AND a.sku = iPsku
      AND b.lang_id = iPlangId
      AND d.lang_id = iPlangId
    ORDER BY
      section_priority, b.section_id, c.priority, c.image_id;

    RETURN;
  END;

  PROCEDURE GetPSFirstGalleryImages (
    iPsku IN INT,
    iPlangId IN INT,
	iPsiteId IN INT,
    curPgetPS OUT refCur
  )
  AS
  BEGIN
    /* Get product group child product's first image from image gallery*/
    OPEN curPgetPS FOR
	SELECT
      a.sku,b.section_id, b.section_name, c.image_id, c.image_path, c.thumb_path,
      d.description, c.priority AS priority, b.priority AS section_priority
    FROM
      YA_PROD_GALLERY a,
      YA_PROD_GALLERY_SECTION b,
      YA_PROD_GALLERY_IMAGE c,
      YA_PROD_GALLERY_DESC d,
	  prod_region pr,
	  prod_avlb pa
    WHERE
      a.gallery_id=c.gallery_id
      AND b.section_id=c.section_id
      AND c.image_id=d.image_id
      AND b.lang_id = iPlangId
      AND d.lang_id = iPlangId
      AND c.priority = 0
      AND a.sku in (SELECT pr.sku FROM ya_prod_rel pr WHERE pr.parent_sku = iPsku)
	  AND pr.region_id=iPsiteId
	  AND pr.prod_id=a.sku
	  AND pr.is_enabled='Y'
	  AND pa.region_id=iPsiteId
	  AND pa.prod_id=a.sku
	  AND pa.avlb<60
    ORDER BY
      section_priority, b.section_id, c.priority, c.image_id;

    RETURN;
  END;

  PROCEDURE GetProductGalleryImagesCount (
    iPsku IN INT,
    iPlangId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    /* Get All Image Gallery Of Specified Sku */
    SELECT
      COUNT(1)
    INTO iPcount
    FROM
      YA_PROD_GALLERY a,
      YA_PROD_GALLERY_SECTION b,
      YA_PROD_GALLERY_IMAGE c,
      YA_PROD_GALLERY_DESC d
    WHERE
      a.gallery_id=c.gallery_id
      AND b.section_id=c.section_id
      AND  c.image_id=d.image_id
      AND a.sku = iPsku
      AND b.lang_id = iPlangId
      AND d.lang_id = iPlangId;
    RETURN;
  END;

  PROCEDURE GetPrdCountByArtistDepartment (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(*) AS num INTO iPcount
      FROM YA_PROD_DEPT a, YA_PRODUCT_ARTIST b
     WHERE a.sku       = b.sku
       AND a.dept_id   = iPdeptId
       AND b.artist_id = iPartistId;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iPcount := 0;
  END GetPrdCountByArtistDepartment;

  PROCEDURE GetProductCountByDepartment (
    iPdeptId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(*) AS num INTO iPcount
      FROM YA_PROD_DEPT
     WHERE dept_id = iPdeptId;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iPcount := 0;
  END GetProductCountByDepartment;

  PROCEDURE GetGroupIdByAccountId(
    iPaccountId IN INT,
    iPdivisionId IN INT,
    iPgroupId out INT
  )
  AS
  BEGIN
    SELECT group_id into iPgroupId FROM ya_group WHERE account_id = iPaccountId and division_id = iPdivisionId;
    return;
  END GetGroupIdByAccountId;

  PROCEDURE GetBargainSuppInfoData(
    iPsite_id IN INT,
    curPgetBargainSuppInfo OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetBargainSuppInfo FOR
    SELECT
      bsi.DEPT_ID AS DEPT_ID, bsi.PROD_COUNT AS PROD_COUNT, bsi.MAX_DISCOUNT AS MAX_DISCOUNT
    FROM
      ya_bargain_supp_info bsi
    WHERE
      bsi.SITE_ID = iPsite_id;

    return;
  END GetBargainSuppInfoData;
  

  PROCEDURE GetPublisherProductGroup (
    iPpublisherId IN INT,
    iPlangId IN INT,
    curPgetProductGroup OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetProductGroup FOR
    SELECT
      p.sku, pl.prod_name, pe.prod_name as ename
    FROM
      YA_PRODUCT p
	  LEFT OUTER JOIN prod_region pr ON p.sku=pr.prod_id AND pr.region_id = 10
    INNER JOIN YA_PROD_LANG pe ON p.sku = pe.sku AND pe.lang_id = 1
    INNER JOIN YA_PROD_LANG pl
    ON p.is_prod_grp_parent = 'Y'
      AND p.sku IN
		(SELECT DISTINCT parent_sku FROM YA_PROD_REL WHERE sku IN (
			SELECT sku FROM YA_PRODUCT WHERE publisher_id = iPpublisherId
			)
            and parent_sku not in (
      -- exclude price range product group
			1004466192,1004466191,1004466190,1004466136,1004466200,1004466199,1004466198,1004466197,
      1004466196,1004466195,1004466194,1004466192,1004466191,1004466190,1004466202

				)

				)
      AND p.sku = pl.sku
 -- exclude people style product group
      and p.sku not in (select sku from ya_prod_dept where dept_id in (select dept_id from ya_peoplestyle))
      AND pl.lang_id = iPlangId
	where (pr.is_enabled='Y' or pr.is_enabled is null)
    GROUP BY p.sku, pl.prod_name, pe.prod_name
    ORDER BY p.sku DESC;
/*
    SELECT
      p.sku, pl.prod_name
    FROM YA_PROD_REL pr
    INNER JOIN YA_PRODUCT p ON p.sku = pr.parent_sku AND p.publisher_id = iPpublisherId AND p.is_prod_grp_parent = 'Y'
    INNER JOIN YA_PROD_LANG pl ON p.sku = pl.sku AND pl.lang_id = iPlangId
    GROUP BY p.sku, pl.prod_name
    ORDER BY p.sku DESC;
*/
    RETURN;
  END GetPublisherProductGroup;

  PROCEDURE GetFrontPageProductLotsByPId (
    iPpublisherId	IN	INT,
    iPDeptId		IN	INT,
    iPlangId		IN	INT,
    iPsiteId		IN	INT,
    curPgetFrontpage	OUT	refCur
  )
  AS
  BEGIN
    OPEN curPgetFrontpage FOR
        SELECT
          pl.sku,
          pl.lot_location,
          pll.description,
          pl.dept_id,
          PLI.desc_img_loc,
          NVL(PLI.desc_img_width,0),
          NVL(PLI.desc_img_height,0),
          NULL,
          -1,
          pll.remark
        FROM
          YA_PRODUCT_LOT pl
          INNER JOIN ya_publisher_file_rel pfr ON
		    pfr.publisher_id = iPpublisherId
		    AND
		    pl.file_id = pfr.file_id
		    AND
		    pfr.dept_id = iPDeptId
          LEFT OUTER JOIN YA_PROD_LOT_LANG pll ON
            pl.prod_lot_id = pll.prod_lot_id
            AND pll.lang_id = iPlangId
          LEFT OUTER JOIN YA_PROD_LOT_LANG PLI ON
            PLI.prod_lot_id = pl.prod_lot_id
          INNER JOIN prod_region pr ON
            pl.sku = pr.prod_id
		    AND pr.region_id=iPsiteId
        WHERE
          pr.is_enabled = 'Y' AND pl.lot_location = iPpublisherId
        ORDER BY pl.lot_location, pl.priority;
  RETURN;
  END GetFrontPageProductLotsByPId;
END Pkg_Fe_Productaccess;
/