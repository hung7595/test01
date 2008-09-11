DROP TABLE Ya_Coupon_Corporate
/

CREATE TABLE Ya_Coupon_Corporate (
	coupon_code                     varchar2(32)                 NOT NULL ,
	corporate_name                  varchar2(200)                NOT NULL ,
	corporate_domain                varchar2(50)                 NOT NULL ,
	priority                        int                          NOT NULL ,
	created_datetime                date                         NOT NULL
)
/

ALTER TABLE Ya_Coupon_Corporate
ADD CONSTRAINT PK_Coupon_Corporate PRIMARY KEY (coupon_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Coupon_Corporate FOR Ya_Coupon_Corporate
/