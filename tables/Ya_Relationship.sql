DROP TABLE Ya_Relationship
/

CREATE TABLE Ya_Relationship (
	rel_id                 int                           NOT NULL ,
	meaning                varchar2(50)
)	
/

ALTER TABLE Ya_Relationship
ADD CONSTRAINT PK_Relationship PRIMARY KEY (rel_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Relationship FOR Ya_Relationship
/