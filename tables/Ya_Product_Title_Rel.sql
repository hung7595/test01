DROP TABLE Ya_Product_Title_Rel
/

CREATE TABLE Ya_Product_Title_Rel (
	product_title_parent_sku                 int                       NOT NULL ,
	product_title_child_sku                  int                       NOT NULL ,
	priority                                 int                       NOT NULL ,
	created_user                             varchar2(50)              NOT NULL ,
	created_date                             date                      NOT NULL ,
	updated_user                             varchar2(50)              NOT NULL ,
	updated_date                             date                      NOT NULL
)	
/

ALTER TABLE Ya_Product_Title_Rel
ADD CONSTRAINT PK_Product_Title_Rel PRIMARY KEY (product_title_parent_sku, product_title_child_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Product_Title_Rel ON Ya_Product_Title_Rel(product_title_child_sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Title_Rel_01 ON Ya_Product_Title_Rel(product_title_child_sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Title_Rel FOR Ya_Product_Title_Rel
/