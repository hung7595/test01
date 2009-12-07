CREATE OR REPLACE PACKAGE "CRON_FE_CHIMUSICGROUPCAMPAIGN" 
AS
  PROCEDURE CronJobUpdateCampaign;
END CRON_FE_CHIMUSICGROUPCAMPAIGN;
/
CREATE OR REPLACE PACKAGE BODY "CRON_FE_CHIMUSICGROUPCAMPAIGN" AS

  PROCEDURE CronJobUpdateCampaign AS
  BEGIN
    
	  -- Empty temp table
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_chimusicgroup_campaign';
	  
	insert into temp_chimusicgroup_campaign (sku)
	select a.sku from
	(
		select prod.sku as sku, case when sysdate between region.sale_price_start and region.sale_price_end and nvl(region.sale_price, 0) > 0 then region.sale_price else region.list_price end as sell_price 
		from ya_product prod, prod_region region, exchange_rate rate, exchange_rate_version version
		where rate.EXCHANGE_RATE_VERSION_ID = version.id 
			and version.EFFECTIVE_START_DT < sysdate and version.EFFECTIVE_END_DT > sysdate and version.id != 0
			and region.cost_currency = rate.currency
			and prod.sku = region.prod_id
			and region.is_can_sell = 'Y'
			and region.is_enabled = 'Y'
			and region.region_id = 1
			and prod.account_id in (1,9,30,33,394,407,4,27,31,61,395,408,7,28,32,393,396,116)
	) a,
	(
		select prod.sku as sku, case when sysdate between region.sale_price_start and region.sale_price_end and nvl(region.sale_price, 0) > 0 then region.sale_price else region.list_price end as sell_price 
		from ya_product prod, prod_region region, exchange_rate rate, exchange_rate_version version
		where rate.EXCHANGE_RATE_VERSION_ID = version.id 
			and version.EFFECTIVE_START_DT < sysdate and version.EFFECTIVE_END_DT > sysdate and version.id != 0
			and region.cost_currency = rate.currency
			and prod.sku = region.prod_id
			and region.is_can_sell = 'Y'
			and region.is_enabled = 'Y'
			and region.region_id = 7
			and prod.account_id in (1,9,30,33,394,407,4,27,31,61,395,408,7,28,32,393,396,116)
	) b
	where a.sell_price > 9.99
	and b.sell_price > 9.99
	and a.sku = b.sku
  and a.sku not in (select sku from ya_campaign where campaign_code in (50001, 50002));

	delete from ya_campaign where campaign_code = 238 and sku not in (select sku from temp_chimusicgroup_campaign);
	
	insert into ya_campaign (campaign_code, sku, campaign_datetime, created_datetime) 
	select 238, sku, sysdate, sysdate from temp_chimusicgroup_campaign 
	where sku not in (select sku from ya_campaign where campaign_code = 238);


	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
  END CronJobUpdateCampaign;

END CRON_FE_CHIMUSICGROUPCAMPAIGN;
/
 