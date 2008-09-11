DROP TABLE Ya_Publication_Lang
/

CREATE TABLE Ya_Publication_Lang (
	publication_id            int                   NOT NULL ,
	lang_id                   int                   NOT NULL ,
	title                     varchar2(1000)        ,
	content                   nclob         
)	
/

ALTER TABLE Ya_Publication_Lang
ADD CONSTRAINT PK_Publication_Lang PRIMARY KEY (publication_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publication_Lang FOR Ya_Publication_Lang
/