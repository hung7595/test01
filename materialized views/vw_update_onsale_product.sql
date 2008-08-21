drop materialized view vw_update_onsale_product
/

CREATE MATERIALIZED VIEW vw_update_onsale_product
  REFRESH COMPLETE ON DEMAND
    AS 
SELECT pr.prod_id, pr.region_id, pr.sale_price, round(1-(pr.sale_price/pr.list_price),2) as discount
    from prod_region pr
    inner join prod_avlb pa on pr.region_id = 10 and pr.prod_id = pa.prod_id and pr.region_id = pa.region_id
    WHERE pr.sale_price IS NOT NULL
 AND pa.avlb < 60
 AND pr.sale_price > 0
 AND pr.list_price > 0
 AND pr.list_price > pr.sale_price
 AND pr.sale_price_start <= sysdate
 AND pr.sale_price_end >= sysdate
UNION
SELECT pr.prod_id, 11 as region_id, pr.sale_price, round(1-(pr.sale_price/pr.list_price),2) as discount
    from prod_region pr
    inner join prod_avlb pa on pr.region_id = 10 and pr.prod_id = pa.prod_id and pr.region_id = pa.region_id
    inner join ya_prod_dept pd on pr.prod_id = pd.sku and pd.dept_id in (11143, 11527, 11528, 11276, 11434)
    WHERE pr.sale_price IS NOT NULL
 AND pa.avlb < 60
 AND pr.sale_price > 0
 AND pr.list_price > 0
 AND pr.list_price > pr.sale_price
 AND pr.sale_price_start <= sysdate
 AND pr.sale_price_end >= sysdate
/