drop MATERIALIZED VIEW VW_UPDATE_INSTOCK_PRODUCT;	
Create materialized view vw_update_instock_product
REFRESH COMPLETE ON DEMAND
AS 
	SELECT pr.prod_id as sku, pr.region_id as site_id
    from prod_region pr
    inner join prod_avlb pa on pr.region_id = 10 and pr.prod_id = pa.prod_id and pr.region_id = pa.region_id
    WHERE pr.list_price != -1
    AND pa.avlb = 0
 UNION
 SELECT pr.prod_id as sku, 11 as site_id
    from prod_region pr
    inner join prod_avlb pa on pr.region_id = 10 and pr.prod_id = pa.prod_id and pr.region_id = pa.region_id
    inner join ya_prod_dept pd on pr.prod_id = pd.sku and pd.dept_id in (11143, 11527, 11528, 11276, 11434)
    WHERE pr.list_price != -1
    AND pa.avlb = 0;