DROP TABLE Sl_Prod_Lot_Lang
/

CREATE TABLE Sl_Prod_Lot_Lang (
	prod_lot_id                  int                         NOT NULL ,
	lang_id                      int                         NOT NULL ,
	description                  varchar2(3000)              ,
	desc_img_loc                 varchar2(100)               ,
	desc_img_width               int                         ,
	desc_img_height              int                         ,
	preferred_flag               char(1)                     ,
	alt_img_loc                  varchar2(100)               ,
	alt_img_width                int                         ,
	alt_img_height               int                         ,
	alt_img_link                 varchar2(100)               ,
	remark                       varchar2(500)
)
/


CREATE PUBLIC SYNONYM Sl_Prod_Lot_Lang FOR Sl_Prod_Lot_Lang
/


create or replace TRIGGER TRI_sl_prod_lot_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON sl_prod_lot_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;