DROP TABLE Ya_HK_Basket
/

CREATE TABLE Ya_HK_Basket (
	shopper_id                        char(32)               NOT NULL ,
	marshalled_basket                 blob                   NOT NULL ,
	updated_date                      date
)
/

ALTER TABLE Ya_HK_Basket
ADD CONSTRAINT PK_HK_Basket PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_HK_Basket FOR Ya_HK_Basket
/