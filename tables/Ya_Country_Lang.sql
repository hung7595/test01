DROP TABLE Ya_Country_Lang
/

CREATE TABLE Ya_Country_Lang (
	country_id                    int                      NOT NULL ,
	lang_id                       int                      NOT NULL ,
	country_name                  varchar2(100)
)
/

ALTER TABLE Ya_Country_Lang
ADD CONSTRAINT PK_Country_Lang PRIMARY KEY (country_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Country_Lang FOR Ya_Country_Lang
/