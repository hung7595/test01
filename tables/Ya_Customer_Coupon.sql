DROP TABLE Ya_Customer_Coupon
/

CREATE TABLE Ya_Customer_Coupon (
	record_id                   int                     NOT NULL ,
	email                       varchar2(255)           NOT NULL ,
	coupon_code                 varchar2(32)            NOT NULL ,
	date_creation               date                    NOT NULL
)
/

ALTER TABLE Ya_Customer_Coupon
ADD CONSTRAINT PK_Customer_Coupon PRIMARY KEY (record_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Coupon FOR Ya_Customer_Coupon
/