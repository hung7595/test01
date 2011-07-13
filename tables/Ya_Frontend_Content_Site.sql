DROP TABLE Ya_Frontend_Content_Site
/

CREATE TABLE Ya_Frontend_Content_Site (
    id                            int             NOT NULL , 
    frontend_content_id           int             NOT NULL ,
    site_id                       int             NOT NULL ,
    is_enabled                    char(1)
)
/

ALTER TABLE Ya_Frontend_Content_Site
ADD CONSTRAINT PK_Frontend_Content_Site PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Frontend_Content_Site 
ADD CONSTRAINT FK_Frontend_Content_Site_01 FOREIGN KEY (frontend_content_id) REFERENCES Ya_Frontend_Content(id)
/

CREATE UNIQUE INDEX UN_Frontend_Content_Site_01 ON Ya_Frontend_Content_Site
    (
      frontend_content_id, 
      site_id
    ) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Frontend_Content_Site FOR Ya_Frontend_Content_Site
/
