DROP TABLE Ya_Bargain_Product
/

CREATE TABLE Ya_Bargain_Product (
	sku                      int                     NOT NULL ,
	site_id                  int                     NOT NULL ,
	sale_price               number(9,2)             NOT NULL ,
	sale_start               date                    NOT NULL ,
	sale_end                 date                    NOT NULL ,
	discount                 number(9,2)             NOT NULL	
)
/

ALTER TABLE Ya_Bargain_Product
ADD CONSTRAINT PK_Bargain_Product PRIMARY KEY (sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Bargain_Product_01 ON Ya_Bargain_Product(sale_start) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Bargain_Product_02 ON Ya_Bargain_Product(sale_end) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Bargain_Product_03 ON Ya_Bargain_Product(sale_start, site_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Bargain_Product_04 ON Ya_Bargain_Product(sale_end, site_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Bargain_Product_05 ON Ya_Bargain_Product(sku, site_id, sale_start, sale_end) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Product FOR Ya_Bargain_Product
/


create or replace TRIGGER TRAL_ya_bargain_product
AFTER INSERT OR UPDATE OR DELETE OF discount, sale_start, sale_end
ON ya_bargain_product
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_BARGAIN_PRODUCT', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_BARGAIN_PRODUCT', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;