DROP TABLE Ya_Prod_Grid_Lang_Bk
/

CREATE TABLE Ya_Prod_Grid_Lang_Bk (
	sku                           int                        NOT NULL ,
	grid_id                       int                        NOT NULL ,
	lang_id                       int                        NOT NULL ,
	display_seq                   int                        NOT NULL ,
	label1_value                  nvarchar2(1000)            ,
	label2_value                  nvarchar2(1000)            ,
	label3_value                  nvarchar2(1000)            ,
	label4_value                  nvarchar2(1000)            ,
	label5_value                  nvarchar2(1000)            ,
	label6_value                  nvarchar2(1000)            ,
	label7_value                  nvarchar2(1000)            ,
	label8_value                  nvarchar2(1000)            ,
	status                        int                        NOT NULL ,
	acdr                          char(1)                    ,
	data_supplier_id              int                        ,
	action_owner                  varchar2(50)	
)
/


CREATE INDEX IX_Prod_Grid_Lang_Bk_01 ON Ya_Prod_Grid_Lang_Bk(grid_id, lang_id) TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Prod_Grid_Lang_Bk FOR Ya_Prod_Grid_Lang_Bk
/


create or replace TRIGGER TRI_prod_grid_lang
BEFORE INSERT OR UPDATE OF ACDR
ON YA_PROD_GRID_LANG_BK
FOR EACH ROW
BEGIN
	:NEW.ACDR := UPPER(:NEW.ACDR);
END;