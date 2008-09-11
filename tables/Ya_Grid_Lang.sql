DROP TABLE Ya_Grid_Lang
/

CREATE TABLE Ya_Grid_Lang (
	grid_id                        int                        NOT NULL ,
	lang_id                        int                        NOT NULL ,
	title                          nvarchar2(800)             ,
	label1                         nvarchar2(800)             ,
	label2                         nvarchar2(800)             ,
	label3                         nvarchar2(800)             ,
	label4                         nvarchar2(800)             ,
	label5                         nvarchar2(800)             ,
	label6                         nvarchar2(800)             ,
	label7                         nvarchar2(800)             ,
	label8                         nvarchar2(800)             ,
	status                         int                        NOT NULL ,
	acdr                           char(1)                    ,
	data_supplier_id               int                        ,
	action_owner                   varchar2(50)
)
/

ALTER TABLE Ya_Grid_Lang
ADD CONSTRAINT PK_Grid_Lang PRIMARY KEY (grid_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Grid_Lang FOR Ya_Grid_Lang
/