drop materialized view vw_catalog_description
/

CREATE MATERIALIZED VIEW vw_catalog_description
  REFRESH COMPLETE ON DEMAND
    AS 
  SELECT
        ypl.sku, ypl.lang_id, yp.updated_date
        FROM ya_prod_lang ypl, ya_description yd, ya_product yp
        WHERE yd.description_id = ypl.us_description_id
        AND yd.description IS NOT NULL
        AND ypl.sku = yp.sku
  --      AND yp.updated_date > sysdate - 60
        AND yp.account_id IN (
            SELECT account_id FROM ya_group WHERE division_id = 21
            AND group_name = 'YA')
    UNION
    SELECT
        ypl.sku, ypl.lang_id, yp.updated_date
        FROM ya_prod_lang ypl, ya_description yd, ya_product yp
        WHERE yd.description_id = ypl.tw_description_id
        AND yd.description IS NOT NULL
        AND ypl.sku = yp.sku
  --      AND yp.updated_date > sysdate - 60
        AND yp.account_id IN (
            SELECT account_id FROM ya_group WHERE division_id = 21
            AND group_name = 'YA')
/
