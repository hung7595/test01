DROP TABLE Ya_Award_Lookup_Lang
/

CREATE TABLE Ya_Award_Lookup_Lang (
	award_lookup_id               int                      NOT NULL ,
	lang_id                       int                      NOT NULL ,
	name                          nvarchar2(100) 
)
/

ALTER TABLE Ya_Award_Lookup_Lang
ADD CONSTRAINT PK_Award_Lookup_Lang PRIMARY KEY (award_lookup_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Lookup_Lang FOR Ya_Award_Lookup_Lang
/