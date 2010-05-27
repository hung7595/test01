DROP TABLE Ya_Prod_Size_Info
/

CREATE TABLE Ya_Prod_Size_Info (
	id                   int              NOT NULL ,
	sku                  int              NOT NULL ,
	lang_id              int              NOT NULL ,
	size_info            int              NOT NULL
)
/

ALTER TABLE Ya_Prod_Size_Info
ADD CONSTRAINT PK_Prod_Size_Info PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Size_Info_01 ON Ya_Prod_Size_Info(sku, lang_id, size_info) TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Prod_Size_Info FOR Ya_Prod_Size_Info
/
