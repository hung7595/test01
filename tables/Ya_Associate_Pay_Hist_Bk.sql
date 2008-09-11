DROP TABLE Ya_Associate_Pay_Hist_Bk
/

CREATE TABLE Ya_Associate_Pay_Hist_Bk (
	associate_id                  int                       NOT NULL ,
	pay_date                      date                      DEFAULT SYSDATE NOT NULL ,
	amount_paid                   number(18,2)              NOT NULL ,
	cheque_num                    varchar2(30)              ,
	rowguid                       varchar2(50)              DEFAULT SYS_GUID() NOT NULL ,
	payment_option                int                       DEFAULT 1 NOT NULL
)
/