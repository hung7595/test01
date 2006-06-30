CREATE OR REPLACE PACKAGE Pkg_BO_ListItemDALC
AS
  TYPE refCur IS REF CURSOR;

  /* proc_bo_GetBaseItemBatch */
  PROCEDURE GetBatch (
    cPserver_id IN VARCHAR2,
    rcPresult1 OUT refCur,
    rcPresult2 OUT refCur,
    rcPresult3 OUT refCur,
    rcPresult4 OUT refCur
  );

END Pkg_BO_ListItemDALC;
/

CREATE OR REPLACE PACKAGE BODY Pkg_BO_ListItemDALC
IS
  PROCEDURE GetBatch (
    cPserver_id IN VARCHAR2,
    rcPresult1 OUT refCur,
    rcPresult2 OUT refCur,
    rcPresult3 OUT refCur,
    rcPresult4 OUT refCur
  )
  AS
    iLupper_sku INT;
    iLlower_sku INT;
    iLnew_upper INT;
    iLnew_lower INT;

    iLCOUNT_ADV INT;
    iLnew_count INT;
    iLtemp INT;
  BEGIN

    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_table_sku';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_table_baseitem';

    BEGIN
      SELECT
        upper_sku,
        lower_sku,
        counter
      INTO
        iLupper_sku,
        iLlower_sku,
        iLCOUNT_ADV
      FROM ya_base_item_log
      WHERE server_id = cPserver_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      BEGIN
        INSERT INTO ya_base_item_log VALUES (-1,-1,500,cPserver_id,NULL,NULL);
        iLupper_sku := -1;
        iLlower_sku := -1;
        iLCOUNT_ADV := 500;
        --COMMIT;
      END;
    END;

    IF iLupper_sku = -1 and iLlower_sku = -1 THEN
      BEGIN
        SELECT MAX(sku)
        INTO iLupper_sku
        FROM ya_product;

        iLlower_sku := iLupper_sku;

        UPDATE ya_base_item_log
        SET last_batch_end_datetime = SYSDATE
        WHERE server_id = cPserver_id;

--        COMMIT;
      END;
    END IF;

    -- initialize sku queue
    -- INSERT INTO temp_table_sku VALUES (iLupper_sku);
    -- INSERT INTO temp_table_sku VALUES (iLlower_sku);

    INSERT INTO temp_table_sku
    SELECT r.sku
    FROM
    (
      SELECT sku
      FROM ya_product
      WHERE sku > iLupper_sku
      ORDER BY sku
    ) r
    WHERE
      ROWNUM <= iLCOUNT_ADV;

    iLnew_count := SQL%ROWCOUNT;

    IF (iLCOUNT_ADV - iLnew_count) > 0 THEN
      BEGIN
        iLnew_count := iLCOUNT_ADV - iLnew_count;

        INSERT INTO temp_table_sku
        SELECT r.sku
        FROM
        (
          SELECT sku
          FROM ya_product
          WHERE sku < iLlower_sku
          ORDER BY sku DESC
        ) r
        WHERE
          ROWNUM <= iLnew_count;
      END;
    END IF;

    SELECT MAX(sku)
    INTO iLnew_upper
    FROM temp_table_sku;

    SELECT MIN(sku)
    INTO iLnew_lower
    FROM temp_table_sku;


    /* update the sku within the range */
    INSERT INTO temp_table_baseItem
    SELECT
      p.sku,
      p.release_date,
      pr1.cansell AS us_cansell,
      pr1.enable AS us_enabled,
      pr2.cansell AS tw_cansell,
      pr2.enable AS tw_enabled,
      p.us_launch_date,
      p.us_launch_date,
      pr1.displaypriority as us_priority,
      pr2.displaypriority as tw_priority,
      a.sku AS adult_sku,
      p.is_parent,
      NVL(ps1.sales_quantity_sum, 0),
      NVL(ps2.sales_quantity_sum, 0),
      NVL(ps1.rank, 0),
      NVL(ps2.rank, 0),
      pl.prod_name,
      NVL(p.num_children, 0)
    FROM
      temp_table_sku s
      INNER JOIN ya_product p ON p.sku = s.sku
	  LEFT JOIN productregion pr1 ON pr1.productId=s.sku AND pr1.regionId=1
	  LEFT JOIN productregion pr2 ON pr2.productId=s.sku AND pr2.regionId=7
      LEFT OUTER JOIN ya_adult_product a ON p.sku = a.sku
      LEFT OUTER JOIN ya_prod_score ps1 ON
        p.sku = ps1.sku
        AND ps1.siteid = 1
      LEFT OUTER JOIN ya_prod_score ps2 ON
        p.sku = ps2.sku
        AND ps2.siteid = 7
      LEFT OUTER JOIN ya_prod_lang pl ON
        pl.sku = p.sku
        AND pl.lang_id = 1
    ORDER BY p.sku DESC;

    OPEN rcPresult1 FOR
    SELECT *
    FROM temp_table_baseItem;

    OPEN rcPresult2 FOR
    SELECT
      b.productid,
      b.availability,
      b.originid
    FROM backend_adm.ProductAvailability b
    WHERE
      b.productid IN
        (
          SELECT t.sku
          FROM temp_table_baseItem t
        )
      AND b.regionid IN (1, 7)
      AND b.category = 1;

    -- MC - Asian Film Award
    OPEN rcPresult3 FOR
    SELECT
      sku,
      COUNT(award_definition_id)
    FROM ya_product_award
    WHERE sku IN (SELECT t.sku FROM temp_table_baseItem t)
    GROUP BY sku;

    -- VBE phrase 2
    OPEN rcPresult4 FOR
    SELECT
      pr1.productid,
      CASE
        WHEN pr1.saleprice IS NOT NULL AND SYSDATE BETWEEN pr1.salePriceStart AND pr1.salePriceEnd THEN pr1.saleprice
        WHEN pr1.listprice IS NOT NULL THEN pr1.listprice
        ELSE 9999
      END,
      pr1.regionid
    FROM backend_adm.productregion pr1
    WHERE
      pr1.productid IN (SELECT t.sku FROM temp_table_baseItem t)
      AND pr1.regionid IN (1,7)
      AND pr1.categoryId = 1;

    -- reset the queue if no more item need to be udpated
    SELECT COUNT(1) INTO iLtemp FROM temp_table_baseItem;

    IF (iLtemp = 0) THEN
      BEGIN
        BEGIN
          SELECT upper_sku INTO iLupper_sku
          FROM ya_base_item_log
          WHERE server_id = cPserver_id;
        EXCEPTION when no_data_found THEN
            iLupper_sku := -1;
        END;

        iLlower_sku := iLupper_sku;

        UPDATE ya_base_item_log
        SET
          last_batch_start_datetime = last_batch_end_datetime,
          last_batch_end_datetime = SYSDATE
        WHERE server_id = cPserver_id;

        --COMMIT;
      END;
    ELSE
      BEGIN
        IF iLnew_upper > iLupper_sku THEN
          BEGIN
            iLupper_sku := iLnew_upper;
          END;
        END IF;
        IF iLnew_lower < iLlower_sku THEN
          BEGIN
            iLlower_sku := iLnew_lower;
          END;
        END IF;
      END;
    END IF;

    UPDATE ya_base_item_log
    SET
      upper_sku = iLupper_sku,
      lower_sku = iLlower_sku
    WHERE server_id = cPserver_id;

    COMMIT;
    RETURN;
  END GetBatch;
END Pkg_BO_ListItemDALC;
/

