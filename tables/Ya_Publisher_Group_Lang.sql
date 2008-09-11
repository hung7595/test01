DROP TABLE Ya_Publisher_Group_Lang
/

CREATE TABLE Ya_Publisher_Group_Lang (
	publisher_group_id               int                          NOT NULL ,
	lang_id                          int                          NOT NULL ,
	publisher_name                   varchar2(100)                NOT NULL
	publisher_name_u                 nvarchar2(100)
)	
/

ALTER TABLE Ya_Publisher_Group_Lang
ADD CONSTRAINT PK_Publisher_Group_Lang PRIMARY KEY (publisher_group_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Group_Lang FOR Ya_Publisher_Group_Lang
/