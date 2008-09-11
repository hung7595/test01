DROP TABLE Ya_Poll_Lang
/

CREATE TABLE Ya_Poll_Lang (
	poll_id                     int                       NOT NULL ,
	lang_id                     int                       NOT NULL ,
	item_order                  int                       NOT NULL ,
	item_id                     int                       NOT NULL ,
	item_type                   varchar2(50)              ,
	item_content                varchar2(500)             ,        
	rowguid                     varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Poll_Lang
ADD CONSTRAINT PK_Poll_Lang PRIMARY KEY (poll_id, lang_id, item_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Poll_Lang_01 ON Ya_Poll_Lang(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Poll_Lang FOR Ya_Poll_Lang
/