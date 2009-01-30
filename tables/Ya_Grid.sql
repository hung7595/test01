DROP TABLE Ya_Grid
/

CREATE TABLE Ya_Grid (
	grid_id                         int                        NOT NULL ,
	name                            varchar2(100)              NOT NULL ,
	"desc"                            varchar2(100)              ,
	product_line_id                 int                        NOT NULL ,
	created_user                    varchar2(50)               NOT NULL ,
	created_date                    date                       NOT NULL ,
	updated_user                    varchar2(50)               NOT NULL ,
	updated_date                    date                       NOT NULL ,
	status                          int                        NOT NULL ,
	acdr                            char(1)                    ,
	data_supplier_id                int                        ,
	action_owner                    varchar2(50)
)
/

ALTER TABLE Ya_Grid
ADD CONSTRAINT PK_Grid PRIMARY KEY (grid_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Grid FOR Ya_Grid
/