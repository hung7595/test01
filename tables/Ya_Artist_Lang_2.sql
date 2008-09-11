DROP TABLE Ya_Artist_Lang_2
/

CREATE TABLE Ya_Artist_Lang_2 (
	artist_id                  number(10)                    NOT NULL ,
	lang_id                    number(10)                    NOT NULL ,
	lastname                   varchar2(800)                 ,
	lastname_u                 nvarchar2(255)                ,
	firstname                  varchar2(125)                 ,
	firstname_u                nvarchar2(100)                ,
	prefix                     nvarchar2(50)                 ,
	suffix                     nvarchar2(50)                 ,
	fullname                   nvarchar2(255)  
)
/

ALTER TABLE Ya_Artist_Lang_2
ADD CONSTRAINT PK_Artist_Lang_2 PRIMARY KEY (artist_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/