DROP TABLE Ya_CustomerUpdate_Payment_Log
/

CREATE TABLE Ya_CustomerUpdate_Payment_Log (
	payment_log_id                   int                          NOT NULL ,
	shopper_id                       char(32)                     ,
	status                           int                          ,
	order_id                         int                          ,
	updated_date                     date                         ,
	payment_method                   int                          ,
	auth_code                        nvarchar2(200)               ,
	avs_code                         nvarchar2(200)               ,
	request_id                       nvarchar2(200)               ,
	firstname                        nvarchar2(400)               ,
	lastname                         nvarchar2(400)               ,
	email                            nvarchar2(510)               ,
	phone                            nvarchar2(200)               ,
	address1                         nvarchar2(510)               ,
	address2                         nvarchar2(510)               ,
	city                             nvarchar2(510)               ,
	state_code                       int                          ,
	state                            nvarchar2(510)               ,
	zip                              nvarchar2(200)               ,
	country                          int                          ,
	cc_type                          int                          ,
	cc_number                        varchar2(40)                 ,
	cc_exp_month                     varchar2(4)                  ,
	cc_exp_year                      varchar2(8)                  ,
	coupon_code                      varchar2(32)                 ,
	coupon_amount                    number(18,2)                 ,
	credit_amount                    number(18,2)                 ,
	currency                         varchar2(6)                  ,
	rowguid                          varchar2(50)                 DEFAULT SYS_GUID() NOT NULL ,
	cc_numberencrypted               varchar2(128)                ,
	encryptionkey                    int                          DEFAULT 0 ,
	auth_amount                      number(18,2)
)
/

ALTER TABLE Ya_CustomerUpdate_Payment_Log
ADD CONSTRAINT PK_CustomerUpdate_Payment_Log PRIMARY KEY (payment_log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CustomerUpdate_Payment_Log FOR Ya_CustomerUpdate_Payment_Log
/