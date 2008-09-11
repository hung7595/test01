DROP TABLE Ya_Text_Lot_Lang
/

CREATE TABLE Ya_Text_Lot_Lang (
	text_lot_id                 int                        NOT NULL ,
	lang_id                     int                        NOT NULL ,
	description                 clob                       ,
	desc_img_loc                varchar2(100)              ,
	desc_img_width              int                        ,
	desc_img_height             int                        ,
	preferred_flag              char(1)
)	
/

ALTER TABLE Ya_Text_Lot_Lang
ADD CONSTRAINT PK_Text_Lot_Lang PRIMARY KEY (text_lot_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Text_Lot_Lang_01 ON Ya_Text_Lot_Lang(text_lot_id, preferred_flag) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Text_Lot_Lang FOR Ya_Text_Lot_Lang
/


create or replace TRIGGER TRI_text_lot_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_text_lot_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;                                            