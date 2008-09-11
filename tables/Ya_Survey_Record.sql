DROP TABLE Ya_Survey_Record
/

CREATE TABLE Ya_Survey_Record (
	record_id                    char(32)                   NOT NULL ,
	survey_id                    int                        NOT NULL ,
	shopper_id                   char(32)                   NOT NULL ,
	email                        varchar2(255)              NOT NULL ,
	site_id                      int                        NOT NULL ,
	created_datetime             date                       DEFAULT SYSDATE NOT NULL ,
	rowguid                      varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey_Record
ADD CONSTRAINT PK_Survey_Record PRIMARY KEY (record_id, survey_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_Record_01 ON Ya_Survey_Record(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Record FOR Ya_Survey_Record
/