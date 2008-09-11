DROP TABLE Ya_Prod_Package
/

CREATE TABLE Ya_Prod_Package (
	attribute_id               number                    NOT NULL ,
	sku                        number                    NOT NULL
)
/

ALTER TABLE Ya_Prod_Package
ADD CONSTRAINT PK_Prod_Package PRIMARY KEY (attribute_id, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Package FOR Ya_Prod_Package
/