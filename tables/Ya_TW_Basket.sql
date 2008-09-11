DROP TABLE Ya_TW_Basket
/

CREATE TABLE Ya_TW_Basket (
	shopper_id                     char(32)               NOT NULL ,
	updated_date                   date                   NOT NULL ,
	marshalled_basket              blob                   NOT NULL
)
/

ALTER TABLE Ya_TW_Basket
ADD CONSTRAINT PK_TW_Basket PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_TW_Basket_01 ON Ya_TW_Basket(updated_date, shopper_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_TW_Basket FOR Ya_TW_Basket
/