DROP TABLE Ya_Survey_Question_Lang
/

CREATE TABLE Ya_Survey_Question_Lang (
	survey_id                    int                        NOT NULL ,
	question_id                  int                        NOT NULL ,
	lang_id                      int                        NOT NULL ,
	question                     varchar2(500)              DEFAULT 1 NOT NULL ,
	rowguid                      varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey_Question_Lang
ADD CONSTRAINT PK_Survey_Question_Lang PRIMARY KEY (survey_id, question_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_Question_Lang_01 ON Ya_Survey_Question_Lang(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Question_Lang FOR Ya_Survey_Question_Lang
/