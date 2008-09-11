DROP TABLE Ya_Asset_Log_Login
/

CREATE TABLE Ya_Asset_Log_Login (
	log_id                 int                      NOT NULL ,
	log_type               int
)
/

ALTER TABLE Ya_Asset_Log_Login
ADD CONSTRAINT PK_Asset_Log_Login PRIMARY KEY (log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset_Log_Login FOR Ya_Asset_Log_Login
/