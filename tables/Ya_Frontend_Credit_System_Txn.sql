DROP TABLE Ya_Frontend_Credit_System_Txn
/

CREATE TABLE Ya_Frontend_Credit_System_Txn (
	credit_id                       int                        NOT NULL ,
	credit_amount                   number(18,2)               ,
	credit_ordernum                 int                        ,
	debit_amount                    number(18,2)               ,
	debit_ordernum                  int                        ,
	snapshot_balance                number(18,2)               ,
	transaction_id                  char(32)                   DEFAULT SYS_GUID() NOT NULL ,
	transaction_datetime            date                       DEFAULT SYSDATE NOT NULL ,
	transaction_remark              varchar2(500)              ,        
	rowguid                         varchar2(50)               DEFAULT SYS_GUID() NOT NULL ,
	action_id                       int                        ,
	credit_credit_id                int                        ,
	debit_credit_id                 int
)
/

ALTER TABLE Ya_Frontend_Credit_System_Txn
ADD CONSTRAINT PK_Frontend_Credit_System_Txn PRIMARY KEY (credit_id, transaction_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Frontend_Credit_System_Txn FOR Ya_Frontend_Credit_System_Txn
/