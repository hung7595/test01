DROP TABLE Ya_Ban_Ship_Country_Account
/

CREATE TABLE Ya_Ban_Ship_Country_Account (
	id                         int                     NOT NULL ,
	account_id                 int                     NOT NULL ,
	country_id                 int                     NOT NULL ,
	site_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Ban_Ship_Country_Account
ADD CONSTRAINT PK_Ban_Ship_Country_Account PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Ban_Ship_Country_Account ON Ya_Ban_Ship_Country_Account(account_id, country_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ban_Ship_Country_Account FOR Ya_Ban_Ship_Country_Account
/