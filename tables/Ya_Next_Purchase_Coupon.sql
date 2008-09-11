DROP TABLE Ya_Next_Purchase_Coupon
/

CREATE TABLE Ya_Next_Purchase_Coupon (
	coupon_code                varchar2(32)                  NOT NULL ,
	created_date               date                          DEFAULT SYSDATE NOT NULL
	order_id                   number                        NOT NULL
)
/

ALTER TABLE Ya_Next_Purchase_Coupon
ADD CONSTRAINT PK_Next_Purchase_Coupon PRIMARY KEY (coupon_code, order_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Next_Purchase_Coupon FOR Ya_Next_Purchase_Coupon
/