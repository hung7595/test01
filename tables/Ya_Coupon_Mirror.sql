DROP TABLE Ya_Coupon_Mirror
/

CREATE TABLE Ya_Coupon_Mirror (
	id                                int                        NOT NULL ,
	coupon_code                       varchar2(32)               NOT NULL ,
	campaign_name                     varchar2(50)               ,        
	coupon_description                varchar2(255)              ,        
	dollar_coupon_value               number(18,2)               ,        
	percentage_coupon_value           number(18,2)               ,        
	order_amount_trigger              number(18,2)               ,        
	order_qty_trigger                 int                        ,        
	item_sku_trigger                  int                        ,        
	item_qty_trigger                  int                        ,        
	expiration_date                   date                       NOT NULL ,
	shopper_id                        char(32)                   ,        
	all_shoppers                      char(1)                    DEFAULT 'N' NOT NULL ,
	coupon_used                       char(1)                    DEFAULT 'N' NOT NULL ,
	coupon_type_id                    int                        DEFAULT 0 NOT NULL ,
	site_id                           int                        ,       
	create_id                         varchar2(50)               ,
	create_date                       date                       ,
	update_date                       date                       DEAFAULT SYSDATE ,
	update_id                         varchar2(50)               ,
	currency                          char(3)                    NOT NULL
)
/

ALTER TABLE Ya_Coupon_Mirror
ADD CONSTRAINT PK_Coupon_Mirror PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Coupon_01 ON Ya_Coupon_Mirror(coupon_code) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Coupon_Mirror FOR Ya_Coupon_Mirror
/
