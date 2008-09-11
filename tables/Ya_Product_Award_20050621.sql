DROP TABLE Ya_Product_Award_20050621
/

CREATE TABLE Ya_Product_Award_20050621 (
	sku                              int                        NOT NULL ,
	award_definition_id              int                        NOT NULL ,
	status_type_id                   int                        NOT NULL ,
	priority                         int                        NOT NULL
)
/

ALTER TABLE Ya_Product_Award_20050621
ADD CONSTRAINT PK_Product_Award_20050621 PRIMARY KEY (sku, award_definition_id, status_type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Award_20050621_01 ON Ya_Product_Award_20050621(award_definition_id, status_type_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Award_20050621 FOR Ya_Product_Award_20050621
/