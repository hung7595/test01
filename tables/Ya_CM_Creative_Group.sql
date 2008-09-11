DROP TABLE Ya_CM_Creative_Group
/

CREATE TABLE Ya_CM_Creative_Group (
	creative_group_id            int                      NOT NULL ,
	title                        varchar2(100)            NOT NULL ,
	description                  varchar2(255)            ,
	dept_id                      int                      ,
	enable                       char(1)
)
/

ALTER TABLE Ya_CM_Creative_Group
ADD CONSTRAINT PK_CM_Creative_Group PRIMARY KEY (creative_group_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CM_Creative_Group FOR Ya_CM_Creative_Group
/