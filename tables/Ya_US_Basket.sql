DROP TABLE Ya_US_Basket
/

CREATE TABLE Ya_US_Basket (
	shopper_id                     char(32)               NOT NULL ,
	updated_date                   date                   NOT NULL ,
	marshalled_basket              blob                   NOT NULL
)
/

ALTER TABLE Ya_US_Basket
ADD CONSTRAINT PK_US_Basket PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_US_Basket_01 ON Ya_US_Basket(updated_date, shopper_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_US_Basket FOR Ya_US_Basket
/