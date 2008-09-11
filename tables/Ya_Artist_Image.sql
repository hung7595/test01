DROP TABLE Ya_Artist_Image
/

CREATE TABLE Ya_Artist_Image (
	artist_id                  int                            NOT NULL ,
	type                       int                            NOT NULL ,
	img_loc                    varchar2(128)                  ,
	img_width                  int                            ,
	img_height                 int
)
/

ALTER TABLE Ya_Artist_Image
ADD CONSTRAINT PK_Artist_Image PRIMARY KEY (artist_id, type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Image FOR Ya_Artist_Image
/