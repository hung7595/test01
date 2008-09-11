DROP TABLE Ya_Prod_Lang_2
/

CREATE TABLE Ya_Prod_Lang_2 (
	sku                               int                     NOT NULL ,
	lang_id                           int                     NOT NULL ,
	prod_name                         varchar2(200)           ,
	prod_name_u                       int                     ,
	prod_series_title                 int                     ,
	prod_title_volume                 int                     ,
	prod_subtitle_volume              int                     ,
	prod_series_volume                int                     ,
	content_id                        int                     ,
	preferred_flag                    char(1)                 ,
	prod_subtitle                     varchar2(255)           ,
	prod_subtitle_u                   nvarchar2(255)          ,
	prod_name_aka                     varchar2(255)           ,
	prod_name_aka_u                   nvarchar2(255)          ,
	prod_subtitle_aka                 varchar2(300)           ,
	prod_subtitle_aka_u               nvarchar2(255)
)
/

ALTER TABLE Ya_Prod_Lang_2
ADD CONSTRAINT PK_Prod_Lang_2 PRIMARY KEY (sku, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/