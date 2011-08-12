DROP TABLE Ya_Asiapay_Alipay_Datafeed
/

CREATE TABLE Ya_Asiapay_Alipay_Datafeed ( 
	id                           number             NOT NULL,
	ya_ref_id                    char(32)          ,
	primary_host_status_code     number            ,
	secondary_host_status_code   number            ,
	bank_ref_order_id            number            ,
	holder_name                  varchar2(50)      ,
	success_code                 number            ,
	pay_dollar_ref               number            ,
	amount                       number(15,5)      ,
	currency                     char(3)           ,
	remark                       varchar2(200)     ,
	payer_ip_address             varchar2(15)      ,
	payer_country                char(3)           ,
	create_dt                    date              NOT NULL
)
/


ALTER TABLE Ya_Asiapay_Alipay_Datafeed
ADD CONSTRAINT PK_Asiapay_Alipay_Datafeed PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asiapay_Alipay_Datafeed FOR Ya_Asiapay_Alipay_Datafeed
/

