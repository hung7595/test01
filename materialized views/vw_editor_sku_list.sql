drop materialized view vw_editor_sku_list
/

CREATE MATERIALIZED VIEW vw_editor_sku_list
  REFRESH COMPLETE ON DEMAND
    AS 
  SELECT distinct pd.dept_id, pd.sku FROM ya_prod_dept pd
  INNER JOIN ya_dept_rel dr on dr.parent_dept_id in (11143, 10864, 11196, 11118, 11213, 11269, 11296, 11276)
  INNER JOIN ya_product yp on yp.sku = pd.sku and yp.release_date > sysdate-60
  INNER JOIN prod_avlb pa on pa.prod_id = pd.sku and pa.origin_id = 10 and pa.avlb < 60
  INNER JOIN prod_region pr on pr.prod_id = pd.sku and pr.region_id = 10 and pr.is_enabled = 'Y'
  INNER JOIN ya_product_rating ypr on ypr.sku = pd.sku
  INNER JOIN ya_prod_rating_lang yprl on yprl.rating_id = ypr.rating_id
  INNER JOIN ya_review yr on yr.review_id = yprl.us_review_id and yr.review is not null
  where pd.dept_id = dr.dept_id
  /
