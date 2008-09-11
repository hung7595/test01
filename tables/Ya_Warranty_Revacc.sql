DROP TABLE Ya_Warranty_Revacc
/

CREATE TABLE Ya_Warranty_Revacc (
	warranty_sku                   int                    NOT NULL ,
	revenue_account                int                    NOT NULL ,
	created_user                   varchar2(20)           NOT NULL ,
	created_date                   date                   NOT NULL
)
/

ALTER TABLE Ya_Warranty_Revacc
ADD CONSTRAINT PK_Warranty_Revacc PRIMARY KEY (warranty_sku, revenue_account)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Warranty_Revacc FOR Ya_Warranty_Revacc
/