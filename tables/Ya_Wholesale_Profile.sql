DROP TABLE Ya_Wholesale_Profile
/

CREATE TABLE Ya_Wholesale_Profile (
	shopper_id                    char(32)                         NOT NULL ,
	firstname                     varchar2(30)                     ,
	lastname                      varchar2(20)                     ,
	company                       varchar2(100)                    ,
	phone                         varchar2(20)                     ,
	country_id                    number(38)                       ,
	business                      varchar2(50)                     ,
	interest                      varchar2(100)                    ,
	permit_number                 varchar2(50)                     ,
	created_datetime              date                             ,
	rowguid                       varchar2(50)                     DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Wholesale_Profile
ADD CONSTRAINT PK_Wholesale_Profile PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Wholesale_Profile_01 ON Ya_Wholesale_Profile(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Wholesale_Profile FOR Ya_Wholesale_Profile
/