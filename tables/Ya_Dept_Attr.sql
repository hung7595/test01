DROP TABLE Ya_Dept_Attr
/

CREATE TABLE Ya_Dept_Attr (
	dept_id                   int                   NOT NULL ,
	attribute_id              int                   NOT NULL
)
/

ALTER TABLE Ya_Dept_Attr
ADD CONSTRAINT PK_Dept_Attr PRIMARY KEY (dept_id, attribute_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Dept_Attr_01 ON Ya_Dept_Attr(attribute_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Attr FOR Ya_Dept_Attr
/