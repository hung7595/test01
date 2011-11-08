CREATE OR REPLACE PACKAGE "CRON_FE_POPCORNCAMPAIGN"
AS
  PROCEDURE CronJobUpdateCampaign;
  
  PROCEDURE CronJobUpdateBlurayCampaign;
  
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
			and region.unit_cost / nvl(rate.exchange_rate, 1) < 5.56
			and region.region_id = 1
			and prod.account_id in (104,14,41,103,10,34,90,11,12,156,150,13,120,155,134,24,25,64,63,26)
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
			and region.unit_cost / nvl(rate.exchange_rate, 1) < 5.56
			and region.region_id = 7
			and prod.account_id in (104,14,41,103,10,34,90,11,12,156,150,13,120,155,134,24,25,64,63,26)
	) b
	where a.sell_price > 9.99
	and b.sell_price > 9.99
	and a.sku = b.sku;

	-- sku must be includeed in the campaigninsert into temp_popcorn_campaign
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (1021222460,1021222369,1021162198,1020582671,1014032771,
			1005118924,1012950057,1010746556,1003947238,1013867193,1014045401,1019892169,1020253253,1014027276,1004777750,
			1014446135,1020518903,1004624361,1004027612,1004412015,1021566152,1003535332,1001821648,1011134003,1003845394,
			1014025985,1002951605,1020418112,1021174932,1020506171,1014412920,1014419454,1014455186,1014402658,1014032737,
			1021882026,1014454809,1014297249,1021972368,1022091332,1022168371
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (
			1000000578,1003225227,1002847249,1004073131,1001831394,1000031323,3031,3051,1000001005,1000009560,1000005006,
			1003843374,1003845800,1003399895,1002839785,1004152506,1003365943,1004309043,1004309044,7997,1020582848,1004073132,
			1004073133,1004073130,1004084985,1004103720,1004461634,1002851838,1000000572,1000006422,1004009452,1004005919,1004005922,
			1001835538,1004898100,1004898102,1000014980,1000015811,1000015813,1000017780,1001916824,1004428671,1004428674,1004920982,
			1003333462,1002951521,4872,1000000598,1000000604,1000000605,1000000606,1000000976,1000000977,1014455193,1002744846,
			1014404665,1001811895,1001803274,1000030191,1000030193,1000030196,1001803924,1004315429,1004583064,1004600286,1001816469,
			1004095427,1003977873,1001833617,1003175463,1002870572,1001858055,1004099487,1001830269,1001830698,1001831557,1004103940
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (
			1003975373,1001810073,1001810509,1001803379,4129,1000001784,1000002215,1000002216,1002843887,3010,1001845058,1001818713,
			1001815408,6606,1004038397,1011881895,1014446134,1000023082,1000030204,1000001963,3497,4697,4698,4087,1004191644,
			1002911802,1004654814,1014334607,1004485960,1004677381,1003202624,1004043080,3358,3359,1002851832,1001853812,1005153997,
			1002995140,1003223178,1003223185,1010917145,1004107818,1004090632,1001829341,1001813337,1004037616,4727,1000000559,
			1000026040,1001803560,1001821242,1003947232,1003831088,1002492152,1003399871,1010096984,1004482687,1004482688,
			1002904684,1002857340,1002853399,1002912538,1002916513,1001851423,1003973291,1001834161,1001834292,1001834299,
			1002951433,1001815595,1003267917,1003327681,1003327682,1003327684,1002846399,1002732980,1000042912,1000013305,1001801810
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (
			1001823161,1001818439,1000028685,1000001098,1002896953,1004484910,1001859412,1001859437,1011977460,1014037308,1004592327,
			1004089403,1004050727,1003950628,1003911875,1003869237,1002939329,1002856708,1002859880,1002844646,1002327283,1001931845,
			1001839128,1001827730,1001817047,1001814956,1001812188,1001809222,1001810076,1001806898,1001807678,1001803714,1000007761,
			1000006100,1000006761,3821,7949,7983,7044,7944,7945,6321,6507,6508,3484,3485,3513,3683,3003,3026,3029,3087,2941,2972,2973,
			1001827655,1021412792,1014454836,1004541216,1011078447,1003675274,1001825310,1010917058,1010917073,1010724002,1000023085,
			1010019030,1004895219,1004659457,1003269674,1002156262,1004547015,1004513813,1004513888,1004482693,1004475861,1001804891,
			1003795241,1004439057,1000004192,1003365913,1003365927,3030,3931,1004163425,1004163326,1004306570,1004280517,1004306615
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (
			1004306579,1004148224,1003239706,1004102538,1004095368,1002839780,1002860399,1002523095,1002468486,1004068320,1000004173,
			4986,4614,1004007076,1003984803,1003984809,1003941856,1003816403,1003767344,1003292169,1003249128,1003293984,1003249441,
			1003249444,1003249445,1003187694,1004583955,1004435169,1004425424,1002949359,1002911782,1002911797,1002911789,1002911776,
			1002861331,1002868657,1002841023,1002819491,1002746072,1002494268,1002490844,1002458206,1002393259,1001859261,1001859253,
			1004135838,1001838300,1001838301,1004034434,1001829275,1001824711,1001818182,1001818648,1001818398,1001815220,1001814126,
			1001813868,1003323984,1001812257,1001803259,1001803020,1000030211,1002844951,1002491366,1002339260,1000022296,1000022293,
			1000015807,1000015803,1001844854,1000007732,1000007735,1000005520,1000005521,1000005522,1000005523,1000002896,1000003530,
			1000000956,1000000957,1000000984,1000028689,1000001961,1000000595,1000000596,1003542800,1001831391,1000005003,1000005005
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (
			1003327696,1002826386,1004456737,1000001892,1000000603,1001825105,1000010581,1000010582,1003079275,1002426428,1002426433,
			1001838074,1001837215,1001831162,1002745631,3012,1002484452,1003945037,1000028000,1004540186,1001827360,1003908533,
			1004104417,1001853402,1001821241,1003947420,1003947479,1003845974,1003744309,1003248863,1002854256,1002912533,1002916506,
			1002525790,1002469184,1000015808,1000023901,1003201521,1000004262,1001823770,1003613028,1003908612,1002392705,1002444411,
			1000030603,1001845066,1003795249,1002523729,1002266444,1001906058,1001836409,1000006142,7948,6183,6633,3511,3022,3027
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (
			1002819476,1002819712,1000027310,1002885363,1003110643,1003950974,1001832637,1010826818,1003910228,1002745634,1000027284,
			1004007070,1003914818,1003789189,1003183256,1003119205,1003022097,1002984756,1002857297,1002851520,1002840005,1002522722,
			1002446064,1002467698,1002444376,1001859699,1001859713,1001845067,1004101015,1001837424,1001833471,1003800684,1003323306,
			1002995236,1001808666,1001806588,1000034563,1002885867,1002491348,1002527088,1000015804,1001836174,1001841843,1001835729,
			1000010221,1000007720,1000005010,1000002631,1000003529,1000003531,1001805142,1000007321,1022498660,1022500636
			) ) a
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

  PROCEDURE CronJobUpdateBlurayCampaign AS
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
			and p_attr.ATTRIBUTE_ID = 81682
			and prod.weight < 201
			and region.is_can_sell = 'Y'
			and region.is_enabled = 'Y'
			and region.unit_cost / nvl(rate.exchange_rate, 1) < 13
			and region.region_id = 1
			and prod.account_id in (14, 81, 10, 85, 11, 87, 12, 89, 13, 91, 134, 24, 25, 64, 63, 26)
	) a,
	(
		select prod.sku as sku, case when sysdate between region.sale_price_start and region.sale_price_end and nvl(region.sale_price, 0) > 0 then region.sale_price else region.list_price end as sell_price
		from ya_product prod, prod_region region, exchange_rate rate, exchange_rate_version version, ya_prod_attr p_attr
		where rate.EXCHANGE_RATE_VERSION_ID = version.id
			and version.EFFECTIVE_START_DT < sysdate and version.EFFECTIVE_END_DT > sysdate and version.id != 0
			and region.cost_currency = rate.currency
			and prod.sku = region.prod_id
			and p_attr.sku = prod.sku
			and p_attr.ATTRIBUTE_ID = 81682
			and prod.weight < 201
			and region.is_can_sell = 'Y'
			and region.is_enabled = 'Y'
			and region.unit_cost / nvl(rate.exchange_rate, 1) < 13
			and region.region_id = 7
			and prod.account_id in (14, 81, 10, 85, 11, 87, 12, 89, 13, 91, 134, 24, 25, 64, 63, 26)
	) b
	where a.sell_price >= 20.49
	and b.sell_price >= 20.49
	and a.sell_price <= 25
	and b.sell_price <= 25
	and a.sku = b.sku;

	-- sku must be includeed in the campaigninsert into temp_popcorn_campaign
	-- bugzilla 12210
	INSERT INTO temp_popcorn_campaign
		SELECT a.sku FROM (select sku from ya_product where sku in (1023974978, 1024136639, 1024215456, 1023684688, 1024208490, 1024381694
			) ) a
			left join temp_popcorn_campaign c on c.sku = a.sku where c.sku is null;
	-- end bugzilla 12210
	
	delete from temp_popcorn_campaign where sku = 1024208490;
	
	delete from ya_campaign where campaign_code = 294 and sku not in (select sku from temp_popcorn_campaign);

	insert into ya_campaign (campaign_code, sku, campaign_datetime, created_datetime)
	select 294, sku, sysdate, sysdate from temp_popcorn_campaign
	where sku not in (select sku from ya_campaign where campaign_code = 294);
    

	IF (SQLCODE = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
  END CronJobUpdateBlurayCampaign;

END CRON_FE_POPCORNCAMPAIGN;
/
