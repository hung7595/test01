DROP TABLE Ya_Associate_Link
/

CREATE TABLE Ya_Associate_Link (
	associate_id                   int                     NOT NULL ,
	link_id                        int                     NOT NULL ,
	site_name                      varchar2(200)           NOT NULL ,
	link_code                      varchar2(10)            NOT NULL ,
	link_type                      int                     DEFAULT 3 ,
	link_type_others               varchar2(200)           ,
	link_percentage                number(18,2)            DEFAULT 0.15 NOT NULL ,
	link_status                    int                     DEFAULT 1 NOT NULL ,
	link_url                       varchar2(512)           NOT NULL ,
	link_desc                      varchar2(500)           ,
	created_date                   date                    DEFAULT SYSDATE ,
	is_english                     char(1)                 ,
	is_chinese                     char(1)                 ,
	is_japanese                    char(1)                 ,
	is_korean                      char(1)                 ,
	is_other                       char(1)                 ,
	hits_type                      int                     ,
	is_music                       char(1)                 ,
	is_karaoke                     char(1)                 ,
	is_movies                      char(1)                 ,
	is_anime                       char(1)                 ,
	is_comics                      char(1)                 ,
	is_books                       char(1)                 ,
	is_video_games                 char(1)                 ,
	is_electronics                 char(1)                 ,
	rowguid                        varchar2(50)            DEFAULT SYS_GUID() NOT NULL ,
	lang_id                        int                     DEFAULT 1 NOT NULL
)
/

ALTER TABLE Ya_Associate_Link
ADD CONSTRAINT PK_Associate_Link PRIMARY KEY (link_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Associate_Link_01 ON Ya_Associate_Link(associate_id, link_id)
TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Link_02 ON Ya_Associate_Link(rowguid)
TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Link_03 ON Ya_Associate_Link(link_code, link_id)
TABLESPACE SSCommerceserver_Index
/

CREATE UNIQUE INDEX UN_Associate_Link_01 ON Ya_Associate_Link(link_code)
TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Link FOR Ya_Associate_Link
/


create or replace TRIGGER TRI_associate_link_01
BEFORE INSERT OR UPDATE OF is_english
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_english := UPPER(:NEW.is_english);
END;
/

create or replace TRIGGER TRI_associate_link_02
BEFORE INSERT OR UPDATE OF is_chinese
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_chinese := UPPER(:NEW.is_chinese);
END;
/

create or replace TRIGGER TRI_associate_link_03
BEFORE INSERT OR UPDATE OF is_japanese
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_japanese := UPPER(:NEW.is_japanese);
END;
/

create or replace TRIGGER TRI_associate_link_04
BEFORE INSERT OR UPDATE OF is_korean
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_korean := UPPER(:NEW.is_korean);
END;
/

create or replace TRIGGER TRI_associate_link_05
BEFORE INSERT OR UPDATE OF is_other
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_other := UPPER(:NEW.is_other);
END;
/

create or replace TRIGGER TRI_associate_link_06
BEFORE INSERT OR UPDATE OF is_music
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_music := UPPER(:NEW.is_music);
END;
/

create or replace TRIGGER TRI_associate_link_07
BEFORE INSERT OR UPDATE OF is_karaoke
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_karaoke := UPPER(:NEW.is_karaoke);
END;
/

create or replace TRIGGER TRI_associate_link_08
BEFORE INSERT OR UPDATE OF is_movies
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_movies := UPPER(:NEW.is_movies);
END;
/

create or replace TRIGGER TRI_associate_link_09
BEFORE INSERT OR UPDATE OF is_anime
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_anime := UPPER(:NEW.is_anime);
END;
/

create or replace TRIGGER TRI_associate_link_10
BEFORE INSERT OR UPDATE OF is_comics
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_comics := UPPER(:NEW.is_comics);
END;
/

create or replace TRIGGER TRI_associate_link_11
BEFORE INSERT OR UPDATE OF is_books
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_books := UPPER(:NEW.is_books);
END;
/

create or replace TRIGGER TRI_associate_link_12
BEFORE INSERT OR UPDATE OF is_video_games
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_video_games := UPPER(:NEW.is_video_games);
END;
/

create or replace TRIGGER TRI_associate_link_13
BEFORE INSERT OR UPDATE OF is_electronics
ON ya_associate_link
FOR EACH ROW
BEGIN
	:NEW.is_electronics := UPPER(:NEW.is_electronics);
END;
/
