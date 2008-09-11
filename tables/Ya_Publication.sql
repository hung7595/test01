DROP TABLE Ya_Publication
/

CREATE TABLE Ya_Publication (
	publication_id             int               NOT NULL ,
	posting_date               date              NOT NULL
)	
/

ALTER TABLE Ya_Publication
ADD CONSTRAINT PK_Publication PRIMARY KEY (publication_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publication FOR Ya_Publication
/