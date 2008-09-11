DROP TABLE Ya_Prod_Electronics
/

CREATE TABLE Ya_Prod_Electronics (
	sku                      int                   NOT NULL ,
	brand_name               varchar2(100)         ,
	model_num                varchar2(100)
)
/

ALTER TABLE Ya_Prod_Electronics
ADD CONSTRAINT PK_Prod_Electronics PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Electronics FOR Ya_Prod_Electronics
/