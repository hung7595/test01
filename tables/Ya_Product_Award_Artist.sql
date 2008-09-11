DROP TABLE Ya_Product_Award_Artist
/

CREATE TABLE Ya_Product_Award_Artist (
	sku                                int                    NOT NULL ,
	award_definition_id                int                    NOT NULL ,
	artist_id                          int                    NOT NULL ,
	priority                           int                    NOT NULL ,
	status_type_id                     int                    NOT NULL
)
/

ALTER TABLE Ya_Product_Award_Artist
ADD CONSTRAINT PK_Product_Award_Artist PRIMARY KEY (sku, award_definition_id, artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Award_Artist FOR Ya_Product_Award_Artist
/