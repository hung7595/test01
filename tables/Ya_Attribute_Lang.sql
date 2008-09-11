DROP TABLE Ya_Attribute_Lang
/

CREATE TABLE Ya_Attribute_Lang (
	attribute_id                    int                      NOT NULL ,
	lang_id                         int                      NOT NULL ,
	attribute_name                  varchar2(255)
)
/

ALTER TABLE Ya_Attribute_Lang
ADD CONSTRAINT PK_Attribute_Lang PRIMARY KEY (attribute_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Attribute_Lang FOR Ya_Attribute_Lang
/