Drop Table Ya_Brand_Lang
/

CREATE TABLE Ya_Brand_Lang (
	id                        int                 NOT NULL ,
	ya_brand_id               int                 NOT NULL ,
	lang_id                   int                 NOT NULL ,
	site_id                   int                 ,
	brand_name                varchar2(255)       ,
	previous_brand_name       varchar2(255)       ,
	brand_desc                nclob               ,
	designer_name             varchar2(255)	
)
/

ALTER TABLE Ya_Brand_Lang
ADD CONSTRAINT PK_Brand_lang PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Brand_Lang
ADD CONSTRAINT FK_Brand_Lang_01 FOREIGN KEY (ya_brand_id)
REFERENCES Ya_Brand(id)
/


CREATE INDEX IX_Brand_Lang_01 ON Ya_Brand_Lang(ya_brand_id, lang_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand_Lang FOR Ya_Brand_Lang
/