DROP TABLE Ya_Prod_Gallery
/

CREATE TABLE Ya_Prod_Gallery (
	gallery_id                int                   NOT NULL ,
	sku                       int                   NOT NULL ,
	canoverride               number(1)             DEFAULT 1 NOT NULL
)
/

ALTER TABLE Ya_Prod_Gallery
ADD CONSTRAINT PK_Prod_Gallery PRIMARY KEY (gallery_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Gallery_01 ON Ya_Prod_Gallery(sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Gallery FOR Ya_Prod_Gallery
/