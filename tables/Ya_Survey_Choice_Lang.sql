DROP TABLE Ya_Survey_Choice_Lang
/

CREATE TABLE Ya_Survey_Choice_Lang (
	survey_id               int                        NOT NULL ,
	question_id             int                        NOT NULL ,
	code                    int                        NOT NULL ,
	lang_id                 int                        NOT NULL ,
	content                 varchar2(50)               NOT NULL ,
	rowguid                 varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey_Choice_Lang
ADD CONSTRAINT PK_Survey_Choice_Lang PRIMARY KEY (survey_id, question_id, code, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_Choice_Lang_01 ON Ya_Survey_Choice_Lang(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Choice_Lang FOR Ya_Survey_Choice_Lang
/