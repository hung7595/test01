DROP TABLE Ya_PeopleStyle
/

CREATE TABLE Ya_PeopleStyle (
	month                       int                  NOT NULL ,
	year                        int                  NOT NULL ,
	dept_id                     int                  NOT NULL ,
	file_id                     int                  NOT NULL ,
	enable                      char(1)              DEFAULT 'Y' NOT NULL ,
	issue_icon                  varchar2(50)         ,
	issue_id                    number               NOT NULL
)
/

ALTER TABLE Ya_PeopleStyle
ADD CONSTRAINT PK_PeopleStyle PRIMARY KEY (issue_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_PeopleStyle_01 ON Ya_PeopleStyle(dept_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_PeopleStyle FOR Ya_PeopleStyle
/