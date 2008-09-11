DROP TABLE Ya_Disp_Lang
/

CREATE TABLE Ya_Disp_Lang (
	lang_id                   int                           NOT NULL ,
	lang_name                 varchar2(50)                  ,
	locale_id                 int                           ,
	codepage                  int                           ,
	charset                   varchar2(50)
)
/

ALTER TABLE Ya_Disp_Lang
ADD CONSTRAINT PK_Disp_Lang PRIMARY KEY (lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Disp_Lang FOR Ya_Disp_Lang
/