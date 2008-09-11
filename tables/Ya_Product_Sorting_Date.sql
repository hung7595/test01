DROP TABLE Ya_Product_Sorting_Date
/

CREATE TABLE Ya_Product_Sorting_Date (
	sku                         int                       NOT NULL ,
	sorting_date                date                      NOT NULL ,
	id                          int                       NOT NULL
)	
/

ALTER TABLE Ya_Product_Sorting_Date
ADD CONSTRAINT PK_Product_Sorting_Date PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Product_Sorting_Date ON Ya_Product_Sorting_Date(sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Sorting_Date FOR Ya_Product_Sorting_Date
/