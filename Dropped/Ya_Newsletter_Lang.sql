DROP TABLE Ya_Newsletter_Lang
/

CREATE TABLE Ya_Newsletter_Lang (
	newsletter_id                int                      NOT NULL ,
	lang_id                      int                      NOT NULL ,
	topic                        nvarchar2(100)           NOT NULL
)
/

ALTER TABLE Ya_Newsletter_Lang
ADD CONSTRAINT PK_Newsletter_Lang PRIMARY KEY (newsletter_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Newsletter_Lang FOR Ya_Newsletter_Lang
/