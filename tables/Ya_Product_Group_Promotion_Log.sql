DROP TABLE Ya_Product_Group_Promotion_Log
/

CREATE TABLE Ya_Product_Group_Promotion_Log (
	log_id             int           NOT NULL ,
	product_group_sku  int           NOT NULL ,
	gift_sku           int           NOT NULL ,
	site_id            int           NOT NULL ,
	start_date         date          ,
	end_date           date          ,
	threshold          int           NOT NULL ,
	priority           int           NOT NULL ,
	updated_user       varchar2(20)  NOT NULL ,
	updated_date       date          NOT NULL
)
/

ALTER TABLE Ya_Product_Group_Promotion_Log
ADD CONSTRAINT PK_Product_Group_Promotion_Log PRIMARY KEY (log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Group_Promotion_Log FOR Ya_Product_Group_Promotion_Log
/
