DROP TABLE Ya_Artist_OverrideName
/

CREATE TABLE Ya_Artist_OverrideName (
	artist_id                number(10)                  NOT NULL ,
	name                     nvarchar2(100)              NOT NULL ,
	lang_id                  number(10)                  NOT NULL
)
/

ALTER TABLE Ya_Artist_OverrideName
ADD CONSTRAINT PK_Artist_OverrideName PRIMARY KEY (artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_OverrideName FOR Ya_Artist_OverrideName
/