DROP TABLE Ya_Text_Lot
/

CREATE TABLE Ya_Text_Lot (
	text_lot_id                  int                        NOT NULL ,
	file_id                      int                        ,
	lot_location                 int                        ,
	active                       char(1)                    ,
	priority                     int                        ,
	updated_user                 varchar2(20)               ,
	updated_date                 date
)	
/

ALTER TABLE Ya_Text_Lot
ADD CONSTRAINT PK_Text_Lot PRIMARY KEY (text_lot_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Text_Lot_01 ON Ya_Text_Lot(file_id, text_lot_id, lot_location) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Text_Lot FOR Ya_Text_Lot
/


create or replace TRIGGER TRI_text_lot
BEFORE INSERT OR UPDATE OF active
ON ya_text_lot
FOR EACH ROW
BEGIN
	:NEW.active := UPPER(:NEW.active);
END;