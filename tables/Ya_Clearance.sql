DROP TABLE Ya_Clearance
/

CREATE TABLE Ya_Clearance (
	sku                       int                      NOT NULL ,
	category                  int                      NOT NULL ,
	site_id                   int                      NOT NULL
)
/


ALTER TABLE Ya_Clearance
ADD CONSTRAINT PK_Clearance PRIMARY KEY (sku, category, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Clearance FOR Ya_Clearance
/