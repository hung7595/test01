DROP TABLE Ya_Poll
/

CREATE TABLE Ya_Poll (
	poll_id                      int                     NOT NULL ,
	poll_topic                   varchar2(500)           ,
	site_id                      int                     ,
	created_datetime             date                    NOT NULL ,
	rowguid                      varchar2(50)            DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Poll
ADD CONSTRAINT PK_Poll PRIMARY KEY (poll_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Poll_01 ON Ya_Poll(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Poll FOR Ya_Poll
/