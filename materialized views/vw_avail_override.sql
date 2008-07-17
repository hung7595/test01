drop materialized view vw_avail_override
/

CREATE MATERIALIZED VIEW vw_avail_override
  REFRESH COMPLETE ON DEMAND
    AS 
  SELECT distinct b.sku, a.updated_date, a.start_date, a.end_date FROM
  (
  SELECT account_id, supplier_id, updated_date, start_date, end_date
    FROM ya_availability_override
  --WHERE start_date <= sysdate
  --AND sysdate <= end_date
  ) a
  INNER JOIN (
    SELECT sku, account_id FROM ya_product
  ) b ON a.account_id = b.account_id
  INNER JOIN (
    SELECT prod_id, supplier_id FROM prod_region WHERE is_enabled = 'Y'
  ) c ON a.supplier_id = c.supplier_id AND b.sku = c.prod_id
/
