Drop materialized view vw_publisher_product_count
/

Create materialized view VW_PUBLISHER_PRODUCT_COUNT
REFRESH COMPLETE ON DEMAND
AS 
SELECT DISTINCT yp.publisher_id AS publisher_id, ypd.dept_id AS dept_id, 
pr.origin_id AS site_id, COUNT(DISTINCT ypd.sku) AS product_count
FROM ya_prod_dept ypd
INNER JOIN ya_product yp ON yp.sku=ypd.sku 
INNER JOIN prod_avlb pa ON pa.prod_id=ypd.sku AND (pa.origin_id=10 OR pa.origin_id=11) 
AND pa.avlb<60
INNER JOIN prod_region pr ON pr.prod_id=ypd.sku AND (pr.origin_id=10 OR pr.origin_id=11) 
AND pr.is_enabled='Y'
LEFT JOIN ya_product_title_rel yptr ON yptr.product_title_parent_sku=ypd.sku
WHERE 
((yptr.product_title_parent_sku=ypd.sku) OR
(yptr.product_title_parent_sku IS NULL AND yptr.product_title_child_sku IS NULL AND pr.is_can_sell='Y'
AND yptr.created_user IS NULL AND yptr.created_date IS NULL))
AND NOT EXISTS (SELECT 1 FROM ya_product_title_rel yptr2 WHERE yptr2.product_title_child_sku=ypd.sku)
AND yp.publisher_id IS NOT NULL
GROUP BY yp.publisher_id, ypd.dept_id, pr.origin_id ORDER BY publisher_id, dept_id, site_id
/