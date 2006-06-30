CREATE OR REPLACE PACKAGE Pkg_fe_BasketAccess
AS
  TYPE refCur IS REF CURSOR;

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

  PROCEDURE GetBasket (
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
END Pkg_fe_BasketAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_BasketAccess
IS
-- Body ---+
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
  iLsql VARCHAR2(500);
BEGIN
  iLsql := 'DELETE FROM ya_new_basket WHERE shopper_id = '''|| cPshopperId
    ||''' AND site_id = '|| CAST(iPsiteId AS nvarchar2)
    ||' AND type = '|| CAST(iPtype AS NVARCHAR2)
    ||' AND sku in (' ||cPskuCSV||')';

  execute immediate iLsql;
  /*
  DELETE FROM ya_new_basket
  WHERE shopper_id = cPshopperId
  AND site_id = iPsiteId
  AND type = iPtype
  AND sku in (cPskuCSV);

  EXCEPTION WHEN NO_DATA_FOUND THEN ROLLBACK;
  WHEN OTHERS THEN ROLLBACK;
  */
  COMMIT;
--  EXCEPTION WHEN others THEN ROLLBACK;
END;


  PROCEDURE GetBasket (
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
    curPgetBasket6 OUT refCur
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
  SELECT
    lq.sku,
    lq.frontend_quantity
  FROM
    ya_limited_quantity lq,
    ya_new_basket b
  WHERE lq.sku = b.sku
  AND b.shopper_id = cPshopperId
  AND b.site_id = iPsiteId
  AND b.type = iPtype
  AND lq.site_id in (99, iPSiteId)
  AND lq.frontend_quantity > 0
  ORDER BY lq.sku;

  /* Get Shipment Unit */
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

  /* Inventory and Availability Info */
    IF iPcountryId = -1 THEN
      BEGIN
        OPEN curPgetBasket4 FOR
        SELECT
          p.sku,
          -1,
          CASE
            WHEN pa.availability = 0 THEN 99
            ELSE 0
          END,
          cast(nvl(o.availability_id, pa.availability) as int)
        FROM
          ya_new_basket pt
          INNER JOIN ya_product p ON
            pt.sku = p.sku
          INNER JOIN backend_adm.productavailability pa ON p.sku = pa.productid
          INNER JOIN backend_adm.productRegion r ON
            pt.sku = r.productId
            AND r.regionId = iPsiteId
            AND pa.productid = r.productid
            AND pa.regionid = r.regionid
		  LEFT OUTER JOIN ya_availability_override o ON r.supplierid = o.supplier_id
            AND p.account_id = o.account_id AND SYSDATE() BETWEEN o.start_date AND o.end_date
            AND pa.availability < o.availability_id
          INNER JOIN
            (
              SELECT rp.productId productId, MIN(SEQUENCE) seq
              FROM backend_adm.productRegion rp
              inner join ya_new_basket b on
                (
                  rp.productID = b.sku
                  and b.shopper_id = cPshopperId
                  and b.site_id = iPsiteid
                  and b.type = iPtype
                )
              WHERE
                --default country ID
                rp.regionId = iPsiteId
              GROUP BY rp.productId
            ) t ON
            r.productId = t.productId
            AND r.sequence = t.seq
        WHERE
          pt.shopper_id = cPshopperId
          AND pa.regionId = iPsiteId
        ORDER BY p.sku;
      END;
    ELSE
      BEGIN
        OPEN curPgetBasket4 FOR
        SELECT
          p.sku,
          -1,
          CASE
            WHEN pa.availability = 0 THEN 99
            ELSE 0
          END,
          NVL(o.availability_id, pa.availability)
        FROM
          ya_new_basket pt
          INNER JOIN ya_product p ON pt.sku = p.sku
          INNER JOIN backend_adm.productavailability pa ON p.sku = pa.productid
          INNER JOIN backend_adm.productRegion r ON
            pt.sku = r.productId
            AND r.regionId = iPsiteId
            AND pa.productid = r.productid
            AND pa.regionid = r.regionid
		  LEFT OUTER JOIN ya_availability_override o ON
            r.supplierid = o.supplier_id
            AND p.account_id = o.account_id
            AND SYSDATE() BETWEEN o.start_date AND o.end_date
            AND pa.availability < o.availability_id
          INNER JOIN
            (
              SELECT
                rp.productId productId,
                MAX(SEQUENCE) seq
              FROM ya_country_region_rel rl
              INNER JOIN backend_adm.productRegion rp ON
                rl.region_id = rp.regionId
              INNER JOIN ya_new_basket b ON
                rp.productID = b.sku
                AND b.shopper_id = cPshopperId
                AND b.site_id = iPsiteid
                AND b.type = iPtype
              WHERE
                rl.country_id = iPcountryId
                AND rp.regionId = iPsiteId
              GROUP BY rp.productId
            ) t ON
              r.productId = t.productId
              AND r.sequence = t.seq
          WHERE
            pt.shopper_id = cPshopperId
            AND pa.regionId = iPsiteId
          ORDER BY p.sku;

      END;
    END IF;



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
    r.productId,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(r.preorder, 'N') AS preorder,
    NVL(r.preorderStart, dtLnullDate) AS preorder_start,
    NVL(r.preorderEnd, dtLnullDate) AS preorder_end,
    NVL(r.listPrice, 9999) AS list_price,
    NVL(r.salePrice, 9999) AS sale_price,
    NVL(r.salePriceStart, dtLnullDate) AS sale_start,
    NVL(r.salePriceEnd, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name_u, ple.prod_name_u),
    NVL(p.release_date, dtLnullDate),
    plp.prod_name_img_loc,
    NVL(plp.name_img_width, 0),
    NVL(plp.name_img_height, 0),
    NVL(p.account_id, -1),
    NVL(r.supplierId, -1),
    NVL(r.enable, 'N'),
    NVL(r.canSell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    NVL(r.preorderBufferDay, -1) AS preorder_buffer_day,
    t.regionCount
  FROM
    ya_new_basket b
    INNER JOIN ya_product p ON
      b.sku = p.sku AND type = iPtype
    LEFT JOIN ya_prod_lang pl ON
      p.sku = pl.sku
      AND pl.lang_id = iPlangId
    LEFT JOIN ya_prod_lang plp ON
      p.sku = plp.sku
      AND plp.lang_id IN -- prefered lang
        (
          SELECT lang_id
          FROM ya_prod_lang
          WHERE
            sku = plp.sku
            AND preferred_flag='Y'
            AND ROWNUM = 1
        )
      LEFT JOIN ya_prod_lang ple ON
        p.sku = ple.sku
        AND ple.lang_id = 1 -- English
      INNER JOIN backend_adm.productRegion r ON
        b.sku = r.productId
      INNER JOIN
        (
          SELECT
            s.productId productId,
            s.seq seq,
            t.regionCount regionCount
          FROM
            (
              SELECT
                rp.productId productId,
                MAX(SEQUENCE) seq
              FROM
                ya_country_region_rel rl
                INNER JOIN backend_adm.productRegion rp ON
                  rl.region_id = rp.regionId
                INNER JOIN ya_new_basket b ON
                  rp.productID = b.sku
                  AND b.shopper_id = cPshopperId
                  AND b.site_id = iPsiteid
                  ANd b.type = iPtype
              WHERE
                iPcountryId <> -1
                AND rl.country_id = iPcountryId
                AND rp.originId = iPsiteId
                AND categoryID = 1
              GROUP BY rp.productId
            ) s
            INNER JOIN
              (
                SELECT
                  rp.productId productId,
                  COUNT(rp.productId) regionCount
                FROM
                  backend_adm.productRegion rp
                  INNER JOIN ya_new_basket b ON
                    rp.productID = b.sku
                    AND b.shopper_id = cPshopperId
                    AND b.site_id = iPsiteid
                    AND b.type = iPtype
                WHERE
                  --default country ID
                  iPcountryId <> -1
                  AND rp.originId = iPsiteId
                  AND categoryID = 1
                GROUP BY rp.productId
              ) t ON
              s.productId = t.productId
            UNION
            SELECT
              rp.productId productId,
              MIN(SEQUENCE) seq,
              COUNT(rp.productId) regionCount
            FROM
              backend_adm.productRegion rp
              INNER JOIN ya_new_basket b ON
                rp.productID = b.sku
                AND b.shopper_id = cPshopperId
                AND b.site_id = iPsiteid
                AND b.type = iPtype
            WHERE
              --default country ID
              iPcountryId = -1
              AND rp.originId = iPsiteId
              AND categoryID = 1
            GROUP BY rp.productId
      ) t ON
    r.productId = t.productId
    AND r.sequence = t.seq
  WHERE categoryID = 1 --not wholesale
    AND originId = iPsiteId
    AND b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    AND p.is_parent = 'N'
  ORDER BY b.created_datetime DESC, b.sku DESC;

  /*
  SELECT
    r.productId,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(r.preorder, 'N') AS preorder,
    NVL(r.preorderStart, dtLnullDate) AS preorder_start,
    NVL(r.preorderEnd, dtLnullDate) AS preorder_end,
    NVL(r.listPrice, 9999) AS list_price,
    NVL(r.salePrice, 9999) AS sale_price,
    NVL(r.salePriceStart, dtLnullDate) AS sale_start,
    NVL(r.salePriceEnd, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name_u, ple.prod_name_u),
    NVL(p.release_date, dtLnullDate),
    plp.prod_name_img_loc,
    NVL(plp.name_img_width, 0),
    NVL(plp.name_img_height, 0),
    NVL(p.account_id, -1),
    NVL(r.supplierId, -1),
    NVL(r.enable, 'N'),
    NVL(r.canSell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    NVL(r.preorderBufferDay, -1) AS preorder_buffer_day,
    t.regionCount
  FROM
    ya_new_basket b
    INNER JOIN ya_product p ON
       b.sku = p.sku
    LEFT OUTER JOIN ya_prod_lang pl ON
      p.sku = pl.sku
      AND pl.lang_id = iPlangId
    LEFT OUTER JOIN ya_prod_lang ple ON
      p.sku = ple.sku
      AND ple.lang_id = 1
    LEFT OUTER JOIN
      (
        SELECT ypl1.*
        FROM
          ya_prod_lang ypl1,
          (
            SELECT
              ypl.sku,
              MIN(ypl.lang_id) lang_id
            FROM
              ya_prod_lang ypl,
              ya_new_basket yb
            WHERE
              ypl.preferred_flag = 'Y'
              AND ypl.sku = yb.sku
              AND yb.shopper_id = cPshopperId
            GROUP BY ypl.sku
          ) ypl2
        WHERE
          ypl1.sku = ypl2.sku
          AND ypl1.lang_id = ypl2.lang_id
      ) plp ON
      p.sku = plp.sku
    INNER JOIN productRegion r ON
      b.sku = r.productId
    INNER JOIN
      (
        SELECT
          rp.productId productId,
          MAX(rp.sequence) seq,
          COUNT(rp.productId) regionCount
        FROM
          ya_country_region_rel rl,
          productRegion rp,
          ya_new_basket b
        WHERE 1=1
          AND rl.country_id = iPcountryId
          AND rp.productID = b.sku
          AND b.shopper_id = cPshopperId
          AND b.site_id = iPsiteId
          AND b.type = iPtype
          AND rl.region_id = rp.regionId
          AND iPcountryId <> -1
          AND rp.originId = 1
          AND rp.categoryID = 1
        GROUP BY rp.productId
        UNION
        SELECT
          rp.productId productId,
          MIN(SEQUENCE) seq,
          COUNT(rp.productId) regionCount
        FROM
          productRegion rp,
          ya_new_basket b
        WHERE
          1=1
          AND rp.productID = b.sku
          AND b.shopper_id = cPshopperId
          AND b.site_id = iPsiteId
          AND b.type = iPtype
          AND iPcountryId = -1
          AND rp.originId = 1
          AND categoryID = 1
        GROUP BY rp.productId
      ) t ON
      r.productId = t.productId
      AND r.sequence = t.seq
  WHERE
    1=1
--    AND r.productId = t.productId
--    AND r.sequence = t.seq
--    AND b.sku = r.productId
    AND r.categoryID = 1 --not wholesale
    AND r.originId = 1
--    AND b.sku = p.sku
    AND b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    AND p.is_parent = 'N'
--    AND p.sku = pl.sku (+)
--    AND (pl.lang_id = iPlangId or pl.lang_id is null) -- pass
--    AND p.sku = ple.sku (+)
--    AND (ple.lang_id = 1 or ple.lang_id is null)
--    AND p.sku = plp.sku (+)

--    AND pl.sku = ple.sku
  ORDER BY b.created_datetime DESC;
*/
  /*
  SELECT
    r.productId,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(r.preorder, 'N') AS preorder,
    NVL(r.preorderStart, dtLnullDate) AS preorder_start,
    NVL(r.preorderEnd, dtLnullDate) AS preorder_end,
    NVL(r.listPrice, 9999) AS list_price,
    NVL(r.salePrice, 9999) AS sale_price,
    NVL(r.salePriceStart, dtLnullDate) AS sale_start,
    NVL(r.salePriceEnd, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name_u, ple.prod_name_u),
    NVL(p.release_date, dtLnullDate),
    plp.prod_name_img_loc,
    NVL(plp.name_img_width, 0),
    NVL(plp.name_img_height, 0),
    NVL(p.account_id, -1),
    NVL(r.supplierId, -1),
    NVL(r.enable, 'N'),
    NVL(r.canSell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    NVL(r.preorderBufferDay, -1) AS preorder_buffer_day,
    t.regionCount
  FROM
    ya_new_basket b,
    ya_product p,
    ya_prod_lang pl,
    ya_prod_lang ple,
    (
      SELECT ypl1.*
      FROM
        ya_prod_lang ypl1,
        (
          SELECT
            ypl.sku,
            MIN(ypl.lang_id) lang_id
          FROM
            ya_prod_lang ypl,
            ya_new_basket yb
          WHERE
            ypl.preferred_flag = 'Y'
            AND ypl.sku = yb.sku
            AND yb.shopper_id = cPshopperId
          GROUP BY ypl.sku
        ) ypl2
      WHERE
        ypl1.sku = ypl2.sku
        AND ypl1.lang_id = ypl2.lang_id
    ) plp,
    productRegion r,
    (
      SELECT
        rp.productId productId,
        MAX(rp.sequence) seq,
        COUNT(rp.productId) regionCount
      FROM
        ya_country_region_rel rl,
        productRegion rp,
        ya_new_basket b
      WHERE 1=1
        AND rl.country_id = iPcountryId
        AND rp.productID = b.sku
        AND b.shopper_id = cPshopperId
        AND b.site_id = iPsiteId
        AND b.type = iPtype
        AND rl.region_id = rp.regionId
        AND iPcountryId <> -1
        AND rp.originId = 1
        AND rp.categoryID = 1
      GROUP BY rp.productId
      UNION
      SELECT
        rp.productId productId,
        MIN(SEQUENCE) seq,
        COUNT(rp.productId) regionCount
      FROM
        productRegion rp,
        ya_new_basket b
      WHERE
        1=1
        AND rp.productID = b.sku
        AND b.shopper_id = cPshopperId
        AND b.site_id = iPsiteId
        AND b.type = iPtype
        AND iPcountryId = -1
        AND rp.originId = 1
        AND categoryID = 1
      GROUP BY rp.productId
    ) t
  WHERE
    1=1
    AND r.productId = t.productId
    AND r.sequence = t.seq
    AND b.sku = r.productId
    AND r.categoryID = 1 --not wholesale
    AND r.originId = 1
    AND b.sku = p.sku
    AND b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    AND p.is_parent = 'N'
    AND p.sku = pl.sku (+)
    AND (pl.lang_id = iPlangId or pl.lang_id is null) -- pass
    AND p.sku = ple.sku (+)
    AND (ple.lang_id = 1 or ple.lang_id is null)
    AND p.sku = plp.sku (+)
    AND pl.sku = ple.sku
  ORDER BY b.created_datetime DESC;
  */
  /*
  SELECT
    r.productId,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(r.preorder, 'N') AS preorder,
    NVL(r.preorderStart, dtLnullDate) AS preorder_start,
    NVL(r.preorderEnd, dtLnullDate) AS preorder_end,
    NVL(r.listPrice, 9999) AS list_price,
    NVL(r.salePrice, 9999) AS sale_price,
    NVL(r.salePriceStart, dtLnullDate) AS sale_start,
    NVL(r.salePriceEnd, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name_u, ple.prod_name_u),
    NVL(p.release_date, dtLnullDate),
    plp.prod_name_img_loc,
    NVL(plp.name_img_width, 0),
    NVL(plp.name_img_height, 0),
    NVL(p.account_id, -1),
    NVL(r.supplierId, -1),
    NVL(r.enable, 'N'),
    NVL(r.canSell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    NVL(r.preorderBufferDay, -1) AS preorder_buffer_day,
    t.regionCount
  FROM
    ya_new_basket b,
    ya_product p,
    ya_prod_lang pl,
    ya_prod_lang ple,
    ya_prod_lang plp,
    productRegion r,
    (
      SELECT
        rp.productId productId,
        MAX(rp.sequence) seq,
        COUNT(rp.productId) regionCount
      FROM
        ya_country_region_rel rl,
        productRegion rp,
        ya_new_basket b
      WHERE
        1=1
        AND rl.country_id = iPcountryId
        AND rp.productID = b.sku
        AND b.shopper_id = cPshopperId
        AND b.site_id = iPsiteId
        AND b.type = iPtype
        AND rl.region_id = rp.regionId
        AND iPcountryId <> -1
        AND rp.originId = 1
        AND rp.categoryID = 1
      GROUP BY rp.productId
      UNION
      SELECT
        rp.productId productId,
        MIN(SEQUENCE) seq,
        COUNT(rp.productId) regionCount
      FROM
        productRegion rp,
        ya_new_basket b
      WHERE
        1=1
        AND rp.productID = b.sku
        AND b.shopper_id = cPshopperId
        AND b.site_id = iPsiteId
        AND b.type = iPtype
        AND iPcountryId = -1
        AND rp.originId = 1
        AND categoryID = 1
      GROUP BY rp.productId
    ) t
  WHERE
    1=1
    AND r.productId = t.productId
    AND r.sequence = t.seq
    AND b.sku = r.productId
    AND r.categoryID = 1 --not wholesale
    AND r.originId = 1
    AND b.sku = p.sku
    AND b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    AND p.is_parent = 'N'
    AND p.sku = pl.sku (+)
    AND (pl.lang_id = iPlangId OR pl.lang_id IS NULL) -- pass
    AND p.sku = ple.sku (+)
    AND (ple.lang_id = 1 OR ple.lang_id IS NULL)
    AND p.sku = plp.sku (+)
    AND
      (
        plp.lang_id =
          (
            SELECT t.lang_id
            FROM ya_prod_lang t
            WHERE
              t.sku = p.sku
              AND t.preferred_flag='Y'
              AND ROWNUM = 1
          )
        OR plp.lang_id is null
      )
    AND pl.sku = ple.sku
  ORDER BY b.created_datetime DESC;
  */
  /*
  SELECT
    r.productId,
    b.quantity,
    p.cover_img_loc AS cover_img_loc,
    NVL(p.cover_img_width, 0) AS cover_img_width,
    NVL(p.cover_img_height, 0) AS cover_img_height,
    NVL(r.preorder, 'N') AS preorder,
    NVL(r.preorderStart, dtLnullDate) AS preorder_start,
    NVL(r.preorderEnd, dtLnullDate) AS preorder_end,
    NVL(r.listPrice, 9999) AS list_price,
    NVL(r.salePrice, 9999) AS sale_price,
    NVL(r.salePriceStart, dtLnullDate) AS sale_start,
    NVL(r.salePriceEnd, dtLnullDate) AS salePriceEnd,
    NVL(pl.prod_name_u, ple.prod_name_u),
    NVL(p.release_date, dtLnullDate),
    plp.prod_name_img_loc,
    NVL(plp.name_img_width, 0),
    NVL(plp.name_img_height, 0),
    NVL(p.account_id, -1),
    NVL(r.supplierId, -1),
    NVL(r.enable, 'N'),
    NVL(r.canSell, 'N'),
    NVL(pl.prod_subtitle, ple.prod_subtitle),
    NVL(pl.prod_name_aka, ple.prod_name_aka),
    NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka),
    CAST(NVL(r.preorderBufferDay, -1) as INT) AS preorder_buffer_day,
    t.regionCount
  FROM
    ya_new_basket b,
    ya_product p,
    ya_prod_lang pl,
    (SELECT * FROM ya_prod_lang plp
     WHERE plp.lang_id in (
      SELECT pl.lang_id
    FROM
      ya_prod_lang pl,
      ya_product p
    WHERE pl.sku = p.sku
    AND pl.preferred_flag = 'Y'
    AND ROWNUM < 2
    )
    ) plp,
    (SELECT * FROM  ya_prod_lang ple
     WHERE ple.lang_id = 1
    ) ple,
    productRegion r,
    (SELECT
       s.productId productId,
       s.seq seq,
       t.regionCount regionCount
     FROM (SELECT
      rp.productId productId,
      MAX(SEQUENCE) seq
    FROM ya_country_region_rel rl,
     productRegion rp,
     ya_new_basket b
    WHERE rl.region_id = rp.regionId
    AND rp.productID = b.sku
    AND b.shopper_id = cPshopperId
    AND b.site_id = iPsiteId
    AND b.type = iPtype
    AND iPcountryId <> - 1
    AND rl.country_id = iPcountryId
    AND rp.originId = iPsiteId
    AND categoryID = 1
    GROUP BY  rp.productId
    ) s,
    (SELECT
       rp.productId productId,
       COUNT(rp.productId) regionCount
     FROM
       productRegion rp,
       ya_new_basket b
     WHERE rp.productID = b.sku
     AND b.shopper_id = cPshopperId
     AND b.site_id = iPsiteId
     AND b.type = iPtype
     AND iPcountryId <> - 1
     AND rp.originId = iPsiteId
     AND categoryID = 1
     GROUP BY rp.productId
     ) t
     WHERE s.productId = t.productId
     UNION
     SELECT
       rp.productId productId,
       MIN(SEQUENCE) seq,
       COUNT(rp.productId) regionCount
     FROM
       productRegion rp,
       ya_new_basket b
     WHERE rp.productID = b.sku
     AND b.shopper_id = cPshopperId
     AND b.site_id = iPsiteId
     AND b.type = iPtype
     AND iPcountryId = - 1
     AND rp.originId = iPsiteId
     AND categoryID = 1
     GROUP BY  rp.productId
     ) t
  WHERE b.sku = p.sku
  AND type = iPtype
  AND p.sku = pl.sku (+)
  AND pl.lang_id (+) = iPlangId
  AND p.sku = plp.sku (+)
  AND p.sku = ple.sku (+)
  AND b.sku = r.productId
  AND r.productId = t.productId
  AND r.sequence = t.seq
  AND categoryID = 1
  AND originId = iPsiteId
  AND b.shopper_id = cPshopperId
  AND b.site_id = iPsiteId
  AND b.type = iPtype
  AND p.is_parent = 'N'
  ORDER BY b.created_datetime DESC;
*/
  RETURN;

END;


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

        UPDATE ya_new_basket
        SET shopper_id = cPtoShopperId
        WHERE
          shopper_id = cPfromShopperId
          AND site_id = iPsiteId;
      END;
    END IF;
    COMMIT;
  END;


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

  UPDATE ya_new_basket SET site_id = iPtoSiteId
  WHERE shopper_id = cPshopperId
  AND site_id = iPfromSiteId;
  COMMIT;
END;




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


    IF iPcountry_id = -1 THEN -- if there is no country_id
      BEGIN
        -- promotiON bundle, aka OnePlusOne, Double Deal
        OPEN curPresult1 FOR
        SELECT
          bpr.productId,
          p.cover_img_loc,
          NVL(p.cover_img_width, 0) AS cover_img_width,
          NVL(p.cover_img_height, 0) AS cover_img_height,
          NVL(bpr.preorder, 'N') AS preorder,
          NVL(bpr.preorderstart, dtLnull_date) AS preorder_start,
          NVL(bpr.preorderend, dtLnull_date) AS preorder_end,
          NVL(bpr.listprice, 9999) AS list_price,
          NVL(bpr.saleprice, 9999) AS sale_price,
          NVL(bpr.salepricestart, dtLnull_date) AS sale_start,
          NVL(bpr.salepriceend, dtLnull_date) AS salepriceend,
          NVL(p.release_date, dtLnull_date) AS release_date,
          NVL(p.account_id, -1) AS account_id,
          NVL(bpr.supplierid, -1) AS supplierid,
          NVL(bpr.enable, 'N') AS enable,
          NVL(bpr.cansell, 'N') AS cansell,
          NVL(bpr.preorderbufferday, -1) AS preorder_buffer_day,
          NVL(o.availability_id, bpa.availability),
          NVL(p.country_release_id, -1),
          NVL(bpr.preorderDeadline, dtLnull_date) AS preorder_date --20
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
            pb.site_id = iPsite_id
            AND (pb.sku = b.sku OR pb.partner_sku = b.sku)
          INNER JOIN
            (
              SELECT *
              FROM
                (
                  SELECT bpr_i.*
                  FROM
                    backend_adm.productRegiON bpr_i,
                    ya_promotion_bundle pb_i
                  WHERE
                    pb_i.site_id = iPsite_id
                    AND (pb_i.sku =  iLlast_sku OR pb_i.partner_sku = iLlast_sku)
                    AND bpr_i.categoryId = 1
                    AND bpr_i.originId = iPsite_id
                    AND
                      (
                        bpr_i.productId <>  iLlast_sku
                        AND (bpr_i.productId = pb_i.partner_sku OR bpr_i.productId = pb_i.sku)
                      )
                  ORDER BY bpr_i.sequence
                )
              WHERE ROWNUM = 1
            ) bpr ON
            bpr.categoryId = 1
            AND bpr.originId = iPsite_id
            AND
              (
                bpr.productId <> b.sku
                AND (bpr.productId = pb.partner_sku OR bpr.productId = pb.sku)
              )
          INNER JOIN backend_adm.productAvailability bpa ON
            bpa.productId = bpr.productId
            AND bpa.originId = iPsite_id
            AND bpa.regionId = bpr.regionId
            AND bpa.category = 1
          INNER JOIN ya_product p ON
            p.sku = bpa.productId
          LEFT JOIN ya_availability_override o ON
            bpr.supplierid = o.supplier_id
            AND p.account_id = o.account_id
            AND dtLcurrent_date BETWEEN o.start_date AND o.end_date
            AND bpa.availability < o.availability_id
        WHERE
          bpr.cansell = 'Y'
          AND dtLcurrent_date -- ya_promotion_bundle
          BETWEEN NVL(pb.start_date, dtLcurrent_date)
          AND NVL(pb.end_date, dtLcurrent_date)
          AND NVL(o.availability_id, bpa.availability) < 60;



        -- cross selling
        OPEN curPresult2 FOR
        SELECT *
        FROM
          (
            SELECT
              bpr.productId,
              p.cover_img_loc,
              NVL(p.cover_img_width, 0) AS cover_img_width,
              NVL(p.cover_img_height, 0) AS cover_img_height,
              NVL(bpr.preorder, 'N') AS preorder,
              NVL(bpr.preorderstart, dtLnull_date) AS preorder_start,
              NVL(bpr.preorderend, dtLnull_date) AS preorder_end,
              NVL(bpr.listprice, 9999) AS list_price,
              NVL(bpr.saleprice, 9999) AS sale_price,
              NVL(bpr.salepricestart, dtLnull_date) AS sale_start,
              NVL(bpr.salepriceend, dtLnull_date) AS salepriceend,
              NVL(p.release_date, dtLnull_date),
              NVL(p.account_id, -1),
              NVL(bpr.supplierid, -1),
              NVL(bpr.enable, 'N'),
              NVL(bpr.cansell, 'N'),
              NVL(bpr.preorderbufferday, -1) AS preorder_buffer_day,
              NVL(o.availability_id, bpa.availability),
              NVL(p.country_release_id, -1),
              NVL(bpr.preorderDeadline, dtLnull_date) AS preorder_date --20
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
              INNER JOIN dm_crosssell_sku cs ON
                (
                cs.sku = b.sku
                AND cs.originId = iPsite_id
                AND cs.sectionId =
                  case
                    WHEN iPsectionId = 0 THEN cs.sectionId --sectionId=0 means all sections
                    ELSE iPsectionId
                  END
                )
              INNER JOIN
                (
                  SELECT
                    cs_i.crossSellSku AS related_sku,
                    MIN(bpr_i.sequence) AS sequence
                  FROM
                    backend_adm.productRegiON bpr_i,
                    dm_crosssell_sku cs_i
                  WHERE
                    cs_i.sku = iLlast_sku
                    AND cs_i.originId = iPsite_id
                    AND cs_i.sectionId =
                      case
                        WHEN iPsectionId = 0 THEN cs_i.sectionId --sectionId=0 means all sections
                        ELSE iPsectionId
                      END
                    AND bpr_i.categoryId = 1
                    AND bpr_i.originId = iPsite_id
                    AND bpr_i.productId = cs_i.crossSellSku
                  GROUP BY cs_i.crossSellSku
                ) tmp_pr ON
                tmp_pr.related_sku = cs.crossSellSku
              INNER JOIN backend_adm.productRegiON bpr ON
                bpr.categoryId = 1
                AND bpr.originId = iPsite_id
                AND bpr.productId = cs.crossSellSku
                AND bpr.sequence = tmp_pr.sequence
                AND bpr.productId = tmp_pr.related_sku
              INNER JOIN backend_adm.productAvailability bpa ON
                bpa.productId = bpr.productId
                AND bpa.originId = iPsite_id
                AND bpa.regionId = bpr.regionId
                AND bpa.category = 1
              INNER JOIN ya_product p ON
                p.sku = bpa.productId
              LEFT JOIN ya_availability_override o ON
                bpr.supplierid = o.supplier_id
                AND p.account_id = o.account_id
                AND dtLcurrent_date BETWEEN o.start_date AND o.end_date
                AND bpa.availability < o.availability_id
            WHERE
              bpr.cansell = 'Y'
              AND NVL(o.availability_id, bpa.availability) < 60
            ORDER BY cs.rank ASC, /* cs.last_modified_datetime DESC, */cs.crossSellSku DESC
          )
        WHERE ROWNUM < 4;
      END;
    ELSE -- if there is country_id
      BEGIN
        -- promotiON bundle, aka OnePlusOne, Double Deal
        OPEN curPresult1 FOR
        SELECT
          bpr.productId,
          p.cover_img_loc,
          NVL(p.cover_img_width, 0) AS cover_img_width,
          NVL(p.cover_img_height, 0) AS cover_img_height,
          NVL(bpr.preorder, 'N') AS preorder,
          NVL(bpr.preorderstart, dtLnull_date) AS preorder_start,
          NVL(bpr.preorderend, dtLnull_date) AS preorder_end,
          NVL(bpr.listprice, 9999) AS list_price,
          NVL(bpr.saleprice, 9999) AS sale_price,
          NVL(bpr.salepricestart, dtLnull_date) AS sale_start,
          NVL(bpr.salepriceend, dtLnull_date) AS salepriceend,
          NVL(p.release_date, dtLnull_date),
          NVL(p.account_id, -1),
          NVL(bpr.supplierid, -1),
          NVL(bpr.enable, 'N'),
          NVL(bpr.cansell, 'N'),
          NVL(bpr.preorderbufferday, -1) AS preorder_buffer_day,
          NVL(o.availability_id, bpa.availability),
          NVL(p.country_release_id, -1),
          NVL(bpr.preorderDeadline, dtLnull_date) AS preorder_date --20
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
            pb.site_id = iPsite_id
            AND (pb.sku = b.sku OR pb.partner_sku = b.sku)
          INNER JOIN
            (
              SELECT *
              FROM
                (
                  SELECT bpr_i.*
                  FROM
                    backend_adm.productRegiON bpr_i,
                    ya_promotion_bundle pb_i,
                    ya_country_region_rel crr
                  WHERE
                    pb_i.site_id = iPsite_id
                    AND (pb_i.sku =  iLlast_sku OR pb_i.partner_sku = iLlast_sku)
                    AND bpr_i.categoryId = 1
                    AND bpr_i.originId = iPsite_id
                    AND
                      (
                        bpr_i.productId <>  iLlast_sku
                        AND (bpr_i.productId = pb_i.partner_sku OR bpr_i.productId = pb_i.sku)
                      )
                    AND crr.country_id = iPcountry_id
                    AND bpr_i.regionId = crr.region_id
                  ORDER BY bpr_i.sequence DESC
                )
              WHERE
                ROWNUM = 1
            ) bpr ON
            bpr.categoryId = 1
            AND bpr.originId = iPsite_id
            AND
              (
                bpr.productId <> b.sku
                AND (bpr.productId = pb.partner_sku OR bpr.productId = pb.sku)
              )
          INNER JOIN backend_adm.productAvailability bpa ON
            bpa.productId = bpr.productId
            AND bpa.originId = iPsite_id
            AND bpa.regionId = bpr.regionId
            AND bpa.category = 1
          INNER JOIN ya_product p ON
            p.sku = bpa.productId
          LEFT JOIN ya_availability_override o ON
            bpr.supplierid = o.supplier_id
            AND p.account_id = o.account_id
            AND dtLcurrent_date BETWEEN o.start_date
            AND o.end_date
            AND bpa.availability < o.availability_id
        WHERE
          bpr.cansell = 'Y'
          AND dtLcurrent_date -- ya_promotion_bundle
            BETWEEN NVL(pb.start_date, dtLcurrent_date) AND NVL(pb.end_date, dtLcurrent_date)
          AND NVL(o.availability_id, bpa.availability) < 60;



        OPEN curPresult2 FOR
        -- cross selling
        SELECT *
        FROM
          (
            SELECT
              bpr.productId,--0
              p.cover_img_loc AS cover_img_loc,
              NVL(p.cover_img_width, 0) AS cover_img_width,
              NVL(p.cover_img_height, 0) AS cover_img_height,
              NVL(bpr.preorder, 'N') AS preorder,
              NVL(bpr.preorderstart, dtLnull_date) AS preorder_start, --5
              NVL(bpr.preorderend, dtLnull_date) AS preorder_end,
              NVL(bpr.listprice, 9999) AS list_price,
              NVL(bpr.saleprice, 9999) AS sale_price,
              NVL(bpr.salepricestart, dtLnull_date) AS sale_start,
              NVL(bpr.salepriceend, dtLnull_date) AS salepriceend, --10
              NVL(p.release_date, dtLnull_date),
              NVL(p.account_id, -1),
              NVL(bpr.supplierid, -1),
              NVL(bpr.enable, 'N'),
              NVL(bpr.cansell, 'N'), -- 15
              NVL(bpr.preorderbufferday, -1) AS preorder_buffer_day,
              NVL(o.availability_id, bpa.availability),
              NVL(p.country_release_id, -1),
              NVL(bpr.preorderDeadline, dtLnull_date) AS preorder_date --20
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
              INNER JOIN ya_country_region_rel crr ON
                crr.country_id = iPcountry_id
              INNER JOIN dm_crosssell_sku cs ON
                (
                cs.sku = b.sku
                AND cs.originId = iPsite_id
                AND cs.sectionId =
                  case
                    WHEN iPsectionId = 0 THEN cs.sectionId --sectionId=0 means all sections
                    ELSE iPsectionId
                  END
                )
              INNER JOIN
                (
                  SELECT
                    cs_i.crossSellSku related_sku,
                    MAX(bpr_i.sequence) sequence
                  FROM
                    backend_adm.productRegiON bpr_i,
                    dm_crosssell_sku cs_i
                  WHERE
                    cs_i.sku = iLlast_sku
                    AND cs_i.originId = iPsite_id
                    AND cs_i.sectionId =
                      case
                        WHEN iPsectionId = 0 THEN cs_i.sectionId --sectionId=0 means all sections
                        ELSE iPsectionId
                      END
                    AND bpr_i.categoryId = 1
                    AND bpr_i.originId = iPsite_id
                    AND bpr_i.productId = cs_i.crossSellSku
                  GROUP BY cs_i.crossSellSku
                ) tmp_pr ON
                tmp_pr.related_sku = cs.crossSellSku
              INNER JOIN backend_adm.productRegiON bpr ON
                bpr.categoryId = 1
                AND bpr.originId = iPsite_id
                AND bpr.productId = cs.crossSellSku
                AND bpr.regionId = crr.region_id
                AND bpr.sequence = tmp_pr.sequence
                AND bpr.productId = tmp_pr.related_sku
              INNER JOIN backend_adm.productAvailability bpa ON
                bpa.productId = bpr.productId
                AND bpa.originId = iPsite_id
                AND bpa.regionId = bpr.regionId
                AND bpa.category = 1
              INNER JOIN ya_product p ON
                p.sku = bpa.productId
              LEFT JOIN ya_availability_override o ON
                bpr.supplierid = o.supplier_id
                AND p.account_id = o.account_id
                AND dtLcurrent_date BETWEEN o.start_date AND o.end_date
                AND bpa.availability < o.availability_id
            WHERE
              bpr.cansell = 'Y'
              AND NVL(o.availability_id, bpa.availability) < 60
            ORDER BY cs.rank ASC,/* cs.last_modified_datetime DESC, */cs.crossSellSku DESC
          )
        WHERE ROWNUM < 4;
      END;
    END IF;
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
      NVL(pl.prod_name_u, ple.prod_name_u)
      , NVL(pl.prod_subtitle, ple.prod_subtitle)
      , NVL(pl.prod_name_aka, ple.prod_name_aka)
      , NVL(pl.prod_subtitle_aka, ple.prod_subtitle_aka)
      , NVL(pl.prod_series_title, ple.prod_series_title)
      , NVL(pl.prod_series_volume, ple.prod_series_volume)-- 5
      , NVL(pl.prod_title_volume, ple.prod_title_volume)
      , ple.prod_name_u
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
      , pa.show_in_browse
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
-- +--- Body
END Pkg_fe_BasketAccess;
/

