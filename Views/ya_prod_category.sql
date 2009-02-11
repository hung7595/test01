CREATE OR REPLACE FORCE VIEW SS_ADM.YA_PROD_CATEGORY (SKU, CAT) AS 
  select t1.sku, mapping.map_type cat
  from (
       select prodAttr.sku,
       min(nvl(mapping.priority,9999)) id
       from ya_prod_attr prodAttr
       left join ya_prod_type_mapper mapping
       ON (prodAttr.attribute_id = mapping.attr_id)
       GROUP BY prodAttr.sku
 ) t1
 inner join ya_prod_type_mapper mapping
ON mapping.priority = t1.id
/


CREATE PUBLIC SYNONYM Ya_Prod_Category FOR Ya_Prod_Category
/