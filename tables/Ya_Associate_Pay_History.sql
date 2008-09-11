DROP TABLE Ya_Associate_Pay_History
/

CREATE TABLE Ya_Associate_Pay_History (
	associate_id                   int                     NOT NULL ,
	pay_date                       date                    NOT NULL ,
	amount_paid                    number(18,2)            NOT NULL
	cheque_num                     varchar2(30)            ,
	rowguid                        varchar2(50)            DEFAULT SYS_GUID() NOT NULL ,
	payment_option                 int                     NOT NULL ,
	id                             int                     NOT NULL
)
/

ALTER TABLE Ya_Associate_Pay_History
ADD CONSTRAINT PK_Associate_Pay_History PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Pay_History FOR Ya_Associate_Pay_History
/