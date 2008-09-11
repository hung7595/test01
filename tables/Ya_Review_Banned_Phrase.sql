DROP TABLE Ya_Review_Banned_Phrase
/

CREATE TABLE Ya_Review_Banned_Phrase (
	id                              int                           NOT NULL ,
	phrase                          nvarchar2(800)                NOT NULL ,
	lang_id                         number(38)                    NOT NULL ,
	created_datetime                date                          NOT NULL ,
	updated_datetime                date                          ,
	risk_level                      int                           NOT NULL
)	
/

ALTER TABLE Ya_Review_Banned_Phrase
ADD CONSTRAINT PK_Review_Banned_Phrase PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Banned_Phrase FOR Ya_Review_Banned_Phrase
/