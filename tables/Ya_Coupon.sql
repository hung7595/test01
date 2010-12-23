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
/

create or replace TRIGGER TRI_coupon_2
BEFORE INSERT OR UPDATE OF coupon_used
ON ya_coupon
FOR EACH ROW
BEGIN
	:NEW.coupon_used := UPPER(:NEW.coupon_used);
END;
/

CREATE OR REPLACE TRIGGER TRI_COUPON_3
BEFORE INSERT OR UPDATE
ON ya_coupon
FOR EACH ROW
begin
	Insert into ya_coupon_mirror (
		id,
		coupon_code,
		campaign_name,
		coupon_description,
		dollar_coupon_value,
		percentage_coupon_value,
		order_amount_trigger,
		order_qty_trigger,
		item_sku_trigger,
		item_qty_trigger,
		expiration_date,
		shopper_id,
		all_shoppers,
		coupon_used,
		coupon_type_id,
		site_id,
		create_id,
		create_date,
		currency,
		update_id,
		update_date
)
	values (
		SEQ_COUPON_MIRROR.nextval,
		:new.coupon_code,
		:new.campaign_name,
		:new.coupon_description,
		:new.dollar_coupon_value,
		:new.percentage_coupon_value,
		:new.order_amount_trigger,
		:new.order_qty_trigger,
		:new.item_sku_trigger,
		:new.item_qty_trigger,
		:new.expiration_date,
		:new.shopper_id,
		:new.all_shoppers,
		:new.coupon_used,
		:new.coupon_type_id,
		:new.site_id,
		:new.create_id,
		:new.create_date,
		:new.currency,
		:new.update_id,
		sysdate );
end;
/
