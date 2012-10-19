DROP TABLE Ya_Description
/

CREATE TABLE Ya_Description (
	description_id               int                  NOT NULL ,
	sku                          int                  NOT NULL ,
	site_id                      int                  NOT NULL ,
	lang_id                      int                  NOT NULL ,
	description                  clob                 ,
	updated_date                 date
)
/

ALTER TABLE Ya_Description
ADD CONSTRAINT PK_Description PRIMARY KEY (description_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Description_01 on Ya_Description (sku, lang_id, site_id)
TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Description_01 on Ya_Description (sku, lang_id)
TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Description_02 on Ya_Description (sku, site_id, lang_id)
TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_DESCRIPTION_03 on ya_description (updated_date) 
TABLESPACE sscommerceserver_index
/

CREATE PUBLIC SYNONYM Ya_Description FOR Ya_Description
/