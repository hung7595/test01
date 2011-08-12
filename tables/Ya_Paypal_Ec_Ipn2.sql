DROP TABLE Ya_Paypal_Ec_Ipn2
/

CREATE TABLE Ya_Paypal_Ec_Ipn2 (
	id                      int                  NOT NULL ,
	ya_ref_id               char(32)             ,
	verify_sign             varchar2(128)        ,
	ec_transaction_id       nvarchar2(19)        ,
	receiver_email          varchar2(127)        ,
	receiver_id             char(13)             ,
	resend                  varchar2(5)          ,
	residence_country       varchar2(5)          ,
	txn_type                varchar2(50)         ,
	payer_email             varchar2(127)        ,
	payer_id                nvarchar2(13)        ,
	mc_currency             char(3)              ,
	mc_fee                  number(18, 2)        ,
	mc_gross                number(18, 2)        ,
	mc_handling             number(18, 2)        ,
	mc_shipping             number(18, 2)        ,
	payer_sts               varchar2(10)         ,
	payment_sts             varchar2(50)         ,
	payment_type            varchar2(50)         ,
	pending_reason          varchar2(50)         ,
	reason_code             varchar2(127)        ,
	payment_dt              date                 ,
	create_dt               date                 NOT NULL 
)
/

ALTER TABLE Ya_Paypal_Ec_Ipn2
ADD CONSTRAINT PK_Paypal_Ec_Ipn2 PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Paypal_Ec_Ipn2 FOR Ya_Paypal_Ec_Ipn2
/
