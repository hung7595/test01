DROP TABLE Ya_Article_Rel
/

CREATE TABLE Ya_Article_Rel (
	article_id             number(10)                   NOT NULL ,
	rel_id                 number(10)                   NOT NULL ,
	rel_type               number(10)                   NOT NULL ,
	priority               number(10)                   NOT NULL ,
	root_dept              number(10)                   NOT NULL ,
	enable                 char(1)                      NOT NULL ,
	lang_id                number(10)                   NOT NULL
)
/

ALTER TABLE Ya_Article_Rel
ADD CONSTRAINT PK_Article_Rel PRIMARY KEY (article_id, rel_id, rel_type, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Article_Rel_01 ON Ya_Article_Rel(rel_id, rel_type, enable) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Article_Rel_02 ON Ya_Article_Rel(article_id, enable) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Article_Rel FOR Ya_Article_Rel
/


create or replace TRIGGER TRI_article_rel
BEFORE INSERT OR UPDATE OF enable
ON Ya_Article_Rel_rel
FOR EACH ROW
BEGIN
	:NEW.enable := UPPER(:NEW.enable);
END;