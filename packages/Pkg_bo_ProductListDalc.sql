
REM START SS_ADM PKG_BO_PRODUCTLISTDALC

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_BO_PRODUCTLISTDALC" 
AS
  TYPE refcur IS ref CURSOR;

  -- --- cross selling 2005 ---+
  PROCEDURE GetCSProdsBySection (
    iPsku IN INT,         -- sku
    iPsectionId IN INT,   -- the id of a section("tabs" in the header of the website)
                          -- see ya_section_dept for the mapping between sectionId and deptId
    iPsiteId IN INT,
    curPresult OUT refcur
  );

  PROCEDURE GetBgnCampaignPrdByGroupId (
    iPgid IN INT,
    iPcampaign_code IN INT,
    dPupper_bound IN DECIMAL,
    dPlower_bound IN DECIMAL,
    iPsite_id IN INT,
    curPsku OUT refcur
  );

  PROCEDURE GetArtPubSKUByReleaseDateRange (
    iPdeptId   IN  INT,
    iPartistId IN INT,
    iPpublisherId IN INt,
    iPcampaignCode IN      INT,
    dtPstartDate   IN      DATE,
    dtPendDate     IN      DATE,
    curPsku      OUT     refcur
  );
  PROCEDURE GetArtistPublisherProductList (
    iPdeptId		IN 	INT,
    iPartistId		IN	INT,
    iPpublisherId IN INT,
    curPsku	OUT	refcur,
    curPcrossSell	OUT refcur
  );
  PROCEDURE GetPreOrderArtPubProdList (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    iPcampaignCode IN INT DEFAULT -1,
    curPsku OUT refcur,
    curPcrossSell OUT refcur
  );
  PROCEDURE GetPreOrderArtPubProductList (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    iPcampaignCode IN INT DEFAULT -1,
    curPsku OUT refcur,
    curPcrossSell OUT refcur
  );
  PROCEDURE GetArtPubCampaignProductList (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    iPcampaignCode IN INT,
    curPsku OUT refcur,
    curPcrossSell OUT refcur
  );
  PROCEDURE GetBargainHighlightProdList (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetAllBargainProductList (
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetAllBargainProdListByDisc (
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetAllBargainProdListByPrice (
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBargainProductList (
    iPbargainAttribute IN INT,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBargainDeptProductList (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBargainProductListByPrice (
    iPbargainAttribute IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBargainDeptProdListByPrice (
    iPdeptId IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBargainProdListByDiscount (
    iPbargainAttribute IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBargainDeptProdListByDisc (
    iPdeptId IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  );
  PROCEDURE GetBackToStockProductList (
    curPgetAward  OUT refcur,
    iPdept_id   IN  INT,
    iPpast_days   IN  INT,
    iPsite_id   IN  INT DEFAULT 1
  );
  PROCEDURE GetArtistCampaignProductList (
    iPdept_id   IN  INT,
    iPartist_id   IN  INT,
    iPcampaign_code IN  INT,
    curPgetArtist1  OUT refcur,
    curPgetArtist2  OUT refcur
  );
  PROCEDURE GetProductByAttribute (
    iPdept_id   IN  INT,
    iPattribute_id  IN  INT,
    curPgetProduct  OUT refcur
  );
  PROCEDURE GetProductList (
    iPdept_id   IN  INT,
    iPtype_id   IN  INT,
    curPgetproduct1 OUT refcur,
    curPgetproduct2 OUT refcur
  );
  PROCEDURE GetProductGroupByInitial (
    cPinitial   IN  CHAR,
    iPdept_id   IN  INT,
    curPgetProduct  OUT refcur
  );
  PROCEDURE GetPreOrderDeadlineProdList (
    iPdept_id   IN  INT,
    curPgetPre1   OUT refcur,
    curPgetPre2   OUT refcur
  );
  PROCEDURE GetReviewProductList (
    curPgetReview   OUT refcur,
    iPdept_id     IN  INT,
    cPtype      IN  VARCHAR2,
    iPnum_of_review   IN  INT DEFAULT 20
  );
  PROCEDURE GetDepartmentProductList (
    iPdept_id   IN  INT,
    curPgetProduct1 OUT refcur,
    curPgetProduct2 OUT refcur
  );
  PROCEDURE GetCampaignProductList (
    iPdept_id   IN  INT,
    iPcampaign_code IN  INT,
    curPgetCamp1  OUT refcur,
    curPgetCamp2  OUT refcur
  );
  PROCEDURE GetPreOrderProductList (
    curPgetPre1   OUT refcur,
    curPgetPre2   OUT refcur,
    iPdept_id   IN  INT,
    iPcampaign_code IN  INT DEFAULT -1
  );
  PROCEDURE GetProductByReleaseDate (
    iPdept_id   IN  INT,
    dtPstart_date IN  DATE,
    dtPend_date   IN  DATE,
    iPsite_id   IN  INT,
    curPgetProduct  OUT refcur
  );
  PROCEDURE GetSKUByReleaseDateRange (
    iPdept_id   IN  INT,
    iPcampaign_code IN      INT,
    dtPstart_date   IN      DATE,
    dtPend_date     IN      DATE,
    curPgetSKU      OUT     refcur
  );
  PROCEDURE GetSupplierProductList (
    iPdept_id     IN  INT,
    iPsupplier_id   IN  INT,
    curPgetSupplier   OUT refcur
  );
  PROCEDURE GetPublisherGroupProductList (
    iPdept_id     IN  INT,
    iPpublisher_group_id  IN  INT,
    curPgetPublisher    OUT refcur
  );
  PROCEDURE GetArtistProductList (
    iPdept_id		IN 	INT,
    iPartist_id		IN	INT,
    curPgetArtist1	OUT	refcur,
    curPgetArtist2	OUT refcur
  );
  PROCEDURE GetGroupProductListByDept (
    iPdept_id		IN	INT,
    iPparent_sku	IN	INT,
    curPgetGroup	OUT	refcur
  );
  PROCEDURE GetGroupProductList (
    iPparent_sku	IN	INT,
    curPgetGroup	OUT	refcur
  );
  PROCEDURE GetFrontpageProductList (
    iPpage_id		IN	INT,
    curPgetFront	OUT	refcur
  );
  PROCEDURE GetMirrorFrontpageProductList (
    iPpage_id		IN	INT,
    curPgetFront	OUT	refcur
  );
  PROCEDURE GetProductByAvailability (
    curPgetProduct	OUT	refcur,
    iPdept_id		IN	INT,
    iPavailability_id	IN	INT,
    iPcampaign_code	IN	INT DEFAULT -1
  );
  PROCEDURE GetBargainPoolProduct (
    iPline_id		IN 	INT,
    curPgetBargain	OUT	refcur
  );
  PROCEDURE GetTopSellerProduct (
    iPdept_id			IN	INT,
    iPtype_id			IN	INT,
    iPsite_id			IN	INT,
    curPgetSales		OUT	refcur
  );
  PROCEDURE GetNRProdistByLaunchDate (
    iPdept_id		IN	INT,
    dtPstart_date	IN	DATE,
    dtPend_date		IN	DATE,
    curPgetNew1		OUT	refcur,
    curPgetNew2		OUT	refcur
  );
  PROCEDURE GetNRProdListBySupplierID (
    iPdept_id	 	IN	INT,
    dtPstart_date	IN	DATE,
    dtPend_date		IN	DATE,
    iPsite_id		IN	INT,
    iPsupplier_id	IN	INT,
    curPgetNew		OUT	refcur
  );
  PROCEDURE GetAwardProductList (
    cPaward_name	IN 	VARCHAR2,
    curPgetAward	OUT	refcur
  );
  PROCEDURE GetClearanceProduct (
    iPsite_id		IN 	INT,
    iPcategory_id	IN	INT,
    iPdept_id		IN	INT,
    curPgetClear	OUT	refcur
  );
  PROCEDURE GetClearanceGroup (
    iPsite_id		IN 	INT,
    curPgetClear	OUT	refcur
  );
  PROCEDURE GetAwardProdListByEventId (
    iPeventId IN INT,
    iPYear IN INT,
    iPSiteId IN INT  ,
    cPawardProdList OUT refcur
  );
  PROCEDURE GetAwardProdListByProdCat (
    iPrevAccGroupId IN INT,
    iPyear IN INT,
    iPsiteId IN INT,
    cPawardProdList OUT refcur
  );
  PROCEDURE GetAwardProdListByArtistId (
-- a specific CASE of proc_bo_getAwardProductByArtistId
    iPartistId IN INT,
    iPsiteId IN INT,
    cPawardProdList OUT refcur
  );
  PROCEDURE GetArtistProductByAvailability (
    iPartist_id		IN   	INT,
    iPdept_id		IN     	INT,
    iPavailability_id	IN     	INT,
    curPgetArtist	OUT refcur
  );
  PROCEDURE GetBgnCpnProdByPrice (
    iPbargain_attr IN INT,
    iPcampaign_code IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  );
  PROCEDURE GetBgnDeptCpnProdByPrice (
    iPdept_id IN INT,
    iPcampaign_code IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  );
  PROCEDURE GetBgnCpnPrdByArtistId (
    iPcampaign_code IN INT,
    iPartist_id IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  );
  PROCEDURE GetBgnCpnPrdListBySku (
    iPcampaign_code IN INT,
    iPsku IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  );
  /*
  * Game Project 21 Nov 2005
  * proc_bo_GetTrailerProductByDepartment
  */
  PROCEDURE GetTrailerProdByDept (
    iPdept_id IN INT,
    iPlang_id IN INT,
    rcPresult_1 OUT refCur,
    rcPresult_2 OUT refCur
  );
  /*
  * Bargain - Random Browse List 29 May 2006
  * --
  */
  PROCEDURE GetBargainDeptProductLot (
    iPdept_id		IN	INT,
    iPlot_location      IN      INT,
    curPresult	OUT	refcur
  );

  PROCEDURE GetMirrorBargainDeptProductLot (
    iPdept_id				IN	INT,
    iPlot_location  IN  INT,
    curPresult			OUT	refcur
  );
END Pkg_bo_ProductListDalc;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_BO_PRODUCTLISTDALC" 
IS
  PROCEDURE GetBargainHighlightProdList (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT sku
    FROM ya_bargain_highlight
    WHERE dept_id = iPdeptId
      AND site_id = iPsiteId
    ORDER BY priority;
    RETURN;
  END GetBargainHighlightProdList;

  PROCEDURE GetAllBargainProductList (
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT
      bp.sku
    FROM
      ya_bargain_product bp
    WHERE
      bp.site_id = iPsiteId;
    RETURN;
  END GetAllBargainProductList;

  PROCEDURE GetAllBargainProdListByDisc (
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT
      bp.sku
    FROM
      ya_bargain_product bp
    WHERE
      bp.sale_start <= SYSDATE
      AND bp.sale_end >= SYSDATE
      AND bp.discount BETWEEN deciPlowerBound AND deciPupperBound
      AND bp.site_id = iPsiteId
      AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);
    RETURN;
  END GetAllBargainProdListByDisc;

  PROCEDURE GetAllBargainProdListByPrice (
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
      SELECT bp.sku
      FROM ya_bargain_product bp
      WHERE bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN deciPlowerBound  AND deciPupperBound
        AND bp.site_id = iPsiteId
        AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);
    RETURN;
  END GetAllBargainProdListByPrice;

  PROCEDURE GetBargainProductList (
    iPbargainAttribute IN INT,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT
      bp.sku
    FROM
      ya_bargain_product bp,
      ya_prod_attr pa
    WHERE
      bp.sku = pa.sku
      AND bp.sale_start <= sysdate
      AND bp.sale_end >= sysdate
      AND pa.attribute_id = iPbargainAttribute
      AND bp.site_id = iPsiteId
      AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);
    RETURN;
  END GetBargainProductList;

  PROCEDURE GetBargainDeptProductList (
    iPdeptId IN INT,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
    iLtmp INT;
  BEGIN
    BEGIN
    SELECT
      1 INTO iLtmp
    FROM
      ya_dept_attr
    WHERE
      dept_id = iPdeptId
      AND attribute_id IN (84, 79982)
      AND ROWNUM = 1;

    EXCEPTION WHEN no_data_found THEN
      iLtmp :=-1;
    END;

    IF iLtmp <> -1 THEN
      OPEN curPsku FOR
      SELECT bp.sku
      FROM ya_bargain_product bp
        INNER JOIN ya_prod_dept pd  on bp.sku = pd.sku
      WHERE bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND pd.dept_id = iPdeptId
        AND bp.site_id = iPsiteId;
    ELSE
      OPEN curPsku FOR
      SELECT bp.sku
      FROM ya_bargain_product bp
        INNER JOIN ya_prod_dept pd ON bp.sku = pd.sku
      WHERE bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND pd.dept_id = iPdeptId
        AND bp.site_id = iPsiteId
        AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);
    END IF;
    RETURN;
  END GetBargainDeptProductList;

  PROCEDURE GetBargainProductListByPrice (
    iPbargainAttribute IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT
      bp.sku
    FROM
      ya_bargain_product bp,
      ya_prod_attr pa
    WHERE
      bp.sku = pa.sku
      AND  bp.sale_start <= SYSDATE
      AND bp.sale_end >= SYSDATE
      AND bp.sale_price BETWEEN deciPlowerBound AND deciPupperBound
      AND pa.attribute_id = iPbargainAttribute
      AND bp.site_id = iPsiteId
      AND bp.sku NOT IN (SELECT sku FROM ya_adult_product);
  END GetBargainProductListByPrice;

  PROCEDURE GetBargainDeptProdListByPrice (
    iPdeptId IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
    iLtmp INT;
  BEGIN
    BEGIN
     SELECT
      1 INTO iLtmp
    FROM
      ya_dept_attr
    WHERE
      dept_id = iPdeptId
      AND attribute_id IN (84, 79982)
      AND ROWNUM = 1;

    EXCEPTION WHEN no_data_found THEN
      iLtmp := -1;
    END;

    IF iLtmp <> -1 THEN
      OPEN curPsku FOR
      SELECT bp.sku
      FROM
        ya_bargain_product bp
        ,ya_prod_dept pd
      WHERE
        bp.sku = pd.sku
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN deciPlowerBound AND deciPupperBound
        AND pd.dept_id = iPdeptId
        AND bp.site_id = iPsiteId;
    ELSE
      OPEN curPsku FOR
      SELECT bp.sku
      FROM
        ya_bargain_product bp
        , ya_prod_dept pd
      WHERE
        bp.sku = pd.sku
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN deciPlowerBound AND deciPupperBound
        AND pd.dept_id = iPdeptId
        AND bp.site_id = iPsiteId
        AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);
    END IF;
    RETURN;
  END GetBargainDeptProdListByPrice;

  PROCEDURE GetBargainProdListByDiscount (
    iPbargainAttribute IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    open curPsku FOR
    SELECT
      bp.sku
    FROM
      ya_bargain_product bp
      , ya_prod_attr pa
    WHERE
      bp.sku = pa.sku
      AND bp.sale_start <= sysdate
      AND bp.sale_end >= sysdate
      AND bp.discount BETWEEN deciPlowerBound AND deciPupperBound
      AND pa.attribute_id = iPbargainAttribute
      AND bp.site_id = iPsiteId
      AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);

    RETURN;
  END GetBargainProdListByDiscount;

  PROCEDURE GetBargainDeptProdListByDisc (
    iPdeptId IN INT,
    deciPlowerBound IN DECIMAL,
    deciPupperBound IN DECIMAL,
    iPsiteId IN INT,
    curPsku OUT refcur
  )
  AS
    iLtmp INT;
  BEGIN
    BEGIN
     SELECT
      1 INTO iLtmp
    FROM
      ya_dept_attr
    WHERE
      dept_id = iPdeptId
      AND attribute_id IN (84, 79982)
      AND ROWNUM = 1;

    EXCEPTION WHEN no_data_found THEN
      iLtmp := -1;
    END;

    IF iLtmp <> -1 THEN
      OPEN curPsku FOR
      SELECT bp.sku
      FROM
        ya_bargain_product bp
        , ya_prod_dept pd
      WHERE
        bp.sku = pd.sku
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.discount BETWEEN deciPlowerBound AND deciPupperBound
        AND pd.dept_id = iPdeptId
        AND bp.site_id = iPsiteId;
    ELSE
      OPEN curPsku FOR
      SELECT bp.sku
      FROM
        ya_bargain_product bp
        , ya_prod_dept pd
      WHERE
        bp.sku = pd.sku
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.discount BETWEEN deciPlowerBound AND deciPupperBound
        AND pd.dept_id = iPdeptId
        AND bp.site_id = iPsiteId
        AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);
    END IF;
    RETURN;
  END GetBargainDeptProdListByDisc;

  PROCEDURE GetBackToStockProductList (
    curPgetAward  OUT refcur,
    iPdept_id   IN  INT,
    iPpast_days   IN  INT,
    iPsite_id   IN  INT DEFAULT 1
  )
  AS
  BEGIN
    IF iPsite_id = 1 THEN
      BEGIN
        OPEN curPgetAward FOR
        SELECT
          DISTINCT dept.sku
        FROM
          ya_prod_dept dept,
          ProductAvailability avail,
          ya_product p
        WHERE
          dept.sku = avail.ProductId
          AND dept.sku = p.sku
          AND dept.dept_id = iPdept_id
          AND avail.originId = 1
          AND avail.Category = 1
          AND avail.lastNonSellableDate is NOT null
          AND ROUND(SYSDATE - avail.lastNonSellableDate) < iPpast_days
          AND (avail.lastSellableDate < avail.lastNonSellableDate
          OR  avail.lastSellableDate is null)
          AND dept.sku NOT IN
          (
            SELECT a.sku
            FROM  ya_adult_product a
          )
          AND p.release_date < (TO_DATE(SYSDATE) + ( 1 * iPpast_days * - 1 ) );
      END;
    ELSE
      BEGIN
        OPEN curPgetAward FOR
        SELECT
          DISTINCT dept.sku
        FROM
          ya_prod_dept dept,
          ProductAvailability avail,
          ya_product p
        WHERE
          dept.sku = avail.ProductId
          AND dept.sku = p.sku
          AND dept.dept_id = iPdept_id
          AND avail.originId = 7
          AND avail.Category = 1
          AND avail.lastNonSellableDate IS NOT NULL
          AND ROUND((SYSDATE) - avail.lastNonSellableDate) < iPpast_days
          AND (avail.lastSellableDate  < avail.lastNonSellableDate OR avail.lastSellableDate IS NULL)
          AND dept.sku NOT IN
          (
            SELECT a.sku FROM ya_adult_product a
          )
          AND p.release_date < (TO_DATE(SYSDATE) + ( 1 * iPpast_days * - 1 ) );
      END;
    END IF;
  RETURN;
  END GetBackToStockProductList;

  PROCEDURE GetArtistCampaignProductList (
    iPdept_id   IN  INT,
    iPartist_id   IN  INT,
    iPcampaign_code IN  INT,
    curPgetArtist1  OUT refcur,
    curPgetArtist2  OUT refcur
  )
  AS
    nLtemp  INT;
  BEGIN
    OPEN curPgetArtist1 FOR
    SELECT
      pd.sku
    FROM
      ya_campaign c,
      ya_prod_dept pd,
      ya_product_artist pa
    WHERE
      c.sku = pd.sku
      AND c.sku = pa.sku
      AND (c.campaign_code  = iPcampaign_code
      AND pd.dept_id  = iPdept_id
      AND pa.artist_id  = iPartist_id);

    BEGIN

    SELECT 1 INTO nLtemp FROM DUAL WHERE EXISTS
      (SELECT 1
       FROM
        ya_dept_attr
       WHERE
        dept_id = iPdept_id
        AND attribute_id = 125   /* video attribute */
      );

    EXCEPTION WHEN no_data_found THEN
      nLtemp := 0;
    END;



    IF(nLtemp != 0 ) THEN
      BEGIN
        OPEN curPgetArtist2 FOR
        SELECT
        c.sku,
        c.related_sku
        FROM
          ya_cross_selling_type3 c,
          ya_prod_dept pd,
          ya_campaign m,
          ya_product_artist pa
        WHERE
          c.sku = pd.sku
          AND (pd.sku = m.sku)
          AND (c.sku = pa.sku)
          AND ( 1=1 --c.type_id = 3
          AND pd.dept_id = iPdept_id
          AND m.campaign_code  = iPcampaign_code
          AND pa.artist_id  = iPartist_id);
      END;
    ELSE
      BEGIN
        OPEN curPgetArtist2 FOR
        SELECT 1 FROM dual WHERE 1=0;
      END;
    END IF;
  RETURN;
  END GetArtistCampaignProductList;

  PROCEDURE GetProductByAttribute (
    iPdept_id   IN  INT,
    iPattribute_id  IN  INT,
    curPgetProduct  OUT refcur
  )
  AS
    iLtemp    INT;
  BEGIN
    /* adult attribute */
    BEGIN
      SELECT 1 INTO iLtemp
      FROM ya_dept_attr
      WHERE dept_id = iPdept_id
      AND attribute_id IN (84, 79982)
      AND ROWNUM = 1;

      EXCEPTION WHEN NO_DATA_FOUND THEN
      SELECT 0 INTO iLtemp FROM DUAL;
    END;

    IF iLtemp = 1 THEN
      BEGIN
        OPEN curPgetProduct FOR
        SELECT pd.sku
        FROM ya_prod_dept pd, ya_prod_attr pa
        WHERE pd.sku = pa.sku
        AND pd.dept_id = iPdept_id
        AND pa.attribute_id = iPattribute_id;
      END;
    ELSE
      BEGIN
        OPEN curPgetProduct FOR
        SELECT pd.sku
        FROM ya_prod_dept pd, ya_prod_attr pa
        WHERE pd.sku = pa.sku
        AND pd.dept_id = iPdept_id
        AND pa.attribute_id = iPattribute_id
        AND pd.sku NOT IN (
          SELECT sku
          FROM ya_adult_product
          );
      END;
    END IF;
  return;
  END GetProductByAttribute;

  PROCEDURE GetProductList (
    iPdept_id   IN  INT,
    iPtype_id   IN  INT,
    curPgetproduct1 OUT refcur,
    curPgetproduct2 OUT refcur
  )
  AS
    iLtemp    INT;
    iLCount   INT;
  BEGIN
    IF iPtype_id = 2 THEN
      BEGIN
        OPEN curPgetproduct1 FOR
        SELECT r.sku
        FROM
        (
          SELECT pl.sku
          FROM
            ya_product_list pl,
            ya_prod_dept pd
          WHERE
            pl.sku = pd.sku
            AND pl.type_id = iPtype_id
            AND pd.dept_id = iPdept_id
            AND pl.priority > 0
          ORDER BY
            pl.priority, pl.create_datetime DESC, pl.sku DESC
        ) r
        WHERE
          ROWNUM <= 100;
      END;
    ELSE
      BEGIN
        OPEN curPgetproduct1 FOR
          SELECT pl.sku
          FROM
            ya_product_list pl,
            ya_prod_dept pd
          WHERE
            pl.sku = pd.sku
            AND pl.type_id = iPtype_id
            AND pd.dept_id = iPdept_id
            AND pl.priority > 0
          ORDER BY
            pl.priority, pl.create_datetime DESC, pl.sku DESC;
      END;
    END IF;

    /* video attribute */
    BEGIN
    SELECT 1 INTO iLtemp
    FROM ya_dept_attr
    WHERE dept_id = iPdept_id
    AND attribute_id = 125;
    EXCEPTION WHEN no_data_found THEN
      iLtemp := 0;
    END;

    IF iLtemp = 1 THEN
      BEGIN
        IF iPtype_id = 2 THEN
          BEGIN
            OPEN curPgetproduct2 FOR
            SELECT c.sku, c.related_sku
            FROM ya_cross_selling_type3 c,
                 ya_product_list pl,
                 ya_prod_dept pd
            WHERE c.sku = pl.sku
              AND c.sku = pd.sku
              --AND c.type_id = 3
              AND pl.priority > 0
              AND pl.type_id = iPtype_id
              AND pd.dept_id = iPdept_id
              AND ROWNUM <=100;
          END;
        ELSE
          BEGIN
            OPEN curPgetproduct2 FOR
            SELECT c.sku, c.related_sku
            FROM ya_cross_selling_type3 c,
                 ya_product_list pl,
                 ya_prod_dept pd
            WHERE c.sku = pl.sku
            AND c.sku = pd.sku
            --AND c.type_id = 3
            AND pl.priority > 0
            AND pl.type_id = iPtype_id
            AND pd.dept_id = iPdept_id;
          END;
        END IF;
      END;
    ELSE
      BEGIN
        open curPgetproduct2 FOR
        SELECT 1 FROM dual WHERE 1 = 0;
      END;
    END IF;

  RETURN;
  END GetProductList;

  PROCEDURE GetProductGroupByInitial (
    cPinitial   IN  CHAR,
    iPdept_id   IN  INT,
    curPgetProduct  OUT refcur
  )
  AS
  BEGIN
    IF cPinitial = '#' THEN
      BEGIN
        OPEN curPgetProduct FOR
        SELECT pd.sku
        FROM
          ya_prod_dept pd,
          ya_product p,
          ya_prod_lang pl
        WHERE pd.sku = p.sku
        AND p.sku = pl.sku
        AND pl.lang_id = 1
        AND p.is_parent = 'Y'
        AND pd.dept_id = iPdept_id
        AND REGEXP_LIKE (SUBSTR(prod_name_u, 0, 1) ,'[0-9]')
        ORDER BY UPPER(prod_name), pd.sku;
      END;
    ELSE
      IF cPinitial = '*' THEN
        BEGIN
          OPEN curPgetProduct FOR
          SELECT pd.sku
          FROM
            ya_prod_dept pd,
            ya_product p,
            ya_prod_lang pl
          WHERE pd.sku = p.sku
          AND p.sku = pl.sku
          AND pl.lang_id = 1
          AND p.is_parent = 'Y'
          AND pd.dept_id = iPdept_id
          AND REGEXP_LIKE (SUBSTR(prod_name_u, 0, 1) ,'[0-9A-Z]', 'i')
          ORDER BY UPPER(prod_name), pd.sku;
        END;
      ELSE
        BEGIN
          OPEN curPgetProduct FOR
          SELECT pd.sku
          FROM
            ya_prod_dept pd,
            ya_product p,
            ya_prod_lang pl
          WHERE pd.sku = p.sku
          AND p.sku = pl.sku
          AND pl.lang_id = 1
          AND p.is_parent = 'Y'
          AND pd.dept_id = iPdept_id
          AND UPPER(SUBSTR(prod_name_u, 0, 1)) LIKE UPPER(cPinitial)
          ORDER BY UPPER(prod_name), pd.sku;
        END;
      END IF;
    END IF;

  RETURN;
  END GetProductGroupByInitial;

  PROCEDURE GetPreOrderDeadlineProdList (
    iPdept_id   IN  INT,
    curPgetPre1   OUT refcur,
    curPgetPre2   OUT refcur
  )
  AS
    iLtemp    INT;
  BEGIN
    IF iPdept_id = 160 THEN
    /* japan videos */
      BEGIN
        OPEN curPgetPre1 FOR
        SELECT p.sku
        FROM ya_prod_dept pd,
             ya_product p,
             ya_adult_product ap
        WHERE p.sku = pd.sku
        AND p.sku = ap.sku (+)
        AND pd.dept_id  = iPdept_id
        AND ap.sku is null
        AND p.is_parent = 'N'
        AND p.preorder_deadline >= SYSDATE
        AND p.cover_img_loc IS NOT NULL;
      END;
    ELSE
      BEGIN
        OPEN curPgetPre1 FOR
          SELECT
            p.sku,
            pr.cansell as us_cansell,
            pr.enable as us_enabled,
            pr1.cansell as tw_cansell,
            pr1.enable as tw_enabled
          FROM  ya_prod_dept pd,
                ya_product p,
                ya_adult_product ap,
				productregion pr,
				productregion pr1
          WHERE p.sku = pd.sku
		  AND p.sku=pr.productId
		  AND pr.regionId=1
		  AND p.sku=pr1.productId
		  AND pr1.regionId=7
          AND p.sku = ap.sku (+)
          AND pd.dept_id = iPdept_id
          AND ap.sku is null
          AND p.is_parent = 'N'
          AND p.preorder_deadline >= SYSDATE;
        END;
      END IF;

    BEGIN
      SELECT 1 INTO iLtemp
      FROM  ya_dept_attr
      WHERE dept_id = iPdept_id
      AND attribute_id = 125;

      EXCEPTION WHEN NO_DATA_FOUND THEN
        SELECT 0 INTO iLtemp FROM DUAL;
    END;

    IF(iLtemp != 0 ) THEN
      /* video attribute */
      BEGIN
        OPEN curPgetPre2 FOR
        SELECT
          c.sku,
          c.related_sku
        FROM
          ya_cross_selling_type3 c,
          ya_prod_dept pd
        WHERE
          c.sku = pd.sku
          --AND c.type_id = 3
          AND pd.dept_id = iPdept_id;
      END;
      ELSE
        BEGIN
          OPEN curPgetPre2 FOR
            SELECT 1 FROM dual WHERE 1 = 0;
        END;
    END IF;

  RETURN;
  END GetPreOrderDeadlineProdList;

  PROCEDURE GetReviewProductList (
    curPgetReview   OUT refcur,
    iPdept_id     IN  INT,
    cPtype      IN  VARCHAR2,
    iPnum_of_review   IN  INT DEFAULT 20
  )
  AS
  BEGIN
    IF iPdept_id = 0 THEN
      BEGIN
        OPEN curPgetReview FOR
          SELECT *
          FROM
          (
            SELECT
              p.sku,
              p.release_date,
              pr.cansell as us_cansell,
              pr.enable as us_enabled,
              pr1.cansell as tw_cansell,
              pr1.enable as tw_enabled
            FROM
              ya_product p
			  INNER JOIN productregion pr ON
			    p.sku=pr.productId
				AND pr.regionId=1
			  INNER JOIN productregion pr1 ON
                p.sku=pr1.productId
				AND pr1.regionId=7
              INNER JOIN ya_prod_dept pd ON
                p.sku = pd.sku
              INNER JOIN ya_product_rating pr ON
                p.sku = pr.sku
              INNER JOIN ya_prod_rating_lang prl ON
                pr.rating_id = prl.rating_id
              INNER JOIN ya_review r ON
                r.review_id = prl.us_review_id
            WHERE
              pd.dept_id = iPdept_id
              AND pr.reviewer_type = cPtype
              AND pr.review_approved = 'Y'
            ORDER BY date_posted DESC NULLS LAST, p.sku DESC
          ) r
          WHERE
            ROWNUM <=
              CASE
                WHEN iPnum_of_review = 0 THEN (ROWNUM + 1)
                ELSE iPnum_of_review
              END;
      END;
    END IF;
  RETURN;
  END GetReviewProductList;

  PROCEDURE GetDepartmentProductList (
    iPdept_id   IN  INT,
    curPgetProduct1 OUT refcur,
    curPgetProduct2 OUT refcur
  )
  AS
    iLtemp1		INT;
    iLtemp2		INT;
  BEGIN
    BEGIN
      SELECT 1 INTO iLtemp1
      FROM ya_dept_attr
      WHERE dept_id = iPdept_id
      AND attribute_id IN (84, 79982)
      AND ROWNUM = 1;

      EXCEPTION WHEN NO_DATA_FOUND THEN
      SELECT 0 INTO iLtemp1 FROM DUAL;
    END;

    /* adult attribute */
    IF iLtemp1 = 1 THEN
      BEGIN
        OPEN curPgetProduct1 FOR
        SELECT pd.sku
        FROM ya_prod_dept pd
        WHERE pd.dept_id = iPdept_id
         AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      END;
    ELSE
      BEGIN
        OPEN curPgetProduct1 FOR
        SELECT pd.sku
        FROM ya_prod_dept pd,
             ya_adult_product yap
        WHERE pd.sku = yap.sku (+)
        AND pd.dept_id = iPdept_id
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude)
        AND yap.sku IS NULL;
      END;
    END IF;

    BEGIN
      SELECT 1 INTO iLtemp2
      FROM ya_dept_attr
      WHERE dept_id = iPdept_id
      AND attribute_id = 125;
      EXCEPTION WHEN NO_DATA_FOUND THEN
      SELECT 0 INTO iLtemp2 FROM DUAL;
    END;

    /* video attribute */
    IF iLtemp2 = 1 THEN
      BEGIN
        OPEN curPgetProduct2 FOR
        SELECT c.sku, c.related_sku
        FROM
          ya_cross_selling_type3 c,
          ya_prod_dept pd
        WHERE c.sku = pd.sku
        --AND c.type_id = 3
        AND pd.dept_id = iPdept_id
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      END;
    END IF;

  RETURN;
  END GetDepartmentProductList;

  PROCEDURE GetCampaignProductList (
    iPdept_id   IN  INT,
    iPcampaign_code IN  INT,
    curPgetCamp1  OUT refcur,
    curPgetCamp2  OUT refcur
  )
  AS
    iLcount INT;
  BEGIN
    OPEN curPgetCamp1 FOR
    SELECT pd.sku
    FROM ya_campaign c,
         ya_prod_dept pd
    WHERE
      c.sku = pd.sku
      AND (c.campaign_code = iPcampaign_code
      AND pd.dept_id = iPdept_id);

    BEGIN
      SELECT dept_id INTO iLCount
      FROM ya_dept_attr
      WHERE
        dept_id = iPdept_id
        AND attribute_id = 125
        AND ROWNUM = 1;

      EXCEPTION WHEN no_data_found THEN
        SELECT 0 INTO iLCount FROM DUAL;
    END;

    IF iLcount !=0 THEN
      BEGIN

      OPEN curPgetCamp2 FOR
      SELECT c.sku, c.related_sku
      FROM
        ya_cross_selling_type3 c,
        ya_campaign m,
        ya_prod_dept pd
      WHERE
        c.sku = m.sku
        AND (c.sku = pd.sku)
        AND (1=1 -- c.type_id = 3
        AND pd.dept_id = iPdept_id
        AND m.campaign_code = iPcampaign_code);
      END;
      ELSE
        BEGIN
          OPEN curPgetCamp2 FOR
          SELECT 1 FROM dual WHERE 1 = 0;
        END;
    END IF;
  RETURN;
  END GetCampaignProductList;

  PROCEDURE GetPreOrderProductList (
    curPgetPre1   OUT refcur,
    curPgetPre2   OUT refcur,
    iPdept_id   IN  INT,
    iPcampaign_code IN  INT DEFAULT -1
  )
  AS
    iLadult   INT;
    iLtemp1   INT;
    iLtemp2   INT;
    iLtemp3   INT;
    iLtemp4   INT;
  BEGIN

    IF(iPcampaign_code = -1) THEN
      BEGIN

        BEGIN
          SELECT 1 INTO iLtemp1
          FROM ya_dept_attr
          WHERE dept_id = iPdept_id
          AND attribute_id = 84
          AND ROWNUM = 1;

          EXCEPTION WHEN NO_DATA_FOUND THEN
          SELECT 0 INTO iLtemp1 FROM DUAL;
        END;

        IF(iLtemp1 != 0 ) THEN
          BEGIN
            SELECT 1 INTO iLadult FROM DUAL;
          END;
        ELSE
          BEGIN
            SELECT 0 INTO iLadult FROM DUAL;
          END;
        END IF;

        IF iPdept_id = 7153 THEN
          BEGIN
          OPEN curPgetPre1 FOR
             SELECT
                p.sku,
                pr.preorder as us_preorder,
                pr.preorderstart as us_preorder_start,
                pr.preorderend as us_preorder_end,
                pr1.preorder as tw_preorder,
                pr1.preorderstart as tw_preorder_start,
                pr1.preorderend as tw_preorder_end,
                SYSDATE,
                p.release_date
              FROM
                ya_prod_dept pd,
                ya_product p,
				productregion pr,
                productregion pr1
              WHERE p.sku = pd.sku
                AND p.sku=pr.productId
                AND pr.regionId=1
                AND p.sku=pr1.productId
                AND pr1.regionId=7
                AND (pd.dept_id = iPdept_id
                AND pr.enable = 'Y'
                AND p.is_parent = 'N'
                AND (TO_DATE(p.preorder_deadline) + ( 1 * - 1 ) )  >= (SYSDATE))
              ORDER BY
                pr.displaypriority DESC,
                p.preorder_deadline,
                p.release_date;
      END;
    ELSE
      BEGIN
        IF iPdept_id = 4407 THEN
          BEGIN
            OPEN curPgetPre1 FOR
            SELECT
              po.sku,
              pr.preorder as us_preorder,
              pr.preorderstart as us_preorder_start,
              pr.preorderend as us_preorder_end,
              pr1.preorder as tw_preorder,
              pr1.preorderstart as tw_preorder_start,
              pr1.preorderend as tw_preorder_end,
              (SYSDATE),
              p.release_date
            FROM
              ya_preorder po,
              ya_product p,
			  productregion pr,
              productregion pr1
            WHERE
              po.sku = p.sku
			  AND p.sku=pr.productId
              AND pr.regionId=1
              AND p.sku=pr1.productId
              AND pr1.regionId=7
              AND dept_id = 4407
              AND site_id = 1
            ORDER BY
              po.priority;
          END;
        ELSE
          BEGIN
            OPEN curPgetPre1 FOR
              SELECT
                pd.sku,
                pr.preorder as us_preorder,
                pr.preorderstart as us_preorder_start,
                pr.preorderend as us_preorder_end,
                pr1.preorder as tw_preorder,
                pr1.preorderstart as tw_preorder_start,
                pr1.preorderend as tw_preorder_end,
                SYSDATE,
                p.release_date
              FROM
                ya_preorder_list l,
                ya_prod_dept pd,
                ya_product p,
                ya_adult_product pa,
				productregion pr,
                productregion pr1
                /* ya_adult_product pa */
              WHERE
                pd.sku = l.sku
				AND p.sku=pr.productId
                AND pr.regionId=1
                AND p.sku=pr1.productId
                AND pr1.regionId=7
                AND pd.sku = p.sku
                AND pd.sku = pa.sku (+)
                AND pd.dept_id  = iPdept_id
                AND p.release_date >= SYSDATE
                AND
                  CASE WHEN iLadult = 0 THEN pa.sku
                  ELSE NULL
                  END IS NULL
                AND ((pr.preorder  = 'Y'
                AND pr.preorderstart <= SYSDATE
                AND pr.preorderend >= SYSDATE)
                OR (pr1.preorder = 'Y'
                AND pr1.preorderstart <= SYSDATE
                AND pr1.preorderend >= SYSDATE));

              BEGIN
                SELECT 1 INTO iLtemp2
                FROM ya_dept_attr
                WHERE dept_id = iPdept_id
                AND attribute_id = 125;

                EXCEPTION WHEN NO_DATA_FOUND THEN
                SELECT 0 INTO iLtemp2 FROM DUAL;
              END;

            IF(iLtemp2 != 0 ) THEN
            /* video attribute */
              BEGIN
                OPEN curPgetPre2 FOR
                SELECT
                  c.sku,
                  c.related_sku
                FROM
                  ya_cross_selling_type3 c,
                  ya_prod_dept pd
                WHERE
                  c.sku = pd.sku
                  --AND c.type_id  = 3
                  AND pd.dept_id = iPdept_id;
              END;
              ELSE
                BEGIN
                  OPEN curPgetPre2 FOR
                  SELECT 1 FROM dual WHERE 1=0;
                END;
            END IF;
          END;
        END IF;
      END;
    END IF;
    END;
    ELSE
      BEGIN
        BEGIN
          SELECT 1 INTO iLtemp3
          FROM ya_dept_attr
          WHERE dept_id = iPdept_id
          AND attribute_id = 84
          AND ROWNUM = 1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
          SELECT 0 INTO iLtemp3 FROM DUAL;
        END;

        IF(iLtemp3 != 0 ) THEN
          BEGIN
            SELECT 1 INTO iLadult FROM DUAL;
          END;
        ELSE
          BEGIN
            SELECT 0 INTO iLadult FROM DUAL;
          END;
        END IF;

        IF iPdept_id = 7153 THEN
          BEGIN
          OPEN curPgetPre1 FOR
          SELECT
            p.sku,
            pr.preorder as us_preorder,
            pr.preorderstart as us_preorder_start,
            pr.preorderend as us_preorder_end,
            pr1.preorder as tw_preorder,
            pr1.preorderstart as tw_preorder_start,
            pr1.preorderend as tw_preorder_end,
            SYSDATE,
            p.release_date
          FROM
            ya_prod_dept pd,
            ya_product p,
            ya_campaign c,
			productregion pr,
            productregion pr1
          WHERE
            p.sku = pd.sku
			AND p.sku=pr.productId
            AND pr.regionId=1
            AND p.sku=pr1.productId
            AND pr1.regionId=7
            AND c.sku = p.sku
            AND c.campaign_code = iPcampaign_code
            AND pd.dept_id = iPdept_id
            AND pr.enable = 'Y'
            AND p.is_parent = 'N'
            AND (TO_DATE(p.preorder_deadline) + ( 1 * - 1 ) )  >= SYSDATE
          ORDER BY
            pr.displaypriority DESC,
            p.preorder_deadline,
            p.release_date;
          END;
      ELSE
      BEGIN
        IF iPdept_id = 4407 THEN
          BEGIN
            OPEN curPgetPre1 FOR
            SELECT
              po.sku,
              pr.preorder as us_preorder,
              pr.preorderstart as us_preorder_start,
              pr.preorderend as us_preorder_end,
              pr1.preorder as tw_preorder,
              pr1.preorderstart as tw_preorder_start,
              pr1.preorderend as tw_preorder_end,
              SYSDATE,
              p.release_date
            FROM
              ya_preorder po,
              ya_product p,
              ya_campaign c,
			  productregion pr,
              productregion pr1
            WHERE
              po.sku = p.sku
			  AND p.sku=pr.productId
              AND pr.regionId=1
              AND p.sku=pr1.productId
              AND pr1.regionId=7
              AND c.sku = p.sku
              AND c.campaign_code = iPcampaign_code
              AND dept_id = 4407
              AND site_id = 1
            ORDER BY
              po.priority;
          END;
        ELSE
          BEGIN
            OPEN curPgetPre1 FOR
            SELECT
              pd.sku,
              pr.preorder as us_preorder,
              pr.preorderstart as us_preorder_start,
              pr.preorderend as us_preorder_end,
              pr1.preorder as tw_preorder,
              pr1.preorderstart as tw_preorder_start,
              pr1.preorderend as tw_preorder_end,
              SYSDATE,
              p.release_date
            FROM
              ya_preorder_list l,
              ya_prod_dept pd,
              ya_product p,
              ya_campaign c,
              ya_adult_product pa,
			  productregion pr,
              productregion pr1
            WHERE
              pd.sku = l.sku
			  AND p.sku=pr.productId
              AND pr.regionId=1
              AND p.sku=pr1.productId
              AND pr1.regionId=7
              AND pd.sku = p.sku
              AND c.sku = p.sku
              AND c.campaign_code = iPcampaign_code
              AND pd.sku = pa.sku (+)
              AND pd.dept_id = iPdept_id
              AND p.release_date >= SYSDATE
              AND
                CASE WHEN iLadult = 0 THEN pa.sku
                ELSE NULL
                END IS NULL
              AND ((pr.preorder = 'Y'
              AND pr.preorderstart <= SYSDATE
              AND pr.preorderend >= SYSDATE)
              OR (pr1.preorder = 'Y'
              AND pr1.preorderstart <= SYSDATE
              AND pr1.preorderend >= SYSDATE));

            BEGIN
              SELECT 1 INTO iLtemp4
              FROM ya_dept_attr
              WHERE dept_id = iPdept_id
              AND attribute_id = 125;
              EXCEPTION WHEN NO_DATA_FOUND THEN
              SELECT 0 INTO iLtemp4 FROM DUAL;
            END;

            IF(iLtemp4 != 0 ) THEN
            /* video attribute */
              BEGIN
              OPEN curPgetPre2 FOR
                SELECT
                  c.sku,
                  c.related_sku
                FROM
                  ya_cross_selling_type3 c,
                  ya_prod_dept pd
                WHERE
                  c.sku = pd.sku
                  --AND c.type_id = 3
                  AND pd.dept_id = iPdept_id;
              END;
              ELSE
                BEGIN
                  OPEN curPgetPre2 FOR
                  SELECT 1 FROM dual WHERE 1=0;
                END;
            END IF;
          END;
        END IF;
      END;
    END IF;
    END;
  END IF;
  RETURN;
  END GetPreOrderProductList;

  PROCEDURE GetProductByReleaseDate (
    iPdept_id   IN  INT,
    dtPstart_date IN  DATE,
    dtPend_date   IN  DATE,
    iPsite_id   IN  INT,
    curPgetProduct  OUT refcur
  )
  AS
  BEGIN
    IF TO_NUMBER(TO_CHAR(dtPstart_date, 'MM')) = TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) THEN
      BEGIN

          OPEN curPgetProduct FOR
          SELECT *
          FROM
          (
			SELECT /*+ USE_NL(pd p pa) */
              pd.sku
            FROM
              ya_prod_dept pd,
              ya_product p,
              productAvailability pa,
			  productregion pr
            WHERE
              1 = 1
              AND pd.sku = p.sku
              AND pd.sku = pa.productid
			  AND pd.sku=pr.productid
			  AND pr.regionId=iPsite_id
              AND pa.regionid = iPsite_id
              AND pd.dept_id = iPdept_id
              AND p.release_date >= dtPstart_date
              AND p.release_date < dtPend_date
              AND p.release_date < SYSDATE
              AND pr.preorder = 'N'
              AND pa.availability < 60
            ORDER BY p.release_date DESC, p.sku DESC
          )
          WHERE
            ROWNUM <= 100;
      END;
    ELSE
        BEGIN
          OPEN curPgetProduct FOR
          SELECT *
          FROM
          (
			SELECT /*+ USE_NL(pd p pa) */
              pd.sku
            FROM
              ya_prod_dept pd,
              ya_product p,
              productAvailability pa,
			  productregion pr
            WHERE
              1 = 1
              AND pd.sku = p.sku
			  AND pd.sku=pr.productId
			  AND pr.regionId=iPsite_id
              AND pd.sku = pa.productid
              AND pa.regionId = iPsite_id
              AND pd.dept_id = iPdept_id
              AND p.release_date >= dtPstart_date
              AND p.release_date < dtPend_date
              AND p.release_date < SYSDATE
              AND pr.preorder = 'N'
              AND pa.availability < 60
            ORDER BY p.release_date DESC, p.sku DESC
          )
          WHERE
            ROWNUM <= 1000;

        END;
    END IF;

    RETURN;
  END GetProductByReleaseDate;

  PROCEDURE GetSKUByReleaseDateRange (
    iPdept_id   IN  INT,
    iPcampaign_code IN      INT,
    dtPstart_date   IN      DATE,
    dtPend_date     IN      DATE,
    curPgetSKU      OUT     refcur
  )
  AS
  BEGIN
    IF iPcampaign_code > 0 THEN
      BEGIN
        OPEN curPgetSKU FOR
          SELECT
            p.sku
          FROM
            ya_product p,
            ya_prod_dept pd,
            ya_campaign c
          WHERE
            p.sku  = pd.sku
            AND pd.dept_id = iPdept_id
            AND (p.sku  = c.sku)
            AND (release_date BETWEEN dtPstart_date AND dtPend_date
            AND c.campaign_code  = iPcampaign_code);
      END;
    ELSE
      BEGIN
        OPEN curPgetSKU FOR
          SELECT
            p.sku
          FROM
            ya_product p,
            ya_prod_dept pd
          WHERE
            p.sku = pd.sku
            AND pd.dept_id  = iPdept_id
            AND (release_date BETWEEN dtPstart_date AND dtPend_date);
      END;
    END IF;
    RETURN;
  END GetSKUByReleaseDateRange;

  PROCEDURE GetSupplierProductList (
    iPdept_id     IN  INT,
    iPsupplier_id   IN  INT,
    curPgetSupplier   OUT refcur
  )
  AS
  BEGIN
    OPEN curPgetSupplier FOR
    SELECT
      pd.sku,
      pr.supplierid as us_supplier_id,
      pr1.supplierid as tw_supplier_id
    FROM
      ya_prod_dept pd,
	  productregion pr,
	  productregion pr1
    WHERE
      pd.sku=pr.productId
	  AND pr.regionId=1
	  AND pd.sku=pr1.productId
	  AND pr1.regionId=7
      AND pd.dept_id = iPdept_id
      AND (pr.supplierid = iPsupplier_id
      OR  pr1.supplierid = iPsupplier_id);

    RETURN;
  END GetSupplierProductList;

  PROCEDURE GetPublisherGroupProductList (
    iPdept_id     IN  INT,
    iPpublisher_group_id  IN  INT,
    curPgetPublisher    OUT refcur
  )
  AS
  BEGIN
    OPEN curPgetPublisher FOR
    SELECT p.sku
    FROM
      ya_publisher_group_rel pg,
      ya_product p,
      ya_prod_dept pd
    WHERE pg.publisher_id = p.publisher_id
    AND p.sku = pd.sku
    AND pd.dept_id = iPdept_id
    AND pg.publisher_group_id = iPpublisher_group_id;
    RETURN;
  END GetPublisherGroupProductList;

  PROCEDURE GetArtistProductList (
    iPdept_id		IN 	INT,
    iPartist_id		IN	INT,
    curPgetArtist1	OUT	refcur,
    curPgetArtist2	OUT refcur
  )
  AS
    iLtemp		INT;
  BEGIN
    IF (iPdept_id <> -1) THEN
    BEGIN
      OPEN curPgetArtist1 FOR
      SELECT
        DISTINCT pa.sku
      FROM
        ya_product_artist pa,
        ya_prod_dept pd
      WHERE
        pa.sku = pd.sku
        AND (pa.artist_id = iPartist_id
        AND pd.dept_id = iPdept_id);

      BEGIN

      SELECT 1 INTO iLtemp FROM DUAL WHERE EXISTS
      (
      SELECT 1 FROM ya_dept_attr
      WHERE dept_id = iPdept_id
      AND attribute_id = 125
      );
      EXCEPTION WHEN no_data_found THEN
        iLtemp := 0;
      END;

      /* video attribute */
      IF(iLtemp != 0 ) THEN
        BEGIN
          OPEN curPgetArtist2 FOR
          SELECT c.sku, c.related_sku
          FROM ya_cross_selling_type3 c,
             ya_prod_dept pd
          WHERE c.sku  = pd.sku
          AND	(1=1 --c.type_id  = 3
          AND	pd.dept_id  = iPdept_id);
        END;
      ELSE
        BEGIN
          OPEN curPgetArtist2 FOR
          SELECT 1 FROM dual WHERE 1 = 0;
        END;
      END IF;
    END;
    ELSE
    BEGIN
      OPEN curPgetArtist1 FOR
      SELECT
        DISTINCT pa.sku
      FROM
        ya_product_artist pa
      WHERE
        pa.artist_id = iPartist_id;
    END;
    END IF;
  return;
  END GetArtistProductList;

  PROCEDURE GetGroupProductListByDept (
    iPdept_id		IN	INT,
    iPparent_sku	IN	INT,
    curPgetGroup	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetGroup FOR
    SELECT
      pr.sku
    FROM
      ya_prod_rel pr
      , ya_prod_dept pd
    WHERE
      pr.parent_sku = iPparent_sku
      AND pd.dept_id = iPdept_id
      AND pr.sku = pd.sku;
    RETURN;
  END GetGroupProductListByDept;

  PROCEDURE GetGroupProductList (
    iPparent_sku	IN	INT,
    curPgetGroup	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetGroup FOR
    SELECT sku
    FROM ya_prod_rel
    WHERE parent_sku = iPparent_sku;
    RETURN;
  END GetGroupProductList;

  PROCEDURE GetFrontpageProductList (
    iPpage_id		IN	INT,
    curPgetFront	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetFront FOR
    SELECT
      DISTINCT sku
    FROM
      ya_product_lot
    WHERE
      file_id = iPpage_id
      AND sku IS NOT NULL
      AND sku > 0;
    RETURN;
  END GetFrontpageProductList;

  PROCEDURE GetMirrorFrontpageProductList (
    iPpage_id		IN	INT,
    curPgetFront	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetFront FOR
    SELECT
      DISTINCT sku
    FROM
      ya_mirror_product_lot
    WHERE
      file_id = iPpage_id
      AND sku IS NOT NULL
      AND sku > 0;
    RETURN;
  END GetMirrorFrontpageProductList;

  PROCEDURE GetProductByAvailability (
    curPgetProduct	OUT	refcur,
    iPdept_id		IN	INT,
    iPavailability_id	IN	INT,
    iPcampaign_code	IN	INT DEFAULT -1
  )
  AS
  BEGIN
   IF (iPcampaign_code = -1) THEN
     BEGIN
       OPEN curPgetProduct FOR
       SELECT
         pd.sku,
         p1.availability,
         p2.availability
       FROM
         ya_prod_dept pd,
         (
         SELECT * FROM productavailability p1
         WHERE p1.category = 1
         AND p1.originid = 1
         AND p1.regionId = 1
         ) p1,
         (
         SELECT * FROM productavailability p2
         WHERE p2.category = 1
         AND p2.originid = 7
         AND p2.regionId = 7
         ) p2,
         ya_product p
       WHERE pd.sku = p1.productid
       AND pd.sku = p2.productid
       AND pd.sku = p.sku
       AND pd.dept_id = iPdept_id
       AND p.is_parent = 'N'
       AND (p1.availability = iPavailability_id
       OR  p2.availability = iPavailability_id);
     END;
   ELSE
     BEGIN
       OPEN curPgetProduct FOR
       SELECT
         pd.sku,
         p1.availability,
         p2.availability
       FROM
         ya_prod_dept pd,
         (
         SELECT * FROM productavailability p1
         WHERE p1.category = 1
         AND p1.originid = 1
         AND p1.regionId = 1
         ) p1,
         (
         SELECT * FROM productavailability p2
         WHERE p2.category = 1
         AND p2.originid = 7
         AND p2.regionId = 7
         ) p2,
         ya_product p,
         ya_campaign c
       WHERE pd.sku = p1.productid
       AND pd.sku = p2.productid
       AND pd.sku = p.sku
       AND c.sku = p.sku
       AND c.campaign_code = iPcampaign_code
       AND pd.dept_id = iPdept_id
       AND p.is_parent = 'N'
       AND (p1.availability = iPavailability_id
       OR  p2.availability = iPavailability_id);
     END;
   END IF;
  RETURN;
  END GetProductByAvailability;

  PROCEDURE GetBargainPoolProduct (
    iPline_id		IN 	INT,
    curPgetBargain	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetBargain FOR
    SELECT
      sku
    FROM
      ya_bargain_data
    WHERE
      status = 1
      AND product_line = iPline_id
    ORDER BY priority;
    RETURN;
  END GetBargainPoolProduct;

  PROCEDURE GetTopSellerProduct (
    iPdept_id			IN	INT,
    iPtype_id			IN	INT,
    iPsite_id			IN	INT,
    curPgetSales		OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetSales FOR
    SELECT
      pr.sku,
      pr.site_id
    FROM
      ya_product_ranking pr
    WHERE
      pr.dept_id = iPdept_id
      AND type_id = iPtype_id
      AND site_id = iPsite_id
      ORDER BY pr.rank;
  RETURN;
  END GetTopSellerProduct;

  PROCEDURE GetNRProdistByLaunchDate (
    iPdept_id		IN	INT,
    dtPstart_date	IN	DATE,
    dtPend_date		IN	DATE,
    curPgetNew1		OUT	refcur,
    curPgetNew2		OUT	refcur
  )
  AS
    iLadult		INT;
    iLtemp1		INT DEFAULT 0;
    iLtemp2		INT DEFAULT 0;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp1
    FROM ya_dept_attr
    WHERE
      dept_id = iPdept_id
      AND attribute_id = 84;

    IF iLtemp1 > 0 THEN
      /* enable adult products browsing */
      iLadult := 1;
    ELSE
      /* disable adult products browsing */
      iLadult := 0;
    END IF;

    IF TO_NUMBER(TO_CHAR(dtPstart_date, 'MM')) = TO_NUMBER(TO_CHAR((SYSDATE), 'MM'))
      AND TO_NUMBER(TO_CHAR(dtPstart_date, 'YYYY')) = TO_NUMBER(TO_CHAR((SYSDATE), 'YYYY')) THEN
      BEGIN
        OPEN curPgetNew1 FOR
        SELECT r.sku
        FROM
        (
          SELECT pd.sku
          FROM
            ya_prod_dept pd,
            ya_product p,
            ya_adult_product ap
          WHERE
            pd.sku = p.sku
            AND p.sku = ap.sku (+)
            AND pd.dept_id = iPdept_id
            AND p.release_date <= SYSDATE
            AND
              CASE WHEN iLadult = 0
                THEN ap.sku
              ELSE NULL
              END IS NULL
            AND p.us_launch_date BETWEEN dtPstart_date AND dtPend_date
          ORDER BY p.us_launch_date DESC
        ) r
        WHERE
          ROWNUM < 201;
       END;
     ELSE
       BEGIN
         OPEN curPgetNew1 FOR
         SELECT pd.sku
         FROM
           ya_prod_dept pd,
           ya_product p,
           ya_adult_product ap
         WHERE
           pd.sku = p.sku
           AND p.sku = ap.sku (+)
           AND pd.dept_id = iPdept_id
           AND p.us_launch_date BETWEEN dtPstart_date AND dtPend_date
           AND p.release_date <= SYSDATE
           AND
             CASE WHEN iLadult = 0
              THEN ap.sku
             ELSE NULL
             END IS NULL;
       END;
     END IF;

     SELECT COUNT(1)
     INTO iLtemp2
     FROM ya_dept_attr
     WHERE dept_id = iPdept_id
     AND attribute_id = 125;

     IF iLtemp2 > 0 THEN
       BEGIN
         OPEN curPgetNew2 FOR
           SELECT
              c.sku, c.related_sku
           FROM
             ya_cross_selling_type3 c,
             ya_prod_dept pd,
             ya_product p
           WHERE
             c.sku = pd.sku
             AND c.sku = p.sku
             --AND c.type_id = 3
             AND pd.dept_id = iPdept_id
             AND p.release_date BETWEEN dtPstart_date AND dtPend_date;
       END;
     END IF;
   RETURN;
  END GetNRProdistByLaunchDate;

  PROCEDURE GetNRProdListBySupplierID (
    iPdept_id	 	IN	INT,
    dtPstart_date	IN	DATE,
    dtPend_date		IN	DATE,
    iPsite_id		IN	INT,
    iPsupplier_id	IN	INT,
    curPgetNew		OUT	refcur
  )
  AS
  BEGIN
      OPEN curPgetNew FOR
        SELECT *
        FROM
        (
          SELECT p.sku
          FROM ya_prod_sort_order ro,
               ya_product p,
               ya_prod_dept pd,
			   productregion pr
          WHERE p.sku = ro.sku
          AND p.sku = pd.sku
		  AND p.sku=pr.productId
		  AND pr.regionId=iPsite_id
          AND pd.dept_id = iPdept_id
          AND ro.list_id = 1
          AND ro.site_id = iPsite_id
          AND pr.supplierid = iPsupplier_id
          AND p.release_date BETWEEN dtPstart_date AND dtPend_date
          ORDER BY ro.priority
        )
        WHERE
          ROWNUM <=100;
     RETURN;
  END GetNRProdListBySupplierID;

  PROCEDURE GetAwardProductList (
    cPaward_name	IN 	VARCHAR2,
    curPgetAward	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetAward FOR
    SELECT
      a.sku
    FROM
      ya_awards a
    WHERE
      a.award_name = cPaward_name
    ORDER BY
      award_year DESC, award_category;
    RETURN;
  END GetAwardProductList;

  PROCEDURE GetClearanceProduct (
    iPsite_id		IN 	INT,
    iPcategory_id	IN	INT,
    iPdept_id		IN	INT,
    curPgetClear	OUT	refcur
  )
  AS
    curLtemp refcur;
    iLcount	INT;
  BEGIN

    OPEN curLtemp FOR
    SELECT *
    FROM
      ya_dept_attr
    WHERE
      dept_id = iPdept_id
      AND attribute_id = 84;

    iLcount := curLtemp%ROWCOUNT;

    IF iLcount !=0 THEN
      BEGIN
        OPEN curPgetClear FOR
        SELECT
          c.sku
        FROM
          ya_clearance c,
          ya_prod_dept d,
          ya_prod_score s
        WHERE
          c.sku = d.sku
          AND (c.sku  = s.sku
          AND s.siteid  = iPsite_id)
          AND (c.site_id  = iPsite_id
          AND c.category  = iPcategory_id
          AND d.dept_id  = iPdept_id)
        ORDER BY
          s.rank DESC;
      END;
    ELSE
      BEGIN
        OPEN curPgetClear FOR
        SELECT
          c.sku
        FROM
          ya_clearance c,
          ya_prod_dept d,
          ya_prod_score s
        WHERE
          c.sku = d.sku
          AND
          (
            c.sku = s.sku
            AND s.siteid = iPsite_id
          )
          AND
          (
            c.site_id = iPsite_id
            AND c.category = iPcategory_id
            AND d.dept_id = iPdept_id
            AND c.sku NOT IN
            (
              SELECT sku
              FROM ya_adult_product
            )
          )
        ORDER BY s.rank DESC;
      END;
    END IF;
  END GetClearanceProduct;

  PROCEDURE GetClearanceGroup (
    iPsite_id		IN 	INT,
    curPgetClear	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetClear FOR
      SELECT sku
      FROM ya_clearance_group
      WHERE site_id = iPsite_id
        AND enabled = 'Y';
  RETURN;
  END GetClearanceGroup;

  PROCEDURE GetAwardProdListByEventId (
    iPeventId IN INT,
    iPYear IN INT,
    iPSiteId IN INT  ,
    cPawardProdList OUT refcur
  )
  AS
  BEGIN
    OPEN cPawardProdList FOR
    SELECT DISTINCT
      pa.sku,
      ad.event_id
    FROM
      ya_award_definition ad
      , ya_product_award pa
      , ProductRegion bpr
    WHERE
      pa.award_definition_id = ad.award_definition_id
      AND
      (
        bpr.productId = pa.sku
        AND bpr.categoryId = 1
        AND bpr.regionId = iPsiteId-- must be equal to YAWeb's siteId
        AND bpr.originId = iPsiteId -- must be equal to YAWeb's siteId
        AND bpr.enable = 'Y'
      )
      AND ad.event_id = iPeventId
      AND ad.year = iPYear
      AND pa.priority = 1;
  RETURN;
  END GetAwardProdListByEventId;

  PROCEDURE GetAwardProdListByProdCat (
    iPrevAccGroupId IN INT,
    iPyear IN INT,
    iPsiteId IN INT,
    cPawardProdList OUT refcur
  )
  AS
  BEGIN
    OPEN cPawardProdList FOR
    SELECT DISTINCT
      pa.sku,
      rag.product_category_id --rev account GROUP id
    FROM
      ya_product_award pa
      , ya_award_definition ad
      , ProductRegion bpr
      , ya_rev_account_group rag
      , ya_product p
      WHERE
        (
          ad.award_definition_id = pa.award_definition_id
          AND ad.year = iPyear
        )
        AND (
          bpr.productId = pa.sku
          AND bpr.categoryId = 1
          AND bpr.regionId = iPsiteId -- must be equal to YAWeb's siteId
          AND bpr.originId = iPsiteId -- must be equal to YAWeb's siteId
          AND bpr.enable = 'Y'
        )
        AND (
          rag.product_category_id = iPrevAccGroupId
        )
        AND
        (
          p.sku = pa.sku
          AND p.account_id = rag.rev_account_id
        )
        AND pa.priority = 1;
  RETURN;
  END GetAwardProdListByProdCat;

  PROCEDURE GetAwardProdListByArtistId (
-- a specific CASE of proc_bo_getAwardProductByArtistId
    iPartistId IN INT,
    iPsiteId IN INT,
    cPawardProdList OUT refcur
  )
  AS
  BEGIN
    OPEN cPawardProdList FOR
    SELECT DISTINCT
      pa.sku,
      part.artist_id
    FROM
      ya_product_award pa
      , ya_product_artist part
      , ProductRegion bpr
    WHERE
      (
        part.artist_id = iPartistId
        AND part.sku = pa.sku
        AND part.rel_id IN (44, 47)
      )
      AND (
        bpr.productId = pa.sku
        AND bpr.categoryId = 1
        AND bpr.regionId = iPsiteId-- must be equal to YAWeb's siteId
        AND bpr.originId = iPsiteId -- must be equal to YAWeb's siteId
        AND bpr.enable = 'Y'
      )
      AND pa.priority = 1;
  RETURN;
  END GetAwardProdListByArtistId;

  PROCEDURE GetArtistProductByAvailability (
    iPartist_id		IN   	INT,
    iPdept_id		IN     	INT,
    iPavailability_id	IN     	INT,
    curPgetArtist	OUT refcur
  )
  AS
  BEGIN
    OPEN curPgetArtist FOR
    SELECT
      pd.sku,
      p1.availability,
      p2.availability
    FROM ya_prod_dept pd,
    	 productavailability p1,
    	 productavailability p2,
    	 ya_product p
    WHERE p1.category = 1
     AND p1.originid = 1
     AND pd.sku = p1.productid
     AND (p2.category  = 1
     AND p2.originid  = 7
     AND pd.sku = p2.productid)
     AND (pd.sku = p.sku)
     AND (pd.dept_id = iPdept_id
     AND p.is_parent = 'N'
     AND (p1.availability = iPavailability_id
     OR	p2.availability = iPavailability_id)
     AND pd.sku IN
    	(
     	SELECT pa.sku
    	FROM ya_product_artist pa
    	WHERE artist_id = iPartist_id
    	));
    return;
  END GetArtistProductByAvailability;



  PROCEDURE GetBgnCpnProdByPrice (
    iPbargain_attr IN INT,
    iPcampaign_code IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    IF iPbargain_attr=14 THEN
    --show music, karaoke AND MV IN cd bargain
      OPEN rcPresult FOR
      SELECT bp.sku
      FROM ya_campaign c
        INNER JOIN ya_bargain_product bp on c.sku = bp.sku
        INNER JOIN ya_prod_attr pa  on bp.sku = pa.sku
      WHERE c.campaign_code = iPcampaign_code
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
        AND pa.attribute_id IN (14,10)
        AND bp.site_id = iPsite_id
        AND bp.sku not IN (SELECT sku FROM ya_adult_product);
    ELSE
      OPEN rcPresult FOR
      SELECT bp.sku
      FROM
        ya_campaign c
        INNER JOIN ya_bargain_product bp ON
          c.sku = bp.sku
        INNER JOIN ya_prod_attr pa ON
          bp.sku = pa.sku
      WHERE
        c.campaign_code = iPcampaign_code
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
        AND pa.attribute_id = iPbargain_attr
        AND bp.site_id = iPsite_id
        AND bp.sku NOT IN
          (
            SELECT sku
            FROM ya_adult_product
          );
    END IF;
  END GetBgnCpnProdByPrice;



  PROCEDURE GetBgnDeptCpnProdByPrice (
    iPdept_id IN INT,
    iPcampaign_code IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  )
  AS
    iLtemp INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp
    FROM ya_dept_attr
    WHERE
      dept_id = iPdept_id
      AND attribute_id IN (84, 79982);

    IF iLtemp > 0 THEN
      OPEN rcPresult FOR
      SELECT bp.sku
      FROM
        ya_campaign c
        INNER JOIN ya_bargain_product bp ON
          c.sku = bp.sku
        INNER JOIN ya_prod_dept pd ON
          bp.sku = pd.sku
      WHERE
        c.campaign_code = iPcampaign_code
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
        AND pd.dept_id = iPdept_id
        AND bp.site_id = iPsite_id;
    ELSE
      OPEN rcPresult FOR
      SELECT bp.sku
      FROM
        ya_campaign c
        INNER JOIN ya_bargain_product bp ON
          c.sku = bp.sku
        INNER JOIN ya_prod_dept pd ON
          bp.sku = pd.sku
      WHERE
        c.campaign_code = iPcampaign_code
        AND bp.sale_start <= SYSDATE
        AND bp.sale_end >= SYSDATE
        AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
        AND pd.dept_id = iPdept_id
        AND bp.site_id = iPsite_id
        AND bp.sku NOT IN
          (
            SELECT ad.sku
            FROM ya_adult_product ad
          );
    END IF;
  END GetBgnDeptCpnProdByPrice;

  PROCEDURE GetArtPubCampaignProductList (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    iPcampaignCode IN INT,
    curPsku OUT refcur,
    curPcrossSell OUT refcur
  )
  AS
    iLtemp INT := 0;
  BEGIN
    IF (iPartistId > 0) THEN
      IF (iPpublisherId > 0) THEN
        OPEN curPsku FOR
        SELECT DISTINCT pd.sku
        FROM ya_campaign c
        INNER JOIN ya_product p ON c.sku = p.sku
        INNER JOIN ya_prod_dept pd ON c.sku = pd.sku
        INNER JOIN ya_product_artist pa ON c.sku = pa.sku
        WHERE c.campaign_code = iPcampaignCode
        AND p.publisher_id = iPpublisherId
        AND pd.dept_id = iPdeptId
        AND pa.artist_id = iPartistId
        AND p.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      ELSE
        OPEN curPsku FOR
        SELECT DISTINCT pd.sku
        FROM ya_campaign c
        INNER JOIN ya_prod_dept pd ON c.sku = pd.sku
        INNER JOIN ya_product_artist pa ON c.sku = pa.sku
        WHERE c.campaign_code = iPcampaignCode
        AND pd.dept_id = iPdeptId
        AND pa.artist_id = iPartistId
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      END IF;
    ELSE
      IF (iPpublisherId > 0) THEN
        OPEN curPsku FOR
        SELECT DISTINCT pd.sku
        FROM ya_campaign c
        INNER JOIN ya_product p ON c.sku = p.sku
        INNER JOIN ya_prod_dept pd ON c.sku = pd.sku
        WHERE c.campaign_code = iPcampaignCode
        AND p.publisher_id = iPpublisherId
        AND pd.dept_id = iPdeptId
        AND p.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      ELSE
        OPEN curPsku FOR
        SELECT DISTINCT pd.sku
        FROM ya_campaign c
        INNER JOIN ya_prod_dept pd ON c.sku = pd.sku
        WHERE c.campaign_code = iPcampaignCode
        AND pd.dept_id = iPdeptId
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      END IF;
    END IF;

    BEGIN
      SELECT 1 INTO iLtemp
      FROM
        ya_dept_attr
      WHERE
        dept_id = iPdeptId
        AND attribute_id = 125;

      EXCEPTION
        WHEN no_data_found THEN
          iLtemp := 0;
    END;

    IF iLtemp = 1 THEN-- video attribute
      OPEN curPcrossSell FOR
      SELECT c.sku, c.related_sku FROM ya_cross_selling_type3 c INNER JOIN
        ya_prod_dept pd ON c.sku = pd.sku
      INNER JOIN ya_campaign m on pd.sku = m.sku
      INNER JOIN ya_product_artist pa on c.sku = pa.sku
      WHERE 1=1
      --c.type_id = 3
      AND pd.dept_id = iPdeptId
      AND m.campaign_code = iPcampaignCode
      AND pa.artist_id = iPartistId
      AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
    END IF;
  END GetArtPubCampaignProductList;

  PROCEDURE GetPreOrderArtPubProdList (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    iPcampaignCode IN INT DEFAULT -1,
    curPsku OUT refcur,
    curPcrossSell OUT refcur
  )
  AS
    iLadultBit INT;
    iLtemp INT;
  BEGIN
    BEGIN
      SELECT 1 INTO iLadultBit
      FROM ya_dept_attr
      WHERE dept_id = iPdeptId
        AND attribute_id = 84
        AND ROWNUM = 1;

     EXCEPTION
       WHEN no_data_found THEN
         iLadultBit := 0;
    END;

    IF ( iPcampaignCode = -1) THEN
      IF iPartistId > 0 THEN
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND pr1.regionId=7
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      ELSE
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      END IF;
    ELSE
      IF iPartistId > 0 THEN
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      ELSE
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      END IF;
    END IF;

    BEGIN
      SELECT 1 INTO iLtemp
      FROM ya_dept_attr
      WHERE dept_id = iPdeptId
        AND attribute_id = 125;

     EXCEPTION
       WHEN no_data_found THEN
         iLtemp := 0;
    END;

    IF (iLtemp = 1) THEN-- video attribute
      OPEN curPcrosssell FOR
      SELECT c.sku, c.related_sku
        FROM ya_cross_selling_type3 c
       INNER JOIN ya_prod_dept pd
          on c.sku      = pd.sku
       WHERE 1=1 -- c.type_id  = 3
         AND pd.dept_id = iPdeptId;
    END IF;

  END GetPreOrderArtPubProdList;

  PROCEDURE GetPreOrderArtPubProductList (
    iPdeptId IN INT,
    iPartistId IN INT,
    iPpublisherId IN INT,
    iPcampaignCode IN INT DEFAULT -1,
    curPsku OUT refcur,
    curPcrossSell OUT refcur
  )
  AS
    iLadultBit INT;
    iLtemp INT;
  BEGIN
    BEGIN
      SELECT 1 INTO iLadultBit
      FROM ya_dept_attr
      WHERE dept_id = iPdeptId
        AND attribute_id = 84
        AND ROWNUM = 1;

     EXCEPTION
       WHEN no_data_found THEN
         iLadultBit := 0;
    END;

    IF ( iPcampaignCode = -1) THEN
      IF iPartistId > 0 THEN
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND pr1.regionId=7
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      ELSE
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      END IF;
    ELSE
      IF iPartistId > 0 THEN
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          INNER JOIN ya_product_artist par ON p.sku=par.sku AND par.artist_id = iPartistId
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      ELSE
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND p.publisher_id=iPpublisherId
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        ELSE
          OPEN curPsku FOR
          SELECT pd.sku, pr.preorder as us_preorder, pr.preorderstart as us_preorder_start, pr.preorderend as us_preorder_end, pr1.preorder as tw_preorder, pr1.preorderstart as tw_preorder_start, pr1.preorderend as tw_preorder_end, SYSDATE, p.release_date
          FROM ya_preorder_list l
          INNER JOIN ya_prod_dept pd on pd.sku = l.sku
          INNER JOIN ya_product p on pd.sku = p.sku
          INNER JOIN ya_campaign c on c.sku = p.sku AND c.campaign_code = iPcampaignCode
          LEFT OUTER JOIN ya_adult_product pa on pd.sku = pa.sku
		  INNER JOIN productregion pr on l.sku=pr.productId AND pr.regionId=1
		  INNER JOIN productregion pr1 on l.sku=pr1.productId AND  pr1.regionId=7
          WHERE pd.dept_id = iPdeptId
          AND p.release_date >= SYSDATE
          AND ((pr.preorder = 'Y' AND pr.preorderstart <= SYSDATE AND pr.preorderend >= SYSDATE)
          OR (pr1.preorder = 'Y' AND pr1.preorderstart <= SYSDATE AND pr1.preorderend >= SYSDATE))
          AND CASE WHEN iLadultBit = 0 THEN pa.sku ELSE NULL END is NULL;
        END IF;
      END IF;
    END IF;

    BEGIN
      SELECT 1 INTO iLtemp
      FROM ya_dept_attr
      WHERE dept_id = iPdeptId
        AND attribute_id = 125;

     EXCEPTION
       WHEN no_data_found THEN
         iLtemp := 0;
    END;

    IF (iLtemp = 1) THEN-- video attribute
      OPEN curPcrosssell FOR
      SELECT c.sku, c.related_sku
        FROM ya_cross_selling_type3 c
       INNER JOIN ya_prod_dept pd
          on c.sku      = pd.sku
       WHERE 1=1 -- c.type_id  = 3
         AND pd.dept_id = iPdeptId;
    END IF;

  END GetPreOrderArtPubProductList;


  PROCEDURE GetArtistPublisherProductList (
    iPdeptId		IN 	INT,
    iPartistId		IN	INT,
    iPpublisherId IN INT,
    curPsku	OUT	refcur,
    curPcrossSell	OUT refcur
  )
  AS
    iLtemp INT :=0;
  BEGIN
    IF (iPartistId > 0)  THEN
      IF (iPpublisherId > 0) THEN
        OPEN curPsku FOR
         SELECT DISTINCT pa.sku
         FROM ya_product_artist pa
         INNER JOIN ya_prod_dept pd ON pa.sku = pd.sku  AND pd.dept_id = iPdeptId
         INNER JOIN ya_product p ON pd.sku=p.sku AND p.publisher_id = iPpublisherId
         WHERE pa.artist_id = iPartistId
         AND pa.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
       ELSE
        OPEN curPsku FOR
         SELECT DISTINCT pa.sku
         FROM ya_product_artist pa
         INNER JOIN ya_prod_dept pd ON pa.sku = pd.sku AND pd.dept_id = iPdeptId
         WHERE pa.artist_id = iPartistId
         AND pa.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
       END IF;
    ELSE
      IF (iPpublisherId > 0) THEN
        OPEN curPsku FOR
        SELECT DISTINCT pd.sku
        FROM ya_prod_dept pd
        INNER JOIN ya_product p ON pd.sku=p.sku AND p.publisher_id = iPpublisherId
        WHERE pd.dept_id = iPdeptId
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      ELSE
        OPEN curPsku FOR
        SELECT DISTINCT pd.sku
        FROM ya_prod_dept pd
        WHERE pd.dept_id = iPdeptId
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
      END IF;
    END IF;

    BEGIN
      SELECT 1 INTO iLtemp
      FROM ya_dept_attr WHERE dept_id = iPdeptId AND attribute_id = 125;

      EXCEPTION
        WHEN no_data_found THEN
        iLtemp := 0;
    END;

    IF (iLtemp = 1)  THEN-- video attribute
      OPEN curPcrossSell FOR
      SELECT c.sku, c.related_sku
      FROM ya_cross_selling_type3 c
      INNER JOIN ya_prod_dept pd ON c.sku = pd.sku
      WHERE 1=1 --c.type_id = 3
      AND pd.dept_id = iPdeptId
      AND c.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude);
    END IF;
  END GetArtistPublisherProductList;

  PROCEDURE GetArtPubSKUByReleaseDateRange (
    iPdeptId   IN  INT,
    iPartistId IN INT,
    iPpublisherId IN INt,
    iPcampaignCode IN      INT,
    dtPstartDate   IN      DATE,
    dtPendDate     IN      DATE,
    curPsku      OUT     refcur
  )
  AS
  BEGIN
    IF iPcampaignCode > 0 THEN
      IF iPartistId > 0 THEN
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          INNER JOIN ya_product_artist pa ON p.sku=pa.sku AND pa.artist_id = iPartistId
          INNER JOIN ya_campaign c ON p.sku = c.sku AND c.campaign_code = iPcampaignCode
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate
          AND p.publisher_id=iPpublisherId;
        ELSE
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          INNER JOIN ya_product_artist pa ON p.sku=pa.sku AND pa.artist_id = iPartistId
          INNER JOIN ya_campaign c ON p.sku = c.sku AND c.campaign_code = iPcampaignCode
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate;
        END IF;
      ELSE
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          INNER JOIN ya_campaign c ON p.sku = c.sku AND c.campaign_code = iPcampaignCode
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate
          AND p.publisher_id=iPpublisherId;
        ELSE
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          INNER JOIN ya_campaign c ON p.sku = c.sku AND c.campaign_code = iPcampaignCode
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate;
        END IF;
      END IF;
    ELSE
      IF iPartistId > 0 THEN
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          INNER JOIN ya_product_artist pa ON p.sku=pa.sku AND pa.artist_id = iPartistId
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate
          AND p.publisher_id=iPpublisherId;
        ELSE
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          INNER JOIN ya_product_artist pa ON p.sku=pa.sku AND pa.artist_id = iPartistId
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate;
        END IF;
      ELSE
        IF iPpublisherId > 0 THEN
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate
          AND p.publisher_id=iPpublisherId;
        ELSE
          OPEN curPsku FOR
          SELECT p.sku
          FROM ya_product p
          INNER JOIN ya_prod_dept pd ON p.sku = pd.sku AND pd.dept_id = iPdeptId
          WHERE release_date BETWEEN dtPstartDate AND dtPendDate;
        END IF;
      END IF;
    END IF;
  END GetArtPubSKUByReleaseDateRange;

  PROCEDURE GetBgnCampaignPrdByGroupId (
    iPgid IN INT,
    iPcampaign_code IN INT,
    dPupper_bound IN DECIMAL,
    dPlower_bound IN DECIMAL,
    iPsite_id IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT DISTINCT bp.sku
    FROM
      ya_campaign c
      INNER JOIN ya_bargain_product bp on c.sku = bp.sku
      INNER JOIN ya_bargain_product_group g on c.sku=g.sku
    WHERE c.campaign_code = iPcampaign_code
      AND bp.sale_start <= SYSDATE
      AND bp.sale_end >= SYSDATE
      AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
      AND g.gid=iPgid
      AND bp.site_id = iPsite_id
      AND bp.sku not IN (SELECT sku FROM ya_adult_product);
  END GetBgnCampaignPrdByGroupId;

  PROCEDURE GetBgnCpnPrdByArtistId (
    iPcampaign_code IN INT,
    iPartist_id IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT DISTINCT bp.sku
    FROM
      ya_campaign c
      INNER JOIN ya_bargain_product bp ON
        c.sku = bp.sku
      INNER JOIN ya_product_artist a ON
        c.sku= a.sku
    WHERE
      c.campaign_code = iPcampaign_code
      AND bp.sale_start <= SYSDATE
      AND bp.sale_end >= SYSDATE
      AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
      AND a.artist_id = iPartist_id
      AND bp.site_id = iPsite_id
      AND bp.sku NOT IN (SELECT sku FROM ya_adult_product);
  END GetBgnCpnPrdByArtistId;

  -- proc_bo_GetBargainCampaignProductBySku
  PROCEDURE GetBgnCpnPrdListBySku (
    iPcampaign_code IN INT,
    iPsku IN INT,
    dPlower_bound IN DECIMAL,
    dPupper_bound IN DECIMAL,
    iPsite_id IN INT,
    rcPresult OUT refCur
  )
  AS
    iLcount INT;
  BEGIN
    SELECT COUNT(is_parent)
    INTO iLcount
    FROM ya_product p
    WHERE
      sku IN
        (
          SELECT sku
          FROM ya_prod_rel
          WHERE parent_sku = iPsku
        )
      AND is_parent = 'Y';

    IF (iLcount > 0) THEN
      OPEN rcPresult FOR
      SELECT DISTINCT bp.sku
      FROM
        ya_campaign c
        INNER JOIN ya_bargain_product bp ON
          c.sku = bp.sku
        INNER JOIN ya_prod_rel r ON
          c.sku = r.sku
      WHERE
        c.campaign_code = iPcampaign_code
        AND bp.sale_start <= SYSDATE()
        AND bp.sale_end >= SYSDATE()
        AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
        AND r.parent_sku IN
          (
            SELECT sku
            FROM ya_prod_rel
            WHERE parent_sku = iPsku
          )
        AND bp.site_id = iPsite_id
        AND bp.sku NOT IN
          (
            SELECT sku
            FROM ya_adult_product
          );
    ELSE
      OPEN rcPresult FOR
      SELECT DISTINCT bp.sku
      FROM
        ya_campaign c
        INNER JOIN ya_bargain_product bp ON
          c.sku = bp.sku
        INNER JOIN ya_prod_rel r ON
          c.sku=r.sku
      WHERE
        c.campaign_code = iPcampaign_code
        AND bp.sale_start <= SYSDATE()
        AND bp.sale_end >= SYSDATE()
        AND bp.sale_price BETWEEN dPlower_bound AND dPupper_bound
        AND r.parent_sku = iPsku
        AND bp.site_id = iPsite_id
        AND bp.sku NOT IN
          (
            SELECT sku
            FROM ya_adult_product
          );
    END IF;
  END GetBgnCpnPrdListBySku;



  /*
  * Game Project 21 Nov 2005
  * proc_bo_GetTrailerProductByDepartment
  */
  PROCEDURE GetTrailerProdByDept (
    iPdept_id IN INT,
    iPlang_id IN INT,
    rcPresult_1 OUT refCur,
    rcPresult_2 OUT refCur
  )
  AS
    iLtemp INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp
    FROM ya_dept_attr
    WHERE dept_id = iPdept_id
    AND attribute_id in (84, 79982);

    IF iLtemp > 0 THEN
      OPEN rcPresult_1 FOR
      SELECT DISTINCT
        pd.sku
      FROM
        ya_prod_dept pd
        INNER JOIN ya_prod_grid pg ON
          pd.sku = pg.sku
          AND pg.grid_id = 9
        INNER JOIN ya_prod_grid_lang pgl ON
          pg.sku = pgl.sku
          AND pgl.grid_id = 9
      WHERE
        pd.dept_id = iPdept_id
        AND pgl.lang_id = iPlang_id
        AND length(pgl.label1_value) > 0
        AND length(pgl.label2_value) > 0
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude)
	AND pd.sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859);
    ELSE
      OPEN rcPresult_1 FOR
      SELECT DISTINCT
        pd.sku
      FROM
        ya_prod_dept pd
        INNER JOIN ya_prod_grid pg ON
          pd.sku = pg.sku
          AND pg.grid_id = 9
        INNER JOIN ya_prod_grid_lang pgl ON
          pg.sku = pgl.sku
          AND pgl.grid_id = 9
        left OUTER JOIN ya_adult_product yap ON
          pd.sku = yap.sku
      WHERE
        pd.dept_id = iPdept_id
        AND pgl.lang_id = iPlang_id
        AND length(pgl.label1_value) > 0
        AND length(pgl.label2_value) > 0
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude)
	AND pd.sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859)
        AND yap.sku IS NULL;
    END IF;


    SELECT COUNT(0)
    INTO iLtemp
    FROM ya_dept_attr
    WHERE dept_id = iPdept_id
    AND attribute_id = 125;

    IF iLtemp > 0 THEN
      OPEN rcPresult_2 FOR
      SELECT
        c.sku,
        c.related_sku
      FROM
        ya_cross_selling_type3 c
        INNER JOIN ya_prod_dept pd ON
          c.sku = pd.sku
      WHERE 1=1
        --c.type_id = 3
        AND pd.dept_id = iPdept_id
        AND pd.sku NOT IN (SELECT sku FROM ya_product_ranking_exclude)
	AND pd.sku NOT IN (select distinct sku from ya_prod_attr where attribute_id=80859)
;
    END IF;
  END GetTrailerProdByDept;

  -- --- cross selling 2005 ---+
  PROCEDURE GetCSProdsBySection (
    iPsku IN INT,         -- sku
    iPsectionId IN INT,   -- the id of a section("tabs" in the header of the website)
                          -- see ya_section_dept for the mapping between sectionId and deptId
    iPsiteId IN INT,
    curPresult OUT refcur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT r2.crossSellSku
    FROM
    (
      SELECT r.sectionid, r.crossSellsku
      FROM
      (
        SELECT dcs.sectionid, dcs.crossSellsku
        FROM
          dm_crossSell_sku dcs,
          productavailability pa,
          productRegion pr
        WHERE
          dcs.sku = iPsku
          AND dcs.originId = iPsiteId
          AND pa.productid = dcs.crossSellsku
          AND pr.productId = pa.productId
          AND pr.regionId = pa.regionId
          AND pr.originId = pa.originId
          AND pr.categoryId = pa.category
          AND pr.enable = 'Y'
          AND pr.cansell = 'Y'
          AND pa.originid = dcs.originId
          AND pa.regionId = dcs.originId
          AND pa.category = 1 -- b2c
          AND pa.availability < 60
          AND dcs.originId = pa.originid
        ORDER BY dcs.rank ASC, dcs.crossSellSku DESC
      ) r
      where ROWNUM <=100
    ) r2
    WHERE
      r2.sectionId =
        case
          WHEN iPsectionId = 0 THEN r2.sectionId --sectionId=0 means all sections
          ELSE iPsectionId
        END;

  END GetCSProdsBySection;
/*
  * Bargain (Production) - Random Browse List 29 May 2006
  * --
  */
  PROCEDURE GetBargainDeptProductLot (
    iPdept_id				IN	INT,
    iPlot_location  IN  INT,
    curPresult			OUT	refcur
  )
	AS
	BEGIN
   OPEN curPresult FOR
    select sku from ya_product_lot where dept_id = iPdept_id and lot_location = iPlot_location order by priority;
	END GetBargainDeptProductLot;

	/*
  * Bargain (Mirrror) - Random Browse List 29 May 2006
  * --
  */
  PROCEDURE GetMirrorBargainDeptProductLot (
    iPdept_id				IN	INT,
    iPlot_location  IN  INT,
    curPresult			OUT	refcur
  )
	AS
	BEGIN
   OPEN curPresult FOR
    select sku from ya_mirror_product_lot where dept_id = iPdept_id and lot_location = iPlot_location order by priority;
	END GetMirrorBargainDeptProductLot;

END Pkg_bo_ProductListDalc;
/
 
REM END SS_ADM PKG_BO_PRODUCTLISTDALC
