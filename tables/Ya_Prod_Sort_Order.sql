DROP TABLE Ya_Prod_Sort_Order
/

CREATE TABLE Ya_Prod_Sort_Order (
	sku                             int                        NOT NULL ,
	site_id                         int                        NOT NULL ,
	priority                        int                        NOT NULL ,
	list_id                         int                        NOT NULL ,
	update_datetime                 date                       NOT NULL
)
/

ALTER TABLE Ya_Prod_Sort_Order
ADD CONSTRAINT PK_Prod_Sort_Order PRIMARY KEY (sku, site_id, list_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Sort_Order_01 ON Ya_Prod_Sort_Order(list_id, site_id, priority, sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Sort_Order FOR Ya_Prod_Sort_Order
/