DROP TABLE Ya_Artist_Info_Lang
/

CREATE TABLE Ya_Artist_Info_Lang (
	artist_info_id                number(10)                   NOT NULL ,
	lang_id                       number(10)                   NOT NULL ,
	topic                         varchar2(500)                ,
	info                          clob
)
/

ALTER TABLE Ya_Artist_Info_Lang
ADD CONSTRAINT PK_Artist_Info_Lang PRIMARY KEY (artist_info_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Info_Lang FOR Ya_Artist_Info_Lang
/