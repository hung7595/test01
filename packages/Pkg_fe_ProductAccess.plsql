create or replace PACKAGE Pkg_Fe_Productaccess
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

  PROCEDURE GetClearanceProductsByRange (
    iPdept_id  		IN  	INT,
    iPsite_id  		IN  	INT,
    deciPrange_from 	IN  	DECIMAL,
    deciPrange_to 	IN  	DECIMAL,
    iPpercent_off_from 	IN  	INT,
    iPpercent_off_to 	IN  	INT,
    cPfilter_adult 	IN  	CHAR,
    curPgetClear 	OUT 	refCur
  );

  PROCEDURE GetProductsByDeptCampaign (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    iPcampaign_code	IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iProwcnt		IN	INT,
    curPgetProds	OUT	refCur,
    cPgetPreorder	IN	VARCHAR2 DEFAULT 'B'
  );

  PROCEDURE GetProductsByDeptCampaignAttr (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    iPcampaign_code	IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iPattr_id		IN	INT,
    iProwcnt		IN	INT,
    curPgetProds	OUT	refCur,
    cPgetPreorder	IN	CHAR DEFAULT 'B'
  );

  PROCEDURE GetProductsByDeptNormal (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iProwcnt		IN	INT,
    curPgetProds	OUT	refCur,
    cPgetPreorder	IN	VARCHAR2 DEFAULT 'B'
  );

  PROCEDURE GetProductsByDeptNormalAttr (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iPattr_id		IN	INT,
    iProwcnt		IN	INT,
    curPgetProds OUT refCur,
    cPgetPreorder	IN	VARCHAR2 DEFAULT 'B'
    );

  PROCEDURE GetHighlightProductData (
    iPsku  		IN 	INT,
    iPlang_id  		IN 	INT,
    iPsite_id  		IN 	INT,
    curPgetHighlight 	OUT 	refCur
  );

  PROCEDURE InsertTrackItDownData (
    iPsku		IN	INT,
    iPsite_id		IN	INT,
    cPemail		IN	VARCHAR2
  );

  PROCEDURE InsertFutureReleaseData (
    iPsku		IN	INT,
    iPsite_id		IN	INT,
    cPemail		IN	VARCHAR2,
    cPname		IN	VARCHAR2
  );

  PROCEDURE GetMostTalkedAboutProducts (
    iPsiteId  		IN  	INT,
    iPdeptId  		IN  	INT,
    iProwCount  	IN 	INT,
    curPgetMost 	OUT 	refCur
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

  PROCEDURE GetProductVideosInformation (
    iPsku		IN	INT,
    curPgetProduct	OUT	refCur
  );

  PROCEDURE FillProductBooksInformation (
    cPskuCsv  		IN 	VARCHAR2,
    iPlangId  		IN 	INT,
    curPgetProduct1 	OUT 	refCur,
    curPgetProduct2 	OUT 	refCur,
    curPgetProduct3 	OUT 	refCur
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

  PROCEDURE GetProductsFromBargainPool (
    iPsiteId  IN INT,
    iPdeptId  IN INT,
    iPrating  IN INT,
    curPgetBargain OUT refCur
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

  PROCEDURE GetStoryBoardItems (
    iPsku IN INT,
    iPlangId IN INT,
    iPepId IN INT,
    curPgetStoryBoard OUT refCur
  );

  PROCEDURE GetProductGalleryImages (
    iPsku IN INT,
    iPlangId IN INT,
    curPgetStoryBoard OUT refCur
  );

  PROCEDURE GetProductGalleryImagesCount (
    iPsku IN INT,
    iPlangId IN INT,
    iPcount OUT INT
  );

  -- YesStyle
  PROCEDURE GetPublisherProductGroup (
    iPpublisherId IN INT,
    iPlangId IN INT,
    curPgetProductGroup OUT refCur
  );
END Pkg_Fe_Productaccess;
/

CREATE OR REPLACE
PACKAGE BODY Pkg_Fe_Productaccess
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


  PROCEDURE GetClearanceProductsByRange (
    iPdept_id   IN  INT,
    iPsite_id   IN  INT,
    deciPrange_from IN  DECIMAL,
    deciPrange_to IN  DECIMAL,
    iPpercent_off_from  IN  INT,
    iPpercent_off_to  IN  INT,
    cPfilter_adult  IN  CHAR,
    curPgetClear  OUT refCur
    )
  AS
  BEGIN
    IF deciPrange_to > -1 THEN
      BEGIN
        OPEN curPgetClear FOR
        SELECT
          DISTINCT p.sku,
          p.is_parent,
          pa.availability AS availability,
          pr.displayPriority AS priority,
          p.release_date,
          CASE WHEN pa.availability <  60 THEN 10 ELSE pa.availability END AS avail_order
        FROM
          YA_PRODUCT p,
          YA_CAMPAIGN c,
          YA_PROD_DEPT pd,
          YA_ADULT_PRODUCT ap,
			    productregion pr,
          productavailability pa
        WHERE c.sku = p.sku
			    AND c.sku=pr.productId
          AND pr.regionId=iPsite_id
          AND c.sku=pa.productId
          AND pa.regionId=iPsite_id
          AND c.campaign_code = 60  /* Clearance campaign code for u s is 60 */
          AND p.sku=pd.sku
          AND pd.dept_id = iPdept_id
          AND ap.sku (+) = p.sku
          AND pr.ENABLE = 'Y'
          AND NVL(ap.sku, 0) <= (CASE cPfilter_adult WHEN 'Y'
                                  THEN 1 ELSE NVL(ap.sku, 2139999999)
                                  END
                                  )
          AND (
            NVL(
              (
              CASE WHEN
                SYSDATE BETWEEN pr.salepricestart AND pr.salepriceend
                THEN pr.saleprice
                ELSE NULL END
              ),
              pr.listprice
            )
            BETWEEN deciPrange_from AND deciPrange_to
            OR
            (
              (
                pr.listprice -
                NVL
                (
                  (
                    CASE WHEN SYSDATE BETWEEN pr.salepricestart AND pr.salepriceend
                    THEN pr.saleprice ELSE NULL END
                    ),
                    pr.listprice
                )
              ) /
              (
                CASE WHEN pr.listprice IS NULL
                THEN 1 WHEN pr.listprice = 0
                THEN 1 ELSE pr.listprice END
              ) * 100
            )
            BETWEEN iPpercent_off_from AND iPpercent_off_to)
            ORDER BY avail_order, p.is_parent DESC, priority DESC, p.release_date DESC, p.sku DESC;

      END;
    ELSE
      BEGIN
        OPEN curPgetClear FOR
          SELECT
            DISTINCT p.sku,
            p.is_parent,
            pa.availability,
            pr.displayPriority AS priority,
            p.release_date,
            CASE WHEN pa.availability < 60 THEN 10 ELSE pa.availability END AS avail_order
          FROM
            YA_PRODUCT p,
            YA_CAMPAIGN c,
            YA_PROD_DEPT pd,
            YA_ADULT_PRODUCT ap,
				    productregion pr,
            productavailability pa
          WHERE c.sku = p.sku
				    AND c.sku=pr.productId
				    AND pr.regionId=iPsite_id
				    AND c.sku=pa.productId
				    AND pa.regionId=iPsite_id
            AND c.campaign_code = 60  /* Clearance campaign code for u s is 60 */
            AND p.sku = pd.sku
            AND pd.dept_id = iPdept_id
            AND ap.sku (+) = p.sku
            AND pr.ENABLE = 'Y'
            AND NVL(ap.sku, 0) <= (CASE cPfilter_adult WHEN 'Y' THEN 1 ELSE NVL(ap.sku, 2139999999) END)
            AND
            (
              NVL
              (
                (
                  CASE WHEN SYSDATE BETWEEN pr.salepricestart AND pr.salepriceend
                  THEN pr.saleprice ELSE NULL END
                ), p.us_list_price
              ) > deciPrange_from
              OR
              (
                (pr.listprice -
                  NVL
                  (
                    (
                      CASE WHEN SYSDATE BETWEEN
                      pr.salepricestart AND pr.salepriceend
                      THEN pr.saleprice ELSE NULL END
                    ), pr.listprice
                  )
                )/(
                  CASE WHEN pr.listprice IS NULL
                    THEN 1 WHEN pr.listprice = 0
                    THEN 1 ELSE pr.listprice END
                  )*100
              ) BETWEEN iPpercent_off_from AND iPpercent_off_to
            )
            ORDER BY avail_order, p.is_parent DESC, priority DESC, p.release_date DESC, p.sku DESC;
      END;
    END IF;
  RETURN;
  END GetClearanceProductsByRange;


/* proc_fe_GetProdsByDeptCampaign */
  PROCEDURE GetProductsByDeptCampaign (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    iPcampaign_code	IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iProwcnt		IN	INT,
    curPgetProds	OUT	refCur,
    cPgetPreorder	IN	VARCHAR2 DEFAULT 'B'
        )
  AS
    cLsite_prefix	VARCHAR2(10);
    cLis_limited_qty	CHAR;
    iLcampaign_code_a	INT;
    iLrowcnt		INT;
  BEGIN
    IF iProwcnt <> 0 THEN
      BEGIN
        iLrowcnt := iProwcnt * 2;
      END;
    ELSE
      BEGIN
        iLrowcnt := 0;
      END;
    END IF;

    IF iPcampaign_code = 10 THEN  /* Bargain Section */
      BEGIN
        iLcampaign_code_a := 12;
        cLis_limited_qty := 'Y';
      END;
    ELSE
      BEGIN
        iLcampaign_code_a := 9999;
        cLis_limited_qty := 'N';
      END;
    END IF;

  OPEN curPgetProds FOR
  SELECT r.*
  FROM
  (
    SELECT
      DISTINCT p.sku,
      p.is_parent,
      avail.availability,
      pr.displayPriority priority,
      p.release_date,
      cp.sku AS cp_sku,
    CASE WHEN avail.availability < 60
      THEN 10
    ELSE avail.availability END AS avail_order,
      NVL(p.country_release_id, -1) AS availability_id
    FROM
      YA_PRODUCT p,
      YA_CAMPAIGN c,
      YA_PROD_DEPT pd,
      YA_CROSS_SELLING_TYPE3 cs,
      YA_PRODUCT cp,
      YA_ADULT_PRODUCT ap,
      YA_LIMITED_QUANTITY lq,
      ProductAvailability avail,
      productregion pr,
      productregion pr1
    WHERE c.sku = p.sku
      AND (c.campaign_code = iPcampaign_code OR c.campaign_code = iLcampaign_code_a)
      AND p.sku = pd.sku
      AND p.sku=pr.productId
      AND pr.regionId=iPsite_id
      AND cp.sku=pr1.productId
      AND pr1.regionId=iPsite_id
      AND pd.dept_id = iPdept_id
      /* Get related (VCD) products */
      AND p.sku = cs.sku (+)
--      AND cs.type_id = 3
      AND cs.related_sku = cp.sku (+)
      AND pr1.ENABLE = 'Y'
      AND ap.sku (+) = p.sku
      AND lq.sku (+) = p.sku
      AND (lq.site_id = iPsite_id OR lq.site_id = 99)
      AND lq.frontend_quantity >= 0
      /* new availability */
      AND avail.ProductId = p.sku
      AND pr.ENABLE = 'Y'
      AND
        (
          NVL(lq.frontend_quantity, 0) >=
            (
            CASE cLis_limited_qty WHEN 'Y'
            THEN 1 ELSE
              NVL
              (
                lq.frontend_quantity, 0
              )
            END
          ) OR
          (
            c.campaign_code = iLcampaign_code_a
          )
        )
      AND NVL(ap.sku, 0) <= (CASE cPfilter_adult WHEN 'Y' THEN 1 ELSE NVL(ap.sku, 2139999999) END)
      AND p.is_parent = CASE cPget_group WHEN 'B' THEN p.is_parent WHEN 'G' THEN 'Y' ELSE 'N' END
      AND pr.preorder = CASE cPgetPreorder WHEN 'B' THEN pr.preorder ELSE cPgetPreorder END
      /* new availability */
      AND avail.availability < 60
      AND avail.regionId = iPsite_id
      ORDER BY p.is_parent DESC, avail_order, priority DESC, p.release_date DESC, p.sku DESC
  ) r
  WHERE
    ROWNUM <= CASE WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;
    RETURN;
  END GetProductsByDeptCampaign;


/* proc_fe_GetProdsByDeptCampaignInAttr */
  PROCEDURE GetProductsByDeptCampaignAttr (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    iPcampaign_code	IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iPattr_id		IN	INT,
    iProwcnt		IN	INT,
    curPgetProds	OUT	refCur,
    cPgetPreorder	IN	CHAR DEFAULT 'B'
    )
  AS
    cLsite_prefix	VARCHAR2(10);
    cLis_limited_qty	CHAR;
    iLcampaign_code_a	INT;
    iLrowcnt		INT;
  BEGIN
    IF iProwcnt <> 0 THEN
      BEGIN
        iLrowcnt := iProwcnt * 2;
      END;
    ELSE
      BEGIN
        iLrowcnt := 0;
      END;
    END IF;

    IF iPcampaign_code = 10 THEN /* Bargain Section */
      BEGIN
        iLcampaign_code_a := 12;
        cLis_limited_qty := 'Y';
      END;
    ELSE
      BEGIN
        iLcampaign_code_a := 9999;
        cLis_limited_qty := 'N';
      END;
    END IF;

    OPEN curPgetProds FOR
    SELECT r.*
    FROM
    (
      SELECT
        DISTINCT p.sku,
        is_parent,
        avail.availability,
      pr.displayPriority priority,
      p.release_date,
      cs.related_sku,
      CASE
        WHEN avail.availability IS NULL THEN 90
        WHEN avail.availability < 60 THEN 10
        ELSE avail.availability
      END avail_order,
        NVL(p.country_release_id, -1)
      FROM
        YA_PRODUCT p,
      YA_CAMPAIGN c,
      YA_PROD_DEPT pd,
      YA_PROD_ATTR pa,
      (
        SELECT
          cs.sku,
          cs.related_sku
        FROM
          YA_CROSS_SELLING_TYPE3 cs,
          productregion pr
        WHERE 1=1 --cs.type_id = 3
        AND cs.sku = pr.productId
	      AND pr.regionId=iPsite_id
        AND pr.ENABLE = 'Y'
      ) cs,
      YA_ADULT_PRODUCT ap,
      YA_LIMITED_QUANTITY lq,
      productAvailability avail,
		  productregion pr
      WHERE c.sku=p.sku
      AND (c.campaign_code = iPcampaign_code OR c.campaign_code = iLcampaign_code_a)
      AND p.sku = pd.sku
      AND pd.dept_id = iPdept_id
      AND pa.sku = p.sku
		  AND pa.sku=pr.productId
		  AND pr.regionId=iPsite_id
      AND pa.attribute_id = iPattr_id
      AND cs.sku (+) = p.sku /* Get related (VCD) products */
      AND ap.sku (+) = p.sku
      AND lq.sku (+) = p.sku
      AND (lq.site_id = iPsite_id OR lq.site_id = 99)
      AND lq.frontend_quantity >= 0
      /* new availability */
      AND avail.productId = p.sku
      AND pr.ENABLE = 'Y'
      AND
      (
        NVL
        (
          lq.frontend_quantity, 0
        ) >=
        (
          CASE cLis_limited_qty WHEN 'Y'
          THEN 1 ELSE NVL
          (
            lq.frontend_quantity, 0
          )
          END
        ) OR
        (
          c.campaign_code = iLcampaign_code_a
        )
      )
      AND NVL(ap.sku, 0) <= (CASE cPfilter_adult WHEN 'Y' THEN 1 ELSE NVL(ap.sku, 2139999999) END)
      AND p.is_parent = CASE cPget_group WHEN 'B' THEN p.is_parent WHEN 'G' THEN 'Y' ELSE 'N' END
      AND pr.preorder = CASE cPgetPreorder WHEN 'B' THEN pr.preorder ELSE cPgetPreorder END
      /* new availability */
      AND avail.availability < 60  AND avail.regionId = iPsite_id
      ORDER BY is_parent DESC, avail_order, priority DESC nulls last, p.release_date DESC nulls last, p.sku DESC
    ) r
    WHERE
      ROWNUM <= CASE WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;
    RETURN;
  END GetProductsByDeptCampaignAttr;


/* proc_fe_GetProdsByDeptNormal */
  PROCEDURE GetProductsByDeptNormal (
    iPdept_id		IN	INT,
    iPsite_id		IN	INT,
    cPfilter_adult	IN	CHAR,
    cPget_group		IN	CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iProwcnt		IN	INT,
    curPgetProds	OUT	refCur,
    cPgetPreorder	IN	VARCHAR2 DEFAULT 'B'
    )
  AS
    cLsite_prefix	VARCHAR2(10);
    cLis_limited_qty	CHAR;
    iLcampaign_code_a	INT;
    iLrowcnt		INT;
    iLtemp		INT DEFAULT 0;
  BEGIN
    IF iProwcnt <> 0 THEN
      BEGIN
        iLrowcnt := iProwcnt * 2;
      END;
    ELSE
      BEGIN
        iLrowcnt := 0;
      END;
    END IF;

    BEGIN
      SELECT 1 INTO iLtemp
      FROM YA_DEPT_ATTR
      WHERE dept_id = iPdept_id
      AND attribute_id = 125;

      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLtemp := 0;
    END;

    IF iLtemp = 1 THEN
      BEGIN
        OPEN curPgetProds FOR
        SELECT r.*
        FROM
        (
          SELECT
            p.sku,
            p.is_parent,
            pa.availability,
            pr.displayPriority priority,
            p.release_date,
            pr1.productId AS cp_sku,
            CASE
              WHEN pa.availability IS NULL THEN 90
              WHEN pa.availability < 60 THEN 10
              ELSE pa.availability
            END avail_order,
            NVL(p.country_release_id, -1)
          FROM
            YA_PRODUCT p,
            YA_PROD_DEPT pd,
            YA_CROSS_SELLING_TYPE3 cs,
            YA_ADULT_PRODUCT ap,
	    ProductAvailability pa,
		productregion pr,
		productregion pr1
          WHERE p.sku = pd.sku
          AND pd.dept_id = iPdept_id
        /* Get related (VCD) products */
          AND cs.sku (+) = p.sku
			    AND pr1.regionId=iPsite_id
			    AND p.sku=pr.productId
			    AND pr.regionId=iPsite_id
			    AND p.sku=pa.productId
			    AND pa.regionId=iPsite_id

          --AND cs.type_id = 3
          AND cs.related_sku = pr1.productId (+)
          AND pr.ENABLE = 'Y'
          AND ap.sku (+) = p.sku
          AND pr1.ENABLE = 'Y'
          AND NVL(ap.sku, 0) <= (CASE cPfilter_adult WHEN 'Y' THEN 1 ELSE NVL(ap.sku, 2139999999) END)
          AND p.is_parent = CASE cPget_group WHEN 'B' THEN p.is_parent WHEN 'G' THEN 'Y' ELSE 'N' END
          AND pr.preorder = CASE WHEN cPgetPreorder = 'B'THEN pr.preorder
                                WHEN cPgetPreorder = 'N'
                                AND p.release_date <= SYSDATE
                                AND NOT (pr.preorder = 'Y' AND SYSDATE
                                BETWEEN pr.preorderstart AND pr.preorderend)
                                THEN pr.preorder
                                ELSE cPgetPreorder END
          ORDER BY p.is_parent DESC, avail_order, priority DESC, p.release_date DESC NULLS first, p.sku DESC
        ) r
        WHERE
          ROWNUM <= CASE WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;

      END;
    ELSE
      BEGIN
        OPEN curPgetProds FOR
        SELECT r.*
        FROM
        (
          SELECT
            p.sku,
            p.is_parent,
            pa.availability,
            pr.displayPriority priority,
            p.release_date, NULL,
            CASE
              WHEN pa.availability IS NULL THEN 90
              WHEN pa.availability < 60 THEN 10
              ELSE pa.availability
            END avail_order,
            NVL(p.country_release_id, -1)
          FROM
            YA_PRODUCT p,
            YA_PROD_DEPT pd,
            YA_ADULT_PRODUCT ap,
	    ProductAvailability pa,
	    productregion pr
          WHERE p.sku = pd.sku
          AND p.sku=pr.productId
	  AND pr.regionId=iPsite_id
			    AND p.sku=pa.productId
			    AND pa.regionId=iPsite_id
          AND pd.dept_id = iPdept_id
          AND ap.sku (+) = p.sku
          AND pr.ENABLE = 'Y'
          AND NVL(ap.sku, 0)<=(CASE cPfilter_adult WHEN 'Y' THEN 1 ELSE NVL(ap.sku, 2139999999) END)
          AND p.is_parent=CASE cPget_group WHEN 'B' THEN p.is_parent WHEN 'G' THEN 'Y' ELSE 'N' END
          AND pr.preorder = CASE WHEN cPgetPreorder = 'B' THEN pr.preorder
                                    WHEN cPgetPreorder = 'N'
                                    AND p.release_date <= SYSDATE
                                    AND NOT (pr.preorder = 'Y' AND SYSDATE
                                    BETWEEN pr.preorderstart AND pr.preorderend
                                            )
                                            THEN pr.preorder
                                            ELSE cPgetPreorder
                              END
          ORDER BY p.is_parent DESC, avail_order, priority DESC nulls last, p.release_date DESC nulls last, p.sku DESC
        ) r
        WHERE
          ROWNUM <= CASE WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;
      END;
    END IF;
  RETURN;
  END GetProductsByDeptNormal;


/* proc_fe_GetProdsByDeptNormalInAttr */
  PROCEDURE GetProductsByDeptNormalAttr (
    iPdept_id IN INT,
    iPsite_id IN INT,
    cPfilter_adult IN CHAR,
    cPget_group IN CHAR,   /* 'G' : get group only,  'P' :get product only, 'B' get both */
    iPattr_id IN INT,
    iProwcnt IN INT,
    curPgetProds OUT refCur,
    cPgetPreorder IN VARCHAR2 DEFAULT 'B'
    )
  AS
      cLsite_prefix	VARCHAR2(10);
      cLis_limited_qty	CHAR;
      iLcampaign_code_a	INT;
      iLrowcnt		INT;
      iLtemp		INT DEFAULT 0;
  BEGIN
    IF iProwcnt <> 0 THEN
      BEGIN
        iLrowcnt := iProwcnt * 2;
      END;
    ELSE
      BEGIN
        iLrowcnt := 0;
      END;
    END IF;

    OPEN curPgetProds FOR
    SELECT r.*
    FROM
    (
      SELECT
        p.sku,
        p.is_parent,
        pa.availability availability,
        pr.displayPriority priority,
        p.release_date,
        cs.related_sku,
        CASE
          WHEN pa.availability IS NULL THEN 90
          WHEN pa.availability < 60 THEN 10
          ELSE pa.availability
        END avail_order,
        NVL(p.country_release_id, -1)
      FROM
        YA_PRODUCT p,
        YA_CROSS_SELLING_TYPE3 cs,
        YA_ADULT_PRODUCT ap,
		productregion pr,
		productavailability pa
      WHERE 1=1
	  AND pa.productId=p.sku
	  AND pa.regionId=iPsite_id
	  AND pr.productId=p.sku
	  AND pr.regionId=iPsite_id
      AND p.SKU IN (SELECT SKU FROM YA_PROD_DEPT WHERE dept_id = iPdept_id)
      AND p.SKU IN (SELECT SKU FROM YA_PROD_ATTR WHERE attribute_id = iPattr_id)
      AND ap.sku (+) = p.sku
      AND cs.sku (+) = p.sku /* Get related (VCD) products */
      AND pr.ENABLE = 'Y'
      AND NVL(ap.sku, 0) <= (CASE cPfilter_adult WHEN 'Y' THEN 1 ELSE NVL(ap.sku, 2139999999) END)
      AND p.is_parent = CASE cPget_group WHEN 'B' THEN p.is_parent WHEN 'G' THEN 'Y' ELSE 'N' END
      AND pr.preorder = CASE cPgetPreorder WHEN 'B' THEN pr.preorder ELSE cPgetPreorder END
      ORDER BY p.is_parent DESC, avail_order, priority DESC nulls last, p.release_date DESC nulls last, p.sku DESC
    ) r
    WHERE
      ROWNUM <= CASE WHEN iLrowcnt = 0 THEN (ROWNUM+1) ELSE iLrowcnt END;

    RETURN;
  END GetProductsByDeptNormalAttr;


  PROCEDURE GetHighlightProductData (
    iPsku IN INT,
    iPlang_id IN INT,
    iPsite_id IN INT,
    curPgetHighlight OUT refCur
    )
  AS
  BEGIN
    /*gets the review count and product description, for 1st product in product list*/
    /*
    cLsite_prefix := CASE iPsite_id
    		   WHEN 1 THEN 'us'
    		   WHEN 2 THEN 'us'
    		   WHEN 3 THEN 'jp'
    		   WHEN 4 THEN 'jp'
    		   WHEN 5 THEN 'hk'
    		   WHEN 6 THEN 'hk'
    		   WHEN 7 THEN 'tw'
    		   WHEN 8 THEN 'tw'
    		   ELSE 'us'
    		   END;
    */

    OPEN curPgetHighlight FOR
    SELECT
      d.description,
      --NVL(SUM(rs.actual_count), 0)
      NVL(rs.actual_count,0)
    FROM
      YA_PROD_LANG pl,
      YA_REVIEW_SUMMARY rs,
      YA_DESCRIPTION d
    WHERE rs.sku (+) = pl.sku
    AND site_id (+) = iPsite_id
    AND d.description_id (+) =
      (
        CASE
          WHEN iPsite_id = 1 OR iPsite_id = 2 THEN pl.us_description_id
          WHEN iPsite_id = 7 OR iPsite_id = 8 THEN pl.tw_description_id
--          WHEN iPsite_id = 5 OR iPsite_id = 6 THEN pl.hk_description_id
          WHEN iPsite_id = 3 OR iPsite_id = 4 THEN pl.jp_description_id
        END
      )
    AND pl.lang_id = iPlang_id
    AND pl.sku = iPsku;
--    GROUP BY description;
  END GetHighlightProductData;


/* proc_fe_InsertTrackItDownEntry */
  PROCEDURE InsertTrackItDownData (
    iPsku IN INT,
    iPsite_id IN INT,
    cPemail IN VARCHAR2
    )
  AS
  BEGIN
    INSERT INTO YA_TRACK_IT_DOWN (
      site_id,
      sku,
      email
      )
    SELECT
      iPsite_id,
      iPsku,
      cPemail
    FROM dual
    WHERE NOT EXISTS
      (
        SELECT 1
        FROM YA_TRACK_IT_DOWN
        WHERE sku = iPsku
        AND site_id = iPsite_id
        AND email = cPemail
        AND ROWNUM = 1
      );

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END InsertTrackItDownData;


  /* proc_fe_InsertFutureReleaseEntry */
  PROCEDURE InsertFutureReleaseData (
    iPsku IN INT,
    iPsite_id IN INT,
    cPemail IN VARCHAR2,
    cPname IN VARCHAR2
    )
  AS
  BEGIN
    INSERT INTO YA_FUTURE_RELEASE (
      site_id,
      sku,
      customer_email,
      customer_name
      )
    SELECT
      iPsite_id,
      iPsku,
      cPemail,
      cPname
    FROM DUAL
    WHERE NOT EXISTS
      (
        SELECT 1
        FROM YA_FUTURE_RELEASE
        WHERE
          sku = iPsku
          AND site_id = iPsite_id
          AND customer_email = cPemail
          AND ROWNUM = 1
      );

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END InsertFutureReleaseData;


  PROCEDURE GetMostTalkedAboutProducts (
    iPsiteId IN INT,
    iPdeptId IN INT,
    iProwCount IN INT,
    curPgetMost OUT refCur
  )
  AS
    iLadult INT;
    iLtemp INT := 0;
    iLtemp2 INT := 0;
  BEGIN
    OPEN curPgetMost FOR
    SELECT r.*
    FROM
      (
        SELECT
          sku,
          last_count,
          total_count
        FROM YA_MOST_TALKED_ABOUT
        WHERE
          dept_id = iPdeptId
          AND site_id = iPsiteId
        ORDER BY priority
      ) r
    WHERE
      ROWNUM <= CASE WHEN iProwCount = 0 THEN (ROWNUM+1) ELSE iProwCount END;

    RETURN;
  END GetMostTalkedAboutProducts;


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
          AND PLI.preferred_flag = 'Y'
        INNER JOIN productregion pr ON
          pl.sku = pr.productId
		  AND pr.regionId=iPsiteId
      WHERE
        pl.file_id = iPfileId
        AND pr.ENABLE = 'Y'
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
          AND PLI.preferred_flag = 'Y'
        INNER JOIN productregion pr ON
          pl.sku = pr.productId
		  AND pr.regionId=iPsiteId
      WHERE
        pl.file_id = iPfileId
        AND pr.ENABLE = 'Y'
      ORDER BY pl.lot_location, pl.priority;
RETURN;
END;

/* proc_fe_get_product_video_info */
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

  PROCEDURE FillProductBooksInformation (
    cPskuCsv		IN	VARCHAR2,
    iPlangId		IN	INT,
    curPgetProduct1	OUT	refCur,
    curPgetProduct2	OUT	refCur,
    curPgetProduct3	OUT	refCur
  )
AS
    iLendpos		INT;
    iLtemp		INT;
    cLskuCsv		VARCHAR2(5000);
    iCounter            INT;
BEGIN
  cLskuCsv := cPskuCsv;
  iCounter := 1;

  EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_product_int_table';

  iLtemp := NVL(LENGTH(RTRIM(cLskuCsv)),0);

  IF(iLtemp) > 0 THEN
    BEGIN
      iLendpos := INSTR(cLskuCsv, ',');
      WHILE  iLendpos  >  0
      LOOP
        BEGIN
          INSERT INTO TEMP_PRODUCT_INT_TABLE (column1, column2)
          VALUES (CAST(SUBSTR(cLskuCsv,1,iLendpos-1) AS INT), iCounter);

          cLskuCsv := SUBSTR(cLskuCsv, iLendpos+1);
          iLendpos := INSTR(cLskuCsv, ',');
          iCounter := iCounter + 1;
        END;
      END LOOP;

      INSERT INTO TEMP_PRODUCT_INT_TABLE (column1, column2)
      VALUES (CAST(cLskuCsv AS INT), iCounter);
    END;
  END IF;


  OPEN curPgetProduct1 FOR
  SELECT
    pp.isbn AS isbn,
    pp.pages,
    lp.meaning AS format,
    le.meaning AS edition,
    pp.edition_number AS edition_number,
    pp.volume_number AS volume_number,
    pp.sku,
    pp.grade_from,
    pp.grade_to
  FROM
    YA_PROD_PRINTED pp
    LEFT OUTER JOIN YA_LOOKUP lp ON
      pp.format = lp.code_id
      AND lp.type_id = 100 /* Western book format */
    LEFT OUTER JOIN YA_LOOKUP le ON
      pp.edition = le.code_id
      AND le.type_id = 101 /* Western book edition */
    INNER JOIN TEMP_PRODUCT_INT_TABLE p ON
      pp.sku = p.column1
  ORDER BY p.column2;

  OPEN curPgetProduct2 FOR
  SELECT
    award_id,
    a.award_name AS award_name,
    a.award_category AS award_category,
    NVL(a.award_year, -1) AS award_year,
    l.meaning AS award_status,
    a.sku
  FROM
    YA_AWARDS a,
    YA_LOOKUP l,
    TEMP_PRODUCT_INT_TABLE p
  WHERE a.award_status_type = l.code_id
  AND l.type_id = 103
  AND a.sku = p.column1
  ORDER BY p.column2;

  OPEN curPgetProduct3 FOR
  SELECT
    tn.note_id,
    lt.meaning AS TYPE,
    NVL(tn.partial_text, 0) AS partial_text,
    tn.text_from_other AS text_from_other,
    lm.meaning AS medium,
    source_date_string AS source_date_string,
    source_volume AS source_volume,
    note_text AS note_text,
    a.artist_id,
    al.firstname_u AS artist_firstname,
    al.lastname_u AS artist_lastname,
    al.akaname_u AS artist_akaname,
    al2.firstname_u AS artist_firstname,
    al2.lastname_u AS artist_lastname,
    al2.akaname_u AS artist_akaname,
    al3.name_img_loc AS name_img_loc,
    NVL(al3.name_img_width, -1) AS name_img_width,
    NVL(al3.name_img_height, -1) AS name_img_height,
    NVL(a.origin_country_id, 0) AS origin_country_id,
    NVL(al3.lang_id, 0) AS lang_id,
    al.prefix AS prefix,
    al.suffix AS suffix,
    al2.prefix AS prefix2,
    al2.suffix AS suffix2,
    tn.note_type AS type_id,
    pt.sku,
    NVL(pt.refer_sku, -1) AS refer_sku,
    ypl.prod_name AS prod_name,
    yatl.attribute_name AS attr_name
  FROM
    YA_PROD_TEXT_NOTE pt
    INNER JOIN
    (
      SELECT
        CASE
          WHEN account_id = 100 THEN 1
          ELSE iPlangId
        END AS lang_id,
        sku
      FROM YA_PRODUCT
      WHERE sku IN (SELECT column1 FROM TEMP_PRODUCT_INT_TABLE)
    ) pd ON
      pt.sku = pd.sku
    INNER JOIN YA_TEXT_NOTE tn ON
      pt.note_id = tn.note_id
      AND tn.lang_id = pd.lang_id
    INNER JOIN YA_LOOKUP lt ON
      tn.note_type = lt.code_id
      AND lt.type_id = 105
    LEFT OUTER JOIN YA_LOOKUP lm ON
      tn.medium_id = lm.code_id
      AND lm.type_id = 102
    LEFT OUTER JOIN YA_ARTIST a ON
      tn.artist_id = a.artist_id
    LEFT OUTER JOIN YA_ARTIST_LANG al ON
      a.artist_id = al.artist_id
      AND al.lang_id = iPlangId
    LEFT OUTER JOIN YA_ARTIST_LANG al2 ON
      a.artist_id = al2.artist_id
      AND al2.lang_id = 1
    LEFT OUTER JOIN YA_ARTIST_LANG al3 ON
      a.artist_id = al3.artist_id
      AND al3.lang_id IN
        (
          SELECT lang_id
          FROM YA_ARTIST_LANG
          WHERE
            artist_id=a.artist_id
            AND preferred_flag='Y'
            AND ROWNUM = 1
        )
    INNER JOIN TEMP_PRODUCT_INT_TABLE p ON
      pt.sku = p.column1
    LEFT OUTER JOIN YA_PROD_LANG ypl ON
      ypl.sku = pt.refer_sku
      AND ypl.lang_id = iPlangId
    LEFT OUTER JOIN YA_PROD_ATTR ypa ON
      ypa.sku = pt.refer_sku
      AND ypa.attribute_id IN
        (
          SELECT yat.attribute_id
          FROM YA_ATTRIBUTE yat
          WHERE yat.attribute_type_id = 27
        )
    LEFT OUTER JOIN YA_ATTRIBUTE_LANG yatl ON
      yatl.attribute_id = ypa.attribute_id
      AND yatl.lang_id = iPlangId
    ORDER BY p.column2;

  RETURN;
END FillProductBooksInformation;



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
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_product_int_table';

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
    AND lq.site_id IN (99, iPsite_id)
    AND lq.frontend_quantity > 0
    ORDER BY lq.sku;

    /* Get Shipment Unit */
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
        t1.sku = t2.sku AND t2.site_id = iPsite_id;
    /*
    SELECT
      t1.sku,
      CAST(
           CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
           ELSE CEIL(NVL(case when dimension_weight is not null and weight is not null
                         then case when dimension_weight > weight
                         then dimension_weight else weight end
                         else weight end, iLShipmentUnitConst) / iLShipmentUnitConst)
           END AS int
           ) as shipment_unit
    FROM
      ya_product t1,
      ya_shipping_unit t2,
      temp_getMostTalked p
      --(select * FROM TABLE (cast ( TabData as tabSKUList)))p
    WHERE t1.sku = p.sku
    AND t1.sku = t2.sku (+)
    AND t2.site_id = iPsite_id;
    */

    /* Inventory and Availability Info */
    OPEN curPgetProduct4 FOR
    SELECT
      p.sku,
      -1,
      CASE
        WHEN pa.availability = 0 THEN 99
        ELSE 0
      END,
      pa.availability
    FROM
      TEMP_PRODUCT_INT_TABLE pt
      INNER JOIN YA_PRODUCT p ON
        pt.column1 = p.sku
      INNER JOIN backend_adm.productavailability pa ON
        pt.column1 = pa.productid AND pa.regionId = iPsite_id
      INNER JOIN backend_adm.productregion pr ON
        pt.column1 = pr.productid AND pr.regionId = iPsite_id
      LEFT OUTER JOIN YA_AVAILABILITY_OVERRIDE o ON
        pr.supplierId = o.supplier_id
        AND p.account_id = o.account_id
        AND SYSDATE BETWEEN o.start_date AND o.end_date
        AND pa.availability < o.availability_id
    WHERE
      pa.regionId = iPsite_id
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
      NVL(pr.preorder, 'N') AS preorder,
      NVL(pr.preorderstart, dtLnullDate) AS preorder_start,
      NVL(pr.preorderend, dtLnullDate) AS preorder_end,
      NVL(pr.listprice, 9999) AS list_price,
      NVL(pr.saleprice, 9999) AS sale_price,
      NVL(pr.salepricestart, dtLnullDate) AS sale_start,
      NVL(pr.salepriceend, dtLnullDate) AS sale_end,
      NVL(pl.prod_name_u, ple.prod_name_u),
      NVL(p.release_date, dtLnullDate),
      pl2.prod_name_img_loc,
      NVL(pl2.name_img_width, 0),
      NVL(pl2.name_img_height, 0),
      NVL(p.account_id, -1),
      NVL(pr.supplierId, -1),
      NVL(pr.ENABLE, 'N'),
      NVL(pr.cansell, 'N'),
      NVL(pl.prod_subtitle, ple.prod_subtitle),
      NVL(pl.prod_name_aka, ple.prod_name_aka),
      NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
      p.preorder_buffer_day AS preorder_buffer_day,
      1 AS region_count
    FROM
      TEMP_PRODUCT_INT_TABLE tp,
      YA_PRODUCT p,
      YA_PROD_LANG pl,
      YA_PROD_LANG pl2,
      YA_PROD_LANG ple,
      productregion pr
    WHERE tp.column1 = p.sku
    AND p.sku=pr.productId
    AND pr.regionId=iPsite_id
    AND p.sku = pl.sku (+)
    AND pl.lang_id = iPlang_id
    AND p.sku = pl2.sku (+)
    AND pl2.lang_id IN (
                        SELECT lang_id
                        FROM YA_PROD_LANG
                        WHERE sku = p.sku
                        AND preferred_flag='Y'
                        AND ROWNUM = 1
                        )
    AND p.sku = ple.sku (+)
    AND ple.lang_id = 1 /* English */
    AND p.is_parent = 'N'
    AND pr.regionId = iPsite_id;


    RETURN;
  RETURN;
  END GetProductBase;


/* proc_fe_GetDeptIDBySKU */
  PROCEDURE GetDeptIDListBySKU (
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
  SELECT dept_id
  FROM YA_PROD_DEPT
  WHERE sku = iPsku
  AND dept_id <> 0
  AND ((CASE iPsite_id
  	WHEN 1 THEN us_enabled
  	WHEN 2 THEN us_ws_enabled
  	WHEN 3 THEN jp_enabled
  	WHEN 5 THEN hk_enabled
  	WHEN 7 THEN tw_enabled
  	ELSE 'Y'  END)='Y')
  ORDER BY dept_id;
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
  SELECT DISTINCT dept_id
  FROM YA_PROD_DEPT
  WHERE sku IN (SELECT sku FROM YA_PROD_REL WHERE parent_sku = iPsku)

  AND dept_id <> 0
  AND ((CASE iPsite_id
  	WHEN 1 THEN us_enabled
  	WHEN 2 THEN us_ws_enabled
  	WHEN 3 THEN jp_enabled
  	WHEN 5 THEN hk_enabled
  	WHEN 7 THEN tw_enabled
  	ELSE 'Y'  END)='Y')
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
  WHERE preferred_flag = 'Y'
  AND sku = iPsku
  AND ROWNUM = 1;
END;

  PROCEDURE GetProductsFromBargainPool (
    iPsiteId  IN INT,
    iPdeptId  IN INT,
    iPrating  IN INT,
    curPgetBargain OUT refCur
  )
AS
    iLtypeId  INT;
BEGIN
  iLtypeId := 1;

  OPEN curPgetBargain FOR
      SELECT pl.sku
      FROM
        YA_PRODUCT_POOL pl,
        YA_PRODUCT p,
        YA_LIMITED_QUANTITY lq,
        YA_CAMPAIGN c,
        YA_PROD_DEPT pd,
		productregion pr,
		productavailability pa
      WHERE pl.sku = p.sku
	  AND p.sku=pr.productId
	  AND pr.regionId=iPsiteId
	  AND p.sku=pa.productId
	  AND pa.regionId=iPsiteId
      AND p.sku = lq.sku
      AND lq.sku = c.sku
      AND pl.sku = pd.sku
      AND lq.frontend_quantity > 0
      AND (lq.site_id = iPsiteId OR lq.site_id = 99)
      AND c.campaign_code = 10
      AND pd.dept_id = iPdeptId
      AND pl.type_id = iLtypeId
      AND pl.rating >= iPrating
      AND pr.cansell = 'Y'
      AND pr.ENABLE = 'Y'
      AND pa.availability = 10
      AND pr.saleprice IS NOT NULL
      AND pr.saleprice < pr.listprice
      ORDER BY pl.rating DESC;
RETURN;
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
      SELECT productId
      FROM productregion
      WHERE regionId=iPsiteID
	  AND productId >= iPlRange
      AND productId <= iPuRange
      AND ENABLE = 'Y'
      ORDER BY productId DESC;

RETURN;
END;

  PROCEDURE GetMaxProductSku (
    iPsiteID  IN INT,
    iPMaxSku  OUT INT
    )
AS
BEGIN
      SELECT MAX(productId) INTO iPMaxSku
      FROM productregion
      WHERE regionId=iPsiteID
	  AND ENABLE = 'Y';
RETURN;
END;


  PROCEDURE GetStoryBoardItems (
    iPsku IN INT,
    iPlangId IN INT,
    iPepId IN INT,
    curPgetStoryBoard OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetStoryBoard FOR
    SELECT
      TYPE, content
    FROM
      YA_STORYBOARD
    WHERE
      sku = iPsku
      AND lang_id = iPlangId
      AND TYPE <> 4
    UNION ALL
    SELECT
      TYPE, content
      FROM
        YA_STORYBOARD
      WHERE
        sku = iPsku
        AND lang_id = iPlangId
        AND ep_id = iPepId
        AND TYPE = 4;
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

  PROCEDURE GetPublisherProductGroup (
    iPpublisherId IN INT,
    iPlangId IN INT,
    curPgetProductGroup OUT refCur
  )
  AS
  BEGIN
    OPEN curPgetProductGroup FOR
    SELECT
      p.sku, pl.prod_name_u
    FROM
      YA_PRODUCT p
    INNER JOIN YA_PROD_LANG pl
    ON p.is_parent = 'Y'
      AND p.sku IN (SELECT DISTINCT parent_sku FROM YA_PROD_REL WHERE sku IN (SELECT sku FROM YA_PRODUCT WHERE publisher_id = iPpublisherId))
      AND p.sku = pl.sku
      AND pl.lang_id = iPlangId
    GROUP BY p.sku, pl.prod_name_u
    ORDER BY p.sku DESC;
/*
    SELECT
      p.sku, pl.prod_name_u
    FROM YA_PROD_REL pr
    INNER JOIN YA_PRODUCT p ON p.sku = pr.parent_sku AND p.publisher_id = iPpublisherId AND p.is_parent = 'Y'
    INNER JOIN YA_PROD_LANG pl ON p.sku = pl.sku AND pl.lang_id = iPlangId
    GROUP BY p.sku, pl.prod_name_u
    ORDER BY p.sku DESC;
*/
    RETURN;
  END GetPublisherProductGroup;

END Pkg_Fe_Productaccess;
/