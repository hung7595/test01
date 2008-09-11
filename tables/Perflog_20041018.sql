DROP TABLE Perflog_20041018   
/

CREATE TABLE Perflog_20041018 (
	logdate                   date                       ,
	spid                      int                        NOT NULL ,
	loginname                 varchar2(20)               ,
	blocked                   int                        NOT NULL ,
	program_name              varchar2(50)               ,
	hostname                  varchar2(15)               ,
	cpu                       int                        ,
	diskio                    int                        ,
	memory                    int                        ,
	startwait                 int                        NOT NULL ,
	endwait                   int                        NOT NULL ,
	startcmd                  nchar(16)                  NOT NULL ,
	endcmd                    nchar(16)                  NOT NULL ,
	perv_status               nchar(30)                  NOT NULL ,
	curr_status               nchar(30)                  NOT NULL
)
/


CREATE PUBLIC SYNONYM Perflog_20041018 FOR Perflog_20041018
/