DROP TABLE Ya_Filter_Log
/

CREATE TABLE Ya_Filter_Log (
	upper_sku                               int                        NOT NULL ,
	lower_sku                               int                        NOT NULL ,
	server_id                               char(20)                   NOT NULL ,
	counter                                 int                        NOT NULL ,
	last_batch_start_datetime               date                       DEFAULT SYSDATE ,
	last_batch_end_datetime                 date                       DEFAULT SYSDATE
)
/

ALTER TABLE Ya_Filter_Log
ADD CONSTRAINT PK_Filter_Log PRIMARY KEY (server_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Filter_Log FOR Ya_Filter_Log
/