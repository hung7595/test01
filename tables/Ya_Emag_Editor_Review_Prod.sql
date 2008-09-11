DROP TABLE Ya_Emag_Editor_Review_Prod
/

CREATE TABLE Ya_Emag_Editor_Review_Prod (
	site_id                 number                  NOT NULL ,
	sku                     number                  NOT NULL ,
	lang_id                 number                  NOT NULL
)
/

ALTER TABLE Ya_Emag_Editor_Review_Prod
ADD CONSTRAINT PK_Emag_Editor_Review_Prod PRIMARY KEY (site_id, sku, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Emag_Editor_Review_Prod FOR Ya_Emag_Editor_Review_Prod
/