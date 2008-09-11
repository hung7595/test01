DROP TABLE Ya_Artist_Rel
/

CREATE TABLE Ya_Artist_Rel (
	rel_id                   number(10)                  NOT NULL ,
	lang_id                  number(10)                  NOT NULL ,
	description              varchar2(255)               NOT NULL
)
/

ALTER TABLE Ya_Artist_Rel
ADD CONSTRAINT PK_Artist_Rel PRIMARY KEY (rel_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Rel FOR Ya_Artist_Rel
/