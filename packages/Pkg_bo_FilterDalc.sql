create or replace package Pkg_bo_FilterDalc
AS
  TYPE refCur IS ref CURSOR;

  PROCEDURE GetBatchProductFilter (
    cPserver_id IN CHAR,
    curPgetFilter OUT refCur
  );
END Pkg_bo_FilterDalc;
/

create or replace PACKAGE BODY Pkg_Bo_Filterdalc
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
      FROM YA_FILTER_LOG
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
        FROM YA_PRODUCT;
--        WHERE sku IN
--          (
--            SELECT pd.sku
--            FROM YA_PROD_DEPT pd
--                  WHERE pd.dept_id IN (106, 168, 5, 7448)
--                  WHERE dept_id > 10793 and dept_id < 10861
--WHERE dept_id IN (10864,11118)

--          );

        iLlower_sku := iLupper_sku;

        UPDATE YA_FILTER_LOG
        SET last_batch_end_datetime = SYSDATE
        WHERE server_id = cPserver_id;
      END;
    END IF;

    INSERT INTO TEMP_SKU
    SELECT r.sku
    FROM
      (
        SELECT sku
        FROM YA_PRODUCT
        WHERE
          sku > iLupper_sku
--          AND sku IN
--            (
--              SELECT pd.sku
 --             FROM YA_PROD_DEPT pd
--                  WHERE pd.dept_id IN (106, 168, 5, 7448)
--                  WHERE dept_id > 10793 and dept_id < 10861
--WHERE dept_id IN (10864,11118)
--            )
        ORDER BY sku
      ) r
    WHERE ROWNUM <= iLCOUNT_ADV;

    iLnew_count := SQL%ROWCOUNT;

    IF (iLCOUNT_ADV - iLnew_count) > 0 THEN
      BEGIN
        iLnew_count := iLCOUNT_ADV - iLnew_count;

        INSERT INTO TEMP_SKU
        SELECT r.sku
        FROM
          (
            SELECT sku
            FROM YA_PRODUCT
            WHERE
              sku < iLlower_sku
--              AND sku IN
--                (
--                  SELECT pd.sku
 --                 FROM YA_PROD_DEPT pd
--                  WHERE pd.dept_id IN (106, 168, 5, 7448)
--                  WHERE dept_id > 10793 and dept_id < 10861
--WHERE dept_id IN (10864,11118)
--                )
            ORDER BY sku DESC
          ) r
        WHERE
          ROWNUM <= iLnew_count;
      END;
    END IF;

    SELECT MAX(sku) INTO iLnew_upper FROM TEMP_SKU;
    SELECT MIN(sku) INTO iLnew_lower FROM TEMP_SKU;

    /* update the sku within the range */
    OPEN curPgetFilter FOR
    SELECT
      pa.sku,
      a.attribute_type_id,
      a.attribute_id
    FROM
      YA_PROD_ATTR pa
      INNER JOIN YA_ATTRIBUTE a ON
        pa.attribute_id = a.attribute_id
    WHERE
      pa.sku IN (SELECT t.sku FROM TEMP_SKU t)
      AND pa.attribute_id IN
        (
		
113, 117, 118, 119, 120, 121, 122, 123, 124, 156, 157, 189, 190, 191, 192, 193,
194, 195, 196, 197, 198, 199, 200, 360, 4, 510, 511, 512, 513, 772, 773, 78372,
78959, 80350, 80413, 80467, 80637, 80677, 80679, 80685, 80702, 80703, 80704,
80729, 80730, 80731, 80732, 80733, 80734, 80735, 80736, 80737, 80738, 80739,
80740, 80745, 80746, 80747, 80814, 80818, 94,
-- Electronics Revamp 2006 March
80997, 80998, 80999, 81000, 81001, 81002, 81003, 81004, 81005, 81006, 81007,
81008, 81009, 80954, 80955, 80956, 80957, 80958, 80959, 80960, 80961, 80962,
80963, 80964, 80965, 80966, 80967, 80968, 80969, 80970, 80918, 80919, 80920,
80921, 80922, 80923, 80924, 80971, 80972, 80973, 80974, 80975, 80976, 80977,
80978, 80979, 80980, 80981, 80982, 80983, 80984, 80985, 80938, 80939, 80940,
80941, 80942, 80943, 80944, 80945, 80946, 80947, 80948, 80949, 80950, 80951,
80952, 80953, 80928, 80929, 80930, 80931, 80932, 80933, 80934, 80935, 80936,
80937, 81015, 81016, 81017, 81018, 81019, 81020, 81021, 81022, 81023, 81024,
81025, 81026, 81010, 81011, 81012, 81013, 81014, 80883, 80863, 80986, 80987,
80988, 80989, 80990, 80991, 80992, 80993, 80994, 80995, 80996,
-- Electronics Revamp 2006 March


-- Yes Style Start --
81491,81492,81493,81494,81495,81496,81497,81498,
81500,81501,81502,81503,81504,81505,81601,81602,
--Stone--
81506,81507,81508,81509,81511,81524,81528,81539,
81541,81514,81634,81537,81612,81531,81512,81521,
81522,81654
-- Yes Style End --
        )
    ORDER BY pa.sku DESC;

    SELECT COUNT(1)
    INTO iLrow_count
    FROM
      YA_PROD_ATTR pa
      INNER JOIN YA_ATTRIBUTE a ON
        pa.attribute_id = a.attribute_id
    WHERE
      pa.sku IN (SELECT t.sku FROM TEMP_SKU t)
      AND pa.attribute_id IN
        (
		
113, 117, 118, 119, 120, 121, 122, 123, 124, 156, 157, 189, 190, 191, 192, 193,
194, 195, 196, 197, 198, 199, 200, 360, 4, 510, 511, 512, 513, 772, 773, 78372,
78959, 80350, 80413, 80467, 80637, 80677, 80679, 80685, 80702, 80703, 80704,
80729, 80730, 80731, 80732, 80733, 80734, 80735, 80736, 80737, 80738, 80739,
80740, 80745, 80746, 80747, 80814, 80818, 94,
-- Electronics Revamp 2006 March
80997, 80998, 80999, 81000, 81001, 81002, 81003, 81004, 81005, 81006, 81007,
81008, 81009, 80954, 80955, 80956, 80957, 80958, 80959, 80960, 80961, 80962,
80963, 80964, 80965, 80966, 80967, 80968, 80969, 80970, 80918, 80919, 80920,
80921, 80922, 80923, 80924, 80971, 80972, 80973, 80974, 80975, 80976, 80977,
80978, 80979, 80980, 80981, 80982, 80983, 80984, 80985, 80938, 80939, 80940,
80941, 80942, 80943, 80944, 80945, 80946, 80947, 80948, 80949, 80950, 80951,
80952, 80953, 80928, 80929, 80930, 80931, 80932, 80933, 80934, 80935, 80936,
80937, 81015, 81016, 81017, 81018, 81019, 81020, 81021, 81022, 81023, 81024,
81025, 81026, 81010, 81011, 81012, 81013, 81014, 80883, 80863, 80986, 80987,
80988, 80989, 80990, 80991, 80992, 80993, 80994, 80995, 80996,
-- Electronics Revamp 2006 March


-- Yes Style Start --
81491,81492,81493,81494,81495,81496,81497,81498,
81500,81501,81502,81503,81504,81505,81601,81602,
--Stone--
81506,81507,81508,81509,81511,81524,81528,81539,
81541,81514,81634,81537,81612,81531,81512,81521,
81522,81654
-- Yes Style End --
        );

    /* reset the queue if no more item need to be updated */
    IF (iLrow_count = 0) THEN
      BEGIN
        BEGIN
          SELECT upper_sku INTO iLupper_sku
          FROM YA_FILTER_LOG
          WHERE server_id = cPserver_id;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          iLupper_sku := -1;
        END;

        iLlower_sku := iLupper_sku;

        UPDATE YA_FILTER_LOG
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

    UPDATE YA_FILTER_LOG
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
END Pkg_Bo_Filterdalc;
/