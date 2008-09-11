DROP TABLE Ya_Email_OpenedEMail
/

CREATE TABLE Ya_Email_OpenedEMail (
	email_message_id           int                           NOT NULL ,
	email                      varchar2(50)                  NOT NULL ,
	created_datetime           date                          DEFAULT SYSDATE NOT NULL ,
	rowguid                    varchar2(50)                  DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Email_OpenedEMail
ADD CONSTRAINT PK_Email_OpenedEMail PRIMARY KEY (email_message_id, email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Email_OpenedEMail FOR Ya_Email_OpenedEMail
/