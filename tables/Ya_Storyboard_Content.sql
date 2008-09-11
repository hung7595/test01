DROP TABLE Ya_Storyboard_Content
/

CREATE TABLE Ya_Storyboard_Content (
	sku                     int                NOT NULL ,
	parameter               varchar2(40)       NOT NULL ,
	type                    int                NOT NULL ,
	html_content            nclob
)	
/

ALTER TABLE Ya_Storyboard_Content
ADD CONSTRAINT PK_Storyboard_Content PRIMARY KEY (sku, parameter, type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Storyboard_Content FOR Ya_Storyboard_Content
/