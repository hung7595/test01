DROP TABLE Sl_Product_Lot
/

CREATE TABLE Sl_Product_Lot (
	prod_lot_id                  int                        NOT NULL ,
	file_id                      int                        ,
	sku                          int                        ,
	dept_id                      int                        ,
	lot_location                 int                        ,
	active                       char(1)                    ,
	priority                     number(38)                 ,
	updated_user                 varchar2(20)               ,
	updated_date                 date
)
/


CREATE PUBLIC SYNONYM Sl_Product_Lot FOR Sl_Product_Lot
/


create or replace TRIGGER TRI_sl_product_lot
BEFORE INSERT OR UPDATE OF active
ON sl_product_lot
FOR EACH ROW
BEGIN
	:NEW.active := UPPER(:NEW.active);
END;