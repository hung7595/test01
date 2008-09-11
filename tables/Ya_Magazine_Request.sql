DROP TABLE Ya_Magazine_Request
/

CREATE TABLE Ya_Magazine_Request (
	name                          varchar2(50)             DEFAULT 'unknown' ,
	email                         varchar2(50)             NOT NULL ,
	magazine_id                   varchar2(8)              NOT NULL ,
	request_datetime              date                     DEFAULT SYSDATE NOT NULL ,
	site_id                       number(38)               NOT NULL ,
	rowguid                       varchar2(50)             DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Magazine_Request
ADD CONSTRAINT PK_Magazine_Request PRIMARY KEY (email, magazine_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Magazine_Request_01 ON Ya_Magazine_Request(name, email, magazine_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Magazine_Request FOR Ya_Magazine_Request
/