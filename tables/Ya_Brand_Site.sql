Drop Table Ya_Brand_Site
/

CREATE TABLE Ya_Brand_Site (
	ya_brand_id             int                 NOT NULL ,
	site_id                 int                 NOT NULL ,
	is_on_sale              char(1)             NOT NULL ,
	is_focus_brand          char(1)             NOT NULL ,
	is_enabled              char(1)             NOT NULL
)
/

ALTER TABLE Ya_Brand_Site
ADD CONSTRAINT PK_Brand_Site PRIMARY KEY (ya_brand_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Brand_Site
ADD CONSTRAINT FK_Brand_Site_01 FOREIGN KEY (ya_brand_id)
REFERENCES Ya_Brand(id)
/


CREATE PUBLIC SYNONYM Ya_Brand_Site FOR Ya_Brand_Site
/