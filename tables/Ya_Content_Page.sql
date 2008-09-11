DROP TABLE Ya_Content_Page
/

CREATE TABLE Ya_Content_Page (
	container_id              int             NOT NULL ,
	site_id                   int             NOT NULL ,
	page_id                   int
)
/

ALTER TABLE Ya_Content_Page
ADD CONSTRAINT PK_Content_Page PRIMARY KEY (container_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Content_Page FOR Ya_Content_Page
/