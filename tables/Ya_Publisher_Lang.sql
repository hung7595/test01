DROP TABLE Ya_Publisher_Lang
/

CREATE TABLE Ya_Publisher_Lang (
	publisher_id                        int                          NOT NULL ,
	lang_id                             int                          NOT NULL ,
	publisher_name                      varchar2(255)                ,
	publisher_name_u                    nvarchar2(255)               ,
	publisher_image_url                 varchar2(50)                 ,
	publisher_desc                      nclob                        ,
	publisher_name_image                varchar2(50)
)	
/

ALTER TABLE Ya_Publisher_Lang
ADD CONSTRAINT PK_Publisher_Lang PRIMARY KEY (publisher_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Lang FOR Ya_Publisher_Lang
/