DROP MATERIALIZED VIEW VW_SIZE_INFO_SKU
/

CREATE MATERIALIZED VIEW vw_size_info_sku
  REFRESH COMPLETE ON DEMAND
    AS
SELECT distinct pr.region_id, psi.lang_id, psi.size_info, psi.sku
    FROM ya_prod_size_info psi, prod_region pr, prod_avlb pa
  WHERE 1 = 1
  AND psi.sku = pa.prod_id
  AND pr.prod_id = pa.prod_id
  AND pr.region_id in (10,11,13)
  AND pa.region_id in (10,11,13)
  AND pa.avlb < 60
  AND pr.is_enabled = 'Y'
  AND pr.is_can_sell = 'Y'
  AND psi.lang_id in (1,2,5)
  AND pa.region_id = pr.region_id
/

grant select on VW_SIZE_INFO_SKU to v5_web_ysv2;
