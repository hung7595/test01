DROP TABLE Ya_On_Sale_Product
/

CREATE TABLE Ya_On_Sale_Product (
	sku                      int                         NOT NULL ,
	site_id                  int                         NOT NULL ,
	sale_price               number(9,2)                 ,
	discount                 number(9,2)
)
/

ALTER TABLE Ya_On_Sale_Product
ADD CONSTRAINT PK_On_Sale_Product PRIMARY KEY (sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_On_Sale_Product FOR Ya_On_Sale_Product
/