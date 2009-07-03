DROP TABLE Ya_Fe_Seo_Keyword_Product_Rel
/

CREATE TABLE Ya_Fe_Seo_Keyword_Product_Rel
(
	sku             int       NOT NULL ,
	keyword_id      int       NOT NULL 
) 
/

ALTER TABLE ya_fe_seo_keyword_product_rel
ADD CONSTRAINT pk_fe_seo_keyword_product_rel PRIMARY KEY (sku, keyword_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Fe_Seo_Keyword_Product  FOR Ya_Fe_Seo_Keyword_Product
/


CREATE OR REPLACE TRIGGER TRAL_ya_fe_seo_keywd_prod_rel
AFTER INSERT OR UPDATE OR DELETE 
ON ya_fe_seo_keyword_product_rel 
FOR EACH ROW 
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM 
   (
     SELECT :new.sku SKU, 'YA_FE_SEO_KEYWORD_PRODUCT_REL', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_FE_SEO_KEYWORD_PRODUCT_REL', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;                 
   
END;
/
