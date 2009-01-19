DROP TABLE Ya_CM_Creative_Text_Lang
/

CREATE TABLE Ya_CM_Creative_Text_Lang (
	creative_id              int               NOT NULL ,
	lang_id                  int               NOT NULL ,
	content                  clob              ,
	create_user              varchar2(50)      NOT NULL ,
	create_dt                date              NOT NULL ,
	mod_user                 varchar2(50)      NOT NULL ,
	mod_dt                   date              NOT NULL
	
)
/

ALTER TABLE Ya_CM_Creative_Text_Lang
ADD CONSTRAINT PK_CM_Creative_Text_Lang PRIMARY KEY (creative_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CM_Creative_Text_Lang FOR Ya_CM_Creative_Text_Lang
/