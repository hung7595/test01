DROP TABLE Ya_Storyboard
/

CREATE TABLE Ya_Storyboard (
	sku                     int          NOT NULL ,
	lang_id                 int          NOT NULL ,
	type                    int          NOT NULL ,
	ep_id                   int          NOT NULL ,
	content                 nclob
)	
/

ALTER TABLE Ya_Storyboard
ADD CONSTRAINT PK_Storyboard PRIMARY KEY (sku, lang_id, type, ep_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Storyboard FOR Ya_Storyboard
/