DROP TABLE Ya_Cache_Invalidate
/

CREATE TABLE Ya_Cache_Invalidate (
	sku                             int                      NOT NULL ,
	server_id                       varchar2(20)             NOT NULL ,
	process_flag                    char(1)                  NOT NULL ,
	created_datetime                date                     NOT NULL ,
	rowguid                         varchar2(50)             DEFAULT SYS_GUID() NOT NULL
)
/


ALTER TABLE Ya_Cache_Invalidate
ADD CONSTRAINT PK_Cache_Invalidate PRIMARY KEY (rowguid)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Cache_Invalidate FOR Ya_Cache_Invalidate
/


create or replace TRIGGER TRI_cache_invalidate
BEFORE INSERT OR UPDATE OF process_flag
ON ya_cache_invalidate
FOR EACH ROW
BEGIN
	:NEW.process_flag := UPPER(:NEW.process_flag);
END;