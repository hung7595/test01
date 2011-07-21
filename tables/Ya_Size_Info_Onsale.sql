DROP TABLE Ya_Size_Info_Onsale
/

CREATE TABLE Ya_Size_Info_Onsale (
    region_id       int             NOT NULL ,
    lang_id         int             NOT NULL ,
    size_info       varchar2(60)    NOT NULL
)
/

ALTER TABLE Ya_Size_Info_Onsale
ADD CONSTRAINT PK_Survey PRIMARY KEY(iregion_id, lang_id, size_info)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Size_Info_Onsale FOR Ya_Size_Info_Onsale
/
