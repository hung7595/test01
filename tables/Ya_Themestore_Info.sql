DROP TABLE Ya_Themestore_Info
/

CREATE TABLE Ya_Themestore_Info (
	theme_id                int                        NOT NULL ,
	name                    nvarchar2(50)              NOT NULL ,
	rowguid                 varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Info
ADD CONSTRAINT PK_Themestore_Info PRIMARY KEY (theme_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Themestore_Info_01 ON Ya_Themestore_Info(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Info FOR Ya_Themestore_Info
/