DROP TABLE Ya_Themestore_Sub_Add_Info
/

CREATE TABLE Ya_Themestore_Sub_Add_Info (
	themestore_id             int                        NOT NULL ,
	email                     nvarchar2(100)             NOT NULL ,
	name                      nvarchar2(100)             NOT NULL ,
	location                  int                        NOT NULL ,
	rowguid                   varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Sub_Add_Info
ADD CONSTRAINT PK_Themestore_Sub_Add_Info PRIMARY KEY (themestore_id, email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Sub_Add_Info FOR Ya_Themestore_Sub_Add_Info
/