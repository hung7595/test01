DROP TABLE Ya_Shipping_Rate_BK
/

CREATE TABLE Ya_Shipping_Rate_BK (
	site_id                            int                  NOT NULL ,
	country_id                         int                  NOT NULL ,
	shipping_method_id                 int                  NOT NULL ,
	shipment_unit_range_from           int                  NOT NULL ,
	shipment_unit_range_to             int                  NOT NULL ,
	shipment_cost                      number(18,2)         NOT NULL ,
	last_change_datetime               date                 NOT NULL
)	
/

ALTER TABLE Ya_Shipping_Rate_BK
ADD CONSTRAINT PK_Shipping_Rate_BK PRIMARY KEY (site_id, country_id, shipping_method_id, shipment_unit_range_from)
USING INDEX TABLESPACE SSCommerceserver_Index
/