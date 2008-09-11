DROP TABLE Results_01   
/

CREATE TABLE Results_01 (
	guid                              char(32)                    NOT NULL ,
	email                             varchar2(50)                NOT NULL ,
	date_time                         date                        ,
	last_modified_datetime            date                        ,
	site_id                           number(3)                   NOT NULL ,
	newsletter_id                     number(3)                   NOT NULL ,
	status                            varchar2(1)                 ,
	pending_status                    varchar2(1)                 ,
	downloaded_flag                   char(1)                     NOT NULL ,
	rowguid                           varchar2(50)   
)
/