DROP TABLE ya_designer CASCADE CONSTRAINTS ; 

CREATE TABLE ya_designer (
   designer_id number NOT NULL,
   designer_name VARCHAR2(255) NULL,
   created_date DATE NULL,
   updated_date DATE NULL
)
/
 
ALTER TABLE ya_designer 
   ADD CONSTRAINT Pk_ya_designer PRIMARY KEY (designer_id)
/
