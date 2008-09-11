DROP TABLE Chk_Asso_Comm_Hist   
/

CREATE TABLE Chk_Asso_Comm_Hist (
	associate_id             int                          ,
	valid_date               date                         ,
	comm_rate                number(9,18)                 ,
	payment_option           int                          ,
	rowguid                  varchar2(50)                 ,
	markdt                   date                         ,
	actionhost               nvarchar2(200)               DEFAULT SYS_CONTEXT('USERENV', 'HOST')
)
/


CREATE PUBLIC SYNONYM Chk_Asso_Comm_Hist FOR Chk_Asso_Comm_Hist
/