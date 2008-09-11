DROP TABLE Tmp_Monitor_Log
/

CREATE TABLE Tmp_Monitor_Log (
	monitor_id                        varchar2(16)               NOT NULL ,
	referrer_link                     varchar2(512)              ,
	transaction_datetime              date                       NOT NULL ,
	shopper_id                        char(32)                   ,
	rowguid                           varchar2(50)               NOT NULL
)
/


CREATE PUBLIC SYNONYM Tmp_Monitor_Log FOR Tmp_Monitor_Log
/