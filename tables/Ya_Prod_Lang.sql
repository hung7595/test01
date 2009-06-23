DROP TABLE Ya_Prod_Lang
/

CREATE TABLE Ya_Prod_Lang (
	sku                               int                     NOT NULL ,
	lang_id                           int                     NOT NULL ,
	prod_name                         nvarchar2(300)          ,
	prod_subtitle                     nvarchar2(255)          ,
	prod_name_aka                     nvarchar2(255)          ,
	prod_subtitle_aka                 nvarchar2(255)          ,
	prod_series_title                 nvarchar2(255)          ,
	prod_title_volume                 nvarchar2(255)          ,
	prod_subtitle_volume              nvarchar2(255)          ,
	prod_series_volume                nvarchar2(255)          ,
	updated_date                      date
)
/

ALTER TABLE Ya_Prod_Lang
ADD CONSTRAINT PK_Prod_Lang PRIMARY KEY (sku, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Lang_01 ON Ya_Prod_Lang(prod_name, sku, lang_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_02 ON Ya_Prod_Lang(updated_date) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Lang FOR Ya_Prod_Lang
/