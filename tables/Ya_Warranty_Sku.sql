DROP TABLE Ya_Warranty_Sku
/

CREATE TABLE Ya_Warranty_Sku (
	warranty_sku                   int                    NOT NULL ,
	warrantee_sku                  int                    NOT NULL ,
	created_user                   varchar2(20)           NOT NULL ,
	created_date                   date                   NOT NULL
)
/

ALTER TABLE Ya_Warranty_Sku
ADD CONSTRAINT PK_Warranty_Sku PRIMARY KEY (warranty_sku, warrantee_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Warranty_Sku FOR Ya_Warranty_Sku
/