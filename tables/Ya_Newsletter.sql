Drop Table Ya_Newsletter
/

CREATE TABLE Ya_Newsletter (
	id                              int                 NOT NULL ,
	type                            int                 NOT NULL ,
	name                            varchar2(50)        NOT NULL ,
	is_enabled                      char(1)             NOT NULL ,
	template_id                     int                 NOT NULL ,
	job_detail_id                   int                 NOT NULL ,
	schedule_cron_expression        varchar2(255)       ,
	is_biweekly_schedule            char(1)             NOT NULL ,
	next_scheduled_time             date                ,
	last_scheduled_time             date                ,
	create_user                     varchar2(50)        NOT NULL ,
	create_dt                       date                NOT NULL ,
	mod_user                        varchar2(50)        NOT NULL ,
	mod_dt                          date                NOT NULL	
)
/

ALTER TABLE Ya_Newsletter
ADD CONSTRAINT PK_Newsletter PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Newsletter
ADD CONSTRAINT FK_Ya_Newsletter_01  FOREIGN KEY (template_id)
REFERENCES Ya_Template(id)
/


CREATE PUBLIC SYNONYM Ya_Newsletter FOR Ya_Newsletter
/
