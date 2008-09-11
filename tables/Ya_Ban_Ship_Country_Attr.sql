DROP TABLE Ya_Ban_Ship_Country_Attr
/

CREATE TABLE Ya_Ban_Ship_Country_Attr (
	id                         int                     NOT NULL ,
	attribute_id               int                     NOT NULL ,
	country_id                 int                     NOT NULL ,
	site_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Ban_Ship_Country_Attr
ADD CONSTRAINT PK_Ban_Ship_Country_Attr PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Ban_Ship_Country_Attr ON Ya_Ban_Ship_Country_Attr(attribute_id, country_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ban_Ship_Country_Attr FOR Ya_Ban_Ship_Country_Attr
/