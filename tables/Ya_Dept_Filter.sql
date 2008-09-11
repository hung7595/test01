DROP TABLE Ya_Dept_Filter
/

CREATE TABLE Ya_Dept_Filter (
	dept_id                   int                   NOT NULL ,
	filter_id                 int                   NOT NULL
)
/

ALTER TABLE Ya_Dept_Filter
ADD CONSTRAINT PK_Dept_Filter PRIMARY KEY (dept_id, filter_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Filter FOR Ya_Dept_Filter
/