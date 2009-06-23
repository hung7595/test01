Drop Table Ya_Profess_Review_Lang
/

CREATE TABLE Ya_Profess_Review_Lang (
	profess_review_id            int                NOT NULL ,
	date_posted                  date               NOT NULL ,
	lang_id                      int                NOT NULL ,
	review                       nclob              NOT NULL ,
	mod_dt                       date               NOT NULL
)
/

ALTER TABLE Ya_Profess_Review_Lang
ADD CONSTRAINT PK_Profess_Review_Lang PRIMARY KEY (profess_review_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Profess_Review_Lang_01 ON Ya_Profess_Review_Lang(date_posted) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Profess_Review_Lang FOR Ya_Profess_Review_Lang
/