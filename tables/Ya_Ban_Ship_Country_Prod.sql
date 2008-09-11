DROP TABLE Ya_Ban_Ship_Country_Prod
/

CREATE TABLE Ya_Ban_Ship_Country_Prod (
	id                         int                     NOT NULL ,
	prod_id                    int                     NOT NULL ,
	country_id                 int                     NOT NULL ,
	site_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Ban_Ship_Country_Prod
ADD CONSTRAINT PK_Ban_Ship_Country_Prod PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Ban_Ship_Country_Attr ON Ya_Ban_Ship_Country_Prod(prod_id, country_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ban_Ship_Country_Prod FOR Ya_Ban_Ship_Country_Prod
/