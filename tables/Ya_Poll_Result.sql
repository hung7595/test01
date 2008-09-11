DROP TABLE Ya_Poll_Result
/

CREATE TABLE Ya_Poll_Result (
	poll_id                     int                       NOT NULL ,
	item_id                     int                       NOT NULL ,
	result_count                int                       NOT NULL ,
	last_update                 date                      NOT NULL ,
	rowguid                     varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Poll_Result
ADD CONSTRAINT PK_Poll_Result PRIMARY KEY (poll_id, item_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Poll_Result_01 ON Ya_Poll_Result(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Poll_Result FOR Ya_Poll_Result
/