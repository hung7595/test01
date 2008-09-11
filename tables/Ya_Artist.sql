DROP TABLE Ya_Artist
/

CREATE TABLE Ya_Artist (
	artist_id                   number(10)                  NOT NULL ,
	gender                      char(1)                     ,
	origin_country_id           number(38)                  ,
	photo_image_loc             varchar2(200)               ,
	photo_image_width           number(38)                  ,
	photo_image_height          number(38)                  ,
	created_date                date                        ,
	updated_date                date                        ,
	created_user                varchar2(20)                ,
	updated_user                varchar2(20)                ,
	is_singer                   char(1)                     ,
	is_actor                    char(1)                     ,
	is_director                 char(1)                     ,
	is_author                   char(1)                     ,
	is_producer                 char(1)                     ,
	date_of_birth               date                        ,
	date_of_death     	        date
)
/

ALTER TABLE Ya_Artist
ADD CONSTRAINT PK_Artist PRIMARY KEY (artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Artist_01 ON Ya_Artist(updated_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Artist_02 ON Ya_Artist(updated_date, artist_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist FOR Ya_Artist
/


create or replace TRIGGER TRI_artist
BEFORE INSERT OR UPDATE OF gender
ON ya_artist
FOR EACH ROW
BEGIN
	:NEW.gender := UPPER(:NEW.gender);
END;

create or replace TRIGGER TRI_artist_1
BEFORE INSERT OR UPDATE OF is_singer
ON ya_artist
FOR EACH ROW
BEGIN
	:NEW.is_singer := UPPER(:NEW.is_singer);
END;

create or replace TRIGGER TRI_artist_2
BEFORE INSERT OR UPDATE OF is_actor
ON ya_artist
FOR EACH ROW
BEGIN
	:NEW.is_actor := UPPER(:NEW.is_actor);
END;

create or replace TRIGGER TRI_artist_3
BEFORE INSERT OR UPDATE OF is_director
ON ya_artist
FOR EACH ROW
BEGIN
	:NEW.is_director := UPPER(:NEW.is_director);
END;

create or replace TRIGGER TRI_artist_4
BEFORE INSERT OR UPDATE OF is_author
ON ya_artist
FOR EACH ROW
BEGIN
	:NEW.is_author := UPPER(:NEW.is_author);
END;

create or replace TRIGGER TRI_artist_5
BEFORE INSERT OR UPDATE OF is_producer
ON ya_artist
FOR EACH ROW
BEGIN
	:NEW.is_producer := UPPER(:NEW.is_producer);
END;