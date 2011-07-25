DROP TABLE Ya_Size_Info_Brand
/

CREATE TABLE Ya_Size_Info_Brand (
    region_id       int             NOT NULL ,
    lang_id         int             NOT NULL ,
    size_info       varchar2(60)    NOT NULL ,
    brand_id        int             NOT NULL
)
/

ALTER TABLE Ya_Size_Info_Brand
ADD CONSTRAINT PK_Size_Info_Brand PRIMARY KEY(brand_id, region_id, lang_id, size_info)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Size_Info_Brand FOR Ya_Size_Info_Brand
/
