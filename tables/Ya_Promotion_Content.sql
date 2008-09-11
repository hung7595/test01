DROP TABLE Ya_Promotion_Content
/

CREATE TABLE Ya_Promotion_Content (
	id                       int                        NOT NULL ,
	site_id                  int                        NOT NULL ,
	lang_id                  int                        NOT NULL ,
	location                 char(10)                   NOT NULL ,
	content                  nclob
)	
/

ALTER TABLE Ya_Promotion_Content
ADD CONSTRAINT PK_Promotion_Content PRIMARY KEY (id, site_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Promotion_Content FOR Ya_Promotion_Content
/