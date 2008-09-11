DROP TABLE Ya_Session
/

CREATE TABLE Ya_Session (
	session_id                  char(32)               NOT NULL ,
	timestamp                   date                   NOT NULL ,
	shopper_id                  char(32)               NOT NULL
)	
/

ALTER TABLE Ya_Session
ADD CONSTRAINT PK_Session PRIMARY KEY (shopper_id, session_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Session_01 ON Ya_Session(session_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Session FOR Ya_Session
/