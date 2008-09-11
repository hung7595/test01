DROP TABLE Ya_Adult_Product
/

CREATE TABLE Ya_Adult_Product (
	sku                 int                      NOT NULL
)
/

ALTER TABLE Ya_Adult_Product
ADD CONSTRAINT PK_Adult_Product PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Adult_Product FOR Ya_Adult_Product
/