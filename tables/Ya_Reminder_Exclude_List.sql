DROP TABLE Ya_Reminder_Exclude_List
/

CREATE TABLE Ya_Reminder_Exclude_List (
	shopper_id                         char(32)                   NOT NULL ,
	reminder_id                        int                        NOT NULL ,
	last_modified_datetime             date                       DEFAULT SYSDATE NOT NULL ,
	site_id                            int                        NOT NULL ,
	rowguid                            varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Reminder_Exclude_List
ADD CONSTRAINT PK_Reminder_Exclude_List PRIMARY KEY (shopper_id, reminder_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Reminder_Exclude_List_01 ON Ya_Reminder_Exclude_List(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Reminder_Exclude_List FOR Ya_Reminder_Exclude_List
/