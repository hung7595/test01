drop materialized view vw_editor_sku_list 
/

Create materialized view VW_EDITOR_SKU_LIST
REFRESH COMPLETE ON DEMAND
AS 
select distinct dr.parent_dept_id, pd.sku from ya_prod_dept pd
inner join ya_dept_rel dr on dr.parent_dept_id in (11143, 11276, 11213, 11296, 11527, 11528, 11583)
 inner join ya_product yp on yp.sku = pd.sku and yp.release_date > sysdate-60
 inner join prod_avlb pa ON pa.prod_id = pd.sku and pa.origin_id = 10 and pa.avlb < 60
 inner join prod_region pr ON pr.prod_id = pd.sku and pr.region_id = 10 and pr.is_enabled = 'Y'
 inner join ya_profess_review ypr ON ypr.sku = pd.sku
 inner join ya_profess_review_lang yprl on yprl.profess_review_id = ypr.id
  where pd.dept_id = dr.dept_id
 union
select distinct dr.parent_dept_id, pd.sku from ya_prod_dept pd
inner join ya_dept_rel dr on dr.parent_dept_id in (11118,10864)
 inner join prod_avlb pa ON pa.prod_id = pd.sku and pa.origin_id = 10 and pa.avlb < 60
 inner join prod_region pr ON pr.prod_id = pd.sku and pr.region_id = 10 and pr.is_enabled = 'Y'
 inner join ya_profess_review ypr ON ypr.sku = pd.sku
 inner join ya_profess_review_lang yprl on yprl.profess_review_id = ypr.id
  where pd.dept_id = dr.dept_id
/
