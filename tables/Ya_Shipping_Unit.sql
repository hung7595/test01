DROP TABLE Ya_Shipping_Unit
/

CREATE TABLE Ya_Shipping_Unit (
	sku                                  int                NOT NULL ,
	site_id                              int                NOT NULL ,
	shipment_unit                        int                NOT NULL ,
	last_changed_datetime                date               NOT NULL
)	
/

ALTER TABLE Ya_Shipping_Unit
ADD CONSTRAINT PK_Shipping_Unit PRIMARY KEY (sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Shipping_Unit FOR Ya_Shipping_Unit
/