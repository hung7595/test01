DROP TABLE Ya_Product_Rate
/

CREATE TABLE Ya_Product_Rate (
	sku                         int                  NOT NULL ,
	rating                      int                  NOT NULL
/

ALTER TABLE Ya_Product_Rate
ADD CONSTRAINT PK_Product_Rate PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Rate FOR Ya_Product_Rate
/