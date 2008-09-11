DROP TABLE Ya_Survey_Question
/

CREATE TABLE Ya_Survey_Question (
	survey_id                    int                        NOT NULL ,
	question_id                  int                        NOT NULL ,
	type_id                      int                        NOT NULL ,
	rowguid                      varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey_Question
ADD CONSTRAINT PK_Survey_Question PRIMARY KEY (survey_id, question_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Survey_Question ON Ya_Survey_Question(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Question FOR Ya_Survey_Question
/