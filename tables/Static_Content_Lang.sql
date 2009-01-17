DROP TABLE Static_Content_Lang
/

CREATE TABLE Static_Content_Lang (
	id                             number                    NOT NULL ,
	content_id                     number                    NOT NULL ,
	title                          varchar2(500)             ,
	content                        clob                      ,
	writer                         nvarchar2(100)            ,
	locale                         varchar2(5)               NOT NULL ,
	version                        number                    NOT NULL
)
/

ALTER TABLE Static_Content_Lang
ADD CONSTRAINT PK_Static_Content_Lang PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Static_Content_Lang FOR Static_Content_Lang
/