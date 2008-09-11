DROP TABLE Ya_Country_Region
/

CREATE TABLE Ya_Country_Region (
	country_id                    int                      NOT NULL ,
	country_name                  nvarchar2(200)           NOT NULL ,
	region                        nvarchar2(200)           NOT NULL
)
/


CREATE PUBLIC SYNONYM Ya_Country_Region FOR Ya_Country_Region
/