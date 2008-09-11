DROP TABLE Ya_Prod_Lang_1
/

CREATE TABLE Ya_Prod_Lang_1 (
	sku                               int                     NOT NULL ,
	lang_id                           int                     NOT NULL ,
	prod_name_img_loc                 varchar2(200)           ,
	name_img_width                    int                     ,
	name_img_height                   int                     ,
	us_description_id                 int                     ,
	hk_description_id                 int                     ,
	jp_description_id                 int                     ,
	tw_description_id                 int                     ,
	preferred_flag                    char(1)                 ,
	prod_subtitle                     varchar2(255)           ,
	prod_subtitle_u                   nvarchar2(255)          ,
	prod_name_aka                     varchar2(255)           ,
	prod_name_aka_u                   nvarchar2(255)          ,
	prod_subtitle_aka                 varchar2(300)           ,
	prod_subtitle_aka_u               nvarchar2(255)
)
/

ALTER TABLE Ya_Prod_Lang_1
ADD CONSTRAINT PK_Prod_Lang_1 PRIMARY KEY (sku, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/