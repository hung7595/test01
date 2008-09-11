DROP TABLE Ya_Product_Lot
/

CREATE TABLE Ya_Product_Lot (
	prod_lot_id               int                  NOT NULL ,
	file_id                   int                  ,
	sku                       int                  ,
	dept_id                   int                  ,
	lot_location              int                  ,
	active                    char(1)              ,
	priority                  int                  ,
	updated_user              varchar2(20)         ,
	updated_date              date
)
/

ALTER TABLE Ya_Product_Lot
ADD CONSTRAINT PK_Product_Lot PRIMARY KEY (prod_lot_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Lotl_01 ON Ya_Product_Lot(sku, active) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Lotl_02 ON Ya_Product_Lot(file_id, prod_lot_id, sku, dept_id, lot_location) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Lot FOR Ya_Product_Lot
/


create or replace TRIGGER TRI_product_lot
BEFORE INSERT OR UPDATE OF active
ON ya_product_lot
FOR EACH ROW
BEGIN
	:NEW.active := UPPER(:NEW.active);
END;   