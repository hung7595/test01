DROP TABLE Ya_Article_Lang
/

CREATE TABLE Ya_Article_Lang (
	article_id               number(10)                   NOT NULL ,
	lang_id                  number(10)                   NOT NULL ,
	title                    nvarchar2(255)               ,
	author                   nvarchar2(255)               ,
	submission_date          date                         ,
	banner_image             nclob                        ,
	body                     nclob                        ,
	parsed_body              nclob
		
)
/

ALTER TABLE Ya_Article_Lang
ADD CONSTRAINT PK_Article_Lang PRIMARY KEY (article_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Article_Lang FOR Ya_Article_Lang
/