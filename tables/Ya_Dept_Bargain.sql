DROP TABLE Ya_Dept_Bargain
/

CREATE TABLE Ya_Dept_Bargain (
	dept_id                   int                   NOT NULL ,
	site_id                   int                   NOT NULL ,
	enabled                   char(10)              NOT NULL
)
/

ALTER TABLE Ya_Dept_Bargain
ADD CONSTRAINT PK_Dept_Bargain PRIMARY KEY (dept_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Bargain FOR Ya_Dept_Bargain
/