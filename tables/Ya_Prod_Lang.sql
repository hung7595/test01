DROP TABLE Ya_Prod_Lang
/

CREATE TABLE Ya_Prod_Lang (
	sku                               int                     NOT NULL ,
	lang_id                           int                     NOT NULL ,
	prod_name                         varchar2(500)           ,
	prod_name_u                       nvarchar2(300)          ,
	prod_name_img_loc                 varchar2(200)           ,
	name_img_width                    int                     ,
	name_img_height                   int                     ,
	us_description_id                 int                     ,
	ys_description_id                 int                     ,
	jp_description_id                 int                     ,
	tw_description_id                 int                     ,
	preferred_flag                    char(1)                 ,
	prod_subtitle                     varchar2(255)           ,
	prod_subtitle_u                   nvarchar2(255)          ,
	prod_name_aka                     varchar2(255)           ,
	prod_name_aka_u                   nvarchar2(255)          ,
	prod_subtitle_aka                 varchar2(300)           ,
	prod_subtitle_aka_u               nvarchar2(255)          ,
	prod_series_title                 nvarchar2(255)          ,
	prod_title_volume                 nvarchar2(255)          ,
	prod_subtitle_volume              nvarchar2(255)          ,
	prod_series_volume                nvarchar2(255)          ,
	content_id                        int                     ,
	updated_date                      date
)
/

ALTER TABLE Ya_Prod_Lang
ADD CONSTRAINT PK_Prod_Lang PRIMARY KEY (sku, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Lang_01 ON Ya_Prod_Lang(prod_name, sku, lang_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_02 ON Ya_Prod_Lang(prod_name_u, sku, lang_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_03 ON Ya_Prod_Lang(sku, preferred_flag) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_04 ON Ya_Prod_Lang(us_description_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_05 ON Ya_Prod_Lang(tw_description_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_06 ON Ya_Prod_Lang(tw_description_id, sku, lang_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_07 ON Ya_Prod_Lang(us_description_id, sku, lang_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_08 ON Ya_Prod_Lang(updated_date) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Lang_09 ON Ya_Prod_Lang(content_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Lang FOR Ya_Prod_Lang
/


create or replace TRIGGER TRI_prod_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_prod_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;