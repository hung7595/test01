CREATE OR REPLACE PACKAGE CRON_FE_SearchIndexAccess
AS
  PROCEDURE CronJobUpdateSaleSku;

  PROCEDURE CronJobUpdateSaleSkuDuplicate;

END CRON_FE_SearchIndexAccess;
/


CREATE OR REPLACE PACKAGE BODY CRON_FE_SearchIndexAccess AS
 PROCEDURE CronJobUpdateSaleSku
 AS
 BEGIN
	delete from ya_se_reindex where action = 1;
	
	insert into ya_se_reindex (sku, action, mod_dt)
	select distinct sku, 0, sysdate from
	(
		select prod_id as sku from prod_region where
		  sale_price_start >= trunc(sysdate) - 1
		  and sale_price_start <= trunc(sysdate) + 1
		union
		select prod_id as sku  from prod_region where
		  sale_price_end >= trunc(sysdate) - 1
		  and sale_price_end <= trunc(sysdate) + 1
    union
    select yp.sku as sku
      from ya_product yp, prod_region pr, ya_availability_override ao
      where yp.sku = pr.prod_id
      and yp.is_prod_grp_parent = 'N'
      and yp.account_id = ao.account_id
      and pr.supplier_id = ao.supplier_id
      and pr.is_enabled='Y'
      and ao.start_date >= trunc(sysdate) - 1
      and ao.start_date <= trunc(sysdate) + 1
		union
    select yp.sku as sku
      from ya_product yp, prod_region pr, ya_availability_override ao
      where yp.sku = pr.prod_id
      and yp.is_prod_grp_parent = 'N'
      and yp.account_id = ao.account_id
      and pr.supplier_id = ao.supplier_id
      and pr.is_enabled='Y'
      and ao.end_date >= trunc(sysdate) - 1
      and ao.end_date <= trunc(sysdate) + 1
	)
  where sku not in (select sku from ya_se_reindex);

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;

 END CronJobUpdateSaleSku;

 PROCEDURE CronJobUpdateSaleSkuDuplicate
 AS
 BEGIN
	delete from ya_se_reindex_duplicate where action = 1;
	
	insert into ya_se_reindex_duplicate (sku, action, mod_dt)
	select distinct sku, 0, sysdate from
	(
		select prod_id as sku from prod_region where
		  sale_price_start >= trunc(sysdate) - 1
		  and sale_price_start <= trunc(sysdate) + 1
		union
		select prod_id as sku  from prod_region where
		  sale_price_end >= trunc(sysdate) - 1
		  and sale_price_end <= trunc(sysdate) + 1
    union
    select yp.sku as sku
      from ya_product yp
        inner join prod_region pr on yp.sku = pr.prod_id and pr.region_id in (1,7,12)
        inner join ya_availability_override ao on yp.account_id = ao.account_id and pr.supplier_id = ao.supplier_id
      where yp.is_prod_grp_parent = 'N'
        and pr.is_enabled='Y'
        and ao.start_date >= trunc(sysdate) - 1
        and ao.start_date <= trunc(sysdate) + 1
		union
    select yp.sku as sku
      from ya_product yp
        inner join prod_region pr on yp.sku = pr.prod_id and pr.region_id in (1,7,12)
        inner join ya_availability_override ao on yp.account_id = ao.account_id and pr.supplier_id = ao.supplier_id
      where yp.is_prod_grp_parent = 'N'
        and pr.is_enabled='Y'
        and ao.end_date >= trunc(sysdate) - 1
        and ao.end_date <= trunc(sysdate) + 1
    union
    select yp.sku as sku
      from ya_product yp
        inner join prod_region pr on yp.sku = pr.prod_id and pr.region_id in (10,13,14,15,18)
        inner join ya_availability_override ao on yp.account_id = ao.account_id and pr.supplier_id = ao.supplier_id
      where not exists (select 1 from ya_product_title_rel ptr where ptr.product_title_child_sku = yp.sku)
        and yp.is_prod_grp_parent = 'N'
        and pr.is_enabled='Y'
        and ao.start_date >= trunc(sysdate) - 1
        and ao.start_date <= trunc(sysdate) + 1
		union
    select yp.sku as sku
      from ya_product yp
        inner join prod_region pr on yp.sku = pr.prod_id and pr.region_id in (10,13,14,15,18)
        inner join ya_availability_override ao on yp.account_id = ao.account_id and pr.supplier_id = ao.supplier_id
      where not exists (select 1 from ya_product_title_rel ptr where ptr.product_title_child_sku = yp.sku)
        and yp.is_prod_grp_parent = 'N'
        and pr.is_enabled='Y'
        and ao.end_date >= trunc(sysdate) - 1
        and ao.end_date <= trunc(sysdate) + 1
	)
  where sku not in (select sku from ya_se_reindex_duplicate);

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;

 END CronJobUpdateSaleSkuDuplicate;

END CRON_FE_SearchIndexAccess;
/

