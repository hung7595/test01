DROP TABLE Ya_Product_Remark
/

CREATE TABLE Ya_Product_Remark (
	sku                             int                        NOT NULL ,
	legal_concern                   int                        ,
	remark                          int                        ,
	id                              date                       NOT NULL
)	
/

ALTER TABLE Ya_Product_Remark
ADD CONSTRAINT PK_Product_Remark PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Product_Remark ON Ya_Product_Remark(sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Remark FOR Ya_Product_Remark
/


create or replace TRIGGER TrIn_ya_product_remark before INSERT ON ya_product_remark FOR EACH ROW
BEGIN
  IF inserting THEN
    IF :NEW.id IS NULL THEN
      SELECT seq_ya_product_remark.nextval
      INTO :NEW.id
      FROM dual;
    END IF;
  END IF;
END;