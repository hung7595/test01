DROP TABLE Tmp_Ya_Associate_Link
/

CREATE TABLE Tmp_Ya_Associate_Link (
	associate_id                    number(10)                NOT NULL ,
	link_id                         number(10)                NOT NULL ,
	site_name                       varchar2(100)             NOT NULL ,
	link_code                       varchar2(10)              NOT NULL ,
	link_type                       number(10)                ,
	link_type_others                varchar2(200)             ,
	link_percentage                 number(18,2)              NOT NULL ,
	link_status                     number(10)                NOT NULL ,
	link_url                        varchar2(512)             NOT NULL ,
	link_desc                       varchar2(500)             ,
	created_date                    date                      ,
	is_english                      char(1)                   ,
	is_chinese                      char(1)                   ,
	is_japanese                     char(1)                   ,
	is_korean                       char(1)                   ,
	is_other                        char(1)                   ,
	hits_type                       number(10)                ,
	is_music                        char(1)                   ,
	is_karaoke                      char(1)                   ,
	is_movies                       char(1)                   ,
	is_anime                        char(1)                   ,
	is_comics                       char(1)                   ,
	is_books                        char(1)                   ,
	is_video_games                  char(1)                   ,
	is_electronics                  char(1)                   ,
	rowguid                         long raw                  NOT NULL ,
	lang_id                         number(10)                NOT NULL
)
/