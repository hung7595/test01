DROP TABLE Ya_Asset_Log
/

CREATE TABLE Ya_Asset_Log (
	log_id                 int                      NOT NULL ,
	type                   int                      ,
	username               varchar2(30)             ,
	ts                     date
)
/

ALTER TABLE Ya_Asset_Log
ADD CONSTRAINT PK_Asset_Log PRIMARY KEY (log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset_Log FOR Ya_Asset_Log
/