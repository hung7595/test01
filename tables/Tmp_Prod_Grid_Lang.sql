DROP TABLE Tmp_Prod_Grid_Lang
/

CREATE TABLE Tmp_Prod_Grid_Lang (
	sku                             int                          NOT NULL ,
	grid_id                         int                          NOT NULL ,
	lang_id                         int                          NOT NULL ,
	display_seq                     int                          NOT NULL ,
	label1_value                    nvarchar2(1500)              ,
	label2_value                    nvarchar2(1500)              ,
	label3_value                    nvarchar2(1500)              ,
	label4_value                    nvarchar2(1500)              ,
	label5_value                    nvarchar2(1500)              ,
	label6_value                    nvarchar2(1500)              ,
	label7_value                    nvarchar2(1500)              ,
	label8_value                    nvarchar2(1500)              ,
	status                          int                          NOT NULL ,
	acdr                            char(1)                      ,
	data_supplier_id                int                          ,
	action_owner                    varchar2(50)
)
/

ALTER TABLE Tmp_Prod_Grid_Lang
ADD CONSTRAINT PK_Tmp_Prod_Grid_Lang PRIMARY KEY (sku, grid_id, lang_id, display_seq)
USING INDEX TABLESPACE SSCommerceserver_Index
/