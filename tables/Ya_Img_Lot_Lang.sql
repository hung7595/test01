DROP TABLE Ya_Img_Lot_Lang
/

CREATE TABLE Ya_Img_Lot_Lang (
	image_lot_id              int                   NOT NULL ,
	lang_id                   int                   NOT NULL ,
	image_loc                 varchar2(100)         ,
	image_width               number(38)            ,
	image_height              number(38)            ,
	alt                       varchar2(100)         ,
	link_url                  varchar2(100)         ,
	preferred_flag            char(1)
)
/

ALTER TABLE Ya_Img_Lot_Lang
ADD CONSTRAINT PK_Img_Lot_Lang PRIMARY KEY (Img_Lot_Lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Img_Lot_Lang_01 ON Ya_Img_Lot_Lang(file_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Img_Lot_Lang FOR Ya_Img_Lot_Lang
/


create or replace TRIGGER TRI_img_lot_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_img_lot_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;