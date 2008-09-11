DROP TABLE Ya_Product_Group_Promotion
/

CREATE TABLE Ya_Product_Group_Promotion (
	product_group_sku             int                  NOT NULL ,
	gift_sku                      int                  NOT NULL ,
	site_id                       int                  NOT NULL ,
	start_date                    date                 ,
	end_date                      date                 ,
	threshold                     int                  NOT NULL ,
	priority                      int                  NOT NULL
)
/

ALTER TABLE Ya_Product_Group_Promotion
ADD CONSTRAINT PK_Product_Group_Promotion PRIMARY KEY (product_group_sku, gift_sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Group_Promotion FOR Ya_Product_Group_Promotion
/