DROP TABLE Ya_Server_WebService
/

CREATE TABLE Ya_Server_WebService (
	ip_address                    varchar2(100)               NOT NULL ,
	service_type                  varchar2(100)               NOT NULL ,
	server_id                     varchar2(20)                NOT NULL ,
	key                           int                         NOT NULL
)	
/

ALTER TABLE Ya_Server_WebService
ADD CONSTRAINT PK_Server_WebService PRIMARY KEY (key)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Server_WebService FOR Ya_Server_WebService
/