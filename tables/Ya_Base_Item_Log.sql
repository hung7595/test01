DROP TABLE Ya_Base_Item_Log
/

CREATE TABLE Ya_Base_Item_Log (
	upper_sku                                 int                     NOT NULL ,
	lower_sku                                 int                     NOT NULL ,
	counter                                   int                     DEFAULT 0 NOT NULL ,
	server_id                                 varchar2(20)            NOT NULL ,
	last_batch_start_datetime                 date                    DEFAULT SYSDATE,
	last_batch_end_datetime                   date	                  DEFAULT SYSDATE
)
/


ALTER TABLE Ya_Base_Item_Log
ADD CONSTRAINT PK_Base_Item_Log PRIMARY KEY (server_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Base_Item_Log FOR Ya_Base_Item_Log
/