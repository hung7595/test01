DROP TABLE Ya_Themestore_Subscribe
/

CREATE TABLE Ya_Themestore_Subscribe (
	themestore_id             int                        NOT NULL ,
	email                     varchar2(500)              NOT NULL ,
	shipping_address          nclob                      ,
	created_datetime          date                       DEFAULT SYSDATE,
	check_num                 nvarchar2(300)             ,
	active                    int                        DEFAULT 0 ,
	actived_datetime          date                       ,
	rowguid                   varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Subscribe
ADD CONSTRAINT PK_Themestore_Subscribe PRIMARY KEY (themestore_id, email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Subscribe FOR Ya_Themestore_Subscribe
/