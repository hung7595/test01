DROP TABLE Ya_Product_Subscription
/

CREATE TABLE Ya_Product_Subscription (
	subscription_sku                int                       NOT NULL ,
	sku                             int                       NOT NULL ,
	start_date                      date                      NOT NULL
)	
/

ALTER TABLE Ya_Product_Subscription
ADD CONSTRAINT PK_Product_Subscription PRIMARY KEY (subscription_sku, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Subscription FOR Ya_Product_Subscription
/