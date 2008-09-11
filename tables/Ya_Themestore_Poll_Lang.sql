DROP TABLE Ya_Themestore_Poll_Lang
/

CREATE TABLE Ya_Themestore_Poll_Lang (
	poll_id                   int                        NOT NULL ,
	lang_id                   int                        NOT NULL ,
	item_order                int                        NOT NULL
	item_id                   int                        NOT NULL ,
	item_type                 char(1)                    ,
	item_content              nvarchar2(500)             ,
	rowguid                   varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Themestore_Poll_Lang
ADD CONSTRAINT PK_Themestore_Poll_Lang PRIMARY KEY (poll_id, lang_id, item_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Themestore_Poll_Lang_01 ON Ya_Themestore_Poll_Lang(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Poll_Lang FOR Ya_Themestore_Poll_Lang
/


create or replace TRIGGER TRI_themestore_poll_lang
BEFORE INSERT OR UPDATE OF item_type
ON ya_themestore_poll_lang
FOR EACH ROW
BEGIN
	:NEW.item_type := UPPER(:NEW.item_type);
END;