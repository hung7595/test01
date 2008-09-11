DROP TABLE Ya_Publisher_Dept
/

CREATE TABLE Ya_Publisher_Dept (
	publisher_id               int                        NOT NULL ,
	dept_id                    int                        NOT NULL
)	
/

ALTER TABLE Ya_Publisher_Dept
ADD CONSTRAINT PK_Publisher_Dept PRIMARY KEY (publisher_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Dept FOR Ya_Publisher_Dept
/