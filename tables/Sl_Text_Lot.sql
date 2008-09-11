DROP TABLE Sl_Text_Lot
/

CREATE TABLE Sl_Text_Lot (
	text_lot_id                     int                        NOT NULL ,
	lang_id                         int                        NOT NULL ,
	description                     varchar2(4000)             ,
	desc_img_loc                    varchar2(100)              ,
	desc_img_width                  int                        ,
	desc_img_height                 int                        ,
	preferred_flag                  char(1)	
)
/


CREATE PUBLIC SYNONYM Sl_Text_Lot FOR Sl_Text_Lot
/


create or replace TRIGGER TRI_sl_text_lot
BEFORE INSERT OR UPDATE OF preferred_flag
ON sl_text_lot
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;