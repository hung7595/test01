DROP TABLE Ya_Survey
/

CREATE TABLE Ya_Survey (
	survey_id                    int                        NOT NULL ,
	created_datetime             date                       DEFAULT SYSDATE NOT NULL ,
	rowguid                      varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey
ADD CONSTRAINT PK_Survey PRIMARY KEY (survey_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_01 ON Ya_Survey(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey FOR Ya_Survey
/