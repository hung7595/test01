DROP TABLE Ya_Prod_Dept
/

CREATE TABLE Ya_Prod_Dept (
	sku                     int              NOT NULL ,
	dept_id                 int              NOT NULL
)
/

ALTER TABLE Ya_Prod_Dept
ADD CONSTRAINT PK_Prod_Dept PRIMARY KEY (sku, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Dept_01 ON Ya_Prod_Dept(dept_id, sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Dept FOR Ya_Prod_Dept
/