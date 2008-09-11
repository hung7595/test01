DROP TABLE Ya_JP_Basket
/

CREATE TABLE Ya_JP_Basket (
	shopper_id                      char(32)            NOT NULL ,
	updated_date                    date                NOT NULL ,
	marshalled_basket               blob                NOT NULL
)
/

ALTER TABLE Ya_JP_Basket
ADD CONSTRAINT PK_JP_Basket PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_JP_Basket FOR Ya_JP_Basket
/