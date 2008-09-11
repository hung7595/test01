DROP TABLE Ya_Prod_Specification_Grid_Rel
/

CREATE TABLE Ya_Prod_Specification_Grid_Rel (
	account_id                    int                      ,
	specification_id              int                      NOT NULL ,
	grid_id                       int                      NOT NULL ,
	col_num                       int                      NOT NULL
)
/

ALTER TABLE Ya_Prod_Specification_Grid_Rel
ADD CONSTRAINT PK_Prod_Specification_Grid_Rel PRIMARY KEY (specification_id, grid_id, col_num)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Specification_Grid_Rel FOR Ya_Prod_Specification_Grid_Rel
/