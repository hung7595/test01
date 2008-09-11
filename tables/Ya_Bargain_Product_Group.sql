DROP TABLE Ya_Bargain_Product_Group
/

CREATE TABLE Ya_Bargain_Product_Group (
	gid                      int                     NOT NULL ,
	sku                      int                     NOT NULL ,
	site_id                  int                     NOT NULL
)
/


ALTER TABLE Ya_Bargain_Product_Group
ADD CONSTRAINT PK_Bargain_Product_Group PRIMARY KEY (gid, sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Product_Group FOR Ya_Bargain_Product_Group
/


create or replace TRIGGER TRAL_ya_bargain_product_group
AFTER INSERT OR UPDATE OR DELETE
ON ya_bargain_product_group
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_BARGAIN_PRODUCT_GROUP', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_BARGAIN_PRODUCT_GROUP', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;