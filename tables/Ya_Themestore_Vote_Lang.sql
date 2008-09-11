DROP TABLE Ya_Themestore_Vote_Lang
/

CREATE TABLE Ya_Themestore_Vote_Lang (
	item_id                 int                        NOT NULL ,
	lang_id                 int                        NOT NULL ,
	item_desc               nvarchar2(100)             ,
	rowguid                 char(50)                   DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Vote_Lang
ADD CONSTRAINT PK_Themestore_Vote_Lang PRIMARY KEY (item_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Themestore_Vote_Lang_01 ON Ya_Themestore_Vote_Lang(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Vote_Lang FOR Ya_Themestore_Vote_Lang
/