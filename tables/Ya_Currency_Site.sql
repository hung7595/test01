DROP TABLE Ya_Currency_Site
/

CREATE TABLE Ya_Currency_Site (
	site_id                      int                  NOT NULL ,
	currency_id                  int                  NOT NULL ,
	priority                     int                  NOT NULL
)
/

ALTER TABLE Ya_Currency_Site
ADD CONSTRAINT PK_Currency_Site PRIMARY KEY (site_id, currency_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Currency_Site FOR Ya_Currency_Site
/