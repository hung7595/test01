DROP TABLE DB_Timing_Log
/

CREATE TABLE DB_Timing_Log (
	trial_id                    int                          NOT NULL ,
	db                          varchar2(50)                 NOT NULL ,
	method_name                 varchar2(100)                NOT NULL ,
	parameter                   nvarchar2(4000)              ,
	run_time                    number(38,2)                 NOT NULL ,
	created_datetime            date                         DEFAULT SYSDATE NOT NULL ,
	remark                      nvarchar2(2000)	
)
/