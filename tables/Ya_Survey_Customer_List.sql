DROP TABLE Ya_Survey_Customer_List
/

CREATE TABLE Ya_Survey_Customer_List (
	shopper_id                   char(32)                    NOT NULL ,
	survey_code                  number                      NOT NULL ,
	email                        varchar2(255)               ,
	completed                    char(1)                     NOT NULL ,
	created_datetime             date                        NOT NULL ,
	updated_datetime             date
)	
/

ALTER TABLE Ya_Survey_Customer_List
ADD CONSTRAINT PK_Survey_Customer_List PRIMARY KEY (shopper_id, survey_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Customer_List FOR Ya_Survey_Customer_List
/