CREATE OR REPLACE PACKAGE Cron_Fe_Upd_Bargain_Prod_Rel
AS

  PROCEDURE BargainUpdate;
  
  PROCEDURE AnnualClearance;

END Cron_Fe_Upd_Bargain_Prod_Rel;
/
  

CREATE OR REPLACE PACKAGE BODY Cron_Fe_Upd_Bargain_Prod_Rel
AS

  Procedure BargainUpdate AS

  dtLlastupdate date;
  
  BEGIN

    /*local variable*/
    select last_updated_datetime into dtLlastupdate from ya_bargain_update_log;
  
  
    /* Automatic Clearance 2007: 51001(Global), 51002(US), 51003(YS) */ 
    insert into tmp_bargain_product_group (sku, site_id, sale_price, sale_start, sale_end, discount)
    select ca.sku, pr.region_id, 
      nvl(pr.sale_price, pr.list_price) as sale_price, 
      nvl(pr.sale_price_start, sysdate - 10) as sale_price_start,
      nvl(pr.sale_price_end, sysdate + 10) as sale_price_end,
      nvl(round(1-(pr.sale_price/pr.list_price),2), 0)
    from ya_campaign ca 
      inner join prod_region pr on ca.sku = pr.prod_id and pr.category_Id =1 and pr.region_id in (1,7)
      inner join prod_avlb pa on ca.sku = pa.prod_id and pa.category =1 and pa.region_id = pr.region_id
    where pa.avlb = 0    
      and ca.campaign_code in (50001, 50002, 50003)
      and pr.list_price > 0
      and not exists (select 1 from tmp_bargain_product_group a where a.sku = ca.sku and a.site_id = pr.region_id)  
    group by ca.sku, pr.region_id, pr.sale_price, pr.list_price, pr.sale_price_start, pr.sale_price_end, round(1-(pr.sale_price/pr.list_price),2);
  
    /* Customize List */
    insert into tmp_bargain_product_group (sku, site_id, sale_price, sale_start, sale_end, discount)
    select bi.sku, pr.region_id, 
      nvl(pr.sale_price, pr.list_price) as sale_price,
      nvl(pr.sale_price_start, sysdate - 10) as sale_price_start,
      nvl(pr.sale_price_end, sysdate + 10) as sale_price_end,
      nvl(round(1-(pr.sale_price/pr.list_price),2), 0)
    from ya_bargain_include bi 
      inner join prod_region pr on bi.sku = pr.prod_id and pr.category_id =1 and pr.region_id = bi.site_id
      inner join prod_avlb pa on bi.sku = pa.prod_id and pa.category =1 and pa.region_id = bi.site_id
    where pa.avlb = 0
      and pr.list_price > 0
      and not exists (select 1 from tmp_bargain_product_group a where a.sku = bi.sku and a.site_id = bi.site_id)
    group by bi.sku, pr.region_id, pr.sale_price, pr.list_price, pr.sale_price_start, pr.sale_price_end, round(1-(pr.sale_price/pr.list_price),2);
    
  
    delete from ya_bargain_product bp
    where exists (select 1 from prod_region pr where bp.sku=pr.prod_id and bp.site_id = pr.region_id and pr.category_id=1 and pr.mod_dt > dtLlastupdate);
    
  
    delete from ya_bargain_product bp
	where exists (select 1 from prod_avlb pa where bp.sku = pa.prod_id and bp.site_id = pa.region_id and pa.category =1 and pa.mod_dt > dtLlastupdate);
           
  
    insert into ya_bargain_product (sku, site_id, sale_price, sale_start, sale_end, discount)
    select a.sku, a.site_id, a.sale_price, a.sale_start, a.sale_end, a.discount from tmp_bargain_product_group a left outer join ya_bargain_product b 
    on a.sku = b.sku and a.site_id = b.site_id where b.sku is null
    and a.discount >= 0.1;
   
    delete from ya_bargain_update_log;
    insert into ya_bargain_update_log values (sysdate-1);
    
    commit;


  END BargainUpdate;


  Procedure AnnualClearance AS
  
  BEGIN
  
    -- remove item less than 30% off discount
    delete from ya_bargain_product where discount < 0.3 and sku not in (select sku from ya_campaign where campaign_code in (88,89,99,100,101,102,103,50001,50002,50003));
    
    -- remove non-instock item
    delete from ya_bargain_product where site_id = 1 
      and sku not in (select prod_id from prod_avlb where avlb = 0 and region_id = 1) ;
    
    delete from ya_bargain_product where site_id = 7 
      and sku not in (select prod_id from prod_avlb where avlb = 0 and region_id = 7);



    delete from ya_bargain_product
    where sku in 
    (
      select sku from ya_bargain_product where site_id=1
      and sku not in
      (
        select sku from ya_campaign where campaign_code=50001
      )
    )
    and site_id=1;

    delete from ya_bargain_product
    where sku in 
    (
      select sku from ya_bargain_product where site_id=7
      and sku not in
      (
        select sku from ya_campaign where campaign_code=50002
      )
    )
    and site_id=7;

    commit;

  END AnnualClearance;
  
END Cron_Fe_Upd_Bargain_Prod_Rel;
/
