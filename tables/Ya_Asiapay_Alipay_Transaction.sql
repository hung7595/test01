DROP TABLE Ya_Asiapay_Alipay_Transaction
/

CREATE TABLE Ya_Asiapay_Alipay_Transaction (
	id                number          NOT NULL ,
	shopper_id        char(32)        NOT NULL ,
	site_id           int             NOT NULL ,
	ya_ref_id         char(32)        NOT NULL ,
	order_num         number          ,
	order_amt         number(20,2)    ,
	order_currency    char(3)         ,
	pay_dollar_ref    number          ,
	sts               number          NOT NULL ,
	create_dt         date            NOT NULL ,
	mod_dt            date            NOT NULL
)
/


ALTER TABLE Ya_Asiapay_Alipay_Transaction
ADD CONSTRAINT PK_Asiapay_Alipay_Transaction PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asiapay_Alipay_Transaction FOR Ya_Asiapay_Alipay_Transaction
/

