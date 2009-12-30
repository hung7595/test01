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
  
  PROCEDURE GetHallmarkGiftOrders (
    cPshopperId IN CHAR,
    iPcount OUT INT
  );
  
  PROCEDURE AddHallmarkGift (
    cPshopper_id IN CHAR
  );
  
  PROCEDURE IsEliteClubFirstOrder (
    cPshopper_id IN CHAR,
    iPyear IN INT,
    cPmembership IN VARCHAR2,
    iPgift_sku IN INT,
    iPis_eligible OUT INT
  );
  
  PROCEDURE InsertFreeGiftOrderTracking (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPorder_num IN INT,
    iPgift_sku IN INT
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
	    AND b.paypal_uid = cPpayPal_uid
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
          WHEN length(plgift.prod_name) = 0 THEN plgift_en.prod_name
          ELSE nvl(plgift.prod_name, plgift_en.prod_name)
        END,
        CASE
          WHEN length(plgrp.prod_name) = 0 THEN plgrp_en.prod_name
          ELSE NVL(plgrp.prod_name, plgrp_en.prod_name)
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
            WHEN length(plgift.prod_name) = 0 THEN plgift_en.prod_name
            ELSE nvl(plgift.prod_name, plgift_en.prod_name)
          END,
          CASE
            WHEN length(plgrp.prod_name) = 0 THEN plgrp_en.prod_name
            ELSE nvl(plgrp.prod_name, plgrp_en.prod_name)
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
  
  PROCEDURE GetHallmarkGiftOrders (
    cPshopperId IN CHAR,
    iPcount OUT INT
  )
  AS
  BEGIN
    SELECT count(*) INTO iPcount
    FROM ya_hallmark_member_gift
    WHERE shopper_id = cPshopperId;

    IF iPcount = 0 THEN
    BEGIN
      iPcount := -1;
      RETURN;
    END;
    END IF;
    
    SELECT count(*) INTO iPcount 
    FROM ya_order 
    WHERE shopper_id = cPshopperId
      AND created_datetime > (
        SELECT max(created_date) FROM ya_hallmark_member_gift WHERE shopper_id = cPshopperId
      );
    RETURN;
  END GetHallmarkGiftOrders;
  
  PROCEDURE AddHallmarkGift (
    cPshopper_id IN CHAR
  )
  AS
  BEGIN
	  INSERT INTO ya_hallmark_member_gift (id, shopper_id, created_date) VALUES (SEQ_YA_HALLMARK_MEMBER_GIFT.nextval, cPshopper_id, sysdate);	  
  END AddHallmarkGift;
  
  PROCEDURE IsEliteClubFirstOrder (
    cPshopper_id IN CHAR,
    iPyear IN INT,
    cPmembership IN VARCHAR2,
    iPgift_sku IN INT,
    iPis_eligible OUT INT
  )
  AS
  BEGIN
    select case when tmp.order_exists = 1 then 0
            else 1
           end into iPis_eligible 
    from loyalty_customer lc
    left outer join (
      select 1 order_exists, fg.shopper_id from ya_free_gift_order_tracking fg
      where fg.shopper_id = cPshopper_id
        and fg.free_gift_prod_id = iPgift_sku
        and fg.sts = 0
        and to_char(fg.create_dt, 'yyyy') = iPyear
        and rownum = 1
    ) tmp on lc.ya_shopper_id = tmp.shopper_id
    where lc.ya_shopper_id = cPshopper_id
    and lc.loyalty_membership_id 
      = (select lm.id from loyalty_membership lm where lm.membership_year = iPyear and lm.membership_name = cPmembership);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPis_eligible := 0;
        END;      
  END IsEliteClubFirstOrder;
  
  PROCEDURE InsertFreeGiftOrderTracking (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPorder_num IN INT,
    iPgift_sku IN INT
  )
  AS
  BEGIN
    INSERT INTO ya_free_gift_order_tracking (id, shopper_id, site_id, fe_order_num,
      free_gift_prod_id, sts, create_user, create_dt)
    VALUES (SEQ_YA_FREE_GIFT_ORDER_TRACK.nextval, cPshopper_id, iPsite_id, iPorder_num,
      iPgift_sku, 0, 'frontend', sysdate);
    
    COMMIT;    
  END InsertFreeGiftOrderTracking;
END Pkg_fe_PromotionAccess;
/

