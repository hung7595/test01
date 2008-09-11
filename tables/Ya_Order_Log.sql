DROP TABLE Ya_Order_Log
/

CREATE TABLE Ya_Order_Log (
	order_id                       char(32)                     ,
	order_num                      int                          ,
	order_line_id                  int                          ,
	action_type_id                 int                          ,
	action_id                      int                          ,
	action_date                    date                         ,
	action_quantity                int                          ,
	action_reason                  varchar2(500)                ,
	other_info                     varchar2(500)                ,
	tracking_num                   varchar2(50)                 ,
	action_amount                  number(18,2)                 ,
	action_user                    varchar2(100)                ,
	office_id                      int                          ,
	batch_id                       int                          ,
	log_type_id                    int                          ,
	rowguid                        varchar2(50)                 DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Order_Log
ADD CONSTRAINT PK_Order_Log PRIMARY KEY (order_id, row_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Order_Log_01 ON Ya_Order_Log(order_num) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_Log_02 ON Ya_Order_Log(order_num, action_type_id, action_id, action_amount, action_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_Log_03 ON Ya_Order_Log(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_Log_04 ON Ya_Order_Log(batch_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_Log_05 ON Ya_Order_Log(order_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_Log FOR Ya_Order_Log
/