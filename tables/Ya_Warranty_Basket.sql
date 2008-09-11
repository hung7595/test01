DROP TABLE Ya_Warranty_Basket
/

CREATE TABLE Ya_Warranty_Basket (
	shopper_id                     char(32)               NOT NULL ,
	site_id                        int                    NOT NULL ,
	warrantee_sku                  int                    NOT NULL ,
	warranty_sku                   int                    NOT NULL ,
	created_date                   date                   DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Warranty_Basket
ADD CONSTRAINT PK_Warranty_Basket PRIMARY KEY (shopper_id, site_id, warrantee_sku, warranty_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Warranty_Basket FOR Ya_Warranty_Basket
/