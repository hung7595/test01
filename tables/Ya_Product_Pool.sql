DROP TABLE Ya_Product_Pool
/

CREATE TABLE Ya_Product_Pool (
	sku                                     int                  NOT NULL ,
	site_id                                 int                  NOT NULL ,
	type_id                                 int                  NOT NULL ,
	last_modified_datetime                  date                 NOT NULL ,
	rating                                  int                  NOT NULL ,
	override_flag                           varchar2(1)          NOT NULL
)
/

ALTER TABLE Ya_Product_Pool
ADD CONSTRAINT PK_Product_Pool PRIMARY KEY (sku, site_id, type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Pool FOR Ya_Product_Pool
/


create or replace TRIGGER TRI_product_pool
BEFORE INSERT OR UPDATE OF override_flag
ON ya_product_pool
FOR EACH ROW
BEGIN
	:NEW.override_flag := UPPER(:NEW.override_flag);
END;                                         