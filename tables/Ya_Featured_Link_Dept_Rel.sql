DROP TABLE Ya_Featured_Link_Dept_Rel
/

CREATE TABLE Ya_Featured_Link_Dept_Rel (
	id                               int                    NOT NULL ,
	dept_id                          int                    NOT NULL ,
	type_id                          int                    NOT NULL ,
	pos                              int                    NOT NULL ,
	created_datetime                 date                   NOT NULL
)
/

ALTER TABLE Ya_Featured_Link_Dept_Rel
ADD CONSTRAINT PK_Featured_Link_Dept_Rel PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Featured_Link_Dept_Rel FOR Ya_Featured_Link_Dept_Rel
/