DROP TABLE Bk_Ya_Fe_Credit_System_Tran   
/

CREATE TABLE Bk_Ya_Fe_Credit_System_Tran (
	credit_id                    int                     NOT NULL ,
	credit_amount                number(18,2)            ,
	credit_ordernum              int                     ,
	debit_amount                 number(18,2)            ,
	debit_ordernum               int                     ,
	snapshot_balance             number(18,2)            ,
	transaction_id               char(32)                NOT NULL ,
	transaction_datetime         date                    NOT NULL ,
	transaction_remark           varchar2(500)           ,
	rowguid                      varchar2(50)            NOT NULL
)
/


CREATE PUBLIC SYNONYM Bk_Ya_Fe_Credit_System_Tran FOR Bk_Ya_Fe_Credit_System_Tran
/