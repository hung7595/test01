Create materialized view vw_update_instock_product
REFRESH COMPLETE ON DEMAND
AS 
	SELECT pr.prod_id as sku, pr.region_id as site_id
    from prod_region pr 
    inner join prod_avlb pa on pr.region_id = 10 and pr.prod_id = pa.prod_id and pr.region_id = pa.region_id
    WHERE pr.list_price != -1
	AND pa.avlb = 0
/