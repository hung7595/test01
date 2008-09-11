DROP TABLE Ya_Lot_Entry_Lang
/

CREATE TABLE Ya_Lot_Entry_Lang (
	entry_id                     int                     NOT NULL ,
	lang_id                      int                     NOT NULL ,
	sku                          int                     ,
	icon_url                     varchar2(100)           ,
	target_url                   varchar2(200)           ,
	content                      nvarchar2(2000)
)
/

ALTER TABLE Ya_Lot_Entry_Lang
ADD CONSTRAINT PK_Lot_Entry_Lang PRIMARY KEY (entry_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Lot_Entry_Lang FOR Ya_Lot_Entry_Lang
/