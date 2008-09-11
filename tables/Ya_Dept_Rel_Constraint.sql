DROP TABLE Ya_Dept_Rel_Constraint
/

CREATE TABLE Ya_Dept_Rel_Constraint (
	dept_id                        int                  NOT NULL ,
	parent_dept_id                 int                  NOT NULL ,
	constraint_type                int                  NOT NULL ,
	constraint_value               int                  NOT NULL
)
/

ALTER TABLE Ya_Dept_Rel_Constraint
ADD CONSTRAINT PK_Dept_Rel_Constraint PRIMARY KEY (dept_id, parent_dept_id, constraint_type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Dept_Rel_Constraint_01 ON Ya_Dept_Rel_Constraint(parent_dept_id, dept_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Rel_Constraint FOR Ya_Dept_Rel_Constraint
/