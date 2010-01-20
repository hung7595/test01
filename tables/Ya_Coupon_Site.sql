DROP TABLE Ya_Coupon_Site
/

CREATE TABLE Ya_Coupon_Site (
	coupon_code         varchar2(32)             NOT NULL ,
	site_id             int
)
/

ALTER TABLE Ya_Coupon_Site
ADD CONSTRAINT PK_Coupon_Site PRIMARY KEY (coupon_code, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Coupon_Site FOR Ya_Coupon_Site
/