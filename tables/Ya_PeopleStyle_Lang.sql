DROP TABLE Ya_PeopleStyle_Lang
/

CREATE TABLE Ya_PeopleStyle_Lang (
	year                        int                     NOT NULL ,
	month                       int                     NOT NULL ,
	lang_id                     int                     NOT NULL ,
	title                       nvarchar2(50)           ,
	issue_name                  nvarchar2(50)           ,
	issue_id                    number                  NOT NULL
)
/

ALTER TABLE Ya_PeopleStyle_Lang
ADD CONSTRAINT PK_PeopleStyle_Lang PRIMARY KEY (issue_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_PeopleStyle_Lang FOR Ya_PeopleStyle_Lang
/