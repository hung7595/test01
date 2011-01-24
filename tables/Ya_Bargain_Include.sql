DROP TABLE Ya_Bargain_Include
/

CREATE TABLE Ya_Bargain_Include (
	site_id          int        NOT NULL ,
	sku              int        NOT NULL
)
/

ALTER TABLE Ya_Bargain_Include
ADD CONSTRAINT PK_Bargain_Include PRIMARY KEY (site_id, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Bargain_Include FOR Ya_Bargain_Include
/
