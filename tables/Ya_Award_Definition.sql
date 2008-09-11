DROP TABLE Ya_Award_Definition
/

CREATE TABLE Ya_Award_Definition (
	award_definition_id         int                  NOT NULL ,
	year                        int                  NOT NULL ,
	event_id                    int                  NOT NULL ,
	title_id                    int                  NOT NULL
)
/

ALTER TABLE Ya_Award_Definition
ADD CONSTRAINT PK_Award_Definition PRIMARY KEY (award_definition_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Award_Definition_01 ON Ya_Award_Definition(year, event_id, title_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Definition FOR Ya_Award_Definition
/