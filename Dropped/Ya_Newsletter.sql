DROP TABLE Ya_Newsletter
/

CREATE TABLE Ya_Newsletter (
	newsletter_id                    int                      NOT NULL ,
	newsletter_name                  varchar2(255)            NOT NULL
)
/

ALTER TABLE Ya_Newsletter
ADD CONSTRAINT PK_Newsletter PRIMARY KEY (newsletter_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Newsletter FOR Ya_Newsletter
/