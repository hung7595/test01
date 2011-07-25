DROP TABLE Ya_Size_Info_Attribute
/

CREATE TABLE Ya_Size_Info_Attribute (
    region_id       int             NOT NULL ,
    lang_id         int             NOT NULL ,
    size_info       varchar2(60)    NOT NULL ,
    attribute_id    int             NOT NULL
)
/

ALTER TABLE Ya_Size_Info_Attribute
ADD CONSTRAINT PK_Size_Info_Attribute PRIMARY KEY(attribute_id, region_id, lang_id, size_info)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Size_Info_Attribute FOR Ya_Size_Info_Attribute
/
