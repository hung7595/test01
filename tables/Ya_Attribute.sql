DROP TABLE Ya_Attribute
/

CREATE TABLE Ya_Attribute (
	attribute_id                    int                      NOT NULL ,
	attribute_type_id               int                      ,
	img_loc                         varchar2(100)            ,
	img_height                      int                      ,
	img_width                       int
)
/

ALTER TABLE Ya_Attribute
ADD CONSTRAINT PK_Attribute PRIMARY KEY (attribute_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Attribute_01 ON Ya_Attribute(attribute_id, attribute_type_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Attribute FOR Ya_Attribute
/