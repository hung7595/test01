DROP TABLE Ya_Prod_Rel
/

CREATE TABLE Ya_Prod_Rel (
	sku                           int                           NOT NULL ,
	parent_sku                    int                           NOT NULL ,
	volume_number                 varchar2(200)                 ,
	priority                      int
)
/

ALTER TABLE Ya_Prod_Rel
ADD CONSTRAINT PK_Prod_Rel PRIMARY KEY (sku, parent_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Rel_01 ON Ya_Prod_Rel(parent_sku, sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Rel FOR Ya_Prod_Rel
/


create or replace TRIGGER TRAL_ya_prod_rel
AFTER INSERT OR UPDATE OR DELETE OF parent_sku
ON ya_prod_rel
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_PROD_REL', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_PROD_REL', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;