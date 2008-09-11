DROP TABLE Ya_Prod_Gallery_Section
/

CREATE TABLE Ya_Prod_Gallery_Section (
	section_id               int                   NOT NULL ,
	lang_id                  int                   NOT NULL ,
	section_name             nvarchar2(510)        ,        
	priority                 int                   DEFAULT 0 NOT NULL
)
/

ALTER TABLE Ya_Prod_Gallery_Section
ADD CONSTRAINT PK_Prod_Gallery_Section PRIMARY KEY (section_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Gallery_Section FOR Ya_Prod_Gallery_Section
/