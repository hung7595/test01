DROP TABLE Ya_Storyboard_Lang
/

CREATE TABLE Ya_Storyboard_Lang (
	sku                     int                NOT NULL ,
	lang_id                 int                NOT NULL ,
	type                    int                NOT NULL ,
	contentkey              varchar2(20)       NOT NULL ,
	content                 nclob
)	
/

ALTER TABLE Ya_Storyboard_Lang
ADD CONSTRAINT PK_Storyboard_Lang PRIMARY KEY (sku, lang_id, type, contentkey)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Storyboard_Lang FOR Ya_Storyboard_Lang
/