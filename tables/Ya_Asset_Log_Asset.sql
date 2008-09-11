DROP TABLE Ya_Asset_Log_Asset
/

CREATE TABLE Ya_Asset_Log_Asset (
	log_id                 int                      NOT NULL ,
	action                 int                      ,
	asset_id               int
)
/

ALTER TABLE Ya_Asset_Log_Asset
ADD CONSTRAINT PK_Asset_Log_Asset PRIMARY KEY (log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset_Log_Asset FOR Ya_Asset_Log_Asset
/