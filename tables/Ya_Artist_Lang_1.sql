DROP TABLE Ya_Artist_Lang_1
/

CREATE TABLE Ya_Artist_Lang_1 (
	artist_id                      number(10)                    NOT NULL ,
	lang_id                        number(10)                    NOT NULL ,
	akaname                        varchar2(60)                  NOT NULL ,
	akaname_u                      nvarchar2(100)                ,
	name_img_loc                   varchar2(100)                 ,
	name_img_width                 int                           ,
	name_img_height                int                           ,
	bio                            varchar2(3000)                ,
	preferred_flag                 char(1)                       NOT NULL ,
	lastname_seq                   int             
)
/

ALTER TABLE Ya_Artist_Lang_1
ADD CONSTRAINT PK_Artist_Lang_1 PRIMARY KEY (artist_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Lang_1 FOR Ya_Artist_Lang_1
/