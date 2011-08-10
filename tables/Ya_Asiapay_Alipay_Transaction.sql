CREATE TABLE Ya_Asiapay_Alipay_Transaction (
	id                     number          NOT NULL,
	shopper_id             char(32)        NOT NULL,
	payment_uid            char(32)        NOT NULL,
	order_num              number          ,
	paydollar_ref          number          ,
	payment_txn_id         char(32)        ,
	created_datetime       date            NOT NULL,
	updated_datetime       date            NOT NULL,
	status                 number          NOT NULL
)
/


ALTER TABLE Ya_Asiapay_Alipay_Transaction
ADD CONSTRAINT PK_Asiapay_Alipay_Transaction PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asiapay_Alipay_Transaction FOR Ya_Asiapay_Alipay_Transaction
/

