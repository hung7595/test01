DROP TABLE Tmp2_Old
/

CREATE TABLE Tmp2_Old (
	sku                             int                        NOT NULL ,
	lang_id                         int                        NOT NULL ,
	prod_name                       varchar2(300)              ,
	prod_name_u                     nvarchar2(300)             ,
	prod_name_img_loc               varchar2(200)              ,
	name_img_width                  int                        ,
	name_img_height                 int                        ,
	us_description_id               int                        ,
	hk_description_id               int                        ,
	jp_description_id               int                        ,
	tw_description_id               int                        ,
	preferred_flag                  char(1)                    ,
	prod_subtitle                   varchar2(255)              ,
	prod_subtitle_u                 nvarchar2(255)             ,
	prod_name_aka                   varchar2(255)              ,
	prod_name_aka_u                 nvarchar2(255)             ,
	prod_subtitle_aka               varchar2(255)              ,
	prod_subtitle_aka_u             nvarchar2(255)             ,
	prod_series_title               nvarchar2(255)             ,
	prod_title_volume               nvarchar2(255)             ,
	prod_subtitle_volume            nvarchar2(255)             ,
	prod_series_volume              nvarchar2(255)             ,
	content_id                      int
)
/


create or replace TRIGGER TRI_tmp2
BEFORE INSERT OR UPDATE OF preferred_flag
ON TMP2_OLD
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;