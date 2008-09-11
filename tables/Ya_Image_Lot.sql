DROP TABLE Ya_Image_Lot
/

CREATE TABLE Ya_Image_Lot (
	image_lot_id              int                  NOT NULL ,
	file_id                   int                  ,
	lot_location              int                  ,
	active                    char(1)              ,
	priority                  number(38)           ,
	updated_user              varchar2(20)         ,
	updated_date              date
)
/

ALTER TABLE Ya_Image_Lot
ADD CONSTRAINT PK_Image_Lot PRIMARY KEY (image_lot_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Image_Lot_01 ON Ya_Image_Lot(file_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Image_Lot FOR Ya_Image_Lot
/


create or replace TRIGGER TRI_image_lot
BEFORE INSERT OR UPDATE OF active
ON ya_image_lot
FOR EACH ROW
BEGIN
	:NEW.active := UPPER(:NEW.active);
END;