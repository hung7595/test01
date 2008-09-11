DROP TABLE Ya_CM_Creative_Button_Lang
/

CREATE TABLE Ya_CM_Creative_Button_Lang (
	creative_id                  int                      NOT NULL ,
	lang_id                      int                      NOT NULL ,
	image_loc                    varchar2(100)            ,
	image_width                  int                      ,
	image_height                 int                      ,
	alt                          varchar2(100)            ,
	link_url                     varchar2(200)
)
/


ALTER TABLE Ya_CM_Creative_Button_Lang
ADD CONSTRAINT PK_CM_Creative_Button_Lang PRIMARY KEY (creative_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CM_Creative_Button_Lang FOR Ya_CM_Creative_Button_Lang
/