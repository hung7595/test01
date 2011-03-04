DROP TABLE Ya_Topseller_Dept
/

CREATE TABLE Ya_Topseller_Dept
(
	dept_id        int            NOT NULL,
	dept_name      varchar2(50)   ,
	top_count      int            ,
	frondend_count int            ,
	is_enabled     char(1)        NOT NULL
)
/

ALTER TABLE Ya_Topseller_Dept
ADD CONSTRAINT PK_Topseller_Dept PRIMARY KEY (dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Topseller_Dept for Ya_Topseller_Dept
/