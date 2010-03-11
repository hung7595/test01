DROP TABLE Ya_Email_Update_Log
/

CREATE TABLE Ya_Email_Update_Log (
	id                           int               NOT NULL ,
	last_subscriber_id           number            NOT NULL ,
	last_order_fulfilled_dt      date              NOT NULL
)
/

ALTER TABLE Ya_Email_Update_Log
ADD CONSTRAINT PK_Email_Update_Log PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Email_Update_Log FOR Ya_Email_Update_Log
/
