DROP TABLE Ya_Dept
/

CREATE TABLE Ya_Dept (
	dept_id                 int                     NOT NULL ,
	created_date            date                    ,
	updated_date            date                    ,
	created_user            varchar2(20)            ,
	updated_user            varchar2(20)            ,
	is_adult                char(1)                 DEFAULT 'N' NOT NULL
)
/

ALTER TABLE Ya_Dept
ADD CONSTRAINT PK_Dept PRIMARY KEY (dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept FOR Ya_Dept
/