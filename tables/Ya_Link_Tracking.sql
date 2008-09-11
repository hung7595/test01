DROP TABLE Ya_Link_Tracking
/

CREATE TABLE Ya_Link_Tracking (
	rec_id                      int                      NOT NULL ,
	data_type                   varchar2(200)            NOT NULL ,
	data_value                  varchar2(500)            NOT NULL ,
	rowguid                     varchar2(50)             DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Link_Tracking
ADD CONSTRAINT PK_Link_Tracking PRIMARY KEY (rec_id, data_type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Link_Tracking FOR Ya_Link_Tracking
/