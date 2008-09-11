DROP TABLE Ya_Prod_Music
/

CREATE TABLE Ya_Prod_Music (
	sku                        int                       NOT NULL ,
	disc_num                   int                       NOT NULL ,
	track_num                  varchar2(3500)            ,
	audio_file_loc             varchar2(100)             ,
	track_duration             int                       ,
	download_file_loc          int                       ,
	orig_artist_flag           char(1)                   ,
	track_name                 varchar2(100)
)
/

ALTER TABLE Ya_Prod_Music
ADD CONSTRAINT PK_Prod_Music PRIMARY KEY (sku, disc_num, track_num)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Music FOR Ya_Prod_Music
/


create or replace TRIGGER TRI_prod_music
BEFORE INSERT OR UPDATE OF orig_artist_flag
ON ya_prod_music
FOR EACH ROW
BEGIN
	:NEW.orig_artist_flag := UPPER(:NEW.orig_artist_flag);
END;