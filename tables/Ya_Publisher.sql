DROP TABLE Ya_Publisher
/

CREATE TABLE Ya_Publisher (
	publisher_id               int                        NOT NULL ,
	contact_name               varchar2(50)               ,
	phone                      varchar2(20)               ,
	email                      varchar2(255)              ,
	fax                        varchar2(20)               ,
	address1                   varchar2(255)              ,
	address2                   varchar2(255)              ,
	city                       varchar2(50)               ,
	state                      varchar2(50)               ,
	zip                        varchar2(50)               ,
	country_id                 int                        ,
	created_date               date                       ,
	updated_date               date                       ,
	created_user               varchar2(50)               ,
	updated_user               varchar2(50)
)	
/

ALTER TABLE Ya_Publisher
ADD CONSTRAINT PK_Publisher PRIMARY KEY (publisher_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher FOR Ya_Publisher
/