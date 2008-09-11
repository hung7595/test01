DROP TABLE Ya_Basket
/

CREATE TABLE Ya_Basket (
	shopper_id                     char(32)              NOT NULL ,
	site_id                        int                   NOT NULL ,
	sku                            int                   NOT NULL ,
	quantity                       int                   NOT NULL ,
	created_datetime               date                  DEFAULT SYSDATE NOT NULL ,
	type                           int                   DEFAULT 0 NOT NULL
)
/


ALTER TABLE Ya_Basket
ADD CONSTRAINT PK_Basket PRIMARY KEY (shopper_id, site_id, sku, type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Basket_01 ON Ya_Basket(shopper_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Basket FOR Ya_Basket
/