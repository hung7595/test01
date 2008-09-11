DROP TABLE Ya_Payment
/

CREATE TABLE Ya_Payment (
	payment_id                          int                            NOT NULL ,
	order_id                            char(32)                       ,
	order_num                           varchar2(50)                   ,
	payment_type                        varchar2(50)                   ,
	check_number                        varchar2(50)                   ,
	check_amount                        int                            ,
	check_date                          date                           ,
	shopper_id                          char(32)                       ,
	firstname_on_card                   varchar2(100)                  ,
	lastname_on_card                    varchar2(100)                  ,
	credit_card_type                    varchar2(50)                   ,
	expiration_date                     date                           ,
	address1                            varchar2(255)                  ,
	address2                            varchar2(255)                  ,
	state                               varchar2(50)                   ,
	zip                                 varchar2(50)                   ,
	day_phone                           varchar2(20)                   ,
	eve_phone                           varchar2(20)                   ,
	mobile_phone                        varchar2(20)                   ,
	card_number                         varchar2(20)                   ,
	email                               varchar2(255)                  ,
	country_id                          int                            ,
	city                                varchar2(50)                   ,
	cc_auth_code                        varchar2(50) 
)
/

ALTER TABLE Ya_Payment
ADD CONSTRAINT PK_Payment PRIMARY KEY (payment_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Payment FOR Ya_Payment
/