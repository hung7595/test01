DROP TABLE Ya_Featured_Link_Dept_Rel_Lang
/

CREATE TABLE Ya_Featured_Link_Dept_Rel_Lang (
	id                           int                          NOT NULL ,
	lang_id                      int                          NOT NULL ,
	link                         varchar2(100)                ,
	content                      nvarchar2(1000)              NOT NULL
)
/

ALTER TABLE Ya_Featured_Link_Dept_Rel_Lang
ADD CONSTRAINT PK_Featured_Link_Dept_Rel_Lang PRIMARY KEY (id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Featured_Link_Dept_Rel_Lang FOR Ya_Featured_Link_Dept_Rel_Lang
/