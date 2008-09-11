DROP TABLE Ya_Se_Sku_Update
/

CREATE TABLE Ya_Se_Sku_Update (
	id                           int                     NOT NULL ,
	sku                          number                  ,
	modifier                     varchar2(50)            NOT NULL ,
	updated_date                 date                    NOT NULL
)	
/

ALTER TABLE Ya_Se_Sku_Update
ADD CONSTRAINT PK_Se_Sku_Update PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Se_Sku_Update_01 ON Ya_Se_Sku_Update(updated_date, sku, modifier) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Se_Sku_Update FOR Ya_Se_Sku_Update
/