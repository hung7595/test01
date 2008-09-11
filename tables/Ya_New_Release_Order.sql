DROP TABLE Ya_New_Release_Order
/

CREATE TABLE Ya_New_Release_Order (
	list_id                          char(32)                    NOT NULL ,
	sku                              char(32)                    NOT NULL ,
	priority                         int                         NOT NULL ,
	last_updated_datetime            int                         NOT NULL
)
/

ALTER TABLE Ya_New_Release_Order
ADD CONSTRAINT PK_New_Release_Order PRIMARY KEY (list_id, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_New_Release_Order_01 ON Ya_New_Release_Order(list_id, priority) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_New_Release_Order FOR Ya_New_Release_Order
/