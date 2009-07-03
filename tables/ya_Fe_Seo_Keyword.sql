DROP TABLE Ya_Fe_Seo_Keyword
/

CREATE TABLE Ya_Fe_Seo_Keyword 
(
	id                int                 NOT NULL ,
	text              nvarchar2(128)      ,
	lang_id           int                 NOT NULL ,
	enable            int                 NOT NULL ,
	note              nvarchar2(512)      ,
	last_update       date NOT NULL       ,
	last_update_user  nvarchar2(24)
) 
/

ALTER TABLE Ya_Fe_Seo_Keyword  ADD 
CONSTRAINT PK_Ya_Fe_Seo_Keyword PRIMARY KEY  (id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Fe_Seo_Keyword  FOR Ya_Fe_Seo_Keyword 
/


CREATE OR REPLACE TRIGGER TRAL_ya_fe_seo_keyword
AFTER INSERT OR UPDATE OR DELETE 
ON ya_fe_seo_keyword 
FOR EACH ROW 
BEGIN
    
  INSERT INTO ya_se_sku_update
  SELECT seq_se_sku_update.nextval, a.* FROM (
     SELECT distinct sku, 'YA_FE_SEO_KEYWORD', sysdate
     FROM ya_fe_seo_keyword_product_rel fskp
     WHERE keyword_id IN (:new.id, :old.id)) a;

END;
/
