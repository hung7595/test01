CREATE TABLE ya_fe_seo_keyword 
(
	id                int NOT NULL ,
	text              nvarchar2(128),
	lang_id           int NOT NULL ,
	enable            int NOT NULL ,
	note              nvarchar2(512),
	last_update       date NOT NULL ,
	last_update_user  nvarchar2(24)
) 
/

ALTER TABLE ya_fe_seo_keyword ADD 
CONSTRAINT PK_fe_seo_keyword PRIMARY KEY  (id,	lang_id)
/

alter index PK_fe_seo_keyword rebuild tablespace sscommerceserver_index;
