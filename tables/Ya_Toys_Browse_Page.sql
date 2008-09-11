DROP TABLE Ya_Toys_Browse_Page
/

CREATE TABLE Ya_Toys_Browse_Page (
	artist_id              int                  NOT NULL
)	
/

ALTER TABLE Ya_Toys_Browse_Page
ADD CONSTRAINT PK_Toys_Browse_Page PRIMARY KEY (artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Toys_Browse_Page FOR Ya_Toys_Browse_Page
/