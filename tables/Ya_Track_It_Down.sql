DROP TABLE Ya_Track_It_Down
/

CREATE TABLE Ya_Track_It_Down (
	site_id                        int                        NOT NULL ,
	sku                            int                        NOT NULL ,
	email                          varchar2(50)               NOT NULL ,
	subscribe_datetime             date                       DEFAULT SYSDATE NOT NULL ,
	notified_datetime              date                       ,
	notification_type              int                        ,
	last_po_datetime               date                       ,
	po_count                       int                        DEFAULT 0 NOT NULL ,
	rowguid                        varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Track_It_Down
ADD CONSTRAINT PK_Track_It_Down PRIMARY KEY (site_id, sku, email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Track_It_Down_01 ON Ya_Track_It_Down(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Track_It_Down FOR Ya_Track_It_Down
/