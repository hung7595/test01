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
			and prod.account_id in (104,14,41,7,132,33,9,103,10,34,90,11,12,156,150,13,4,133,394,32,396,120,155,105,134,24,25,64,159,157,63,40,26)
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
			and prod.account_id in (104,14,41,7,132,33,9,103,10,34,90,11,12,156,150,13,4,133,394,32,396,120,155,105,134,24,25,64,159,157,63,40,26)
	) b
	where a.sell_price > 9.99
	and b.sell_price > 9.99
	and a.sku = b.sku;
	
	-- sku must be includeed in the campaign
	insert into temp_popcorn_campaign values (1021222460);
	insert into temp_popcorn_campaign values (1021222369);
	insert into temp_popcorn_campaign values (1021162198);
	insert into temp_popcorn_campaign values (1020582671);
	insert into temp_popcorn_campaign values (1014032771);
	insert into temp_popcorn_campaign values (1005118924);
	insert into temp_popcorn_campaign values (1012950057);
	insert into temp_popcorn_campaign values (1010746556);
	insert into temp_popcorn_campaign values (1003947238);
	insert into temp_popcorn_campaign values (1013867193);
	insert into temp_popcorn_campaign values (1014045401);
	insert into temp_popcorn_campaign values (1019892169);
	insert into temp_popcorn_campaign values (1020253253);
	insert into temp_popcorn_campaign values (1014027276);
	insert into temp_popcorn_campaign values (1004777750);
	insert into temp_popcorn_campaign values (1014446135);
	insert into temp_popcorn_campaign values (1020518903);
	insert into temp_popcorn_campaign values (1004624361);
	insert into temp_popcorn_campaign values (1004027612);
	insert into temp_popcorn_campaign values (1004412015);
	insert into temp_popcorn_campaign values (1021566152);
	insert into temp_popcorn_campaign values (1003535332);
	insert into temp_popcorn_campaign values (1001821648);
	insert into temp_popcorn_campaign values (1011134003);
	insert into temp_popcorn_campaign values (1003845394);
	insert into temp_popcorn_campaign values (1014025985);
	insert into temp_popcorn_campaign values (1002951605);

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
 