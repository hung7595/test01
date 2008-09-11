DROP TABLE Ya_Publisher_Artist
/

CREATE TABLE Ya_Publisher_Artist (
	publisher_id               int                        NOT NULL ,
	artist_id                  int                        NOT NULL
)	
/

ALTER TABLE Ya_Publisher_Artist
ADD CONSTRAINT PK_Publisher_Artist PRIMARY KEY (artist_id, publisher_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Artist FOR Ya_Publisher_Artist
/