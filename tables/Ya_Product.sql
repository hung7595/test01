DROP TABLE Ya_Product
/

CREATE TABLE Ya_Product (
	sku                                     int                        NOT NULL ,
	nisnumber                               varchar2(10)               ,
	cover_img_loc                           varchar2(200)              ,
	cover_img_width                         int                        ,
	cover_img_height                        int                        ,
	bar_code                                varchar2(100)              ,
	weight                                  number(18,4)               ,
	release_date                            date                       ,
	other_info                         	varchar2(40)               ,
	country_release_id                      int                        ,
	publisher_id                            int                        ,
	is_prod_grp_parent                      char(1)                    NOT NULL ,
	has_prod_grp_parent                     char(1)                    NOT NULL ,
	width                                   number(18,2)               ,
	height                                  number(18,2)               ,
	length                                  number(18,2)               ,
	manu_part_num                           varchar2(100)              ,
	supplier_info                           varchar2(100)              ,
	created_date                            date                       ,
	updated_date                            date                       ,
	created_user                            nvarchar2(150)             ,
	updated_user                            nvarchar2(150)             ,
	account_id                              int                        NOT NULL,
	key_code                                varchar2(100)              ,
	key_code_type                           int                        ,
	dimension_weight                        number(18,4)               ,
	brand_id                                int                        ,
	manu_country_id                         int
)
/

ALTER TABLE Ya_Product
ADD CONSTRAINT PK_Product PRIMARY KEY (sku)
/


CREATE INDEX IX_Product_01 ON Ya_Product(sku, is_prod_grp_parent, release_date, has_prod_grp_parent, account_id)
nologging
TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_02 ON Ya_Product(manu_part_num) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_03 ON Ya_Product(bar_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_04 ON Ya_Product(publisher_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_05 ON Ya_Product(updated_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_06 ON Ya_Product(release_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_07 ON Ya_Product(account_id, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_08 ON Ya_Product(updated_date, sku, is_prod_grp_parent) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_09 ON Ya_Product(key_code_type, key_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_10 ON Ya_Product(release_date, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_11 ON Ya_Product(created_date, sku, bar_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_12 ON Ya_Product(sku, key_code, key_code_type) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_13 ON Ya_Product(brand_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product FOR Ya_Product
/