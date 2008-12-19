DROP TABLE Ya_Cms_File_Rel
/

CREATE TABLE Ya_Cms_File_Rel (
    id      int                    NOT NULL ,
    version                 int    DEFAULT 0 NOT NULL ,
    parent_cms_file_id      int NOT NULL ,
    child_cms_file_id       int NOT NULL
)
/

ALTER TABLE Ya_Cms_File_Rel
ADD CONSTRAINT PK_Cms_File_Rel PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE UNIQUE INDEX UN_Ya_Cms_File_Rel ON Ya_Cms_File_Rel (parent_cms_file_id, child_cms_file_id) TABLESPACE SSCommerceserver_Index
/