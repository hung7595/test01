DROP TABLE Ya_Link_Tracking_Log
/

CREATE TABLE Ya_Link_Tracking_Log (
	rec_id                       int                    NOT NULL ,
	tracking_type                varchar2(128)          NOT NULL ,
	created_datetime             date                   NOT NULL ,
	url_referer                  varchar2(256)          ,
	rowguid                      varchar2(50)           DEFAULT SYS_GUID() NOT NULL
	
)
/

ALTER TABLE Ya_Link_Tracking_Log
ADD CONSTRAINT PK_Link_Tracking_Log PRIMARY KEY (rec_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Link_Tracking_Log FOR Ya_Link_Tracking_Log
/