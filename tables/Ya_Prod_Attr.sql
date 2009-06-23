DROP TABLE Ya_Prod_Attr
/

CREATE TABLE Ya_Prod_Attr (
	sku                     int              NOT NULL ,
	attribute_id            int              NOT NULL
)
/

ALTER TABLE Ya_Prod_Attr
ADD CONSTRAINT PK_Prod_Attr PRIMARY KEY (sku, attribute_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Attr_01 ON Ya_Prod_Attr(attribute_id, sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Attr FOR Ya_Prod_Attr
/