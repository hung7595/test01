DROP TABLE Ya_Artist_Nickname
/

CREATE TABLE Ya_Artist_Nickname (
	id                       number(10)                  NOT NULL ,
	artist_id                number(10)                  NOT NULL ,
	name                     nvarchar2(100)              NOT NULL ,
	lang_id                  number(10)                  NOT NULL
)
/

ALTER TABLE Ya_Artist_Nickname
ADD CONSTRAINT PK_Artist_Nickname PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Nickname FOR Ya_Artist_Nickname
/