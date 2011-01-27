DROP TABLE Tmp_Bargain_Product_Group
/

CREATE GLOBAL TEMPORARY TABLE Tmp_Bargain_Product_Group (
	sku                int                 NOT NULL ,
	site_id            int                 NOT NULL ,
	sale_price         decimal(18,2)       NOT NULL ,
	sale_start         date                NOT NULL ,
	sale_end           date                NOT NULL ,
	discount           decimal(18,2)       NOT NULL
)
/

CREATE PUBLIC SYNONYM Tmp_Bargain_Product_Group FOR Tmp_Bargain_Product_Group
/
