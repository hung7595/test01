DROP TABLE Ya_Prod_Value_History
/

CREATE TABLE Ya_Prod_Value_History (
	sku                            int                        NOT NULL ,
	site_id                        int                        NOT NULL ,
	type_id                        int                        NOT NULL ,
	old_value                      number(18,2)               ,
	current_value                  number(18,2)               NOT NULL ,
	updated_date                   date                       NOT NULL ,
	updated_user                   nvarchar2(20)              NOT NULL
)
/

ALTER TABLE Ya_Prod_Value_History
ADD CONSTRAINT PK_Prod_Value_History PRIMARY KEY (sku, site_id, type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Value_History FOR Ya_Prod_Value_History
/


create or replace TRIGGER TRAL_ya_prod_value_history
AFTER INSERT OR UPDATE OR DELETE OF current_value, old_value
ON ya_prod_value_history
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_PROD_VALUE_HISTORY', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_PROD_VALUE_HISTORY', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;