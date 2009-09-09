CREATE OR REPLACE PACKAGE CRON_FE_SearchIndexAccess
AS
  PROCEDURE CronJobUpdateSaleSku;
END CRON_FE_SearchIndexAccess;
/


CREATE OR REPLACE PACKAGE BODY CRON_FE_SearchIndexAccess
IS
 PROCEDURE CronJobUpdateSaleSku

 AS
 BEGIN
	delete from ya_se_reindex where created_dt < trunc(sysdate) - 1 and action = 1;
	
	insert into ya_se_reindex (sku, action, created_dt) 
	select distinct sku, 0, sysdate from 
	(
		select prod_id as sku from prod_region where 
		  sale_price_start >= trunc(sysdate) - 1
		  and sale_price_start <= trunc(sysdate) + 1
		union
		select prod_id as sku  from prod_region where 
		  sale_price_end >= trunc(sysdate) - 1
		  and sale_price_end <= trunc(sysdate) + 1
	)
	where sku not in (select sku from ya_se_reindex);
 
	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;

 END CronJobUpdateSaleSku;
END CRON_FE_SearchIndexAccess;
/

