CREATE TABLE ya_fe_seo_keyword_product_rel
(
	sku        int    NOT NULL ,
	keyword_id int    NOT NULL 
) 
/

ALTER TABLE ya_fe_seo_keyword_product_rel
ADD CONSTRAINT pk_fe_seo_keyword_product_rel PRIMARY KEY (sku, keyword_id)
/

