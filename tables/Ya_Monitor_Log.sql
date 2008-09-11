DROP TABLE Ya_Monitor_Log
/

CREATE TABLE Ya_Monitor_Log (
	monitor_id                       varchar2(19)                   NOT NULL ,
	referrer_link                    varchar2(512)                  ,
	transaction_datetime             date                           DEFAULT SYSDATE NOT NULL ,
	shopper_id                       char(32)                       ,
	rowguid                          varchar2(50)                   DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Monitor_Log
ADD CONSTRAINT PK_Monitor_Log PRIMARY KEY (rowguid)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Monitor_Log_01 ON Ya_Monitor_Log(transaction_datetime) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Monitor_Log FOR Ya_Monitor_Log
/