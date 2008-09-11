DROP TABLE Ya_Coupon_User
/

CREATE TABLE Ya_Coupon_User (
	coupon_code                varchar2(32)                 NOT NULL ,
	shopper_id                 char(32)                     NOT NULL ,
	created_datetime           date                         NOT NULL
)
/

ALTER TABLE Ya_Coupon_User
ADD CONSTRAINT PK_Coupon_User PRIMARY KEY (coupon_code, shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Coupon_User FOR Ya_Coupon_User
/