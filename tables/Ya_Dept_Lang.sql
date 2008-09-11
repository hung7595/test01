DROP TABLE Ya_Dept_Lang
/

CREATE TABLE Ya_Dept_Lang (
	dept_id                          int                     NOT NULL ,
	lang_id                          int                     NOT NULL ,
	dept_name                        varchar2(200)           ,
	dept_name_u                      nvarchar2(50)           ,
	dept_description                 varchar2(500)           ,
	dept_description_u               nvarchar2(500)          ,
	dept_path                        varchar2(500)
)
/

ALTER TABLE Ya_Dept_Lang
ADD CONSTRAINT PK_Dept_Lang PRIMARY KEY (dept_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Lang FOR Ya_Dept_Lang
/