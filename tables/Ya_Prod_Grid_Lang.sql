DROP TABLE Ya_Prod_Grid_Lang
/

CREATE TABLE Ya_Prod_Grid_Lang (
	sku                           int                     NOT NULL ,
	grid_id                       int                     NOT NULL ,
	lang_id                       int                     NOT NULL ,
	display_seq                   int                     NOT NULL ,
	label1_value                  nclob                   ,
	label2_value                  nclob                   ,
	label3_value                  nclob                   ,
	label4_value                  nclob                   ,
	label5_value                  nclob                   ,
	label6_value                  nclob                   ,
	label7_value                  nclob                   ,
	label8_value                  nclob                   ,
	status                        int                     NOT NULL ,
	acdr                          char(1)                 ,
	data_supplier_id              int                     ,
	action_owner                  varchar2(50)
)
/

ALTER TABLE Ya_Prod_Grid_Lang
ADD CONSTRAINT PK_Prod_Grid_Lang PRIMARY KEY (sku, grid_id, lang_id, display_seq)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Grid_Lang FOR Ya_Prod_Grid_Lang
/