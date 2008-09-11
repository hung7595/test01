DROP TABLE Ya_Email_ClickedEMail
/

CREATE TABLE Ya_Email_ClickedEMail (
	email_message_id           int                           NOT NULL ,
	email                      varchar2(50)                  NOT NULL ,
	created_datetime           date                          DEFAULT SYSDATE NOT NULL ,
	rowguid                    varchar2(50)                  DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Email_ClickedEMail
ADD CONSTRAINT PK_Email_ClickedEMail PRIMARY KEY (email_message_id, email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Email_ClickedEMail FOR Ya_Email_ClickedEMail
/