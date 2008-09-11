DROP TABLE Ya_Text_Note
/

CREATE TABLE Ya_Text_Note (
	note_id                         int                        NOT NULL ,
	note_type                       int                        NOT NULL ,
	partial_text                    int                        ,
	artist_id                       int                        ,
	text_from_other                 varchar2(80)               ,
	medium_id                       int                        ,
	source_date_string              varchar2(30)               ,
	source_volume                   varchar2(30)               ,
	note_text                       clob                       ,
	lang_id                         int                        DEFAULT 1
)	
/

ALTER TABLE Ya_Text_Note
ADD CONSTRAINT PK_Text_Note PRIMARY KEY (note_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Text_Note_01 ON Ya_Text_Note(artist_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Text_Note FOR Ya_Text_Note
/