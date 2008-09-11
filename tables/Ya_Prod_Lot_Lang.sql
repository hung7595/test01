DROP TABLE Ya_Prod_Lot_Lang
/

CREATE TABLE Ya_Prod_Lot_Lang (
	prod_lot_id                int                       NOT NULL ,
	lang_id                    int                       NOT NULL ,
	description                varchar2(3500)            ,
	desc_img_loc               varchar2(100)             ,
	desc_img_width             int                       ,
	desc_img_height            int                       ,
	preferred_flag             char(1)                   ,
	alt_img_loc                varchar2(100)             ,
	alt_img_width              int                       ,
	alt_img_height             int                       ,
	alt_img_link               varchar2(100)             ,
	remark                     varchar2(500)	
)
/

ALTER TABLE Ya_Prod_Lot_Lang
ADD CONSTRAINT PK_Prod_Lot_Lang PRIMARY KEY (prod_lot_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Lot_Lang FOR Ya_Prod_Lot_Lang
/


create or replace TRIGGER TRI_prod_lot_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_prod_lot_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;