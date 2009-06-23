Drop Table Ya_Brand_Img_Lang
/

CREATE TABLE Ya_Brand_Img_Lang (
	ya_brand_img_id       int                 NOT NULL ,
	lang_id               int                 NOT NULL ,
	img_name              varchar2(255)
)
/

ALTER TABLE Ya_Brand_Img_Lang
ADD CONSTRAINT PK_Brand_Img_lang PRIMARY KEY (ya_brand_img_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Brand_Img_Lang
ADD CONSTRAINT FK_Brand_Img_Lang_01 FOREIGN KEY (ya_brand_img_id)
REFERENCES Ya_Brand_Img(id)
/


CREATE PUBLIC SYNONYM Ya_Brand_Img_Lang FOR Ya_Brand_Img_Lang
/