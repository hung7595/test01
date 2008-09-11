DROP TABLE Ya_Subscription
/

CREATE TABLE Ya_Subscription (
	subscription_sku            int                NOT NULL ,
	number_of_issues            int                NOT NULL
)	
/

ALTER TABLE Ya_Subscription
ADD CONSTRAINT PK_Subscription PRIMARY KEY (subscription_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Subscription FOR Ya_Subscription
/