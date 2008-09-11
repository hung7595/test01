DROP TABLE Ya_Section_Dept
/

CREATE TABLE Ya_Section_Dept (
	section_id                     number(4)              NOT NULL ,
	dept_id                        number(4)              NOT NULL
)	
/

ALTER TABLE Ya_Section_Dept
ADD CONSTRAINT PK_Section_Dept PRIMARY KEY (section_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Section_Dept FOR Ya_Section_Dept
/