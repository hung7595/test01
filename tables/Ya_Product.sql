DROP TABLE Ya_Product
/

CREATE TABLE Ya_Product (
	sku                                     int                        NOT NULL ,
	ancode                                  varchar2(20)               ,        
	nisnumber                               varchar2(15)               ,        
	content_id                              int                        ,        
	cover_img_loc                           varchar2(200)              ,        
	cover_img_width                         int                        ,        
	cover_img_height                        int                        ,        
	us_list_price                           number(18,2)               ,        
	us_sale_price                           number(18,2)               ,        
	us_sale_start                           date                       ,        
	us_sale_end                             date                       ,        
	us_ws_list_price                        number(18,2)               ,        
	us_ws_sale_price                        number(18,2)               ,        
	us_ws_sale_start                        date                       ,        
	us_ws_sale_end                          date                       ,        
	hk_list_price                           number(18,2)               ,        
	hk_sale_price                           number(18,2)               ,        
	hk_sale_start                           date                       ,        
	hk_sale_end                             date                       ,        
	hk_ws_list_price                        number(18,2)               ,        
	hk_ws_sale_price                        number(18,2)               ,        
	hk_ws_sale_start                        date                       ,        
	hk_ws_sale_end                          date                       ,        
	jp_list_price                           number(18,2)               ,        
	jp_sale_price                           number(18,2)               ,        
	jp_sale_start                           date                       ,        
	jp_sale_end                             date                       ,        
	jp_ws_list_price                        number(18,2)               ,        
	jp_ws_sale_price                        number(18,2)               ,        
	jp_ws_sale_start                        date                       ,        
	jp_ws_sale_end                          date                       ,        
	tw_list_price                           number(18,2)               ,        
	tw_sale_price                           number(18,2)               ,        
	tw_sale_start                           date                       ,        
	tw_sale_end                             date                       ,        
	tw_ws_list_price                        number(18,2)               ,        
	tw_ws_sale_price                        number(18,2)               ,        
	tw_ws_sale_start                        date                       ,        
	tw_ws_sale_end                          date                       ,        
	bar_code                                varchar2(30)               ,        
	us_availability_id                      number(4)                  ,        
	us_ws_availability_id                   number(4)                  ,        
	hk_availability_id                      number(4)                  ,        
	hk_ws_availability_id                   number(4)                  ,        
	jp_availability_id                      number(4)                  ,        
	jp_ws_availability_id                   number(4)                  ,        
	tw_availability_id                      number(4)                  ,        
	tw_ws_availability_id                   number(4)                  ,        
	weight                                  number(18,4)               ,        
	us_max_quant_allowed                    int                        ,        
	us_ws_max_quant_allowed                 int                        ,        
	jp_max_quant_allowed                    int                        ,        
	jp_ws_max_quant_allowed                 int                        ,        
	hk_max_quant_allowed                    int                        ,        
	hk_ws_max_quant_allowed                 int                        ,        
	tw_max_quant_allowed                    int                        ,        
	tw_ws_max_quant_allowed                 int                        ,        
	release_date                            date                       ,        
	product_version                         varchar2(40)               ,        
	product_edit_status                     char(1)                    ,        
	us_enabled                              char(1)                    NOT NULL ,
	hk_enabled                              char(1)                    NOT NULL ,
	jp_enabled                              char(1)                    NOT NULL ,
	tw_enabled                              char(1)                    NOT NULL ,
	hk_ws_enabled                           char(1)                    NOT NULL ,
	us_ws_enabled                           char(1)                    NOT NULL ,
	jp_ws_enabled                           char(1)                    NOT NULL ,
	tw_ws_enabled                           char(1)                    NOT NULL ,
	us_cansell                              char(1)                    NOT NULL ,
	hk_cansell                              char(1)                    NOT NULL ,
	jp_cansell                              char(1)                    NOT NULL ,
	tw_cansell                              char(1)                    NOT NULL ,
	hk_ws_cansell                           char(1)                    NOT NULL ,
	us_ws_cansell                           char(1)                    NOT NULL ,
	jp_ws_cansell                           char(1)                    NOT NULL ,
	tw_ws_cansell                           char(1)                    NOT NULL ,
	us_unit_cost                            number(18,2)               ,        
	hk_unit_cost                            number(18,2)               ,        
	jp_unit_cost                            number(18,2)               ,        
	tw_unit_cost                            number(18,2)               ,        
	us_supplier_id                          int                        ,        
	hk_supplier_id                          int                        ,        
	jp_supplier_id                          int                        ,        
	tw_supplier_id                          int                        ,        
	country_release_id                      int                        ,        
	publisher_id                            int                        ,        
	us_launch_date                          date                       ,        
	jp_launch_date                          date                       ,        
	ys_launch_date                          date                       ,        
	tw_launch_date                          date                       ,        
	is_parent                               char(1)                    NOT NULL ,
	has_parent                              char(1)                    NOT NULL ,
	width                                   number(18,2)               ,        
	height                                  number(18,2)               ,        
	length                                  number(18,2)               ,        
	manu_part_num                           varchar2(30)               ,        
	info                                    varchar2(100)              ,        
	us_priority                             number(4)                  ,        
	us_ws_priority                          number(4)                  ,        
	hk_priority                             number(4)                  ,        
	hk_ws_priority                          number(4)                  ,        
	jp_priority                             number(4)                  ,        
	jp_ws_priority                          number(4)                  ,        
	tw_priority                             number(4)                  ,        
	tw_ws_priority                          number(4)                  ,        
	num_children                            int                        ,        
	pref_dept_id                            int                        ,        
	created_date                            date                       ,        
	updated_date                            date                       ,        
	created_user                            varchar2(20)               ,        
	updated_user                            varchar2(20)               ,        
	us_preorder                             char(1)                    ,        
	hk_preorder                             char(1)                    ,        
	jp_preorder                             char(1)                    ,        
	tw_preorder                             char(1)                    ,        
	us_ws_preorder                          char(1)                    ,        
	hk_ws_preorder                          char(1)                    ,        
	jp_ws_preorder                          char(1)                    ,        
	tw_ws_preorder                          char(1)                    ,        
	account_id                              int                        ,        
	is_bundle                               char(1)                    ,        
	us_preorder_start                       date                       ,        
	us_preorder_end                         date                       ,        
	hk_preorder_start                       date                       ,        
	hk_preorder_end                         date                       ,        
	tw_preorder_start                       date                       ,        
	tw_preorder_end                         date                       ,        
	jp_preorder_start                       date                       ,        
	jp_preorder_end                         date                       ,        
	us_ws_preorder_start                    date                       ,        
	us_ws_preorder_end                      date                       ,        
	hk_ws_preorder_start                    date                       ,        
	hk_ws_preorder_end                      date                       ,        
	tw_ws_preorder_start                    date                       ,        
	tw_ws_preorder_end                      date                       ,        
	jp_ws_preorder_start                    date                       ,        
	jp_ws_preorder_end                      date                       ,        
	preorder_deadline                       date                       ,        
	key_code                                varchar2(30)               ,        
	key_code_type                           int                        ,        
	dimension_weight                        number(18,4)               ,        
	preorder_buffer_day                     int                        DEFAULT 0
)
/

ALTER TABLE Ya_Product
ADD CONSTRAINT PK_Product PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_01 ON Ya_Product(sku, us_sale_price, us_sale_start, us_sale_end, us_cansell) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_02 ON Ya_Product(sku, is_parent, release_date, us_enabled, us_cansell, has_parent, us_availability_id, us_priority, account_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_03 ON Ya_Product(bar_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_04 ON Ya_Product(manu_part_num) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_05 ON Ya_Product(publisher_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_06 ON Ya_Product(updated_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_07 ON Ya_Product(us_preorder, us_preorder_start, us_preorder_end) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_08 ON Ya_Product(us_supplier_id, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_09 ON Ya_Product(tw_supplier_id, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_10 ON Ya_Product(tw_preorder, tw_preorder_start, tw_preorder_end) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_11 ON Ya_Product(release_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_12 ON Ya_Product(sku, tw_enabled) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_14
CREATE INDEX IX_Product_13 ON Ya_Product(preorder_deadline, is_parent) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_15
CREATE INDEX IX_Product_14 ON Ya_Product(account_id, sku) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_16
CREATE INDEX IX_Product_15 ON Ya_Product(us_launch_date) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_17
CREATE INDEX IX_Product_16 ON Ya_Product(release_date, us_supplier_id) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_18
CREATE INDEX IX_Product_17 ON Ya_Product(updated_date, sku, is_parent) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_19
CREATE INDEX IX_Product_18 ON Ya_Product(key_code_type, key_code) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_20
CREATE INDEX IX_Product_19 ON Ya_Product(release_date, sku) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_21
CREATE INDEX IX_Product_20 ON Ya_Product(created_date, sku, bar_code) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_22
CREATE INDEX IX_Product_21 ON Ya_Product(sku, key_code, key_code_type) TABLESPACE SSCommerceserver_Index
/

--Old Index IX_Product_23
CREATE INDEX IX_Product_22 ON Ya_Product(content_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product FOR Ya_Product
/


create or replace TRIGGER TRI_product_1
BEFORE INSERT OR UPDATE OF product_edit_status
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.product_edit_status := UPPER(:NEW.product_edit_status);
END;

create or replace TRIGGER TRI_product_2
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_product_3
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_product_4
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_product_5
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_product_6
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;

create or replace TRIGGER TRI_product_7
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_product_8
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;

create or replace TRIGGER TRI_product_9
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;

create or replace TRIGGER TRI_product_10
BEFORE INSERT OR UPDATE OF us_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_cansell := UPPER(:NEW.us_cansell);
END;

create or replace TRIGGER TRI_product_11
BEFORE INSERT OR UPDATE OF hk_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_cansell := UPPER(:NEW.hk_cansell);
END;

create or replace TRIGGER TRI_product_12
BEFORE INSERT OR UPDATE OF jp_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.jp_cansell := UPPER(:NEW.jp_cansell);
END;

create or replace TRIGGER TRI_product_13
BEFORE INSERT OR UPDATE OF tw_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.tw_cansell := UPPER(:NEW.tw_cansell);
END;

create or replace TRIGGER TRI_product_14
BEFORE INSERT OR UPDATE OF hk_ws_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_ws_cansell := UPPER(:NEW.hk_ws_cansell);
END;

create or replace TRIGGER TRI_product_15
BEFORE INSERT OR UPDATE OF us_ws_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_ws_cansell := UPPER(:NEW.us_ws_cansell);
END;

create or replace TRIGGER TRI_product_16
BEFORE INSERT OR UPDATE OF jp_ws_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.jp_ws_cansell := UPPER(:NEW.jp_ws_cansell);
END;

create or replace TRIGGER TRI_product_17
BEFORE INSERT OR UPDATE OF tw_ws_cansell
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.tw_ws_cansell := UPPER(:NEW.tw_ws_cansell);
END;

create or replace TRIGGER TRI_product_18
BEFORE INSERT OR UPDATE OF is_parent
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.is_parent := UPPER(:NEW.is_parent);
END;

create or replace TRIGGER TRI_product_19
BEFORE INSERT OR UPDATE OF has_parent
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.has_parent := UPPER(:NEW.has_parent);
END;

create or replace TRIGGER TRI_product_20
BEFORE INSERT OR UPDATE OF has_parent
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.has_parent := UPPER(:NEW.has_parent);
END;

create or replace TRIGGER TRI_product_21
BEFORE INSERT OR UPDATE OF us_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_preorder := UPPER(:NEW.us_preorder);
END;

create or replace TRIGGER TRI_product_22
BEFORE INSERT OR UPDATE OF hk_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_preorder := UPPER(:NEW.hk_preorder);
END;

create or replace TRIGGER TRI_product_23
BEFORE INSERT OR UPDATE OF jp_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.jp_preorder := UPPER(:NEW.jp_preorder);
END;

create or replace TRIGGER TRI_product_24
BEFORE INSERT OR UPDATE OF tw_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.tw_preorder := UPPER(:NEW.tw_preorder);
END;

create or replace TRIGGER TRI_product_25
BEFORE INSERT OR UPDATE OF us_ws_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_ws_preorder := UPPER(:NEW.us_ws_preorder);
END;

create or replace TRIGGER TRI_product_26
BEFORE INSERT OR UPDATE OF hk_ws_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_ws_preorder := UPPER(:NEW.hk_ws_preorder);
END;

create or replace TRIGGER TRI_product_27
BEFORE INSERT OR UPDATE OF jp_ws_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.jp_ws_preorder := UPPER(:NEW.jp_ws_preorder);
END;

create or replace TRIGGER TRI_product_28
BEFORE INSERT OR UPDATE OF tw_ws_preorder
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.tw_ws_preorder := UPPER(:NEW.tw_ws_preorder);
END;

create or replace TRIGGER TRI_product_29
BEFORE INSERT OR UPDATE OF is_bundle
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.is_bundle := UPPER(:NEW.is_bundle);
END;

create or replace TRIGGER TRI_product_30
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_product_31
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_product
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;