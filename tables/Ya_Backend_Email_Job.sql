DROP TABLE Ya_Backend_Email_Job
/

CREATE TABLE Ya_Backend_Email_Job (
   id                  int             NOT NULL ,
   version             int             NOT NULL ,
   origin_id           int             NOT NULL ,
   category_id         int             NOT NULL ,
   lang_id             int             NOT NULL ,
   template_type_id    int             NOT NULL ,
   origin_order_id     nvarchar2(100)  ,
   shopper_id          char(32)        ,
   supplement_xml      clob            NOT NULL ,
   sts                 int             NOT NULL ,
   create_user         varchar2(50)    NOT NULL ,
   create_dt           date            NOT NULL ,
   mod_user            varchar2(50)    NOT NULL ,
   mod_dt              date            NOT NULL
)
/

ALTER TABLE Ya_Backend_Email_Job
ADD CONSTRAINT PK_Backend_Email_Job PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Backend_Email_Job FOR Ya_Backend_Email_Job
/
