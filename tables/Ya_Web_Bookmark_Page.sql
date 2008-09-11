DROP TABLE Ya_Web_Bookmark_Page
/

CREATE TABLE Ya_Web_Bookmark_Page (
	id                         int                      NOT NULL ,
	web20_id                   int                      NOT NULL ,
	type                       int                      NOT NULL
)
/

ALTER TABLE Ya_Web_Bookmark_Page
ADD CONSTRAINT PK_Web_Bookmark_Page PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Web_Bookmark_Page FOR Ya_Web_Bookmark_Page
/