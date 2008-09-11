DROP TABLE Ya_Attribute_Type
/

CREATE TABLE Ya_Attribute_Type (
	attribute_type_id              int                      NOT NULL ,
	attribute_type_name            int                      ,
	lang_id                        varchar2(255)            NOT NULL
)
/

ALTER TABLE Ya_Attribute_Type
ADD CONSTRAINT PK_Attribute_Type PRIMARY KEY (attribute_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Attribute_Type FOR Ya_Attribute_Type
/