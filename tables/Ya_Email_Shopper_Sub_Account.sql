DROP TABLE Ya_Email_Shopper_Sub_Account
/

CREATE TABLE Ya_Email_Shopper_Sub_Account (
	shopper_id        varchar2(32)       NOT NULL ,
	account_id        number             NOT NULL ,
	counter           number             NOT NULL ,
	last_order_date   date               NOT NULL
)
/

ALTER TABLE Ya_Email_Shopper_Sub_Account
ADD CONSTRAINT PK_Email_Shopper_Sub_Account PRIMARY KEY (shopper_id, account_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Email_Shopper_Sub_Account FOR Ya_Email_Shopper_Sub_Account
/
