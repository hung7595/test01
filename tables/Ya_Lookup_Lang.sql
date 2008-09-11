DROP TABLE Ya_Lookup_Lang
/

CREATE TABLE Ya_Lookup_Lang (
	type_id                    int                        NOT NULL ,
	code_id                    int                        NOT NULL ,
	lang_id                    int                        NOT NULL ,
	meaning                    varchar2(200)
)
/

ALTER TABLE Ya_Lookup_Lang
ADD CONSTRAINT PK_Lookup_Lang PRIMARY KEY (type_id, code_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Lookup_Lang FOR Ya_Lookup_Lang
/