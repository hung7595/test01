DROP TABLE Ya_Coupon_Exclude_Display
/

CREATE TABLE Ya_Coupon_Exclude_Display (
    shopper_id     char(32)       NOT NULL,
    coupon_code    varchar2(32)   NOT NULL 
)
/

ALTER TABLE Ya_Coupon_Exclude_Display
ADD CONSTRAINT PK_Coupon_Exclude_Display PRIMARY KEY (coupon_code, shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/
