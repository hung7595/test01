DROP TABLE Ya_Publication_Site
/

CREATE TABLE Ya_Publication_Site (
	site_id                   int                   NOT NULL ,
	publication_id            int                   NOT NULL
)	
/

ALTER TABLE Ya_Publication_Site
ADD CONSTRAINT PK_Publication_Site PRIMARY KEY (site_id, publication_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publication_Site FOR Ya_Publication_Site
/