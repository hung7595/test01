DROP TABLE Ya_Themestore_Poll
/

CREATE TABLE Ya_Themestore_Poll (
	poll_id                         int                        NOT NULL ,
	poll_topic                      nvarchar2(500)             NOT NULL ,
	site_id                         int                        ,
	created_datetime                date                       NOT NULL ,
	theme_id                        int                        NOT NULL ,
	rowguid                         varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Poll
ADD CONSTRAINT PK_Themestore_Poll PRIMARY KEY (poll_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Themestore_Poll_01 ON Ya_Themestore_Poll(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Themestore_Poll_02 ON Ya_Themestore_Poll(theme_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Poll FOR Ya_Themestore_Poll
/