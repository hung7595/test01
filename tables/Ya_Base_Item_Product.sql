DROP TABLE Ya_Base_Item_Product
/

CREATE TABLE Ya_Base_Item_Product (
	sku                           int                     NOT NULL ,
	server_id                     varchar2(20)            NOT NULL ,
	updated_date                  date
)
/


ALTER TABLE Ya_Base_Item_Product
ADD CONSTRAINT PK_Bargain_Product_Group PRIMARY KEY (sku, server_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Base_Item_Product FOR Ya_Base_Item_Product
/