DROP TABLE Ya_Themestore_Vote_Temp
/

CREATE TABLE Ya_Themestore_Vote_Temp (
	themestore_id                int                           NOT NULL ,
	email                        nvarchar2(100)                NOT NULL ,
	item_id                      int                           ,
	lang_id                      int                           ,
	item_desc                    nvarchar2(100)                ,
	rowguid                      char(50)                      DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Vote_Temp
ADD CONSTRAINT PK_Themestore_Vote_Temp PRIMARY KEY (themestore_id, email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Themestore_Vote_Temp_01 ON Ya_Themestore_Vote_Temp(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Vote_Temp FOR Ya_Themestore_Vote_Temp
/