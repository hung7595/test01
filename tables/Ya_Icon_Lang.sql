DROP TABLE Ya_Icon_Lang
/

CREATE TABLE Ya_Icon_Lang (
	icon_type                int                   NOT NULL ,
	lang_id                  int                   NOT NULL ,
	image_path               varchar2(100)         NOT NULL
)
/

ALTER TABLE Ya_Icon_Lang
ADD CONSTRAINT PK_Icon_Lang PRIMARY KEY (icon_type, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Icon_Lang FOR Ya_Icon_Lang
/