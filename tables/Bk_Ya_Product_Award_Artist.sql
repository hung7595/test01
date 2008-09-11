DROP TABLE Bk_Ya_Product_Award_Artist   
/

CREATE TABLE Bk_Ya_Product_Award_Artist (
	sku                           int                      NOT NULL ,
	award_definition_id           int                      NOT NULL ,
	artist_id                     int                      NOT NULL ,
	priority                      int                      NOT NULL ,
	status_type_id                number(18,2)             NOT NULL
)
/