CREATE TABLE Ya_Asiapay_Alipay_Datafeed ( 
	id                   number           NOT NULL,
	src                  number           , 
	prc                  number           , 
	ord                  number           ,
	holder               varchar2(50)     ,
	success_code         number           ,
	ref                  char(32)         ,
	pay_ref              varchar2(50)     ,
	amount               number(15,5)     ,
	cur                  char(3)          ,
	remark               varchar2(200)    ,
	source_ip            varchar2(15)     ,
	ip_country           char(3)          , 
	created_datetime     date             NOT NULL
)
/


ALTER TABLE Ya_Asiapay_Alipay_Datafeed
ADD CONSTRAINT PK_Asiapay_Alipay_Datafeed PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asiapay_Alipay_Datafeed FOR Ya_Asiapay_Alipay_Datafeed
/

