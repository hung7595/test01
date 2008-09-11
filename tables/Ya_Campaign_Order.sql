DROP TABLE Ya_Campaign_Order
/

CREATE TABLE Ya_Campaign_Order (
	order_num                     nvarchar2(100)            NOT NULL ,
	order_id                      int                       NOT NULL ,
	sku                           int                       NOT NULL ,
	quantity                      int                       NOT NULL ,
	campaign_code                 int                       NOT NULL
)
/


ALTER TABLE Ya_Campaign_Order
ADD CONSTRAINT PK_Campaign_Order PRIMARY KEY (order_id, sku, campaign_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Campaign_Order FOR Ya_Campaign_Order
/