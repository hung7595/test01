DROP TABLE Ya_Prod_Gallery_Image
/

CREATE TABLE Ya_Prod_Gallery_Image (
	image_id                 int                   NOT NULL ,
	gallery_id               int                   NOT NULL ,
	section_id               int                   NOT NULL ,
	image_path               varchar2(255)         ,
	thumb_path               varchar2(255)         ,
	priority                 int                   DEFAULT 0 NOT NULL
)
/

ALTER TABLE Ya_Prod_Gallery_Image
ADD CONSTRAINT PK_Prod_Gallery_Image PRIMARY KEY (image_id, gallery_id, section_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Gallery_Image_01 ON Ya_Prod_Gallery_Image(gallery_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Gallery_Image FOR Ya_Prod_Gallery_Image
/