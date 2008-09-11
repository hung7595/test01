DROP TABLE Ya_Coupon_MS
/

CREATE TABLE Ya_Coupon_MS (
	coupon_code                 varchar2(32)               NOT NULL ,
	coupon_used                 char(1)                    NOT NULL
)
/

CREATE INDEX IX_Coupon_MS_01 ON Ya_Coupon_MS(coupon_code) TABLESPACE SSCommerceserver_Index
/