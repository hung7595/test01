DROP TABLE Ya_Prod_Award
/

CREATE TABLE Ya_Prod_Award (
	sku                          int                   NOT NULL ,
	award_id                     int                   NOT NULL ,
	award_status_type_id         int                   ,
	status                       int                   NOT NULL ,
	acdr                         char(1)               ,
	data_supplier_id             int                   ,
	action_owner                 varchar2(50)	
)
/

ALTER TABLE Ya_Prod_Award
ADD CONSTRAINT PK_Prod_Award PRIMARY KEY (sku, award_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Award FOR Ya_Prod_Award
/