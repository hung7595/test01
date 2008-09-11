DROP TABLE Ya_Order_SS
/

CREATE TABLE Ya_Order_SS (
	order_id                              char(32)                     NOT NULL ,
	order_num                             int                          NOT NULL ,
	shopper_id                            char(32)                     NOT NULL ,
	total_amount                          number(18,2)                 ,
	adjusted_total                        number(18,2)                 ,
	status                                int                          ,
	order_date                            date                         DEFAULT SYSDATE ,
	date_changed                          date                         ,
	marshalled_receipt                    blob                         ,
	coupon_code                           varchar2(32)                 ,
	ship_to_firstname                     varchar2(50)                 ,
	ship_to_lastname                      varchar2(50)                 ,
	ship_to_address1                      varchar2(255)                ,
	ship_to_address2                      varchar2(255)                ,
	ship_to_city                          varchar2(50)                 ,
	ship_to_state                         varchar2(50)                 ,        
	ship_to_zip                           varchar2(50)                 ,        
	ship_to_country_id                    int                          ,        
	ship_to_day_phone                     varchar2(20)                 ,        
	ship_to_eve_phone                     varchar2(20)                 ,        
	ship_to_fax_number                    varchar2(20)                 ,        
	ship_to_mobile_phone                  varchar2(20)                 ,        
	ship_to_email                         varchar2(255)                ,        
	gift_flag                             char(1)                      ,        
	gift_message                          varchar2(255)                ,        
	associate_id                          int                          ,        
	comment                               varchar2(255)                ,        
	site_id                               int                          ,        
	ip_address                            varchar2(50)                 ,        
	shopper_email                         varchar2(255)                ,        
	cc_auth_code                          varchar2(50)                 ,        
	name_on_card                          varchar2(100)                ,        
	firstname_on_card                     varchar2(50)                 ,        
	lastname_on_card                      varchar2(50)                 ,        
	cc_expiration_month                   int                          ,        
	cc_expiration_year                    int                          ,        
	cc_address1                           varchar2(255)                ,        
	cc_address2                           varchar2(255)                ,        
	cc_state                              varchar2(50)                 ,        
	cc_zip                                varchar2(50)                 ,        
	cc_phone                              varchar2(20)                 ,        
	cc_country_id                         int                          ,        
	cc_city                               varchar2(50)                 ,        
	referral_url                          varchar2(255)                ,        
	entry_url                             varchar2(255)                ,        
	cc_warning                            varchar2(50)                 ,        
	avs_code                              varchar2(10)                 ,        
	ya_comment                            varchar2(500)                ,        
	shipping_method_id                    int                          ,        
	special_handling                      varchar2(50)                 ,        
	cc_type_id                            int                          ,        
	payment_method_id                     int                          ,        
	cc_number                             varchar2(50)                 ,        
	print_invoice_location                int                          ,        
	shipping_total                        number(18,2)                 ,        
	coupon_total                          number(18,2)                 ,        
	approval_date                         date                         ,        
	rowguid                               varchar2(50)                 DEFAULT SYS_GUID() NOT NULL ,
	parent_order_id                       char(32)                     ,
	tax_total                             number(18,2)                 ,
	handling_total                        number(18,2)                 ,
	order_type_id                         int	
)
/

ALTER TABLE Ya_Order_SS
ADD CONSTRAINT PK_Order_SS PRIMARY KEY (order_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Order_SS_01 ON Ya_Order_SS(order_num, site_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_SS_02 ON Ya_Order_SS(shopper_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_SS_03 ON Ya_Order_SS(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_SS_04 ON Ya_Order_SS(coupon_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_SS_05 ON Ya_Order_SS(order_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_SS FOR Ya_Order_SS
/


create or replace TRIGGER TRI_order_ss   
BEFORE INSERT OR UPDATE OF gift_flag     
ON ya_order_ss                           
FOR EACH ROW                             
BEGIN                                    
	:NEW.gift_flag := UPPER(:NEW.gift_flag);
END;                                     