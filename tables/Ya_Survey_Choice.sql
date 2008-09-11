DROP TABLE Ya_Survey_Choice
/

CREATE TABLE Ya_Survey_Choice (
	survey_id               int                        NOT NULL ,
	question_id             int                        NOT NULL ,
	code                    int                        NOT NULL ,
	text_entry              char(1)                    DEFAULT 'N' NOT NULL ,
	rowguid                 varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey_Choice
ADD CONSTRAINT PK_Survey_Choice PRIMARY KEY (survey_id, question_id, code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_Choice_01 ON Ya_Survey_Choice(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Choice FOR Ya_Survey_Choice
/


create or replace TRIGGER TRI_survey_choice
BEFORE INSERT OR UPDATE OF text_entry
ON ya_survey_choice
FOR EACH ROW
BEGIN
	:NEW.text_entry := UPPER(:NEW.text_entry);
END;