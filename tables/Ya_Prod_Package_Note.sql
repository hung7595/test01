DROP TABLE Ya_Prod_Package_Note
/

CREATE TABLE Ya_Prod_Package_Note (
	attribute_id               number                    NOT NULL ,
	asset_id                   number                    NOT NULL
)
/

ALTER TABLE Ya_Prod_Package_Note
ADD CONSTRAINT PK_Prod_Package_Note PRIMARY KEY (attribute_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Package_Note FOR Ya_Prod_Package_Note
/