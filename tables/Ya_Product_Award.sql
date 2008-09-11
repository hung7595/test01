DROP TABLE Ya_Product_Award
/

CREATE TABLE Ya_Product_Award (
	sku                              int                        NOT NULL ,
	award_definition_id              int                        NOT NULL ,
	status_type_id                   int                        NOT NULL ,
	priority                         int                        NOT NULL
)
/

ALTER TABLE Ya_Product_Award
ADD CONSTRAINT PK_Product_Award PRIMARY KEY (sku, award_definition_id, status_type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Award_01 ON Ya_Product_Award(award_definition_id, status_type_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Award FOR Ya_Product_Award
/


create or replace TRIGGER TRAL_ya_product_award
AFTER INSERT OR UPDATE OR DELETE OF award_definition_id
ON ya_product_award
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_PRODUCT_AWARD', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_PRODUCT_AWARD', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;