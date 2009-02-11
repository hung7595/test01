DROP TABLE Ya_Credit_Card_Profile
/

CREATE TABLE Ya_Credit_Card_Profile (
	profile_id                          int                           NOT NULL ,
	shopper_id                          char(32)                      NOT NULL ,
	card_profile_name                   varchar2(255)                 ,
	name_on_card                        varchar2(100)                 ,
	firstname_on_card                   varchar2(100)                 ,
	lastname_on_card                    varchar2(50)                  ,
	card_type_id                        int                           ,
	charge_back_flag                    char(1)                       ,
	address1                            varchar2(255)                 ,
	address2                            varchar2(255)                 ,
	state                               varchar2(50)                  ,
	zip                                 varchar2(50)                  ,
	phone                               varchar2(40)                  ,
	card_number                         varchar2(50)                  ,
	last_five_digits                    varchar2(5)                   ,
	email                               varchar2(255)                 ,
	country_id                          int                           ,
	city                                varchar2(100)                 ,
	preferred                           char(1)                       ,
	expiration_month                    int                           ,
	expiration_year                     int                           ,
	bank_name                           varchar2(100)                 ,
	bank_phone                          varchar2(50)                  ,
	site_id                             int                           ,
	rowguid                             varchar2(50)                  DEFAULT SYS_GUID() NOT NULL ,
	card_numberencrypted                varchar2(128)                 DEFAULT 0 ,
	encryptionkey                       int
)
/

ALTER TABLE Ya_Credit_Card_Profile
ADD CONSTRAINT PK_Credit_Card_Profile PRIMARY KEY (shopper_id, profile_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Credit_Card_Profile FOR Ya_Credit_Card_Profile
/