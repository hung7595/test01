CREATE OR REPLACE PACKAGE Cron_fe_BargainAccess
AS
  PROCEDURE UpdateBargainSuppInfo
  (
    iPdept_id IN INT,
    iPsite_id IN INT
  );
  PROCEDURE CronJobUpdateBargainSuppInfo;
END Cron_fe_BargainAccess;
/


CREATE OR REPLACE PACKAGE BODY Cron_fe_BargainAccess
IS
 PROCEDURE UpdateBargainSuppInfo(
    iPdept_id IN INT,
    iPsite_id IN INT
 )
 AS
    iLprod_count INT;
    iLmax_discount NUMBER(9,2);
 BEGIN
  iLprod_count := 0;
  iLmax_discount := 0;

  SELECT COUNT(*), NVL(MAX(bp.discount), 0) INTO iLprod_count, iLmax_discount
  FROM ya_bargain_product bp
    INNER JOIN ya_prod_dept pd  ON bp.sku = pd.sku
    INNER JOIN prod_region pr ON bp.sku = pr.prod_id AND pr.region_id = iPsite_id AND pr.is_enabled = 'Y'
    INNER JOIN prod_avlb pa ON bp.sku = pa.prod_id AND pa.region_id = pr.region_id AND pa.avlb < 60
  WHERE bp.sale_start <= SYSDATE
    AND bp.sale_end >= SYSDATE
    AND bp.discount < 1
    AND pd.dept_id = iPdept_id
    AND bp.site_id = iPsite_id
    AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad);

/*
  dbms_output.put_line(iPdept_id);
  dbms_output.put_line(iPsite_id);
  dbms_output.put_line(iLprod_count);
  dbms_output.put_line(iLmax_discount);
*/

  DELETE FROM ya_bargain_supp_info WHERE SITE_ID = iPsite_id AND DEPT_ID = iPdept_id;

  INSERT INTO ya_bargain_supp_info
    (SITE_ID, DEPT_ID, PROD_COUNT, MAX_DISCOUNT, UPDATED_DATE)
  VALUES
    (iPsite_id, iPdept_id, iLprod_count, iLmax_discount, SYSDATE);

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
  END IF;

 END UpdateBargainSuppInfo;

 PROCEDURE CronJobUpdateBargainSuppInfo
 AS
 BEGIN
  --Chinese Video - dept id -> 106
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(106, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(106, 7); --GB

  --Korean Video - dept id -> 165
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(165, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(165, 7); --GB

  --Japanese Video - dept id -> 160
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(160, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(160, 7); --GB

  --Japanese Video - dept id -> 168
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(168, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(168, 7); --GB

  --Chinese Music - dept id -> 83
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(83, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(83, 7); --GB

  --Korean Music - dept id -> 91
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(91, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(91, 7); --GB

  --Japanese Music - dept id -> 97
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(97, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(97, 7); --GB

  --Western Music - dept id -> 156
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(156, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(156, 7); --GB

  --Chinese MV - dept id -> 163
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(163, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(163, 7); --GB

  --Korean MV - dept id -> 166
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(166, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(166, 7); --GB

  --Japanese MV - dept id -> 161
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(161, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(161, 7); --GB

  --Western MV - dept id -> 169
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(169, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(169, 7); --GB

  --Other - Game - dept id -> 5
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(5, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(5, 7); --GB

  --Other - Chinese Book - dept id -> 5
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(3591, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(3591, 7); --GB

  --Other - Comic - dept id -> 914
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(914, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(914, 7); --GB

  --Other - Toys - dept id -> 7153
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(7153, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(7153, 7); --GB

-- V5 - Movies and Videos - All Chinese -> 106
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(106, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(106, 7); --GB

-- V5 - Movies and Videos - Japan -> 6918
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(6918, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(6918, 7); --GB

-- V5 - Movies and Videos - Korea -> 295
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(295, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(295, 7); --GB

-- V5 - Movies and Videos - Western -> 8648
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(8648, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(8648, 7); --GB

-- V5 - Music - All Chinese -> 83
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(83, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(83, 7); --GB

-- V5 - Music - Japanese -> 97
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(97, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(97, 7); --GB

-- V5 - Music - Korean -> 91
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(91, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(91, 7); --GB

-- V5 - Concerts and MVs - All Chinese -> 163
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(163, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(163, 7); --GB

-- V5 - Games - All -> 5
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(5, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(5, 7); --GB

-- V5 - Toys - All -> 7153
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(7153, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(7153, 7); --GB

-- V5 - Books - In Chinese -> 3591
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(3591, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(3591, 7); --GB

-- V5 - Comics - In Chinese -> 2980
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(2980, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(2980, 7); --GB

-- V5 - TV - All Chinese -> 157
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(157, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(157, 7); --GB

-- V5 - TV - Japan -> 179
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(179, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(179, 7); --GB

-- V5 - TV - Korea -> 2957
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(2957, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(2957, 7); --GB

-- V5 - TV - Western -> 10961
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(10961, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(10961, 7); --GB

-- V5 - TV - HK -> 10678
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(10678, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(10678, 7); --GB

-- V5 - TV - Mainlang China -> 6458
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(6458, 1); --US
  Cron_fe_BargainAccess.UpdateBargainSuppInfo(6458, 7); --GB

 END CronJobUpdateBargainSuppInfo;
END Cron_fe_BargainAccess;
/

