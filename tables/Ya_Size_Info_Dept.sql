DROP TABLE Ya_Size_Info_Dept
/

CREATE TABLE Ya_Size_Info_Dept (
    region_id       int             NOT NULL ,
    lang_id         int             NOT NULL ,
    size_info       varchar2(60)    NOT NULL ,
    dept_id         int             NOT NULL
)
/

ALTER TABLE Ya_Size_Info_Dept
ADD CONSTRAINT PK_Size_Info_Dept PRIMARY KEY(region_id, lang_id, size_info, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Size_Info_Dept FOR Ya_Size_Info_Dept
/
