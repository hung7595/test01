DROP TABLE Ya_Newsletter_Sent_Record
/

CREATE TABLE Ya_Newsletter_Sent_Record (
	site_id                  int             NOT NULL ,
	newsletter_id            int             NOT NULL ,
	newsletter_string        varchar2(50)    ,
	email_sent_count         int             ,
	sent_date                date            NOT NULL
)
/

ALTER TABLE Ya_Newsletter_Sent_Record
ADD CONSTRAINT PK_Newsletter_Sent_Record PRIMARY KEY (site_id, newsletter_id, sent_date)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Newsletter_Sent_Record FOR Ya_Newsletter_Sent_Record
/
