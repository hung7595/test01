
  CREATE OR REPLACE PACKAGE "PKG_FE_BASKETACCESS2" 
AS
  TYPE refCur IS REF CURSOR;
  PROCEDURE DeleteWarrantyItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPwarranteeSku IN INT,
    iPwarrantySku IN INT
  );

  PROCEDURE AddWarrantyItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPwarranteeSku IN INT,
    iPwarrantySku IN INT
  );

  PROCEDURE AddItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPsku IN INT,
    iPquantity IN INT,
    iPtype IN INT
  );

  PROCEDURE AddMultiItems (
    cPshopperId IN CHAR,
    cPskuCsv IN VARCHAR2,
    iPsiteId IN INT,
    iPtype IN INT
  );

  PROCEDURE UpdateMultiItems (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPskuCsv IN VARCHAR2,
    cPqtyCsv IN VARCHAR2,
    iPtype IN INT
  );

  PROCEDURE UpdateSingleItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPsku IN INT,
    iPquantity IN INT,
    iPtype IN INT
  );

  PROCEDURE DeleteSingleItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPsku IN INT,
    iPtype IN INT
  );

  PROCEDURE DeleteMultiItems (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPskuCSV IN VARCHAR2,
    iPtype IN INT
  );
  PROCEDURE ClearBasket (
    cPshopperId IN CHAR,
    iPsiteId IN INT
  );

  PROCEDURE ClearSaveForLaterBasket (
    cPshopperId IN CHAR,
    iPsiteId IN INT
  );
	PROCEDURE GetShadowBasketWithWarranty (
	cPguid IN CHAR,
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPlangId IN INT,
    iPtype IN INT,
    iPcountryId IN INT DEFAULT -1,
    curPgetBasket1 OUT refCur,
    curPgetBasket2 OUT refCur,
    curPgetBasket3 OUT refCur,
    curPgetBasket4 OUT refCur,
    curPgetBasket5 OUT refCur,
    curPgetBasket6 OUT refCur,
    curPgetBasket7 OUT refCur
    );

  PROCEDURE GetBasketWithWarranty (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPlangId IN INT,
    iPtype IN INT,
    iPcountryId IN INT DEFAULT -1,
    curPgetBasket1 OUT refCur,
    curPgetBasket2 OUT refCur,
    curPgetBasket3 OUT refCur,
    curPgetBasket4 OUT refCur,
    curPgetBasket5 OUT refCur,
    curPgetBasket6 OUT refCur,
    curPgetBasket7 OUT refCur
  );
  
  PROCEDURE GetBasketYS (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPlangId IN INT,
    iPtype IN INT,
    iPcountryId IN INT DEFAULT -1,
    curPgetBasket7 OUT refCur,
    curPgetBasket1 OUT refCur,
    curPgetBasket2 OUT refCur,
    curPgetBasket3 OUT refCur,
    curPgetBasket4 OUT refCur,
    curPgetBasket5 OUT refCur,
    curPgetBasket6 OUT refCur
  );

  PROCEDURE TransferBasket (
    cPfromShopperId IN CHAR,
    cPtoShopperId IN CHAR,
    iPsiteId IN INT
  );

  PROCEDURE FlyBasket (
    cPshopperId IN CHAR,
    iPfromSiteId IN INT,
    iPtoSiteId IN INT
  );

  /* proc_fe_GetBasketCrossSellingProduct */
  PROCEDURE GetBasketCSProductBase (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPtype IN INT,
    iPcountry_id IN INT,
    iPsectionId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  );

  /* proc_fe_GetBasketCrossSellingProductDetail */
  PROCEDURE GetBasketCSProductDetail (
    iPlang_id IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    iPsku1 IN INT DEFAULT NULL,
    iPsku2 IN INT DEFAULT NULL,
    iPsku3 IN INT DEFAULT NULL,
    iPsku4 IN INT DEFAULT NULL,
    iPsku5 IN INT DEFAULT NULL,
    iPsku6 IN INT DEFAULT NULL,
    iPsku7 IN INT DEFAULT NULL,
    iPsku8 IN INT DEFAULT NULL,
    iPsku9 IN INT DEFAULT NULL,
    iPsku10 IN INT DEFAULT NULL,
    iPsku11 IN INT DEFAULT NULL,
    iPsku12 IN INT DEFAULT NULL,
    iPsku13 IN INT DEFAULT NULL,
    iPsku14 IN INT DEFAULT NULL,
    iPsku15 IN INT DEFAULT NULL,
    iPsku16 IN INT DEFAULT NULL,
    iPsku17 IN INT DEFAULT NULL,
    iPsku18 IN INT DEFAULT NULL,
    iPsku19 IN INT DEFAULT NULL,
    iPsku20 IN INT DEFAULT NULL
  );
END Pkg_fe_BasketAccess2;
/
CREATE OR REPLACE PACKAGE BODY "PKG_FE_BASKETACCESS2" 
IS
------------- AddItem
  PROCEDURE AddItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPsku IN INT,
    iPquantity IN INT,
    iPtype IN INT
  )
AS
    iLorigQuantity INT;
BEGIN
  BEGIN
    SELECT quantity INTO iLorigQuantity
    FROM ya_new_basket
    WHERE shopper_id = cPshopperId
    AND site_id = iPsiteid
    AND sku = iPsku
    AND type = iPtype;

    EXCEPTION when NO_DATA_FOUND THEN
      iLorigQuantity := NULL;
  END;

  IF iLorigQuantity IS NULL THEN
    BEGIN
      INSERT INTO ya_new_basket (shopper_id, site_id, sku, quantity, type)
      VALUES (cPshopperid, iPsiteId, iPsku, iPquantity, iPtype);
    END;
  ELSE
    BEGIN
      UPDATE ya_new_basket SET quantity = (iLorigQuantity + iPquantity)
      WHERE shopper_id = cPshopperId
      AND site_id = iPsiteId
      AND sku = iPsku
      AND type = iPtype;
    END;
  END IF;

  COMMIT;
--  EXCEPTION WHEN OTHERS THEN
--    ROLLBACK;
RETURN;
END;

------------ AddMultiItems
  PROCEDURE AddMultiItems (
    cPshopperId IN CHAR,
    cPskuCsv IN VARCHAR2,
    iPsiteId IN INT,
    iPtype IN INT
  )
AS
    iLsku INT;
    iLstartpos INT := 1;
    iLendpos INT;
    dtLnullDate DATE;
    iLtemp INT;
    iLtemp2 INT;
    cLskuCsv VARCHAR2(2000);
BEGIN
  dtLnullDate := TO_DATE('01-01-1900','DD-MM-YYYY');
  cLskuCsv := cPskuCsv;

  iLtemp := NVL(LENGTH(RTRIM(cLskuCsv)),0);

  IF(iLtemp) > 0 THEN
    BEGIN
      iLendpos := INSTR(cPskuCsv, ',');
      WHILE iLendpos > 0  LOOP
        BEGIN
          iLsku := CAST(SUBSTR(cLskuCsv, iLstartpos, iLendpos - iLstartpos) AS int);

          SELECT COUNT(1)
          INTO iLtemp2
          FROM ya_new_basket
          WHERE
            sku = iLsku
            AND shopper_id = cPshopperId
            AND site_id = iPsiteId
            AND type = iPtype;
/*
          BEGIN
            SELECT 1 INTO iLtemp2 FROM DUAL
            WHERE EXISTS
              (
                SELECT * FROM ya_new_basket
                WHERE sku = iLsku
                AND shopper_id = cPshopperId
                AND site_id = iPsiteId
                AND type = iPtype
              );
          EXCEPTION WHEN NO_DATA_FOUND THEN
            iLtemp2 := -1;
          END;
*/
          IF (iLtemp2 > 0) THEN
            BEGIN
              UPDATE ya_new_basket SET quantity = quantity + 1
              WHERE sku = iLsku AND shopper_id = cPshopperId
              AND site_id = iPsiteId
              AND type = iPtype;
            END;
          ELSE
            BEGIN
              INSERT INTO ya_new_basket (shopper_id, site_id, sku, quantity, created_datetime, type)
              VALUES (cPshopperId, iPsiteId, iLsku, 1, SYSDATE, iPtype);
            END;
          END IF;

          cLskuCsv := SUBSTR(cLskuCsv, iLendpos + 1, LENGTH(RTRIM(cLskuCsv)) - iLendpos);
          iLendpos := INSTR(cLskuCsv, ',') ;
        END;
      END LOOP;

      /* Throw in the last one */
      iLsku := CAST(cLskuCsv as int);

      SELECT COUNT(1)
      INTO iLtemp2
      FROM ya_new_basket
      WHERE
        sku = iLsku
        AND shopper_id = cPshopperId
        AND site_id = iPsiteId
        AND type = iPtype;
      /*
      BEGIN
        SELECT 1 INTO iLtemp2 FROM DUAL
        WHERE EXISTS
          (
            SELECT * FROM ya_new_basket
            WHERE sku = iLsku
            AND shopper_id = cPshopperId
            AND site_id = iPsiteId
            AND type = iPtype
          );
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iLtemp2 := -1;
      END;
      */

      IF (iLtemp2 > 0) THEN
        BEGIN
          UPDATE ya_new_basket SET quantity = quantity + 1
          WHERE sku = iLsku
          AND shopper_id = cPshopperId
          AND site_id = iPsiteId
          AND type = iPtype;
        END;
      ELSE
        BEGIN
          INSERT INTO ya_new_basket (shopper_id, site_id, sku, quantity, created_datetime, type)
          VALUES (cPshopperId, iPsiteId, iLsku, 1, SYSDATE, iPtype);
        END;
      END IF;
    END;
  END IF;
  COMMIT;
END AddMultiItems;

------------ UpdateMultiItems
  PROCEDURE UpdateMultiItems (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPskuCsv IN VARCHAR2,
    cPqtyCsv IN VARCHAR2,
    iPtype IN INT
    )
AS
    iLstartSkuPos  INT := 1;
    iLendSkuPos  INT;
    iLstartQtyPos       INT := 1;
    iLendQtyPos  INT;
    iLcurrentqty  INT;
    iLtemp INT;
    cLskuCsv VARCHAR2(1650);
    cLqtyCsv VARCHAR2(300);
BEGIN
  iLtemp := LENGTH(RTRIM(cPskuCsv));

  IF(iLtemp) > 0 THEN
    BEGIN
      iLendSkuPos := INSTR(cPskuCsv, ',');
      iLendQtyPos := INSTR(cPqtyCsv, ',');

      cLskuCsv := cPskuCsv;
      cLqtyCsv := cPqtyCsv;

      WHILE  iLendSkuPos  >  0
      LOOP
      BEGIN
        iLcurrentqty := CAST(SUBSTR(cLqtyCsv, iLstartQtyPos, iLendQtyPos - iLstartQtyPos) as INT);

        IF (iLcurrentqty > 0) THEN
          BEGIN
            UPDATE ya_new_basket
            SET quantity = iLcurrentqty
            WHERE site_id = iPsiteId
            AND sku = CAST(SUBSTR(cLskuCsv, iLstartSkuPos, iLendSkuPos - iLstartSkuPos) as INT)
            AND shopper_id = cPshopperId
            AND type = iPtype;
          END;
        ELSE
          BEGIN
            DELETE FROM ya_new_basket
            WHERE site_id = iPsiteId
            AND shopper_id = cPshopperId
            AND type = iPtype
            AND sku = CAST(SUBSTR(cLskuCsv, iLstartSkuPos, iLendSkuPos - iLstartSkuPos) as INT);

            IF (iPtype = 0) THEN
            BEGIN
              DELETE FROM ya_warranty_basket
              WHERE site_id = iPsiteId
              AND shopper_id = cPshopperId
              AND warrantee_sku = CAST(SUBSTR(cLskuCsv, iLstartSkuPos, iLendSkuPos - iLstartSkuPos) as INT);
            END;
            END IF ;
          END;
        END IF;

        cLskuCsv := SUBSTR(cLskuCsv, iLendSkuPos + 1, LENGTH(RTRIM(cLskuCsv)) - iLendSkuPos);
        cLqtyCsv := SUBSTR(cLqtyCsv, iLendQtyPos + 1, LENGTH(RTRIM(cLqtyCsv)) - iLendQtyPos);
        iLendSkuPos := INSTR(cLskuCsv, ',');
        iLendQtyPos := INSTR(cLqtyCsv, ',');
      END;
      END LOOP;


      /* Throw in the last one */
      iLcurrentqty := CAST(cLqtyCsv as INT);

      IF (iLcurrentqty > 0) THEN
        BEGIN
          UPDATE ya_new_basket
          SET quantity = iLcurrentqty
          WHERE site_id = iPsiteId
          AND sku = CAST(cLskuCsv as INT)
          AND shopper_id = cPshopperId
          AND type = iPtype;
        END;
      ELSE
        BEGIN
          DELETE FROM ya_new_basket
          WHERE site_id = iPsiteId
            AND shopper_id = cPshopperId
            AND type = iPtype
            AND sku = CAST(cLskuCsv as INT);

          IF (iPtype = 0) THEN
          BEGIN
            DELETE FROM ya_warranty_basket
            WHERE site_id = iPsiteId
            AND shopper_id = cPshopperId
            AND warrantee_sku = CAST(cLskuCsv as INT);
          END;
          END IF;
        END;
      END IF;
      COMMIT;
    END;
  END IF;
END UpdateMultiItems;


/* proc_fe_UpdateSingleBasketItem */
  PROCEDURE UpdateSingleItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPsku IN INT,
    iPquantity IN INT,
    iPtype IN INT
    )
AS
BEGIN
  IF iPquantity = 0 THEN
    BEGIN
      DELETE FROM ya_new_basket
      WHERE shopper_id = cPshopperId
        AND site_id = iPsiteId
        AND sku = iPsku
        AND type = iPtype;

      IF (iPtype = 0) THEN
      BEGIN
        DELETE FROM ya_warranty_basket
        WHERE shopper_id = cPshopperId
          AND site_id = iPsiteId
          AND warrantee_sku = iPsku;
      END;
      END IF;
    END;
  ELSE
    BEGIN
      UPDATE ya_new_basket SET quantity = iPquantity
      WHERE shopper_id = cPshopperId
        AND site_id = iPsiteId
        AND sku = iPsku
        AND type = iPtype;
    END;
  END IF;
  COMMIT;
END;


  PROCEDURE DeleteSingleItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPsku IN INT,
    iPtype IN INT
  )
AS
    iLcert_count INT;
BEGIN
  DELETE FROM ya_new_basket
    WHERE shopper_id = cPshopperId
    AND site_id = iPsiteId
    AND sku = iPsku
    AND type = iPtype;

  IF (iPtype = 0) THEN
  BEGIN
    DELETE FROM ya_warranty_basket
      WHERE shopper_id = cPshopperId
      AND site_id = iPsiteId
      AND warrantee_sku = iPsku;
  END;
  END IF ;
 --   EXCEPTION WHEN NO_DATA_FOUND THEN
 --     ROLLBACK;
  COMMIT;

END;

/* proc_fe_DeleteMultiBasketItems */
  PROCEDURE DeleteMultiItems (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPskuCSV IN VARCHAR2,
    iPtype IN INT
  )
AS
  iLsql VARCHAR2(1000);
BEGIN
  iLsql := 'DELETE FROM ya_new_basket WHERE shopper_id = '''|| cPshopperId
    ||''' AND site_id = '|| CAST(iPsiteId AS nvarchar2)
    ||' AND type = '|| CAST(iPtype AS NVARCHAR2)
    ||' AND sku in (' ||cPskuCSV||')';

  execute immediate iLsql;

  IF (iPtype = 0) THEN
  BEGIN
    iLsql := 'DELETE FROM ya_warranty_basket WHERE shopper_id = '''|| cPshopperId
      ||''' AND site_id = '|| CAST(iPsiteId AS nvarchar2)
      ||' AND warrantee_sku in (' ||cPskuCSV||')';

    execute immediate iLsql;
  END;
  END IF ;
  /*
  DELETE FROM ya_new_basket
  WHERE shopper_id = cPshopperId
  AND site_id = iPsiteId
  AND type = iPtype
  AND sku in (cPskuCSV);

  DELETE FROM ya_warranty_basket
  WHERE shopper_id = cPshopperId
  AND site_id = iPsiteId
  AND warrantee_sku in (cPskuCSV)

  EXCEPTION WHEN NO_DATA_FOUND THEN ROLLBACK;
  WHEN OTHERS THEN ROLLBACK;
  */
  COMMIT;
--  EXCEPTION WHEN others THEN ROLLBACK;
END;
  PROCEDURE ClearBasket (
    cPshopperId IN CHAR,
    iPsiteId IN INT
    )
  AS
  BEGIN
    DELETE FROM ya_new_basket WHERE shopper_id = cPshopperId AND site_id = iPsiteId AND type = 0; -- type = 0 for normal basket
    DELETE FROM ya_warranty_basket WHERE shopper_id = cPshopperId AND site_id = iPsiteId;
    COMMIT;
  END;

  PROCEDURE ClearSaveForLaterBasket (
    cPshopperId IN CHAR,
    iPsiteId IN INT
    )
  AS
  BEGIN
    DELETE FROM ya_new_basket WHERE shopper_id = cPshopperId AND site_id = iPsiteId AND type = 1; -- type = 1 for save for later basket
    COMMIT;
  END;
/* use by paypal order*/
 PROCEDURE GetShadowBasketWithWarranty (
	cPguid IN CHAR,
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPlangId IN INT,
    iPtype IN INT,
    iPcountryId IN INT DEFAULT -1,
    curPgetBasket1 OUT refCur,
    curPgetBasket2 OUT refCur,
    curPgetBasket3 OUT refCur,
    curPgetBasket4 OUT refCur,
    curPgetBasket5 OUT refCur,
    curPgetBasket6 OUT refCur,
    curPgetBasket7 OUT refCur
    )
  AS
    dtLnullDate DATE := TO_DATE('01-01-1900','DD-MM-YYYY');
    iLShipmentUnitConst INT;
  BEGIN
  /* Attribute Info */
  OPEN curPgetBasket1 FOR
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
    ya_attribute_lang al
  WHERE pa.attribute_id = a.attribute_id
  AND pa.attribute_id = ale.attribute_id
  AND ale.lang_id = 1 /* English */
  AND pa.attribute_id = al.attribute_id
  AND al.lang_id = iPlangId
  AND pa.sku IN (
                SELECT sku
                FROM ya_new_basket_shadow
                WHERE shopper_id = cPshopperId
                  AND site_id = iPsiteId
				          AND paypal_uid = cPguid
                  AND type = iPtype
                )
  ORDER BY pa.sku, a.attribute_type_id;

  /* Limited Quantity */
  OPEN curPgetBasket2 FOR
  SELECT sku, 
  case when lmqnty < crqnty and lmqnty > 0 then lmqnty 
  when lmqnty > crqnty and crqnty = 0 then lmqnty 
  else crqnty end 
  FROM (
    SELECT
      nb.sku,  
      nvl(lq.frontend_quantity, 0) as lmqnty,
      nvl(cr.avlb_qnty, 0) as crqnty
    FROM
      ya_new_basket_shadow nb     
      INNER JOIN prod_region pr ON
        pr.prod_id = nb.sku
      --LEFT OUTER JOIN ya_limited_quantity lq on nb.sku = lq.sku and lq.frontend_quantity > 0 and lq.site_id in (99, pr.origin_id)
      LEFT OUTER JOIN ya_limited_quantity lq on (lq.site_id, lq.sku) in (
          select max(lq2.site_id), lq2.sku
          from ya_limited_quantity lq2
          where lq2.frontend_quantity > 0
            and lq2.site_id in (iPsiteId, 99)
          group by lq2.sku
        ) and nb.sku = lq.sku
      LEFT OUTER JOIN clearance cr on concat(nvl(pr.prefix,''), pr.prod_id) = cr.sku and cr.avlb_qnty > 0 and cr.sts = 1
    WHERE nb.shopper_id = cPshopperId
      AND nb.shopper_id <> '8a81844a2b805a4b012ba8cf4e0202ea'
      AND nb.site_id = iPsiteId
      AND nb.type = iPtype
      AND nb.paypal_uid = cPguid
      AND exists (
        select 1
        from prod_region prr
        inner join ya_region_mapping def on def.region_id = prr.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
          and prr.prod_id = pr2.prod_id
        left outer join prod_region pr3 on pr3.region_id = iPsiteId
          and prr.prod_id = pr3.prod_id
        where nb.sku = prr.prod_id
          and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
          and nb.site_id = def.site_id
      )
      AND (lq.frontend_quantity is not null or cr.avlb_qnty is not null)      
    ORDER BY nb.sku
  );

  /* Get shipment Unit */
  iLShipmentUnitConst := 200; /* in Grams */

  OPEN curPgetBasket3 FOR
  SELECT
    t1.sku,
    CAST(
         CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
         ELSE CEIL(NVL(t1.weight, iLShipmentUnitConst) / iLShipmentUnitConst)
         END AS int
         ) as shipment_unit
  FROM
    ya_product t1,
    ya_shipping_unit t2
  WHERE t1.sku = t2.sku(+)
  AND t2.site_id(+) = iPsiteId
  AND t1.sku IN
    (
      SELECT sku
      FROM ya_new_basket_shadow
      WHERE shopper_id = cPshopperId
      AND site_id = iPsiteId
	    AND paypal_uid = cPguid
      AND type = iPtype
    );

  /* inventory and Availability Info */
  OPEN curPgetBasket4 FOR
  SELECT
    pt.sku,
    -1,
    CASE
      WHEN pa.avlb = 0 THEN 99
      ELSE 0
    END,
    NVL(o.availability_id, pa.avlb),
    pa.is_in_stock
  FROM 
    ya_new_basket_shadow pt
    INNER JOIN prod_avlb pa ON pt.sku = pa.prod_id
    INNER JOIN prod_region pr ON 
      pa.prod_id = pr.prod_id
    INNER JOIN ya_product yp ON pt.sku = yp.sku
	  LEFT OUTER JOIN ya_availability_override o ON
      pr.supplier_id = o.supplier_id
      AND SYSDATE BETWEEN o.start_date AND o.end_date
      AND pa.avlb < o.availability_id
      AND yp.account_id = o.account_id
    WHERE
      pt.shopper_id = cPshopperId
      AND pa.origin_id = iPsiteId
      AND pa.category = 1
		  AND pt.paypal_uid = cPguid
      AND exists (
        select 1
        from prod_avlb paa
        inner join ya_region_mapping def on def.region_id = paa.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_avlb pa2 on yrm.region_id = pa2.region_id 
          and paa.prod_id = pa2.prod_id
        left outer join prod_avlb pa3 on pa3.region_id = iPsiteId
          and paa.prod_id = pa3.prod_id
        where pa.prod_id = paa.prod_id
          and pa.region_id = nvl(nvl(pa2.region_id, pa3.region_id), paa.region_id)
          and pt.site_id = def.site_id
      )
      AND exists (
        select 1
        from prod_region prr
        inner join ya_region_mapping def on def.region_id = prr.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
          and prr.prod_id = pr2.prod_id
        left outer join prod_region pr3 on pr3.region_id = iPsiteId
          and prr.prod_id = pr3.prod_id
        where pr.prod_id = prr.prod_id
          and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
          and pt.site_id = def.site_id
      )
    ORDER BY pt.sku;
  /* Campaign Code */
  OPEN curPgetBasket5 FOR
  SELECT
    c.sku,
    c.campaign_code
  FROM
    ya_campaign c,
    ya_new_basket_shadow b
  WHERE c.sku = b.sku
  AND b.shopper_id = cPshopperId
  AND b.site_id = iPsiteId
  AND b.type = iPtype
  AND b.paypal_uid=cPguid
  ORDER BY c.sku DESC;


  /* Product Information */
  OPEN curPgetBasket6 FOR
  SELECT
    b.sku,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(pr.is_preorder, 'N') AS preorder,
    NVL(pr.preorder_start, dtLnullDate) AS preorder_start,
    NVL(pr.preorder_end, dtLnullDate) AS preorder_end,
    NVL(pr.list_price, 9999) AS list_price,
    NVL(pr.sale_price, 9999) AS sale_price,
    NVL(pr.sale_price_start, dtLnullDate) AS sale_start,
    NVL(pr.sale_price_end, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name, ple.prod_name),
    NVL(p.release_date, dtLnullDate),
    null as name_img_path,
    0 as name_img_width,
    0 as name_img_height,
    NVL(p.account_id, -1),
    NVL(pr.supplier_id, -1),
    NVL(pr.is_enabled, 'N'),
    NVL(pr.is_can_sell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    0 AS preorder_buffer_day,
    1 AS region_count,
    yr.currency,
    p.brand_id,
    cd.currency
  FROM
    ya_new_basket_shadow b
    INNER JOIN ya_product p ON
      b.sku = p.sku
    LEFT JOIN ya_prod_lang pl ON
      p.sku = pl.sku
      AND pl.lang_id = iPlangId
    LEFT JOIN ya_prod_lang ple ON
      p.sku = ple.sku
      AND ple.lang_id = 1 -- English
    INNER JOIN prod_region pr ON
      b.sku = pr.prod_id
    INNER JOIN ya_region yr ON    
      pr.region_id = yr.region_id
    LEFT OUTER JOIN ya_checkout_data cd ON
      cd.site_id = b.site_id
      AND cd.shopper_id = b.shopper_id
  WHERE b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
	  AND b.paypal_uid = cPguid
    AND p.is_prod_grp_parent = 'N'
    AND exists (
      select 1
      from prod_region prr
      inner join ya_region_mapping def on def.region_id = prr.region_id
        and def.country_id = -1
      left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
        and yrm.country_id <> -1 
        and yrm.country_id = iPcountryId
      left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
        and prr.prod_id = pr2.prod_id
      left outer join prod_region pr3 on pr3.region_id = iPsiteId
        and prr.prod_id = pr3.prod_id
      where pr.prod_id = prr.prod_id
        and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
        and b.site_id = def.site_id
    )    
  ORDER BY b.created_datetime DESC, b.sku DESC;

  -- warranty item brought
  OPEN curPgetBasket7 for
  SELECT warrantee_sku, warranty_sku FROM
    ya_warranty_basket_shadow
  where
    shopper_id = cPshopperId
    AND site_id = iPsiteId
	AND paypal_uid=cPguid;
  RETURN;
END GetShadowBasketWithWarranty;



  PROCEDURE GetBasketWithWarranty (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPlangId IN INT,
    iPtype IN INT,
    iPcountryId IN INT DEFAULT -1,
    curPgetBasket1 OUT refCur,
    curPgetBasket2 OUT refCur,
    curPgetBasket3 OUT refCur,
    curPgetBasket4 OUT refCur,
    curPgetBasket5 OUT refCur,
    curPgetBasket6 OUT refCur,
    curPgetBasket7 OUT refCur
    )
  AS
    dtLnullDate DATE := TO_DATE('01-01-1900','DD-MM-YYYY');
    iLShipmentUnitConst INT;
  BEGIN
  
  /* Attribute Info */
  OPEN curPgetBasket1 FOR
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
    ya_attribute_lang al
  WHERE pa.attribute_id = a.attribute_id
  AND pa.attribute_id = ale.attribute_id
  AND ale.lang_id = 1 /* English */
  AND pa.attribute_id = al.attribute_id
  AND al.lang_id = iPlangId
  AND pa.sku IN (
                SELECT sku
                FROM ya_new_basket
                WHERE shopper_id = cPshopperId
                AND site_id = iPsiteId
                AND type = iPtype
                )
  ORDER BY pa.sku, a.attribute_type_id;

  /* Limited Quantity */
  OPEN curPgetBasket2 FOR
  SELECT sku, 
  case when lmqnty < crqnty and lmqnty > 0 then lmqnty 
  when lmqnty > crqnty and crqnty = 0 then lmqnty 
  else crqnty end 
  FROM (
    SELECT
      nb.sku,  
      nvl(lq.frontend_quantity, 0) as lmqnty,
      nvl(cr.avlb_qnty, 0) as crqnty
    FROM
      ya_new_basket nb     
      INNER JOIN prod_region pr ON
        pr.prod_id = nb.sku
--      LEFT OUTER JOIN ya_limited_quantity lq on nb.sku = lq.sku and lq.frontend_quantity > 0 and lq.site_id in (99, pr.origin_id)
      LEFT OUTER JOIN ya_limited_quantity lq on (lq.site_id, lq.sku) in (
          select max(lq2.site_id), lq2.sku
          from ya_limited_quantity lq2
          where lq2.frontend_quantity > 0
            and lq2.site_id in (iPsiteId, 99)
          group by lq2.sku
        ) and nb.sku = lq.sku
      LEFT OUTER JOIN clearance cr on concat(nvl(pr.prefix,''), pr.prod_id) = cr.sku and cr.avlb_qnty > 0 and cr.sts = 1
    WHERE nb.shopper_id = cPshopperId
      AND nb.shopper_id <> '8a81844a2b805a4b012ba8cf4e0202ea'
      AND nb.site_id = iPsiteId
      AND nb.type = iPtype
      AND exists (
        select 1
        from prod_region prr
        inner join ya_region_mapping def on def.region_id = prr.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
          and prr.prod_id = pr2.prod_id
        left outer join prod_region pr3 on pr3.region_id = iPsiteId
          and prr.prod_id = pr3.prod_id
        where nb.sku = prr.prod_id
          and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
          and nb.site_id = def.site_id
      )
      AND (lq.frontend_quantity is not null or cr.avlb_qnty is not null)      
    ORDER BY nb.sku
  );

  /* Get shipment Unit */
  iLShipmentUnitConst := 200; /* in Grams */

  OPEN curPgetBasket3 FOR
  SELECT
    t1.sku,
    CAST(
         CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
         ELSE CEIL(NVL(t1.weight, iLShipmentUnitConst) / iLShipmentUnitConst)
         END AS int
         ) as shipment_unit
  FROM
    ya_product t1,
    ya_shipping_unit t2
  WHERE t1.sku = t2.sku(+)
  AND t2.site_id(+) = iPsiteId
  AND t1.sku IN
    (
      SELECT sku
      FROM ya_new_basket
      WHERE shopper_id = cPshopperId
      AND site_id = iPsiteId
      AND type = iPtype
    );

  /* inventory and Availability Info */
  OPEN curPgetBasket4 FOR
  SELECT
    pt.sku,
    -1,
    CASE
      WHEN pa.avlb = 0 THEN 99
      ELSE 0
    END,
    NVL(o.availability_id, pa.avlb),
    pa.is_in_stock
  FROM
    ya_new_basket pt
    INNER JOIN prod_avlb pa ON
      pa.prod_id = pt.sku
    INNER JOIN prod_region pr ON
      pa.prod_id = pr.prod_id
    INNER JOIN ya_product yp ON pt.sku = yp.sku
    LEFT OUTER JOIN ya_availability_override o ON
      pr.supplier_id = o.supplier_id
      AND SYSDATE() BETWEEN o.start_date AND o.end_date
      AND pa.avlb < o.availability_id
      AND yp.account_id = o.account_id   
    WHERE
      pt.shopper_id = cPshopperId
      AND pt.site_id = iPsiteId
      AND pt.type = iPtype
      AND exists (
        select 1
        from prod_avlb paa
        inner join ya_region_mapping def on def.region_id = paa.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_avlb pa2 on yrm.region_id = pa2.region_id 
          and paa.prod_id = pa2.prod_id
        left outer join prod_avlb pa3 on pa3.region_id = iPsiteId
          and paa.prod_id = pa3.prod_id
        where pa.prod_id = paa.prod_id
          and pa.region_id = nvl(nvl(pa2.region_id, pa3.region_id), paa.region_id)
          and pt.site_id = def.site_id
      )
      AND exists (
        select 1
        from prod_region prr
        inner join ya_region_mapping def on def.region_id = prr.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
          and prr.prod_id = pr2.prod_id
        left outer join prod_region pr3 on pr3.region_id = iPsiteId
          and prr.prod_id = pr3.prod_id
        where pr.prod_id = prr.prod_id
          and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
          and pt.site_id = def.site_id
      )
      ORDER BY pt.sku;

  /* Campaign Code */
  OPEN curPgetBasket5 FOR
  SELECT
    c.sku,
    c.campaign_code
  FROM
    ya_campaign c,
    ya_new_basket b
  WHERE c.sku = b.sku
  AND b.shopper_id = cPshopperId
  AND b.site_id = iPsiteId
  AND b.type = iPtype
  ORDER BY c.sku DESC;

  /* Product Information */
  OPEN curPgetBasket6 FOR
  SELECT
    b.sku,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(pr.is_preorder, 'N') AS preorder,
    NVL(pr.preorder_start, dtLnullDate) AS preorder_start,
    NVL(pr.preorder_end, dtLnullDate) AS preorder_end,
    NVL(pr.list_price, 9999) AS list_price,
    NVL(pr.sale_price, 9999) AS sale_price,
    NVL(pr.sale_price_start, dtLnullDate) AS sale_start,
    NVL(pr.sale_price_end, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name, ple.prod_name),
    NVL(p.release_date, dtLnullDate),
    null as name_img_loc,
    0 as name_img_width,
    0 as name_img_height,
    NVL(p.account_id, -1),
    NVL(pr.supplier_id, -1),
    NVL(pr.is_enabled, 'N'),
    NVL(pr.is_can_sell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    0 AS preorder_buffer_day,
    0 AS region_count,
    yr.currency,
    p.brand_id,
    cd.currency
  FROM
    ya_new_basket b
    INNER JOIN ya_product p ON
      b.sku = p.sku
    LEFT JOIN ya_prod_lang pl ON
      p.sku = pl.sku
      AND pl.lang_id = iPlangId
    LEFT JOIN ya_prod_lang ple ON
      p.sku = ple.sku
      AND ple.lang_id = 1 -- English
    INNER JOIN prod_region pr ON
      b.sku = pr.prod_id
    INNER JOIN ya_region yr ON
      yr.region_id = pr.region_id
    LEFT OUTER JOIN ya_checkout_data cd ON
      cd.shopper_id = b.shopper_id
      AND cd.site_id = b.site_id
  WHERE b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    AND p.is_prod_grp_parent = 'N'
    AND exists (
      select 1
      from prod_region prr
      inner join ya_region_mapping def on def.region_id = prr.region_id
        and def.country_id = -1
      left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
        and yrm.country_id <> -1 
        and yrm.country_id = iPcountryId
      left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
        and prr.prod_id = pr2.prod_id
      left outer join prod_region pr3 on pr3.region_id = iPsiteId
        and prr.prod_id = pr3.prod_id
      where pr.prod_id = prr.prod_id
        and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
        and b.site_id = def.site_id
    )
  ORDER BY b.created_datetime DESC, b.sku DESC;

  -- warranty item brought
  OPEN curPgetBasket7 for
  SELECT warrantee_sku, warranty_sku FROM
    ya_warranty_basket
  where
    shopper_id = cPshopperId
    AND site_id = iPsiteId;
  RETURN;
END GetBasketWithWarranty;

  PROCEDURE GetBasketYS (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPlangId IN INT,
    iPtype IN INT,
    iPcountryId IN INT DEFAULT -1,
    curPgetBasket7 OUT refCur,
    curPgetBasket1 OUT refCur,
    curPgetBasket2 OUT refCur,
    curPgetBasket3 OUT refCur,
    curPgetBasket4 OUT refCur,
    curPgetBasket5 OUT refCur,
    curPgetBasket6 OUT refCur
    )
  AS
    dtLnullDate DATE := TO_DATE('01-01-1900','DD-MM-YYYY');
    iLShipmentUnitConst INT;
    iLTypeId INT := 1;
  BEGIN
    IF iPsiteId = 12 THEN
      iLTypeId := 2;
    END IF;
    --Get Shopper Detail
	  Pkg_FE_ShopperAccess.GetShopperDataByShopperIdYS(
	    cPshopperId,iPsiteId, curPgetBasket7);
    /* Attribute Info */
    OPEN curPgetBasket1 FOR
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
      ya_attribute_lang al
    WHERE pa.attribute_id = a.attribute_id
    AND pa.attribute_id = ale.attribute_id
    AND ale.lang_id = 1 /* English */
    AND pa.attribute_id = al.attribute_id
    AND al.lang_id = iPlangId
    AND pa.sku IN (
                  SELECT sku
                  FROM ya_new_basket
                  WHERE shopper_id = cPshopperId
                  AND site_id = iPsiteId
                  AND type = iPtype
                  )
    ORDER BY pa.sku, a.attribute_type_id;

    /* Limited Quantity */
    OPEN curPgetBasket2 FOR
    SELECT sku, 
      case when lmqnty < crqnty and lmqnty > 0 then lmqnty 
      when lmqnty > crqnty and crqnty = 0 then lmqnty 
      else crqnty end 
    FROM (
      SELECT
        nb.sku,  
        nvl(lq.frontend_quantity, 0) as lmqnty,
        nvl(cr.avlb_qnty, 0) as crqnty
      FROM
        ya_new_basket nb     
        INNER JOIN prod_region pr ON pr.prod_id = nb.sku
--        LEFT OUTER JOIN ya_limited_quantity lq on nb.sku = lq.sku and lq.frontend_quantity > 0 and lq.site_id in (99, pr.origin_id)
        LEFT OUTER JOIN ya_limited_quantity lq on (lq.site_id, lq.sku) in (
            select max(lq2.site_id), lq2.sku
            from ya_limited_quantity lq2
            where lq2.frontend_quantity > 0
              and lq2.site_id in (iPsiteId, 99)
            group by lq2.sku
          ) and nb.sku = lq.sku
        LEFT OUTER JOIN clearance cr on concat(nvl(pr.prefix,''), pr.prod_id) = cr.sku and cr.avlb_qnty > 0 and cr.sts = 1
      WHERE nb.shopper_id = cPshopperId
        AND nb.shopper_id <> '8a81844a2b805a4b012ba8cf4e0202ea'
        AND nb.site_id = iPsiteId
        AND nb.type = iPtype
        AND (lq.frontend_quantity is not null or cr.avlb_qnty is not null)  
        AND exists (
          select 1
          from prod_region prr
          inner join ya_region_mapping def on def.region_id = prr.region_id
            and def.country_id = -1
          left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
            and yrm.country_id <> -1 
            and yrm.country_id = iPcountryId
          left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
            and prr.prod_id = pr2.prod_id
          left outer join prod_region pr3 on pr3.region_id = iPsiteId
            and prr.prod_id = pr3.prod_id
          where nb.sku = prr.prod_id
            and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
            and nb.site_id = def.site_id
        )
      ORDER BY nb.sku
    );    

    /* Get shipment Unit */
    iLShipmentUnitConst := 200; /* in Grams */

    OPEN curPgetBasket3 FOR
    SELECT
      t1.sku,
      CAST(
          CASE WHEN t2.shipment_unit IS NOT NULL THEN t2.shipment_unit
          ELSE CEIL(NVL(t1.weight, iLShipmentUnitConst) / iLShipmentUnitConst)
          END AS int
          ) as shipment_unit
    FROM
      ya_product t1,
      ya_shipping_unit t2
    WHERE t1.sku = t2.sku(+)
    AND t2.site_id(+) = iPsiteId
    AND t1.sku IN
      (
        SELECT sku
        FROM ya_new_basket
        WHERE shopper_id = cPshopperId
        AND site_id = iPsiteId
        AND type = iPtype
      );

    /* inventory and Availability Info */
    OPEN curPgetBasket4 FOR
    SELECT
      pt.sku,
      -1,
      CASE
        WHEN pa.avlb = 0 THEN 99
        ELSE 0
      END,
      NVL(o.availability_id, pa.avlb),
      pa.is_in_stock
    FROM
      ya_new_basket pt
      INNER JOIN prod_avlb pa ON 
        pt.sku = pa.prod_id
      INNER JOIN prod_region pr ON
        pa.prod_id = pr.prod_id
      INNER JOIN ya_product yp ON pt.sku = yp.sku
		  LEFT OUTER JOIN ya_availability_override o ON
        pr.supplier_id = o.supplier_id
        AND SYSDATE() BETWEEN o.start_date AND o.end_date
        AND pa.avlb < o.availability_id
        AND yp.account_id = o.account_id
    WHERE
      pt.shopper_id = cPshopperId
      AND pt.site_id = iPsiteId
      AND pt.type = iPtype
      AND exists (
        select 1
        from prod_avlb paa
        inner join ya_region_mapping def on def.region_id = paa.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_avlb pa2 on yrm.region_id = pa2.region_id 
          and paa.prod_id = pa2.prod_id
        left outer join prod_avlb pa3 on pa3.region_id = iPsiteId
          and paa.prod_id = pa3.prod_id
        where pa.prod_id = paa.prod_id
          and pa.region_id = nvl(nvl(pa2.region_id, pa3.region_id), paa.region_id)
          and pt.site_id = def.site_id
      )
      AND exists (
        select 1
        from prod_region prr
        inner join ya_region_mapping def on def.region_id = prr.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
          and prr.prod_id = pr2.prod_id
        left outer join prod_region pr3 on pr3.region_id = iPsiteId
          and prr.prod_id = pr3.prod_id
        where pr.prod_id = prr.prod_id
          and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
          and pt.site_id = def.site_id
      )
    ORDER BY pt.sku;

    /* Campaign Code */
    OPEN curPgetBasket5 FOR
    SELECT
      c.sku,
      c.campaign_code
    FROM
      ya_campaign c,
      ya_new_basket b
    WHERE c.sku = b.sku
    AND b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    ORDER BY c.sku DESC;


    /* Product Information */
    OPEN curPgetBasket6 FOR
    SELECT
      b.sku,
      b.quantity,
      p.cover_img_loc AS cover_img_loc,
      NVL(p.cover_img_width, 0) AS cover_img_width,
      NVL(p.cover_img_height, 0) AS cover_img_height,
      NVL(pr.is_preorder, 'N') AS preorder,
      NVL(pr.preorder_start, dtLnullDate) AS preorder_start,
      NVL(pr.preorder_end, dtLnullDate) AS preorder_end,
      NVL(pr.list_price, 9999) AS list_price,
      NVL(pr.sale_price, 9999) AS sale_price,
      NVL(pr.sale_price_start, dtLnullDate) AS sale_start,
      NVL(pr.sale_price_end, dtLnullDate) AS salePriceEnd,
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
      1 AS region_count,
      yr.currency,
      p.brand_id,
      cd.currency
    FROM
      ya_new_basket b
      INNER JOIN ya_product p ON
        b.sku = p.sku
      LEFT JOIN ya_prod_lang pl ON
        p.sku = pl.sku
        AND pl.lang_id = iPlangId
      LEFT JOIN ya_prod_lang ple ON
        p.sku = ple.sku
        AND ple.lang_id = 1 -- English
      INNER JOIN prod_region pr ON
        b.sku = pr.prod_id
      INNER JOIN ya_region yr ON
        pr.region_id = yr.region_id
      LEFT OUTER JOIN ya_checkout_data cd ON
        cd.shopper_id = b.shopper_id
        AND cd.site_id = b.site_id
    WHERE 
      b.shopper_id = cPshopperId
      AND b.site_id = iPsiteId
      AND b.type = iPtype
      AND p.is_prod_grp_parent = 'N'
      AND exists (
        select 1
        from prod_region prr
        inner join ya_region_mapping def on def.region_id = prr.region_id
          and def.country_id = -1
        left outer join ya_region_mapping yrm on def.site_id = yrm.site_id 
          and yrm.country_id <> -1 
          and yrm.country_id = iPcountryId
        left outer join prod_region pr2 on yrm.region_id = pr2.region_id 
          and prr.prod_id = pr2.prod_id
        left outer join prod_region pr3 on pr3.region_id = iPsiteId
          and prr.prod_id = pr3.prod_id
        where pr.prod_id = prr.prod_id
          and pr.region_id = nvl(nvl(pr2.region_id, pr3.region_id), prr.region_id)
          and b.site_id = def.site_id
      )
    ORDER BY b.created_datetime DESC, b.sku DESC;

    RETURN;

  END GetBasketYS;


  PROCEDURE TransferBasket (
    cPfromShopperId IN CHAR,
    cPtoShopperId IN CHAR,
    iPsiteId IN INT
  )
  AS
    iLtemp INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp
    FROM ya_new_basket
    WHERE
      shopper_id = cPfromShopperId
      AND site_id = iPsiteId;

    IF iLtemp > 0 THEN
      BEGIN
        DELETE FROM ya_new_basket
        WHERE
          shopper_id = cPtoShopperId
          AND site_id = iPsiteId;

        DELETE FROM ya_warranty_basket
        WHERE
          shopper_id = cPtoShopperId
          AND site_id = iPsiteId;

        UPDATE ya_new_basket
        SET shopper_id = cPtoShopperId
        WHERE
          shopper_id = cPfromShopperId
          AND site_id = iPsiteId;

        UPDATE ya_warranty_basket
        SET shopper_id = cPtoShopperId
        WHERE
          shopper_id = cPfromShopperId
          AND site_id = iPsiteId;
      END;
    END IF;
    COMMIT;
  END TransferBasket;

  PROCEDURE FlyBasket (
    cPshopperId IN CHAR,
    iPfromSiteId IN INT,
    iPtoSiteId IN INT
  )
  AS
  BEGIN
    DELETE FROM ya_new_basket
    WHERE shopper_id = cPshopperId
    AND site_id = iPtoSiteId;

    DELETE FROM ya_warranty_basket
    WHERE shopper_id = cPshopperId
    AND site_id = iPtoSiteId;

    UPDATE ya_new_basket SET site_id = iPtoSiteId
    WHERE shopper_id = cPshopperId
    AND site_id = iPfromSiteId;

    UPDATE ya_warranty_basket
    SET site_id = iPtoSiteId
    WHERE shopper_id = cPshopperId
    AND site_id = iPfromSiteId;

    COMMIT;
  END FlyBasket;




  -- proc_fe_GetBasketCrossSellingProduct
  PROCEDURE GetBasketCSProductBase ( -- CrossSelling Product Base
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
    iPlang_id IN INT,
    iPtype IN INT,
    ipcountry_id in int,
    iPsectionId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  )
  AS
    dtLnull_date DATE;
    dtLcurrent_date DATE;
    iLlast_sku INT;
  BEGIN
    dtLnull_date := TO_DATE('01-01-1900','DD-MM-YYYY');
    dtLcurrent_date := SYSDATE;

    BEGIN
      SELECT sku
      INTO iLlast_sku
      FROM
        (
          SELECT sku
          FROM
            ya_new_basket b
          WHERE
            b.shopper_id = cPshopper_id
            AND b.site_id = iPsite_id
            AND b.type = iPtype
          ORDER BY b.created_datetime DESC, b.sku DESC
        )
      WHERE ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLlast_sku := NULL;
    END;
    
    -- promotiON bundle, aka OnePlusOne, Double Deal
    OPEN curPresult1 FOR
    SELECT
      bpr.prod_id,
      p.cover_img_loc,
      NVL(p.cover_img_width, 0) AS cover_img_width,
      NVL(p.cover_img_height, 0) AS cover_img_height,
      NVL(bpr.is_preorder, 'N') AS preorder,
      NVL(bpr.preorder_start, dtLnull_date) AS preorder_start,
      NVL(bpr.preorder_end, dtLnull_date) AS preorder_end,
      NVL(bpr.list_price, 9999) AS list_price,
      NVL(bpr.sale_price, 9999) AS sale_price,
      NVL(bpr.sale_price_start, dtLnull_date) AS sale_start,
      NVL(bpr.sale_price_end, dtLnull_date) AS salepriceend,
      NVL(p.release_date, dtLnull_date),
      NVL(p.account_id, -1),
      NVL(bpr.supplier_id, -1),
      NVL(bpr.is_enabled, 'N'),
      NVL(bpr.is_can_sell, 'N'),
      0 AS preorder_buffer_day,
      NVL(o.availability_id, bpa.avlb),
      NVL(p.country_release_id, -1),
      NVL(bpr.preorder_deadline, dtLnull_date) AS preorder_date, --20
      rm.currency, p.brand_id
    FROM
      (
        SELECT *
        FROM
          (
            SELECT *
            FROM ya_new_basket b
            WHERE
              b.shopper_id = cPshopper_id
              AND b.site_id = iPsite_id
              AND b.type = iPtype
            ORDER BY b.created_datetime DESC
          )
        WHERE ROWNUM = 1
      ) b
      INNER JOIN ya_promotion_bundle pb ON
        pb.site_id = b.site_id
        AND (pb.sku = b.sku OR pb.partner_sku = b.sku)
      INNER JOIN
        (
          SELECT bpr_i.*
          FROM
            prod_region bpr_i,
            ya_promotion_bundle pb_i
          WHERE
            pb_i.site_id = iPsite_id
            AND (pb_i.sku = iLlast_sku OR pb_i.partner_sku = iLlast_sku)
            AND bpr_i.category_id = 1
            AND bpr_i.origin_id = pb_i.site_id
            AND bpr_i.prod_id <> iLlast_sku
            AND (bpr_i.prod_id = pb_i.partner_sku OR bpr_i.prod_id = pb_i.sku)
        ) bpr ON
          bpr.prod_id <> b.sku
          AND (bpr.prod_id = pb.partner_sku OR bpr.prod_id = pb.sku)
      INNER JOIN
        (
          select pa2.prod_id, nvl(rm.region_id, pa2.origin_id) as region_id         
          from prod_region pa2
            left outer join
            (
              select rm.region_id, rm.origin_id, rm.category
              from ya_region_mapping rm
              where country_id = ipcountry_id
            ) rm on pa2.origin_id = rm.origin_id and exists( select 1 from prod_region pr2 where rm.region_id = pr2.region_id and pr2.prod_id = pa2.prod_id )
            and pa2.category_id = rm.category
          where pa2.origin_id = iPsite_id
            and pa2.category_id = 1
            and pa2.region_id = pa2.origin_id
        ) t ON
          bpr.prod_id = t.prod_id
          AND bpr.region_id = t.region_id
      INNER JOIN prod_avlb bpa ON
        bpa.prod_id = bpr.prod_id
        AND bpa.origin_id = b.site_id
        AND bpa.category = 1
        AND bpa.region_id = bpr.region_id
      INNER JOIN ya_product p ON
        p.sku = bpa.prod_id
      LEFT JOIN ya_availability_override o ON
        bpr.supplier_id = o.supplier_id
        AND dtLcurrent_date BETWEEN o.start_date
        AND o.end_date
        AND bpa.avlb < o.availability_id
        AND p.account_id = o.account_id
      INNER JOIN ya_region rm ON bpr.region_id = rm.region_id
    WHERE
      bpr.is_can_sell = 'Y'
      AND dtLcurrent_date -- ya_promotion_bundle
        BETWEEN NVL(pb.start_date, dtLcurrent_date) AND NVL(pb.end_date, dtLcurrent_date)
      AND NVL(o.availability_id, bpa.avlb) < 60;

    OPEN curPresult2 FOR
    -- cross selling
    SELECT *
    FROM
      (
        SELECT
          bpr.prod_id,--0
          p.cover_img_loc AS cover_img_loc,
          NVL(p.cover_img_width, 0) AS cover_img_width,
          NVL(p.cover_img_height, 0) AS cover_img_height,
          NVL(bpr.is_preorder, 'N') AS preorder,
          NVL(bpr.preorder_start, dtLnull_date) AS preorder_start, --5
          NVL(bpr.preorder_end, dtLnull_date) AS preorder_end,
          NVL(bpr.list_price, 9999) AS list_price,
          NVL(bpr.sale_price, 9999) AS sale_price,
          NVL(bpr.sale_price_start, dtLnull_date) AS sale_start,
          NVL(bpr.sale_price_end, dtLnull_date) AS salepriceend, --10
          NVL(p.release_date, dtLnull_date),
          NVL(p.account_id, -1),
          NVL(bpr.supplier_id, -1),
          NVL(bpr.is_enabled, 'N'),
          NVL(bpr.is_can_sell, 'N'), -- 15
          0 AS preorder_buffer_day,
          NVL(o.availability_id, bpa.avlb),
          NVL(p.country_release_id, -1),
          NVL(bpr.preorder_deadline, dtLnull_date) AS preorder_date, --20
          rm.currency, p.brand_id
        FROM
          (
            SELECT *
            FROM
              (
                SELECT *
                FROM ya_new_basket nb
                WHERE
                  nb.shopper_id = cPshopper_id
                  AND nb.site_id = iPsite_id
                  AND nb.type = iPtype
                ORDER BY nb.created_datetime DESC
              )
            WHERE ROWNUM = 1
          ) b
          INNER JOIN dm_crosssell_product cs ON
            cs.productid = b.sku
            AND cs.originId = iPsite_id
            AND cs.fesectionId =
              CASE
                WHEN iPsectionId = 0 THEN cs.fesectionId --sectionId=0 means all sections
                ELSE iPsectionId
              END
          INNER JOIN
            (
              SELECT
                cs_i.crossSellProductId related_sku, cs_i.originId
              FROM
                dm_crosssell_product cs_i
              WHERE
                cs_i.productid = iLlast_sku
                AND cs_i.fesectionId =
                  case
                    WHEN iPsectionId = 0 THEN cs_i.fesectionId --sectionId=0 means all sections
                    ELSE iPsectionId
                  END
              GROUP BY cs_i.crossSellProductId, cs_i.originId
            ) tmp_pr ON
            tmp_pr.related_sku = cs.crossSellProductId
            AND tmp_pr.originId = iPsite_id
          INNER JOIN prod_region bpr ON
            bpr.category_id = 1
            AND bpr.origin_id = iPsite_id
            AND bpr.prod_id = cs.crossSellProductId
            AND bpr.prod_id = tmp_pr.related_sku
          INNER JOIN prod_avlb bpa ON
            bpa.prod_id = bpr.prod_id
            AND bpa.origin_id = bpr.origin_id
            AND bpa.region_id = bpr.region_id
            AND bpa.category = bpr.category_id
          INNER JOIN
            (
              select pa2.prod_id, nvl(rm.region_id, pa2.origin_id) as region_id         
              from prod_region pa2
                left outer join
                (
                  select rm.region_id, rm.origin_id, rm.category
                  from ya_region_mapping rm
                  where country_id = ipcountry_id
                ) rm on pa2.origin_id = rm.origin_id and exists( select 1 from prod_region pr2 where rm.region_id = pr2.region_id and pr2.prod_id = pa2.prod_id )
                and pa2.category_id = rm.category
              where pa2.origin_id = iPsite_id
                and pa2.category_id = 1
                and pa2.region_id = pa2.origin_id            
            ) t ON
              bpr.prod_id = t.prod_id
              AND bpr.region_id = t.region_id    
          INNER JOIN ya_product p ON
            p.sku = bpa.prod_id                              
          LEFT JOIN ya_availability_override o ON
            bpr.supplier_id = o.supplier_id
            AND dtLcurrent_date BETWEEN o.start_date AND o.end_date
            AND bpa.avlb < o.availability_id
            AND p.account_id = o.account_id
          INNER JOIN ya_region rm ON bpr.region_id = rm.region_id
        WHERE
          bpr.is_can_sell = 'Y'
          AND NVL(o.availability_id, bpa.avlb) < 60
        ORDER BY cs.rank ASC, cs.crossSellProductId DESC
      )
    WHERE ROWNUM < 4;

    RETURN;
  END GetBasketCSProductBase;

  PROCEDURE GetBasketCSProductDetail (
    iPlang_id IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
    iPsku1 IN INT DEFAULT NULL,
    iPsku2 IN INT DEFAULT NULL,
    iPsku3 IN INT DEFAULT NULL,
    iPsku4 IN INT DEFAULT NULL,
    iPsku5 IN INT DEFAULT NULL,
    iPsku6 IN INT DEFAULT NULL,
    iPsku7 IN INT DEFAULT NULL,
    iPsku8 IN INT DEFAULT NULL,
    iPsku9 IN INT DEFAULT NULL,
    iPsku10 IN INT DEFAULT NULL,
    iPsku11 IN INT DEFAULT NULL,
    iPsku12 IN INT DEFAULT NULL,
    iPsku13 IN INT DEFAULT NULL,
    iPsku14 IN INT DEFAULT NULL,
    iPsku15 IN INT DEFAULT NULL,
    iPsku16 IN INT DEFAULT NULL,
    iPsku17 IN INT DEFAULT NULL,
    iPsku18 IN INT DEFAULT NULL,
    iPsku19 IN INT DEFAULT NULL,
    iPsku20 IN INT DEFAULT NULL
  )
  AS
    dtLnull_date DATE;
  BEGIN
    dtLnull_date := TO_DATE('01-01-1900','DD-MM-YYYY');

    -- product name, subtitles, prod_name_aka, prod_subtitle_aka
    OPEN curPresult1 FOR
    SELECT
      NVL(pl.prod_name, ple.prod_name)
      , NVL(pl.prod_subtitle, ple.prod_subtitle)
      , NVL(pl.prod_name_aka, ple.prod_name_aka)
      , NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka)
      , NVL(pl.prod_series_title, ple.prod_series_title)
      , NVL(pl.prod_series_volume, ple.prod_series_volume)-- 5
      , NVL(pl.prod_title_volume, ple.prod_title_volume)
      , ple.prod_name
      , pl.sku -- 8
    FROM
      ya_prod_lang pl
      LEFT OUTER JOIN ya_prod_lang ple ON
        ple.sku = pl.sku
        AND ple.lang_id = 1 -- always English
    WHERE
      pl.lang_id = iPlang_id
      AND pl.sku IN
        (
          iPsku1,
          iPsku2,
          iPsku3,
          iPsku4,
          iPsku5,
          iPsku6,
          iPsku7,
          iPsku8,
          iPsku9,
          iPsku10,
          iPsku11,
          iPsku12,
          iPsku13,
          iPsku14,
          iPsku15,
          iPsku16,
          iPsku17,
          iPsku18,
          iPsku19,
          iPsku20
        );


    OPEN curPresult2 FOR
    -- return the roles of a artist for a product
    -- get artist info by proc_bo_GetArtistAttributeInfo
    SELECT
      pa.artist_id -- 0
      , 'Y' as show_in_browse
      , ar.description
      , al.firstname_u
      , al.lastname_u
      , al.akaname_u
      , ale.firstname_u
      , ale.lastname_u
      , ale.akaname_u
      , NVL(a.origin_country_id, 0)
      , al.prefix --10
      , al.suffix
      , ale.prefix
      , ale.suffix
      , pa.sku --18
    FROM
      ya_product_artist pa
      INNER JOIN ya_artist a ON
        a.artist_id  = pa.artist_id
      LEFT OUTER JOIN ya_artist_rel ar ON
        pa.rel_id = ar.rel_id
        AND ar.lang_id = iPlang_id
      LEFT OUTER JOIN ya_artist_lang al ON
        pa.artist_id = al.artist_id
        AND al.lang_id = iPlang_id
      LEFT OUTER JOIN ya_artist_lang ale ON
        pa.artist_id = ale.artist_id
        AND ale.lang_id = 1 -- always English
    WHERE pa.sku IN
      (
        iPsku1,
        iPsku2,
        iPsku3,
        iPsku4,
        iPsku5,
        iPsku6,
        iPsku7,
        iPsku8,
        iPsku9,
        iPsku10,
        iPsku11,
        iPsku12,
        iPsku13,
        iPsku14,
        iPsku15,
        iPsku16,
        iPsku17,
        iPsku18,
        iPsku19,
        iPsku20
      )
    ORDER BY pa.rel_ranking;

    RETURN;
  END GetBasketCSProductDetail;

 PROCEDURE AddWarrantyItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPwarranteeSku IN INT,
    iPwarrantySku IN INT
  )
  AS
    iLrecExist INT;
  BEGIN
    BEGIN
     SELECT
        site_id INTO iLrecExist
      FROM
        ya_warranty_basket
      WHERE
        shopper_id = cPshopperId
        AND site_id = iPsiteId
        AND warrantee_sku = iPwarranteeSku;

      EXCEPTION when NO_DATA_FOUND THEN
        iLrecExist := NULL;
    END;

    IF iLrecExist IS NULL THEN
      BEGIN
        INSERT INTO
          ya_warranty_basket
          (shopper_id, site_id, warrantee_sku, warranty_sku)
        VALUES
          (cPshopperId, iPsiteId, iPwarranteesku, iPwarrantySku);
      END;
    ELSE
      BEGIN
        UPDATE
          ya_warranty_basket
        SET
          warranty_sku = iPwarrantySku
        WHERE
          shopper_id = cPshopperId
          AND site_id = iPsiteId
          AND warrantee_sku = iPwarranteeSku;
      END;
    END IF;

    COMMIT;
  END AddWarrantyItem;

  PROCEDURE DeleteWarrantyItem (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    iPwarranteeSku IN INT,
    iPwarrantySku IN INT
  )
  AS
  BEGIN
    DELETE FROM
      ya_warranty_basket
    WHERE
      shopper_id = cPshopperId
      AND site_id = iPsiteId
      AND warrantee_sku = iPwarranteeSku
      AND warranty_sku = iPwarrantySku;

    COMMIT;
  END DeleteWarrantyItem;
-- +--- Body
END Pkg_fe_BasketAccess2;
/
 