DROP TABLE Ya_Preorder
/

CREATE TABLE Ya_Preorder (
	dept_id                          int                   NOT NULL ,
	sku                              int                   NOT NULL ,
	site_id                          int                   NOT NULL ,
	type                             int                   NOT NULL ,
	priority                         int                   NOT NULL ,
	release_date                     date                  ,        
	created_datetime                 date                  DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Preorder
ADD CONSTRAINT PK_Preorder PRIMARY KEY (dept_id, sku, site_id, type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Preorder FOR Ya_Preorder
/