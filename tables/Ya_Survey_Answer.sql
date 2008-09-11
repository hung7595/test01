DROP TABLE Ya_Survey_Answer
/

CREATE TABLE Ya_Survey_Answer (
	site_id                     int                        NOT NULL ,
	survey_code                 int                        NOT NULL ,
	survey_name                 varchar2(50)               ,
	email                       varchar2(255)              NOT NULL ,
	answer_datetime             date                       DEFAULT SYSDATE NOT NULL ,
	question_id                 varchar2(50)               NOT NULL ,
	question_answer             varchar2(2048)             NOT NULL ,
	rowguid                     varchar2(50)               DEFAULT SYS_GUID() NOT NULL ,
	name                        varchar2(50)               ,
	shopper_id                  varchar2(32)
)	
/

ALTER TABLE Ya_Survey_Answer
ADD CONSTRAINT PK_Survey_Answer PRIMARY KEY (site_id, survey_code, email, question_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_Answer_01 ON Ya_Survey_Answer(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Answer FOR Ya_Survey_Answer
/