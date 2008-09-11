DROP TABLE Ya_Country_Region_Rel
/

CREATE TABLE Ya_Country_Region_Rel (
	region_id                    int                      NOT NULL ,
	country_id                   int                      NOT NULL
)
/

ALTER TABLE Ya_Country_Region_Rel
ADD CONSTRAINT PK_Country_Region_Rel PRIMARY KEY (region_id, country_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Country_Region_Rel FOR Ya_Country_Region_Rel
/