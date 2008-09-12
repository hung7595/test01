DROP TABLE ya_designer_lang CASCADE CONSTRAINTS ; 

CREATE TABLE ya_designer_lang (
   designer_id number NOT NULL,
   lang_id number NULL,
   designer_name VARCHAR2(255) NULL,
   designer_icon_url VARCHAR2(255) NULL,
   publisher_bg_url VARCHAR2(255) NULL
)
/
 
ALTER TABLE ya_designer_lang 
   ADD CONSTRAINT Pk_ya_designer_lang PRIMARY KEY (designer_id, lang_id)
/
