DROP TABLE ProductSupplierCategory   
/

CREATE TABLE ProductSupplierCategory (
	id                                 int                NOT NULL ,
	productid                          int                ,
	suppliercategoryid                 int
)
/


CREATE INDEX IX_ProductSupplierCategory_1 ON ProductSupplierCategory (productid, suppliercategoryid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_ProductSupplierCategory_2 ON ProductSupplierCategory (suppliercategoryid, productid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM ProductSupplierCategory FOR ProductSupplierCategory
/