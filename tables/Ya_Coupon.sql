DROP TABLE Ya_Coupon
/

CREATE TABLE Ya_Coupon (
	coupon_code                          varchar2(32)                NOT NULL ,
	campaign_name                        varchar2(50)                ,        
	coupon_description                   varchar2(255)               ,        
	dollar_coupon_value                  number(18,2)                ,        
	percentage_coupon_value              number(18,2)                ,        
	order_amount_trigger                 number(18,2)                ,        
	order_qty_trigger                    int                         ,        
	item_sku_trigger                     int                         ,        
	item_qty_trigger                     int                         ,        
	expiration_date                      date                        NOT NULL ,
	shopper_id                           char(32)                    ,        
	all_shoppers                         char(1)                     DEFAULT 'N' NOT NULL ,
	coupon_used                          char(1)                     DEFAULT 'N' NOT NULL ,
	coupon_type_id                       int                         DEFAULT 0 NOT NULL ,
	site_id                              int                         ,       
	rowguid                              varchar2(50)                DEFAULT SYS_GUID() NOT NULL ,
	create_id                            varchar2(50)                ,
	create_date                          date                        ,
	currency                             char(3)                     DEFAULT 'USD' NOT NULL
	update_id                            varchar2(50)                ,
	update_date                          date
)
/

ALTER TABLE Ya_Coupon
ADD CONSTRAINT PK_Coupon PRIMARY KEY (coupon_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Coupon_01 ON Ya_Coupon(all_shoppers) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Coupon_02 ON Ya_Coupon(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Coupon_03 ON Ya_Coupon(expiration_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Coupon_04 ON Ya_Coupon(campaign_name) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Coupon_05 ON Ya_Coupon(shopper_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Coupon FOR Ya_Coupon
/


create or replace TRIGGER TRI_coupon_1
BEFORE INSERT OR UPDATE OF all_shoppers
ON ya_coupon
FOR EACH ROW
BEGIN
	:NEW.all_shoppers := UPPER(:NEW.all_shoppers);
END;

create or replace TRIGGER TRI_coupon_2
BEFORE INSERT OR UPDATE OF coupon_used
ON ya_coupon
FOR EACH ROW
BEGIN
	:NEW.coupon_used := UPPER(:NEW.coupon_used);
END;