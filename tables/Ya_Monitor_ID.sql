DROP TABLE Ya_Monitor_ID
/

CREATE TABLE Ya_Monitor_ID (
	monitor_id                    varchar2(20)                      NOT NULL ,
	used_flag                     varchar2(1)
)
/


CREATE PUBLIC SYNONYM Ya_Monitor_ID FOR Ya_Monitor_ID
/