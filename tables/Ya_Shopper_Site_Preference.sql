DROP TABLE Ya_Shopper_Site_Preference
/

CREATE TABLE Ya_Shopper_Site_Preference  (
	id                      int                 NOT NULL ,
	shopper_id              char(32)            NOT NULL ,
	site_id                 int                 NOT NULL ,
	prefer_lang_id          int                 NTO NULL ,
	prefer_currency         char(3)
)
/

ALTER TABLE Ya_Shopper_Site_Preference
ADD CONSTRAINT PK_Shopper_Site_Preference PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Shopper_Site_Preference_01 ON Ya_Shopper_Site_Preference(shopper_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Shopper_Site_Preference FOR Ya_Shopper_Site_Preference
/
