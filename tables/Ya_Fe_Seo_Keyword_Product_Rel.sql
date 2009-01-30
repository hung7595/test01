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