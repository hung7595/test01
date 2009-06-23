Drop Table Ya_Video_Lang
/

CREATE TABLE Ya_Video_Lang (
	ya_video_id                 int                NOT NULL ,
	lang_id                     int                NOT NULL,
	video_name                  varchar2(255)      ,        
	video_desc                  nclob              ,        
	width                       int                ,        
	height                      int                ,        
	video_path                  varchar2(500)      NOT NULL ,
	preview_img_path            varchar2(500)      NOT NULL ,
	created_dt                  date               NOT NULL ,
	created_user                varchar2(50)       NOT NULL ,
	mod_dt                      date               NOT NULL ,
	mod_user                    varchar2(50)       NOT NULL
)
/

ALTER TABLE Ya_Video_Lang
ADD CONSTRAINT PK_Video_Lang PRIMARY KEY (ya_video_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Video_Lang
ADD CONSTRAINT FK_Video_Lang_01 FOREIGN KEY (ya_video_id)
REFERENCES Ya_Video(id)
/


CREATE PUBLIC SYNONYM Ya_Video_Lang FOR Ya_Video_Lang
/