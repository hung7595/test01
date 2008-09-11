DROP TABLE Ya_Award_Event_Lang
/

CREATE TABLE Ya_Award_Event_Lang (
	award_event_id               int                      NOT NULL ,
	lang_id                      int                      NOT NULL ,
	name                         nvarchar2(50)            NOT NULL ,
	description                  nclob
)
/

ALTER TABLE Ya_Award_Event_Lang
ADD CONSTRAINT PK_Award_Event_Lang PRIMARY KEY (award_event_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Event_Lang FOR Ya_Award_Event_Lang
/