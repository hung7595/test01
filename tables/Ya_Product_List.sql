DROP TABLE Ya_Product_List
/

CREATE TABLE Ya_Product_List (
	sku                         int                  NOT NULL ,
	type_id                     int                  NOT NULL ,
	priority                    int                  NOT NULL ,
	create_datetime             date                 NOT NULL
)
/

ALTER TABLE Ya_Product_List
ADD CONSTRAINT PK_Product_List PRIMARY KEY (type_id, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Listl_01 ON Ya_Product_List(sku, type_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Listl_02 ON Ya_Product_List(type_id, sku, priority) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_List FOR Ya_Product_List
/