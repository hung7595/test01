DROP TABLE Ya_Popular_Artist
/

CREATE TABLE Ya_Popular_Artist (
	artist_id                    int                       NOT NULL ,
	dept_id                      int                       NOT NULL ,
	override_flag                char(1)                   NOT NULL ,
	show                         char(1)                   NOT NULL ,
	gender                       char(1)                   NOT NULL	
)
/

ALTER TABLE Ya_Popular_Artist
ADD CONSTRAINT PK_Popular_Artist PRIMARY KEY (artist_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Popular_Artist FOR Ya_Popular_Artist
/


create or replace TRIGGER TRI_popular_artist_1
BEFORE INSERT OR UPDATE OF override_flag
ON ya_popular_artist
FOR EACH ROW
BEGIN
	:NEW.override_flag := UPPER(:NEW.override_flag);
END;

create or replace TRIGGER TRI_popular_artist_2
BEFORE INSERT OR UPDATE OF show
ON ya_popular_artist
FOR EACH ROW
BEGIN
	:NEW.show := UPPER(:NEW.show);
END;

create or replace TRIGGER TRI_popular_artist_3
BEFORE INSERT OR UPDATE OF gender
ON ya_popular_artist
FOR EACH ROW
BEGIN
	:NEW.gender := UPPER(:NEW.gender);
END;