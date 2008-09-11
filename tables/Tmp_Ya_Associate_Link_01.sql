DROP TABLE Tmp_Ya_Associate_Link_01
/

CREATE TABLE Tmp_Ya_Associate_Link_01 (
	associate_id                    int                       NOT NULL ,
	link_id                         int                       NOT NULL ,
	site_name                       varchar2(100)             NOT NULL ,
	link_code                       varchar2(10)              NOT NULL ,
	link_type                       int                       DEFAULT 3 ,        
	link_type_others                varchar2(200)             ,        
	link_percentage                 number(18,2)              DEFAULT 0.15 NOT NULL ,
	link_status                     int                       DEFAULT 1 NOT NULL ,
	link_url                        varchar2(512)             NOT NULL ,
	link_desc                       varchar2(500)             ,        
	created_date                    date                      DEFAULT SYSDATE ,        
	is_english                      char(1)                   ,        
	is_chinese                      char(1)                   ,        
	is_japanese                     char(1)                   ,        
	is_korean                       char(1)                   ,        
	is_other                        char(1)                   ,        
	hits_type                       int                       ,        
	is_music                        char(1)                   ,        
	is_karaoke                      char(1)                   ,        
	is_movies                       char(1)                   ,        
	is_anime                        char(1)                   ,        
	is_comics                       char(1)                   ,        
	is_books                        char(1)                   ,        
	is_video_games                  char(1)                   ,        
	is_electronics                  char(1)                   ,        
	rowguid                         varchar2(50)              DEFAULT SYS_GUID() NOT NULL ,
	lang_id                         int                       DEFAULT 1 NOT NULL
)
/