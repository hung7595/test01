Drop Table Ya_Site_Canship_Country
/

CREATE TABLE Ya_Site_Canship_Country (
	site_id                int              NOT NULL ,
	country_id             int              NOT NULL
)
/

ALTER TABLE Ya_Site_Canship_Country
ADD CONSTRAINT PK_Site_Canship_Country PRIMARY KEY (country_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Site_Canship_Country FOR Ya_Site_Canship_Country
/