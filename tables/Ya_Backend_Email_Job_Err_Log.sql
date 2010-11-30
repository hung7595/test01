DROP TABLE Ya_Backend_Email_Job_Err_Log
/

CREATE TABLE Ya_Backend_Email_Job_Err_Log (
	id                        int             NOT NULL ,
	ya_backend_email_job_id   int             NOT NULL ,
	type                      int             NOT NULL ,
	subject                   varchar2(255)   NOT NULL ,
	from_email                varchar2(255)   NOT NULL ,
	error_to_emails           varchar2(255)   ,
	error_cc_emails           varchar2(255)   ,
	error_bcc_emails          varchar2(255)   ,
	content                   clob            NOT NULL ,
	remark                    clob            ,
	create_user               varchar2(50)    NOT NULL ,
	create_dt                 date            NOT NULL
)
/

ALTER TABLE Ya_Backend_Email_Job_Err_Log
ADD CONSTRAINT PK_Backend_Email_Job_Err_Log PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Backend_Email_Job_Err_Log
ADD CONSTRAINT FK_Backend_Email_Job_ErrLog_01 FOREIGN KEY (ya_backend_email_job_id)
REFERENCES ya_backend_email_job(id)
/


CREATE PUBLIC SYNONYM Ya_Backend_Email_Job_Err_Log FOR Ya_Backend_Email_Job_Err_Log
/
