CREATE OR REPLACE package Pkg_fe_ProductAccess
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
END Pkg_fe_ProductAccess;
/

CREATE OR REPLACE package body Pkg_fe_ProductAccess
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
      FROM ya_publisher_group_lang
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
        CAST(al.lang_id as int)
      FROM ya_attribute_lang al
      WHERE al.attribute_id = iPattrId
      AND al.lang_id <= 4
      ORDER BY al.lang_id;

    OPEN curPgetAttri2 FOR
      SELECT
        a.attribute_id,
        CAST(a.attribute_type_id as int),
        a.img_loc,
        NVL(a.img_height,0),
        NVL(a.img_width,0)
      FROM ya_attribute a
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
      FROM ya_supplier_lang
      WHERE supplier_id = iPsupplier_id
      AND lang_id = iPlang_id;
      EXCEPTION when NO_DATA_FOUND THEN
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
          pa.availability as availability,
          pr.displayPriority as priority,
          p.release_date,
          CASE WHEN pa.availability <  60 THEN 10 ELSE pa.availability END as avail_order
        FROM
          ya_product p,
          ya_campaign c,
          ya_prod_dept pd,
          ya_adult_product ap,
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
          AND pr.enable = 'Y'
          AND NVL(ap.sku, 0) <= (CASE cPfilter_adult when 'Y'
                                  THEN 1 ELSE NVL(ap.sku, 2139999999)
                                  END
                                  )
          AND (
            NVL(
              (
              CASE WHEN
                SYSDATE BETWEEN pr.salepricestart AND pr.salepriceend
                THEN pr.saleprice
                ELSE null END
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
                CASE WHEN pr.listprice is null
                THEN 1 WHEN pr.listprice = 0
                THEN 1 ELSE pr.listprice end
              ) * 100
            )
            BETWEEN iPpercent_off_from and iPpercent_off_to)
            ORDER BY avail_order, p.is_parent desc, priority desc, p.release_date desc, p.sku desc;

      END;
    ELSE
      BEGIN
        OPEN curPgetClear FOR
          SELECT
            DISTINCT p.sku,
            p.is_parent,
            pa.availability,
            pr.displayPriority as priority,
            p.release_date,
            CASE WHEN pa.availability < 60 THEN 10 ELSE pa.availability END as avail_order
          FROM
            ya_product p,
            ya_campaign c,
            ya_prod_dept pd,
            ya_adult_product ap,
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
            AND pr.enable = 'Y'
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
            ORDER BY avail_order, p.is_parent desc, priority desc, p.release_date desc, p.sku desc;
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
    ELSE avail.availability END as avail_order,
      NVL(p.country_release_id, -1) AS availability_id
    FROM
      ya_product p,
      ya_campaign c,
      ya_prod_dept pd,
      ya_cross_selling_type3 cs,
      ya_product cp,
      ya_adult_product ap,
      ya_limited_quantity lq,
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
      AND pr1.enable = 'Y'
      AND ap.sku (+) = p.sku
      AND lq.sku (+) = p.sku
      AND (lq.site_id = iPsite_id OR lq.site_id = 99)
      AND lq.frontend_quantity >= 0
      /* new availability */
      AND avail.ProductId = p.sku
      AND pr.enable = 'Y'
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
            end
          ) or
          (
            c.campaign_code = iLcampaign_code_a
          )
        )
      AND NVL(ap.sku, 0) <= (CASE cPfilter_adult when 'Y' then 1 else NVL(ap.sku, 2139999999) end)
      AND p.is_parent = case cPget_group when 'B' then p.is_parent when 'G' then 'Y' else 'N' end
      AND pr.preorder = case cPgetPreorder when 'B' then pr.preorder else cPgetPreorder end
      /* new availability */
      AND avail.availability < 60
      AND avail.regionId = iPsite_id
      ORDER BY p.is_parent desc, avail_order, priority desc, p.release_date desc, p.sku desc
  ) r
  WHERE
    ROWNUM <= case WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;
    return;
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
      case
        WHEN avail.availability IS NULL THEN 90
        when avail.availability < 60 then 10
        else avail.availability
      end avail_order,
        NVL(p.country_release_id, -1)
      FROM
        ya_product p,
      ya_campaign c,
      ya_prod_dept pd,
      ya_prod_attr pa,
      (
        SELECT
          cs.sku,
          cs.related_sku
        FROM
          ya_cross_selling_type3 cs,
          productregion pr
        WHERE 1=1 --cs.type_id = 3
        AND cs.sku = pr.productId
	      AND pr.regionId=iPsite_id
        AND pr.enable = 'Y'
      ) cs,
      ya_adult_product ap,
      ya_limited_quantity lq,
      productAvailability avail,
		  productregion pr
      WHERE c.sku=p.sku
      AND (c.campaign_code = iPcampaign_code or c.campaign_code = iLcampaign_code_a)
      AND p.sku = pd.sku
      AND pd.dept_id = iPdept_id
      AND pa.sku = p.sku
		  AND pa.sku=pr.productId
		  AND pr.regionId=iPsite_id
      AND pa.attribute_id = iPattr_id
      AND cs.sku (+) = p.sku /* Get related (VCD) products */
      AND ap.sku (+) = p.sku
      AND lq.sku (+) = p.sku
      AND (lq.site_id = iPsite_id or lq.site_id = 99)
      AND lq.frontend_quantity >= 0
      /* new availability */
      AND avail.productId = p.sku
      AND pr.enable = 'Y'
      AND
      (
        NVL
        (
          lq.frontend_quantity, 0
        ) >=
        (
          case cLis_limited_qty when 'Y'
          then 1 else NVL
          (
            lq.frontend_quantity, 0
          )
          end
        ) or
        (
          c.campaign_code = iLcampaign_code_a
        )
      )
      AND NVL(ap.sku, 0) <= (case cPfilter_adult when 'Y' then 1 else NVL(ap.sku, 2139999999) end)
      AND p.is_parent = case cPget_group when 'B' then p.is_parent when 'G' then 'Y' else 'N' end
      AND pr.preorder = case cPgetPreorder when 'B' then pr.preorder else cPgetPreorder end
      /* new availability */
      AND avail.availability < 60  and avail.regionId = iPsite_id
      ORDER BY is_parent desc, avail_order, priority desc nulls last, p.release_date desc nulls last, p.sku desc
    ) r
    WHERE
      ROWNUM <= case WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;
    return;
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
      FROM ya_dept_attr
      WHERE dept_id = iPdept_id
      AND attribute_id = 125;

      EXCEPTION when NO_DATA_FOUND THEN
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
            case
              WHEN pa.availability IS NULL THEN 90
              when pa.availability < 60 then 10
              else pa.availability
            end avail_order,
            NVL(p.country_release_id, -1)
          FROM
            ya_product p,
            ya_prod_dept pd,
            ya_cross_selling_type3 cs,
            ya_adult_product ap,
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
          AND pr.enable = 'Y'
          AND ap.sku (+) = p.sku
          AND pr1.enable = 'Y'
          AND NVL(ap.sku, 0) <= (case cPfilter_adult when 'Y' then 1 else NVL(ap.sku, 2139999999) end)
          AND p.is_parent = case cPget_group when 'B' then p.is_parent when 'G' then 'Y' else 'N' end
          AND pr.preorder = case when cPgetPreorder = 'B'then pr.preorder
                                when cPgetPreorder = 'N'
                                and p.release_date <= SYSDATE
                                and not (pr.preorder = 'Y' and SYSDATE
                                between pr.preorderstart and pr.preorderend)
                                then pr.preorder
                                else cPgetPreorder end
          ORDER BY p.is_parent desc, avail_order, priority desc, p.release_date desc NULLS first, p.sku desc
        ) r
        WHERE
          ROWNUM <= case WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;

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
            p.release_date, null,
            case
              WHEN pa.availability IS NULL THEN 90
              when pa.availability < 60 then 10
              else pa.availability
            end avail_order,
            NVL(p.country_release_id, -1)
          FROM
            ya_product p,
            ya_prod_dept pd,
            ya_adult_product ap,
	    ProductAvailability pa,
	    productregion pr
          WHERE p.sku = pd.sku
          AND p.sku=pr.productId
	  AND pr.regionId=iPsite_id
			    AND p.sku=pa.productId
			    AND pa.regionId=iPsite_id
          AND pd.dept_id = iPdept_id
          AND ap.sku (+) = p.sku
          AND pr.enable = 'Y'
          AND NVL(ap.sku, 0)<=(case cPfilter_adult when 'Y' then 1 else NVL(ap.sku, 2139999999) end)
          AND p.is_parent=case cPget_group when 'B' then p.is_parent when 'G' then 'Y' else 'N' end
          AND pr.preorder = case when cPgetPreorder = 'B' then pr.preorder
                                    when cPgetPreorder = 'N'
                                    and p.release_date <= SYSDATE
                                    and not (pr.preorder = 'Y' and SYSDATE
                                    between pr.preorderstart and pr.preorderend
                                            )
                                            then pr.preorder
                                            else cPgetPreorder
                              end
          ORDER BY p.is_parent desc, avail_order, priority desc nulls last, p.release_date desc nulls last, p.sku desc
        ) r
        WHERE
          ROWNUM <= case WHEN iLrowcnt = 0 THEN (ROWNUM + 1) ELSE iLrowcnt END;
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
        ya_product p,
        ya_cross_selling_type3 cs,
        ya_adult_product ap,
		productregion pr,
		productavailability pa
      WHERE 1=1
	  AND pa.productId=p.sku
	  AND pa.regionId=iPsite_id
	  AND pr.productId=p.sku
	  AND pr.regionId=iPsite_id
      AND p.SKU IN (SELECT SKU FROM ya_prod_dept where dept_id = iPdept_id)
      AND p.SKU IN (SELECT SKU FROM ya_prod_attr where attribute_id = iPattr_id)
      AND ap.sku (+) = p.sku
      AND cs.sku (+) = p.sku /* Get related (VCD) products */
      AND pr.enable = 'Y'
      AND NVL(ap.sku, 0) <= (case cPfilter_adult when 'Y' then 1 else NVL(ap.sku, 2139999999) end)
      AND p.is_parent = case cPget_group when 'B' then p.is_parent when 'G' then 'Y' else 'N' end
      AND pr.preorder = case cPgetPreorder when 'B' then pr.preorder else cPgetPreorder end
      ORDER BY p.is_parent desc, avail_order, priority desc nulls last, p.release_date desc nulls last, p.sku desc
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
      ya_prod_lang pl,
      ya_review_summary rs,
      ya_description d
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
    INSERT INTO ya_track_it_down (
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
        FROM ya_track_it_down
        WHERE sku = iPsku
        AND site_id = iPsite_id
        AND email = cPemail
        AND ROWNUM = 1
      );

    IF sqlcode <> 0 THEN
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
    INSERT INTO ya_future_release (
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
        FROM ya_future_release
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
        FROM ya_most_talked_about
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
        pli.desc_img_loc,
        NVL(pli.desc_img_width,0),
        NVL(pli.desc_img_height,0),
        NULL, --dl.dept_name,
        -1, --NVL(ps.dept_id, -1),
        pll.remark
      FROM
        ya_product_lot pl
        LEFT OUTER JOIN ya_prod_lot_lang pll ON
          pl.prod_lot_id = pll.prod_lot_id
          AND pll.lang_id = iPlangId
        LEFT OUTER JOIN ya_prod_lot_lang pli ON
          pli.prod_lot_id = pl.prod_lot_id
          AND pli.preferred_flag = 'Y'
        INNER JOIN productregion pr ON
          pl.sku = pr.productId
		  AND pr.regionId=iPsiteId
      WHERE
        pl.file_id = iPfileId
        AND pr.enable = 'Y'
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
        pli.desc_img_loc,
        NVL(pli.desc_img_width,0),
        NVL(pli.desc_img_height,0),
        NULL, --dl.dept_name,
        -1, --NVL(ps.dept_id, -1),
        pll.remark
      FROM
        ya_mirror_product_lot pl
        LEFT OUTER JOIN ya_mirror_prod_lot_lang pll ON
          pl.prod_lot_id = pll.prod_lot_id
          AND pll.lang_id = iPlangId
        LEFT OUTER JOIN ya_mirror_prod_lot_lang pli ON
          pli.prod_lot_id = pl.prod_lot_id
          AND pli.preferred_flag = 'Y'
        INNER JOIN productregion pr ON
          pl.sku = pr.productId
		  AND pr.regionId=iPsiteId
      WHERE
        pl.file_id = iPfileId
        AND pr.enable = 'Y'
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
    SELECT sample_loc FROM ya_prod_video WHERE sku = iPsku;
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
          INSERT INTO temp_product_int_table (column1, column2)
          VALUES (CAST(substr(cLskuCsv,1,iLendpos-1) AS INT), iCounter);

          cLskuCsv := SUBSTR(cLskuCsv, iLendpos+1);
          iLendpos := INSTR(cLskuCsv, ',');
          iCounter := iCounter + 1;
        END;
      END LOOP;

      INSERT INTO temp_product_int_table (column1, column2)
      VALUES (CAST(cLskuCsv AS INT), iCounter);
    END;
  END IF;


  OPEN curPgetProduct1 FOR
  SELECT
    pp.isbn as isbn,
    pp.pages,
    lp.meaning as format,
    le.meaning as edition,
    pp.edition_number as edition_number,
    pp.volume_number as volume_number,
    pp.sku,
    pp.grade_from,
    pp.grade_to
  FROM
    ya_prod_printed pp
    LEFT OUTER JOIN ya_lookup lp ON
      pp.format = lp.code_id
      AND lp.type_id = 100 /* Western book format */
    LEFT OUTER JOIN ya_lookup le ON
      pp.edition = le.code_id
      AND le.type_id = 101 /* Western book edition */
    INNER JOIN temp_product_int_table p ON
      pp.sku = p.column1
  ORDER BY p.column2;

  OPEN curPgetProduct2 FOR
  SELECT
    award_id,
    a.award_name as award_name,
    a.award_category as award_category,
    NVL(a.award_year, -1) as award_year,
    l.meaning as award_status,
    a.sku
  FROM
    ya_awards a,
    ya_lookup l,
    temp_product_int_table p
  WHERE a.award_status_type = l.code_id
  AND l.type_id = 103
  AND a.sku = p.column1
  ORDER BY p.column2;

  OPEN curPgetProduct3 FOR
  SELECT
    tn.note_id,
    lt.meaning as type,
    NVL(tn.partial_text, 0) as partial_text,
    tn.text_from_other as text_from_other,
    lm.meaning as medium,
    source_date_string as source_date_string,
    source_volume as source_volume,
    note_text as note_text,
    a.artist_id,
    al.firstname_u as artist_firstname,
    al.lastname_u as artist_lastname,
    al.akaname_u as artist_akaname,
    al2.firstname_u as artist_firstname,
    al2.lastname_u as artist_lastname,
    al2.akaname_u as artist_akaname,
    al3.name_img_loc as name_img_loc,
    NVL(al3.name_img_width, -1) as name_img_width,
    NVL(al3.name_img_height, -1) as name_img_height,
    NVL(a.origin_country_id, 0) as origin_country_id,
    NVL(al3.lang_id, 0) as lang_id,
    al.prefix as prefix,
    al.suffix as suffix,
    al2.prefix as prefix2,
    al2.suffix as suffix2,
    tn.note_type as type_id,
    pt.sku,
    NVL(pt.refer_sku, -1) as refer_sku,
    ypl.prod_name as prod_name,
    yatl.attribute_name as attr_name
  FROM
    ya_prod_text_note pt
    INNER JOIN
    (
      SELECT
        case
          when account_id = 100 then 1
          else iPlangId
        end as lang_id,
        sku
      FROM ya_product
      where sku in (select column1 from temp_product_int_table)
    ) pd ON
      pt.sku = pd.sku
    INNER JOIN ya_text_note tn ON
      pt.note_id = tn.note_id
      AND tn.lang_id = pd.lang_id
    INNER JOIN ya_lookup lt ON
      tn.note_type = lt.code_id
      AND lt.type_id = 105
    LEFT OUTER JOIN ya_lookup lm ON
      tn.medium_id = lm.code_id
      AND lm.type_id = 102
    LEFT OUTER JOIN ya_artist a ON
      tn.artist_id = a.artist_id
    LEFT OUTER JOIN ya_artist_lang al ON
      a.artist_id = al.artist_id
      and al.lang_id = iPlangId
    LEFT OUTER JOIN ya_artist_lang al2 ON
      a.artist_id = al2.artist_id
      and al2.lang_id = 1
    LEFT OUTER JOIN ya_artist_lang al3 ON
      a.artist_id = al3.artist_id
      and al3.lang_id in
        (
          select lang_id
          from ya_artist_lang
          where
            artist_id=a.artist_id
            and preferred_flag='Y'
            AND ROWNUM = 1
        )
    INNER JOIN temp_product_int_table p ON
      pt.sku = p.column1
    LEFT OUTER JOIN ya_prod_lang ypl ON
      ypl.sku = pt.refer_sku
      and ypl.lang_id = iPlangId
    LEFT OUTER JOIN ya_prod_attr ypa ON
      ypa.sku = pt.refer_sku
      and ypa.attribute_id IN
        (
          SELECT yat.attribute_id
          from ya_attribute yat
          where yat.attribute_type_id = 27
        )
    LEFT OUTER JOIN ya_attribute_lang yatl ON
      yatl.attribute_id = ypa.attribute_id
      and yatl.lang_id = iPlangId
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
      	  INSERT INTO temp_product_int_table
          (
            column1
          )
          VALUES
          (
            CAST(substr(cLsku_csv,1,iLendpos-1) AS int)
          );
  	      cLsku_csv := SUBSTR(cLsku_csv, iLendpos+1);
          iLendpos := INSTR(cLsku_csv, ',');
        END;
        END LOOP;

      	INSERT INTO temp_product_int_table
        (
          column1
        )
        VALUES
        (
          CAST(cLsku_csv AS int)
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
      ya_prod_attr pa,
      ya_attribute a,
      ya_attribute_lang ale,
      ya_attribute_lang al,
      temp_product_int_table p
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
      ya_limited_quantity lq,
      temp_product_int_table p
    WHERE lq.sku = p.column1
    AND lq.site_id in (99, iPsite_id)
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
          ceil
            (
              nvl
                (
                  case
                    when dimension_weight is not null and weight is not null then
                      case
                        when dimension_weight > weight then dimension_weight
                        else weight
                      end
                    else weight
                  end,
                  iLShipmentUnitConst
                ) / iLShipmentUnitConst
            )
      END as shipment_unit
    FROM
      ya_product t1
      INNER JOIN temp_product_int_table p ON
        t1.sku = p.column1
      LEFT OUTER JOIN ya_shipping_unit t2 ON
        t1.sku = t2.sku and t2.site_id = iPsite_id;
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
      temp_product_int_table pt
      INNER JOIN ya_product p ON
        pt.column1 = p.sku
      INNER JOIN backend_adm.productavailability pa ON
        pt.column1 = pa.productid and pa.regionId = iPsite_id
      INNER JOIN backend_adm.productregion pr ON
        pt.column1 = pr.productid and pr.regionId = iPsite_id
      LEFT OUTER JOIN ya_availability_override o ON
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
      ya_campaign c,
      temp_product_int_table tp
      --(select * FROM TABLE (cast ( TabData as tabSKUList))) tp
    WHERE c.sku = tp.column1
    ORDER BY tp.column1 DESC;

    OPEN curPgetProduct6 FOR
    SELECT
      tp.column1,
      p.cover_img_loc as cover_img_loc,
      NVL(p.cover_img_width, 0) as cover_img_width,
      NVL(p.cover_img_height, 0) as cover_img_height,
      NVL(pr.preorder, 'N') as preorder,
      NVL(pr.preorderstart, dtLnullDate) as preorder_start,
      NVL(pr.preorderend, dtLnullDate) as preorder_end,
      NVL(pr.listprice, 9999) as list_price,
      NVL(pr.saleprice, 9999) as sale_price,
      NVL(pr.salepricestart, dtLnullDate) as sale_start,
      NVL(pr.salepriceend, dtLnullDate) as sale_end,
      NVL(pl.prod_name_u, ple.prod_name_u),
      NVL(p.release_date, dtLnullDate),
      pl2.prod_name_img_loc,
      NVL(pl2.name_img_width, 0),
      NVL(pl2.name_img_height, 0),
      NVL(p.account_id, -1),
      NVL(pr.supplierId, -1),
      NVL(pr.enable, 'N'),
      NVL(pr.cansell, 'N'),
      NVL(pl.prod_subtitle, ple.prod_subtitle),
      NVL(pl.prod_name_aka, ple.prod_name_aka),
      NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
      p.preorder_buffer_day as preorder_buffer_day,
      1 as region_count
    FROM
      temp_product_int_table tp,
      ya_product p,
      ya_prod_lang pl,
      ya_prod_lang pl2,
      ya_prod_lang ple,
      productregion pr
    WHERE tp.column1 = p.sku
    AND p.sku=pr.productId
    AND pr.regionId=iPsite_id
    AND p.sku = pl.sku (+)
    AND pl.lang_id = iPlang_id
    AND p.sku = pl2.sku (+)
    AND pl2.lang_id in (
                        SELECT lang_id
                        FROM ya_prod_lang
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
  FROM ya_prod_dept
  WHERE sku = iPsku
  AND dept_id <> 0
  AND ((CASE iPsite_id
  	WHEN 1 then us_enabled
  	WHEN 2 then us_ws_enabled
  	WHEN 3 then jp_enabled
  	WHEN 5 then hk_enabled
  	WHEN 7 then tw_enabled
  	ELSE 'Y'  end)='Y')
  ORDER BY dept_id;
return;
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
  FROM ya_prod_dept
  WHERE sku in (SELECT sku FROM ya_prod_rel WHERE parent_sku = iPsku)

  AND dept_id <> 0
  AND ((CASE iPsite_id
  	WHEN 1 then us_enabled
  	WHEN 2 then us_ws_enabled
  	WHEN 3 then jp_enabled
  	WHEN 5 then hk_enabled
  	WHEN 7 then tw_enabled
  	ELSE 'Y'  end)='Y')
  ORDER BY dept_id;
return;
END;

  PROCEDURE GetPreferredProductLangBySKU (
    iPsku  IN INT,
    curPgetPreferred OUT refCur
    )
AS
BEGIN
  OPEN curPgetPreferred FOR
  SELECT CAST(NVL(lang_id,-1) as int) as lang_id
  FROM ya_prod_lang
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
        ya_product_pool pl,
        ya_product p,
        ya_limited_quantity lq,
        ya_campaign c,
        ya_prod_dept pd,
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
      AND (lq.site_id = iPsiteId or lq.site_id = 99)
      AND c.campaign_code = 10
      AND pd.dept_id = iPdeptId
      AND pl.type_id = iLtypeId
      AND pl.rating >= iPrating
      AND pr.cansell = 'Y'
      AND pr.enable = 'Y'
      AND pa.availability = 10
      AND pr.saleprice is not null
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
      AND enable = 'Y'
      ORDER BY productId desc;

return;
END;

  PROCEDURE GetMaxProductSku (
    iPsiteID  IN INT,
    iPMaxSku  OUT INT
    )
AS
BEGIN
      SELECT max(productId) INTO iPMaxSku
      FROM productregion
      WHERE regionId=iPsiteID
	  AND enable = 'Y';
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
      ya_storyboard
    WHERE
      sku = iPsku
      AND lang_id = iPlangId
      AND TYPE <> 4
    UNION ALL
    SELECT
      TYPE, content
      FROM
        ya_storyboard
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
      d.description, c.priority as priority, b.priority as section_priority
    FROM
      ya_prod_gallery a,
      ya_prod_gallery_section b,
      ya_prod_gallery_image c,
      ya_prod_gallery_desc d
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
      ya_prod_gallery a,
      ya_prod_gallery_section b,
      ya_prod_gallery_image c,
      ya_prod_gallery_desc d
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
      FROM ya_prod_dept a, ya_product_artist b
     WHERE a.sku       = b.sku
       AND a.dept_id   = iPdeptId
       AND b.artist_id = iPartistId;

    EXCEPTION
      WHEN no_data_found THEN
        iPcount := 0;
  END GetPrdCountByArtistDepartment;

  PROCEDURE GetProductCountByDepartment (
    iPdeptId IN INT,
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(*) as num INTO iPcount
      FROM ya_prod_dept
     WHERE dept_id = iPdeptId;

    EXCEPTION
      WHEN no_data_found THEN
        iPcount := 0;
  END GetProductCountByDepartment;
END Pkg_fe_ProductAccess;
/

