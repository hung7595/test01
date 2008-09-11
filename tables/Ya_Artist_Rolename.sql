DROP TABLE Ya_Artist_Rolename
/

CREATE TABLE Ya_Artist_Rolename (
	rel_id                   number(10)                  NOT NULL ,
	lang_id                  number(10)                  NOT NULL ,
	artist_id                number(10)                  NOT NULL ,
	last_name                nvarchar2(100)              ,
	first_name               nvarchar2(100)
)
/

ALTER TABLE Ya_Artist_Rolename
ADD CONSTRAINT PK_Artist_Rolename PRIMARY KEY (rel_id, lang_id, artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Rolename FOR Ya_Artist_Rolename
/