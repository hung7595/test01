DROP TABLE Ya_Ban_Ship_Country_Supplier
/

CREATE TABLE Ya_Ban_Ship_Country_Supplier (
	id                         int                     NOT NULL ,
	supplier_id                int                     NOT NULL ,
	country_id                 int                     NOT NULL ,
	site_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Ban_Ship_Country_Supplier
ADD CONSTRAINT PK_Ban_Ship_Country_Supplier PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Ban_Ship_Country_Supplier ON Ya_Ban_Ship_Country_Supplier(supplier_id, country_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ban_Ship_Country_Supplier FOR Ya_Ban_Ship_Country_Supplier
/