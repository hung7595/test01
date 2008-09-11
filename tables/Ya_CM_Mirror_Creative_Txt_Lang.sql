DROP TABLE Ya_CM_Mirror_Creative_Txt_Lang
/

CREATE TABLE Ya_CM_Mirror_Creative_Txt_Lang (
	creative_id               int                  NOT NULL ,
	lang_id                   int                  NOT NULL ,
	content                   clob
)
/

ALTER TABLE Ya_CM_Mirror_Creative_Txt_Lang
ADD CONSTRAINT PK_CM_Mirror_Creative_Txt_Lang PRIMARY KEY (creative_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CM_Mirror_Creative_Txt_Lang FOR Ya_CM_Mirror_Creative_Txt_Lang
/