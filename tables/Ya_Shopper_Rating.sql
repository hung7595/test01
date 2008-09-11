DROP TABLE Ya_Shopper_Rating
/

CREATE TABLE Ya_Shopper_Rating (
	shopper_id                  char(32)               NOT NULL ,
	sku                         int                    NOT NULL ,
	rating                      int                    DEFAULT 0 NOT NULL ,
	version                     int                    DEFAULT 0 NOT NULL
)	
/

ALTER TABLE Ya_Shopper_Rating
ADD CONSTRAINT PK_Shopper_Rating PRIMARY KEY (shopper_id, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Shopper_Rating FOR Ya_Shopper_Rating
/