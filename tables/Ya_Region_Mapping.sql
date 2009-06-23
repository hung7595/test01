Drop Table Ya_Region_Mapping
/

CREATE TABLE Ya_Region_Mapping (
	origin_id              int              NOT NULL ,
	category               int              NOT NULL ,
	region_id              int              NOT NULL ,
	country_id             int              NOT NULL ,
	site_id                int
)
/

ALTER TABLE Ya_Region_Mapping
ADD CONSTRAINT PK_Region_Mapping PRIMARY KEY (origin_id, category, country_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Region_Mapping FOR Ya_Region_Mapping
/