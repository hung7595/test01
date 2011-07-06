DROP TABLE Ya_Address
/

CREATE TABLE Ya_Address (
	address_id                           int                      NOT NULL ,
	address_profile_name                 varchar2(255)            ,
	shopper_id                           char(32)                 NOT NULL ,
	firstname                            varchar2(200)            ,
	lastname                             varchar2(200)            ,
	address1                             varchar2(300)            ,
	address2                             varchar2(255)            ,
	city                                 varchar2(120)            ,
	state_id                             int                      ,
	state                                varchar2(100)            ,
	zip                                  varchar2(80)             ,
	country_id                           int                      ,
	preferred                            char(10)                 DEFAULT 'N' ,
	preferred_ship                       char(1)                  DEFAULT 'N' ,
	preferred_bill                       char(1)                  DEFAULT 'N' ,
	day_phone                            varchar2(90)             ,
	eve_phone                            varchar2(80)             ,
	fax_number                           varchar2(80)             ,
	mobile_phone                         varchar2(80)             ,
	email                                varchar2(255)            ,
	site_id                              int                      ,
	rowguid                              varchar2(50)             DEFAULT sys_guid() ,
	lang_id                              int                      NOT NULL ,
	city_id                              int                      DEFAULT (-1)
	created_by_checkout_session          char(1)                  DEFAULT 'N' NOT NULL
)
/

ALTER TABLE Ya_Address
ADD CONSTRAINT PK_Address PRIMARY KEY (shopper_id, address_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_address_01 ON Ya_Address(address_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Address FOR Ya_Address
/