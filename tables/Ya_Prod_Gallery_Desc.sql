DROP TABLE Ya_Prod_Gallery_Desc
/

CREATE TABLE Ya_Prod_Gallery_Desc (
	image_id                  int                   NOT NULL ,
	lang_id                   int                   NOT NULL ,
	description               nvarchar2(510)
)
/

ALTER TABLE Ya_Prod_Gallery_Desc
ADD CONSTRAINT PK_Prod_Gallery_Desc PRIMARY KEY (image_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Gallery_Desc FOR Ya_Prod_Gallery_Desc
/