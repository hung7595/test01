DROP TABLE Ya_Prod_Grid
/

CREATE TABLE Ya_Prod_Grid (
	sku                          int                     NOT NULL ,
	grid_id                      int                     NOT NULL ,
	created_user                 varchar2(50)            NOT NULL ,
	created_date                 date                    NOT NULL ,
	updated_user                 varchar2(50)            NOT NULL ,
	updated_date                 date                    NOT NULL ,
	status                       int                     NOT NULL ,
	acdr                         char(1)                 ,
	data_supplier_id             int                     ,
	action_owner                 varchar2(50)
)
/

ALTER TABLE Ya_Prod_Grid
ADD CONSTRAINT PK_Prod_Grid PRIMARY KEY (sku, grid_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Grid FOR Ya_Prod_Grid
/