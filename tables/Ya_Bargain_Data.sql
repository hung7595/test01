DROP TABLE Ya_Bargain_Data
/

CREATE TABLE Ya_Bargain_Data (
	sku                                   int                       NOT NULL ,
	product_line                          int                       NOT NULL ,
	priority                              int                       ,        
	status                                int                       ,        
	us_list_price                         number(18,2)              ,        
	us_sale_price                         number(18,2)              ,        
	us_original_list_price                number(18,2)              ,        
	us_original_sale_price                number(18,2)              ,        
	us_original_sale_start                date                      ,        
	us_original_sale_end                  date                      ,        
	gb_list_price                         number(18,2)              ,        
	gb_sale_price                         number(18,2)              ,        
	gb_original_list_price                number(18,2)              ,        
	gb_original_sale_price                number(18,2)              ,        
	gb_original_sale_start                date                      ,        
	gb_original_sale_end                  date                      ,        
	limited_quantity                      int                       ,        
	campaign_code                         int                       ,        
	import_date                           date                      ,        
	mark_dirty                            number(1)                 NOT NULL ,
	access_counter                        int
)
/

ALTER TABLE Ya_Bargain_Data
ADD CONSTRAINT PK_Bargain_Data PRIMARY KEY (sku, product_line)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Data FOR Ya_Bargain_Data
/