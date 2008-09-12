DROP TABLE ya_publisher_designer CASCADE CONSTRAINTS ; 

CREATE TABLE ya_publisher_designer (
   publisher_id number NOT NULL,
   designer_id number NOT NULL
)
/
 
ALTER TABLE ya_publisher_designer 
   ADD CONSTRAINT Pk_ya_publisher_designer PRIMARY KEY (publisher_id, designer_id)
/
