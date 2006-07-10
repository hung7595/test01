
CREATE OR REPLACE package Pkg_bo_FilterDalc
AS
  TYPE refCur IS ref CURSOR;

  PROCEDURE GetBatchProductFilter (
    cPserver_id IN CHAR,
    curPgetFilter OUT refCur
  );
END Pkg_bo_FilterDalc;
/

CREATE OR REPLACE package body Pkg_bo_FilterDalc
IS
  PROCEDURE GetBatchProductFilter (
    cPserver_id IN CHAR,
    curPgetFilter OUT refCur
  )
  AS
    iLupper_sku INT;
    iLlower_sku INT;
    iLnew_upper INT;
    iLnew_lower INT;
    iLCOUNT_ADV INT;
    iLnew_count INT;
    iLrow_count INT;
  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_sku';

    BEGIN
      SELECT
        upper_sku,
        lower_sku,
        counter
      INTO
        iLupper_sku,
        iLlower_sku,
        iLCOUNT_ADV
      FROM ya_filter_log
      WHERE server_id = cPserver_id;

    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        iLupper_sku := -1;
        iLlower_sku := -1;
        iLCOUNT_ADV := 0;
      END;
    END;

    IF iLupper_sku = -1 AND iLlower_sku = -1 THEN
      BEGIN
        SELECT MAX(sku)
        INTO iLupper_sku
        FROM ya_product
        WHERE sku IN
          (
            SELECT pd.sku
            FROM ya_prod_dept pd
            WHERE pd.dept_id IN (106, 168, 5, 7448)
          );

        iLlower_sku := iLupper_sku;

        UPDATE ya_filter_log
        SET last_batch_end_datetime = SYSDATE
        WHERE server_id = cPserver_id;
      END;
    END IF;

    INSERT INTO temp_sku
    SELECT r.sku
    FROM
      (
        SELECT sku
        FROM ya_product
        WHERE
          sku > iLupper_sku
          AND sku IN
            (
              SELECT pd.sku
              FROM ya_prod_dept pd
              WHERE pd.dept_id IN (106, 168, 5, 7448)
            )
        ORDER BY sku
      ) r
    WHERE ROWNUM <= iLCOUNT_ADV;

    iLnew_count := SQL%ROWCOUNT;

    IF (iLCOUNT_ADV - iLnew_count) > 0 THEN
      BEGIN
        iLnew_count := iLCOUNT_ADV - iLnew_count;

        INSERT INTO temp_sku
        SELECT r.sku
        FROM
          (
            SELECT sku
            FROM ya_product
            WHERE
              sku < iLlower_sku
              AND sku IN
                (
                  SELECT pd.sku
                  FROM ya_prod_dept pd
                  WHERE pd.dept_id IN (106, 168, 5, 7448)
                )
            ORDER BY sku DESC
          ) r
        WHERE
          ROWNUM <= iLnew_count;
      END;
    END IF;

    SELECT MAX(sku) INTO iLnew_upper FROM temp_sku;
    SELECT MIN(sku) INTO iLnew_lower FROM temp_sku;

    /* update the sku within the range */
    OPEN curPgetFilter FOR
    SELECT
      pa.sku,
      a.attribute_type_id,
      a.attribute_id
    FROM
      ya_prod_attr pa
      INNER JOIN ya_attribute a ON
        pa.attribute_id = a.attribute_id
    WHERE
      pa.sku IN (SELECT t.sku FROM temp_sku t)
      AND pa.attribute_id IN
        (
113, 117, 118, 119, 120, 121, 122, 123, 124, 156, 157, 189, 190, 191, 192, 193,
194, 195, 196, 197, 198, 199, 200, 360, 4, 510, 511, 512, 513, 772, 773, 78372,
78959, 80350, 80413, 80467, 80637, 80677, 80679, 80685, 80702, 80703, 80704,
80729, 80730, 80731, 80732, 80733, 80734, 80735, 80736, 80737, 80738, 80739,
80740, 80745, 80746, 80747, 80814, 80818, 94
        )
    ORDER BY pa.sku DESC;

    SELECT COUNT(1)
    INTO iLrow_count
    FROM
      ya_prod_attr pa
      INNER JOIN ya_attribute a ON
        pa.attribute_id = a.attribute_id
    WHERE
      pa.sku IN (SELECT t.sku FROM temp_sku t)
      AND pa.attribute_id IN
        (
113, 117, 118, 119, 120, 121, 122, 123, 124, 156, 157, 189, 190, 191, 192, 193,
194, 195, 196, 197, 198, 199, 200, 360, 4, 510, 511, 512, 513, 772, 773, 78372,
78959, 80350, 80413, 80467, 80637, 80677, 80679, 80685, 80702, 80703, 80704,
80729, 80730, 80731, 80732, 80733, 80734, 80735, 80736, 80737, 80738, 80739,
80740, 80745, 80746, 80747, 80814, 80818, 94
        );

    /* reset the queue if no more item need to be updated */
    IF (iLrow_count = 0) THEN
      BEGIN
        BEGIN
          SELECT upper_sku INTO iLupper_sku
          FROM ya_filter_log
          WHERE server_id = cPserver_id;
        EXCEPTION WHEN no_data_found THEN
          iLupper_sku := -1;
        END;

        iLlower_sku := iLupper_sku;

        UPDATE ya_filter_log
        SET
          last_batch_start_datetime = last_batch_end_datetime,
          last_batch_end_datetime = SYSDATE
        WHERE server_id = cPserver_id;
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

    UPDATE ya_filter_log
    SET
      upper_sku = iLupper_sku,
      lower_sku = iLlower_sku
    WHERE server_id = cPserver_id;

    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END;
END Pkg_bo_FilterDalc;
/

