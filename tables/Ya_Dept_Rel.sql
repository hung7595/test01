DROP TABLE Ya_Dept_Rel
/

CREATE TABLE Ya_Dept_Rel (
	dept_id                        int                  NOT NULL ,
	parent_dept_id                 int                  NOT NULL
)
/

ALTER TABLE Ya_Dept_Rel
ADD CONSTRAINT PK_Dept_Rel PRIMARY KEY (dept_id, parent_dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Dept_Rel_01 ON Ya_Dept_Rel(parent_dept_id, dept_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Rel FOR Ya_Dept_Rel
/