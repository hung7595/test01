DROP TABLE Ya_Shipping_Rate_Supplement
/

CREATE TABLE Ya_Shipping_Rate_Supplement (
	site_id                                int                NOT NULL ,
	country_id                             int                NOT NULL ,
	shipping_method_id                     int                NOT NULL ,
	subsequent_batch_size                  int                NOT NULL ,
	subsequent_batch_cost                  number(18,2)       NOT NULL ,
	last_change_datetime                   date               NOT NULL
)	
/

ALTER TABLE Ya_Shipping_Rate_Supplement
ADD CONSTRAINT PK_Shipping_Rate_Supplement PRIMARY KEY (site_id, country_id, shipping_method_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Shipping_Rate_Supplement FOR Ya_Shipping_Rate_Supplement
/