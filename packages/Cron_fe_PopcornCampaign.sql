CREATE OR REPLACE PACKAGE "CRON_FE_POPCORNCAMPAIGN" 
AS
  PROCEDURE CronJobUpdateCampaign;
END Cron_fe_PopcornCampaign;
/
CREATE OR REPLACE PACKAGE BODY "CRON_FE_POPCORNCAMPAIGN" AS

  PROCEDURE CronJobUpdateCampaign AS
  BEGIN
    
	  -- Empty temp table
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_popcorn_campaign';
	  
	insert into temp_popcorn_campaign (sku)
	select a.sku from
	(
		select prod.sku as sku, case when sysdate between region.sale_price_start and region.sale_price_end and nvl(region.sale_price, 0) > 0 then region.sale_price else region.list_price end as sell_price 
		from ya_product prod, prod_region region, exchange_rate rate, exchange_rate_version version, ya_prod_attr p_attr
		where rate.EXCHANGE_RATE_VERSION_ID = version.id 
			and version.EFFECTIVE_START_DT < sysdate and version.EFFECTIVE_END_DT > sysdate and version.id != 0
			and region.cost_currency = rate.currency
			and prod.sku = region.prod_id
			and p_attr.sku = prod.sku
			and p_attr.ATTRIBUTE_ID = 117
			and prod.weight < 201
			and region.is_can_sell = 'Y'
			and region.is_enabled = 'Y'
			and region.unit_cost / nvl(rate.exchange_rate, 1) < 6.2
			and region.region_id = 1
			and prod.account_id in (104,14,41,7,132,33,9,103,10,34,90,11,12,156,150,13,4,133,394,32,396,120,155,134,24,25,64,63,26)
	) a,
	(
		select prod.sku as sku, case when sysdate between region.sale_price_start and region.sale_price_end and nvl(region.sale_price, 0) > 0 then region.sale_price else region.list_price end as sell_price 
		from ya_product prod, prod_region region, exchange_rate rate, exchange_rate_version version, ya_prod_attr p_attr
		where rate.EXCHANGE_RATE_VERSION_ID = version.id 
			and version.EFFECTIVE_START_DT < sysdate and version.EFFECTIVE_END_DT > sysdate and version.id != 0
			and region.cost_currency = rate.currency
			and prod.sku = region.prod_id
			and p_attr.sku = prod.sku
			and p_attr.ATTRIBUTE_ID = 117
			and prod.weight < 201
			and region.is_can_sell = 'Y'
			and region.is_enabled = 'Y'
			and region.unit_cost / nvl(rate.exchange_rate, 1) < 6.2
			and region.region_id = 7
			and prod.account_id in (104,14,41,7,132,33,9,103,10,34,90,11,12,156,150,13,4,133,394,32,396,120,155,134,24,25,64,63,26)
	) b
	where a.sell_price > 9.99
	and b.sell_price > 9.99
	and a.sku = b.sku;
	
	-- sku must be includeed in the campaigninsert into temp_popcorn_campaign 
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (1021222460,1021222369,1021162198,1020582671,1014032771,
			1005118924,1012950057,1010746556,1003947238,1013867193,
			1014045401,1019892169,1020253253,1014027276,1004777750,
			1014446135,1020518903,1004624361,1004027612,1004412015,
			1021566152,1003535332,1001821648,1011134003,1003845394,
			1014025985,1002951605,1020418112,1021174932,1020506171,
			1014412920,1014419454,1014455186,1014402658,1014032737,
			1021882026,1014454809,1014297249,1021972368,1022091332) ) a 
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
			
	delete from temp_popcorn_campaign where sku = 1020582831;

	delete from ya_campaign where campaign_code = 216 and sku not in (select sku from temp_popcorn_campaign);
	
	insert into ya_campaign (campaign_code, sku, campaign_datetime, created_datetime) 
	select 216, sku, sysdate, sysdate from temp_popcorn_campaign 
	where sku not in (select sku from ya_campaign where campaign_code = 216);


	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
  END CronJobUpdateCampaign;

END CRON_FE_POPCORNCAMPAIGN;
/
 