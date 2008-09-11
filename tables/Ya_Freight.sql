DROP TABLE Ya_Freight
/

CREATE TABLE Ya_Freight (
	supplier_id                int                        NOT NULL ,
	site_id                    int                        NOT NULL ,
	account_id                 int                        NOT NULL ,
	attribute_id               int                        NOT NULL ,
	freight_cost               number(18,2)               ,
	packing_cost               number(18,2)               ,
	status                     char(1)                    NOT NULL
)
/

ALTER TABLE Ya_Freight
ADD CONSTRAINT PK_Freight PRIMARY KEY (supplier_id, site_id, account_id, attribute_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Freight FOR Ya_Freight
/