DROP TABLE Ya_CM_Mirror_Creative_Location
/

CREATE TABLE Ya_CM_Mirror_Creative_Location (
	creative_id               int                  NOT NULL ,
	file_id                   int                  NOT NULL ,
	site_id                   int                  NOT NULL ,
	location                  int                  NOT NULL ,
	priority                  int                  NOT NULL
)
/

ALTER TABLE Ya_CM_Mirror_Creative_Location
ADD CONSTRAINT PK_CM_Mirror_Creative_Location PRIMARY KEY (creative_id, file_id, site_id, location)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CM_Mirror_Creative_Location FOR Ya_CM_Mirror_Creative_Location
/