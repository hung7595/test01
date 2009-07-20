drop materialized view vw_not_sellable_dt
/
/*
Create materialized view vw_not_sellable_dt
REFRESH COMPLETE ON DEMAND
AS 
Select a.prod_id, a.origin_id, a.category, a.last_non_sellable_dt, a.last_sellable_dt
FROM prod_avlb a
WHERE ROUND(SYSDATE - a.last_non_sellable_dt) < 30
  AND (a.last_sellable_dt < a.last_non_sellable_dt
  OR  a.last_sellable_dt IS NULL)
AND a.last_non_sellable_dt IS NOT NULL
*/

Create materialized view vw_not_sellable_dt
REFRESH COMPLETE ON DEMAND
AS 
SELECT a.prod_id, a.origin_id, a.category, a.last_non_sellable_dt, a.last_sellable_dt 
FROM prod_avlb a 
INNER JOIN ya_product p on a.prod_id = p.sku and p.is_prod_grp_parent = 'N'
WHERE ROUND(SYSDATE - a.last_non_sellable_dt) < 30 
AND (a.last_sellable_dt < a.last_non_sellable_dt OR a.last_sellable_dt IS NULL) 
AND a.last_non_sellable_dt IS NOT NULL
AND p.release_date < (sysdate - 30)
/

create index ix_VW_NOT_SELLABLE_DT_01 on VW_NOT_SELLABLE_DT (prod_id);

Create public synonym vw_not_sellable_dt for ss_adm.vw_not_sellable_dt;

grant select on vw_not_sellable_dt to ys_staging, ys_web, bo_ys;

