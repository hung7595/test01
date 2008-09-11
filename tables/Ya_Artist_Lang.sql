DROP TABLE Ya_Artist_Lang
/

CREATE TABLE Ya_Artist_Lang (
	artist_id                      number(10)                    NOT NULL ,
	lang_id                        number(10)                    NOT NULL ,
	lastname                       varchar2(800)                 ,
	lastname_u                     nvarchar2(255)                ,
	firstname                      varchar2(125)                 ,
	firstname_u                    nvarchar2(100)                ,
	akaname                        varchar2(60)                  ,
	akaname_u                      nvarchar2(100)                ,
	name_img_loc                   varchar2(100)                 ,
	name_img_width                 int                           ,
	name_img_height                int                           ,
	bio                            varchar2(3000)                ,
	preferred_flag                 char(1)                       NOT NULL ,
	lastname_seq                   int                           ,
	prefix                         nvarchar2(50)                 ,
	suffix                         nvarchar2(50)                 ,
	fullname                       nvarchar2(255)	  
)
/

ALTER TABLE Ya_Artist_Lang
ADD CONSTRAINT PK_Artist_Lang PRIMARY KEY (artist_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Artist_Lang_01 ON Ya_Artist_Lang(artist_id, preferred_flag) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Artist_Lang_02 ON Ya_Artist_Lang(upper(fullname)) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Artist_Lang_03 ON Ya_Artist_Lang(upper(lastname_u)) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Artist_Lang_04 ON Ya_Artist_Lang(upper(firstname_u)) TABLESPACE SSCommerceserver_Index
/



CREATE PUBLIC SYNONYM Ya_Artist_Lang FOR Ya_Artist_Lang
/


create or replace TRIGGER TRI_artist_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_artist_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;