DROP TABLE Ya_Artist_Info
/

CREATE TABLE Ya_Artist_Info (
	artist_info_id                number(10)                   NOT NULL ,
	artist_id                     number(10)                   NOT NULL ,
	created_date                  date                         NOT NULL
)
/

ALTER TABLE Ya_Artist_Info
ADD CONSTRAINT PK_Artist_Info PRIMARY KEY (artist_info_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Info FOR Ya_Artist_Info
/