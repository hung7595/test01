DROP TABLE Ya_Award_Event
/

CREATE TABLE Ya_Award_Event (
	award_event_id             int                  NOT NULL ,
	region_id                  int                  NOT NULL ,
	priority                   int                  NOT NULL ,
	type_id                    int                  NOT NULL
)
/

ALTER TABLE Ya_Award_Event
ADD CONSTRAINT PK_Award_Event PRIMARY KEY (award_event_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Event FOR Ya_Award_Event
/