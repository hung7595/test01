DROP TABLE Ya_Country
/

CREATE TABLE Ya_Country (
	country_id                  int                      NOT NULL ,
	alpha_2                     char(2)                  ,
	alpha_3                     char(3)                  ,
	is_enabled                  char(1)                  NOT NULL
)
/

ALTER TABLE Ya_Country
ADD CONSTRAINT PK_Country PRIMARY KEY (country_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Country FOR Ya_Country
/