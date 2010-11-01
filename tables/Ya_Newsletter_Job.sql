Drop Table Ya_Newsletter_Job
/

CREATE TABLE Ya_Newsletter_Job (
	id                               int                 NOT NULL ,
	newsletter_id                    int                 NOT NULL ,
	associate_link_id                int                 NOT NULL ,
	status                           int                 NOT NULL ,
	start_time                       date                ,
	end_time                         date                ,
	sample_email_content             clob                ,
	error_email_list_path            varchar2(100)       ,
	job_detail_id                    int                 NOT NULL
)
/

ALTER TABLE Ya_Newsletter_Job
ADD CONSTRAINT PK_Newsletter_Job PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Newsletter_Job
ADD CONSTRAINT FK_Ya_Newsletter_Job_01  FOREIGN KEY (newsletter_id)
REFERENCES Ya_Newsletter(id)
/


CREATE PUBLIC SYNONYM Ya_Newsletter_Job FOR Ya_Newsletter_Job
/
