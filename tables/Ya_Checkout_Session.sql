DROP TABLE Ya_Checkout_Session
/

CREATE TABLE Ya_Checkout_Session (
	id                                 int                   ,
	shopper_id                         char(32)              NOT NULL ,
	site_id                            int                   NOT NULL ,
	associate_code                     nvarchar2(100)        ,
	split_shipment                     char(1)               DEFAULT 'N' NOT NULL ,
	shipping_address_id                int                   ,
	preferred_shipping_address_id      int                   ,
	shipping_method_id                 int                   NOT NULL ,
	payment_method_id                  int                   NOT NULL ,
	billing_address_id                 int                   ,
	preferred_billing_address_id       int                   ,
	cc_profile_id                      int                   ,
	preferred_cc_profile_id            int                   ,
	cvv_code                           nvarchar2(100)        ,
	coupon_code                        nvarchar2(100)        ,
	credit_amount                      number(18,2)          ,
	credit_currency                    char(3)               ,
	bank_name                          nvarchar2(100)        ,
	bank_phone                         nvarchar2(100)        ,
	comments                           nvarchar2(200)        ,
	order_currency                     char(3)               ,
	created_date                       date                  NOT NULL ,
	modified_date                      date                  NOT NULL
)
/

ALTER TABLE Ya_Checkout_Session 
ADD CONSTRAINT PK_Ya_Checkout_Session PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Checkout_Session FOR Ya_Checkout_Session
/
