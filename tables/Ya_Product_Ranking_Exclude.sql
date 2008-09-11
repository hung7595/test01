DROP TABLE Ya_Product_Ranking_Exclude
/

CREATE TABLE Ya_Product_Ranking_Exclude (
	sku                              int                  NOT NULL ,
	type_id                          int                  NOT NULL ,
	create_datetime                  date                 DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Product_Ranking_Exclude
ADD CONSTRAINT PK_Product_Ranking_Exclude PRIMARY KEY (sku, type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Ranking_Exclude FOR Ya_Product_Ranking_Exclude
/


create or replace TRIGGER TRAL_ya_prod_ranking_exclude
AFTER INSERT OR UPDATE OR DELETE OF sku
ON ya_product_ranking_exclude
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_PRODUCT_RANKING_EXCLUDE', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_PRODUCT_RANKING_EXCLUDE', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;