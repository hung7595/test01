DROP TABLE Ya_Ban_Ship_Country_Brand
/

CREATE TABLE Ya_Ban_Ship_Country_Brand (
	id                     int                     NOT NULL ,
	brand_id               int                     NOT NULL ,
	country_id             int                     NOT NULL ,
	site_id                int                     NOT NULL ,
	mod_user               varchar2(150)           ,
	mod_date               date
)
/

ALTER TABLE Ya_Ban_Ship_Country_Brand
ADD CONSTRAINT PK_Ban_Ship_Country_Brand PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Ban_Ship_Country_Brand_01 ON Ya_Ban_Ship_Country_Brand(brand_id, site_id, country_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ban_Ship_Country_Brand FOR Ya_Ban_Ship_Country_Brand
/