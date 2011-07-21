create or replace
PACKAGE CRON_FE_SizeInfoRefreshAccess
AS
  PROCEDURE CronJobRefreshDeptIds;
  PROCEDURE CronJobRefreshBrandIds;
  PROCEDURE CronJobRefreshAttributeIds;
  PROCEDURE CronJobRefreshOnSales;
END CRON_FE_SizeInfoRefreshAccess;
/

create or replace
PACKAGE BODY CRON_FE_SizeInfoRefreshAccess
IS

 PROCEDURE CronJobRefreshDeptIds
 AS
 BEGIN
  DELETE FROM ya_size_info_dept;

  insert into ya_size_info_dept
  SELECT DISTINCT v.region_id, v.lang_id , v.size_info, yp.dept_id
  FROM ya_prod_dept yp, vw_size_info_sku v
  WHERE 1=1
  AND yp.sku = v.sku ;

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
 END CronJobRefreshDeptIds;

 PROCEDURE CronJobRefreshBrandIds
 AS
 BEGIN
  DELETE FROM ya_size_info_brand;

  insert into ya_size_info_brand
  SELECT DISTINCT v.region_id, v.lang_id , v.size_info, yp.brand_id
  FROM ya_product yp, vw_size_info_sku v
  WHERE 1=1
  AND yp.sku = v.sku
  AND yp.brand_id is not null;

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
 END CronJobRefreshBrandIds;

 PROCEDURE CronJobRefreshAttributeIds
 AS
 BEGIN
  DELETE FROM ya_size_info_attribute;

  insert into ya_size_info_attribute
  SELECT DISTINCT v.region_id, v.lang_id , v.size_info, yp.attribute_id
  FROM ya_prod_attr yp, vw_size_info_sku v
  WHERE 1=1
  AND yp.sku = v.sku ;

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
 END CronJobRefreshAttributeIds;

 PROCEDURE CronJobRefreshOnSales
 AS
 BEGIN
  DELETE FROM ya_size_info_onsale;

  insert into ya_size_info_onsale
  SELECT DISTINCT v.region_id, v.lang_id , v.size_info
  FROM prod_region preg, vw_size_info_sku v
  WHERE 1=1
  AND preg.prod_id = v.sku
  AND preg.sale_price_start < sysdate
  AND preg.sale_price_end > sysdate;


	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
 END CronJobRefreshOnSales;

END CRON_FE_SizeInfoRefreshAccess;
/
