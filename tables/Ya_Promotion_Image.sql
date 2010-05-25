DROP TABLE Ya_Promotion_Image
/

CREATE TABLE Ya_Promotion_Image (
	id                  int                NOT NULL, 
	promotion_id        int                NOT NULL,
	type                int                NOT NULL,
	img_path            varchar2(255)      NOT NULL,
	url                 varchar2(255)
)
/

ALTER TABLE Ya_Promotion_Image
ADD CONSTRAINT PK_Promotion_Image PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Promotion_Image
ADD CONSTRAINT Fk_Promotion_Image_01 FOREIGN KEY (promotion_id) REFERENCES Ya_Yromotion (id)
/

CREATE PUBLIC SYNONYM Ya_Promotion_Image FOR Ya_Promotion_Image
/
