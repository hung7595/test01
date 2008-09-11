DROP TABLE Ya_Coupon_Valid_User
/

CREATE TABLE Ya_Coupon_Valid_User (
	coupon_code                varchar2(32)                 NOT NULL ,
	shopper_id                 char(32)                     NOT NULL
)
/

ALTER TABLE Ya_Coupon_Valid_User
ADD CONSTRAINT PK_Coupon_Valid_User PRIMARY KEY (coupon_code, shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Coupon_Valid_User FOR Ya_Coupon_Valid_User
/