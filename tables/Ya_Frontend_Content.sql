DROP TABLE Ya_Frontend_Content
/

CREATE TABLE Ya_Frontend_Content (
    id                            int             NOT NULL , 
    type                          int             NOT NULL ,
    image_url                     varchar2(100)   ,
    display_dt                    date            NOT NULL ,
    valid_start                   date            ,
    valid_end                     date            ,
    priority                      int             NOT NULL ,
    create_user                   varchar2(50)    NOT NULL ,
    create_dt                     date            NOT NULL ,
    mod_user                      varchar2(50)    NOT NULL ,
    mod_dt                        date            NOT NULL
)
/

ALTER TABLE Ya_Frontend_Content
ADD CONSTRAINT PK_Frontend_Content PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Frontend_Content FOR Ya_Frontend_Content
/
