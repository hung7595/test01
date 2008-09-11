DROP TABLE Ya_Prod_Specification_Group
/

CREATE TABLE Ya_Prod_Specification_Group (
	dept_id                             int                      NOT NULL ,
	specification_group_id              int                      NOT NULL ,
	specification_id                    int                      NOT NULL ,
	display_order                       int                      NOT NULL
)
/

ALTER TABLE Ya_Prod_Specification_Group
ADD CONSTRAINT PK_Prod_Specification_Group PRIMARY KEY (dept_id, specification_group_id, specification_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Specification_Group FOR Ya_Prod_Specification_Group
/