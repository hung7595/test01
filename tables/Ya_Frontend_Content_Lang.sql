DROP TABLE Ya_Frontend_Content_Lang
/

CREATE TABLE Ya_Frontend_Content_Lang (
    id                            int             NOT NULL , 
    frontend_content_id           int             NOT NULL ,
    lang_id                       int             NOT NULL ,
    site_id                       int             ,
    title                         varchar2(500)   ,
    content                       clob
)
/

ALTER TABLE ya_Frontend_Content_Lang
ADD CONSTRAINT PK_Frontend_Content_Lang PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Frontend_Content_Lang 
ADD CONSTRAINT FK_Frontend_Content_Lang_01 FOREIGN KEY (frontend_content_id) REFERENCES Ya_Frontend_Content(id)
/


CREATE PUBLIC SYNONYM Ya_Frontend_Content_Lang FOR Ya_Frontend_Content_Lang
/
