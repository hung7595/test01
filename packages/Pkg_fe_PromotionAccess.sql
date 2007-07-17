CREATE OR REPLACE PACKAGE Pkg_fe_PromotionAccess
AS
  TYPE refcur IS ref CURSOR;
   PROCEDURE GetShadowPromotionItems (
    cPshopper_id	IN	CHAR,
	cPpayPal_uid	IN  CHAR,
    iPsite_id		IN	INT,
    curPgetPromotion	OUT	refcur
  );
  /* proc_fe_GetPromotionItems */
  PROCEDURE GetPromotionItems (
    cPshopper_id	IN	CHAR,
    iPsite_id		IN	INT,
    curPgetPromotion	OUT	refcur
  );
  /* proc_fe_GetPromotionBundleInfo */
  PROCEDURE GetPrdGrpPromotionInfo (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    curPresult OUT refcur
  );
  PROCEDURE GetPromotionBundleInfo (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    curPresult OUT refcur
  );
  /* proc_fe_GetProductGroupPromotionInfo */
  PROCEDURE GetPrdGrpPromotionDetailInfo (
    iPgrp_sku IN INT,
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    rcPresult OUT refCur
  );
  
  PROCEDURE GetPromotionMessage (
    cPpromotion_name IN VARCHAR2,
    iPlang_id IN INT,
    rcPresult OUT refCur
  );
END Pkg_fe_PromotionAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_fe_PromotionAccess
IS
  PROCEDURE GetShadowPromotionItems (
    cPshopper_id	IN	CHAR,
	cPpayPal_uid	IN  CHAR,
    iPsite_id		IN	INT,
    curPgetPromotion	OUT	refcur
  )
  AS
  BEGIN

    OPEN curPgetPromotion FOR
    SELECT
      CASE
        WHEN p.sku IS NOT NULL THEN 1008
        ELSE c.campaign_code
      END,
      b.sku
    FROM
      ya_new_basket_shadow b
      LEFT OUTER JOIN ya_campaign c ON
        b.sku = c.sku
      LEFT OUTER JOIN ya_product p ON
        b.sku = p.sku
        AND p.account_id IN (23,39,48,56)
    WHERE
      b.shopper_id = cPshopper_id
      AND b.site_id = iPsite_id
	  AND b.paypal_uid=cPpayPal_uid
      AND (c.sku IS NOT NULL OR p.sku IS NOT NULL)
      AND b.type = 0;

  RETURN;
  END GetShadowPromotionItems;
  PROCEDURE GetPromotionItems (
    cPshopper_id	IN	CHAR,
    iPsite_id		IN	INT,
    curPgetPromotion	OUT	refcur
  )
  AS
  BEGIN

    OPEN curPgetPromotion FOR
    SELECT
      CASE
        WHEN p.sku IS NOT NULL THEN 1008
        ELSE c.campaign_code
      END,
      b.sku
    FROM
      ya_new_basket b
      LEFT OUTER JOIN ya_campaign c ON
        b.sku = c.sku
      LEFT OUTER JOIN ya_product p ON
        b.sku = p.sku
        AND p.account_id IN (23,39,48,56)
    WHERE
      b.shopper_id = cPshopper_id
      AND b.site_id = iPsite_id
      AND (c.sku IS NOT NULL OR p.sku IS NOT NULL)
      AND b.type = 0;

  RETURN;
  END GetPromotionItems;

  PROCEDURE GetPromotionBundleInfo (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    curPresult OUT refcur
  )
  AS
    dtLcurrDate DATE;
  BEGIN
    SELECT SYSDATE INTO dtLcurrDate FROM DUAL;

    OPEN curPresult FOR
    SELECT
      DISTINCT
      pr.sku,
      pr.partner_sku,
      pr.bundled_discount,
      pr.partner_bundled_discount
    FROM
      ya_new_basket b
      LEFT OUTER JOIN ya_promotion_bundle pr ON
        pr.sku = b.sku
        OR pr.partner_sku = b.sku
    WHERE
      b.shopper_id = cPshopperId
      AND b.site_id = iPsiteId
      AND b.type = 0
      AND pr.sku IS NOT NULL
      AND pr.site_id = iPsiteId
      AND dtLcurrDate BETWEEN NVL(pr.start_date, dtLcurrDate) AND NVL(pr.end_date, dtLcurrDate);
    RETURN;
  END GetPromotionBundleInfo;

  PROCEDURE GetPrdGrpPromotionInfo (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    curPresult OUT refcur
  )
  AS
    dtLcurrDate DATE;
  BEGIN
    SELECT SYSDATE INTO dtLcurrDate FROM DUAL;

    OPEN curPresult FOR
    SELECT
      pr.parent_sku,
      pgp.gift_sku,
      pgp.priority,
      pgp.threshold,
      b.sku
    FROM
      ya_new_basket b
      , ya_prod_rel pr
      , ya_product_group_promotion pgp
    WHERE
      pr.sku = b.sku
      AND (
        pgp.product_group_sku = pr.parent_sku
        AND pgp.site_id = iPsiteId
        AND dtLcurrDate BETWEEN NVL(pgp.start_date, dtLcurrDate) AND NVL(pgp.end_date, dtLcurrDate)
      )
      AND b.shopper_id = cPshopperId
      AND b.site_id = iPsiteId
      AND b.type = 0
    ORDER BY
      pr.parent_sku ASC, pgp.priority ASC;
    RETURN;
  END GetPrdGrpPromotionInfo;



  PROCEDURE GetPrdGrpPromotionDetailInfo (
    iPgrp_sku IN INT,
    iPsku IN INT,
    iPsite_id IN INT,
    iPlang_id IN INT,
    rcPresult OUT refCur
  )
  AS
    dLcurrent DATE;
  BEGIN
    dLcurrent := SYSDATE();

    IF iPsku = -1 THEN
      OPEN rcPresult FOR
      SELECT
        pgp.product_group_sku,
        pgp.gift_sku,
        pgp.threshold,
        pgp.start_date,
        CASE
          WHEN length(plgift.prod_name_u) = 0 THEN plgift_en.prod_name_u
          ELSE nvl(plgift.prod_name_u, plgift_en.prod_name_u)
        END,
        CASE
          WHEN length(plgrp.prod_name_u) = 0 THEN plgrp_en.prod_name_u
          ELSE NVL(plgrp.prod_name_u, plgrp_en.prod_name_u)
        END
      FROM
        ya_product_group_promotion pgp,
        (SELECT * FROM ya_prod_lang WHERE lang_id = 1) plgift_en,
        (SELECT * FROM ya_prod_lang WHERE lang_id = iPlang_id) plgift,
        (SELECT * FROM ya_prod_lang WHERE lang_id = 1) plgrp_en,
        (SELECT * FROM ya_prod_lang WHERE lang_id = iPlang_id) plgrp
      WHERE
        pgp.product_group_sku = iPgrp_sku
        AND pgp.site_id = iPsite_id
        AND dLcurrent BETWEEN
          nvl(pgp.start_date, dLcurrent)
          AND nvl(pgp.end_date, dLcurrent)
        AND pgp.gift_sku = plgift_en.sku(+)
        AND pgp.gift_sku = plgift.sku(+)
        AND pgp.product_group_sku = plgrp_en.sku(+)
        AND pgp.product_group_sku = plgrp.sku(+);
    ELSE
      IF iPgrp_sku = -1 THEN
        OPEN rcPresult FOR
        SELECT
          pgp.product_group_sku,
          pgp.gift_sku,
          pgp.threshold,
          pgp.start_date,
          CASE
            WHEN length(plgift.prod_name_u) = 0 THEN plgift_en.prod_name_u
            ELSE nvl(plgift.prod_name_u, plgift_en.prod_name_u)
          END,
          CASE
            WHEN length(plgrp.prod_name_u) = 0 THEN plgrp_en.prod_name_u
            ELSE nvl(plgrp.prod_name_u, plgrp_en.prod_name_u)
          END
        FROM
          ya_product_group_promotion pgp,
          ya_prod_rel pr,
          (SELECT * FROM ya_prod_lang WHERE lang_id = 1) plgift_en,
          (SELECT * FROM ya_prod_lang WHERE lang_id = iPlang_id) plgift,
          (SELECT * FROM ya_prod_lang WHERE lang_id = 1) plgrp_en,
          (SELECT * FROM ya_prod_lang WHERE lang_id = iPlang_id) plgrp
        WHERE
          pr.sku = iPsku
          AND pgp.product_group_sku = pr.parent_sku
          AND pgp.site_id = iPsite_id
          AND dLcurrent BETWEEN
            nvl(pgp.start_date, dLcurrent)
            AND nvl(pgp.end_date, dLcurrent)
          AND pgp.gift_sku = plgift_en.sku(+)
          AND pgp.gift_sku = plgift.sku(+)
          AND pgp.product_group_sku = plgrp_en.sku(+)
          AND pgp.product_group_sku = plgrp.sku(+);
      END IF;
    END IF;
  END GetPrdGrpPromotionDetailInfo;
  
    PROCEDURE GetPromotionMessage (
    cPpromotion_name IN VARCHAR2,
    iPlang_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
	  SELECT * FROM ya_asset_translation t, ya_promotion_message m 
		WHERE t.asset_id = m.asset_id 
		  AND m.promotion_name = cPpromotion_name
		  AND t.lang_id = iPlang_id;
	RETURN;
  END GetPromotionMessage;
END Pkg_fe_PromotionAccess;
/

