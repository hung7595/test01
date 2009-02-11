DROP TABLE Ya_Address_Nigeria
/

CREATE TABLE Ya_Address_Nigeria (
	address_id                           int                      NOT NULL ,
	address_profile_name                 varchar2(255)            ,
	shopper_id                           char(32)                 NOT NULL ,
	firstname                            varchar2(50)             ,
	lastname                             varchar2(50)             ,
	address1                             varchar2(255)            ,
	address2                             varchar2(255)            ,
	city                                 varchar2(50)             ,
	state_id                             int                      ,
	state                                varchar2(50)             ,
	zip                                  varchar2(50)             ,
	country_id                           int                      ,
	preferred                            char(1)                  ,
	preferred_ship                       char(1)                  ,
	preferred_bill                       char(1)                  ,
	day_phone                            varchar2(20)             ,
	eve_phone                            varchar2(20)             ,
	fax_number                           varchar2(20)             ,
	mobile_phone                         varchar2(20)             ,
	email                                varchar2(255)            ,
	site_id                              int
)
/


CREATE PUBLIC SYNONYM Ya_Address_Nigeria FOR Ya_Address_Nigeria
/


create or replace TRIGGER TRI_address_nigeria_1
BEFORE INSERT OR UPDATE OF preferred_bill
ON ya_address_nigeria
FOR EACH ROW
BEGIN
	:NEW.preferred_bill := UPPER(:NEW.preferred_bill);
END;

create or replace TRIGGER TRI_address_nigeria_2
BEFORE INSERT OR UPDATE OF preferred_ship
ON ya_address_nigeria
FOR EACH ROW
BEGIN
	:NEW.preferred_ship := UPPER(:NEW.preferred_ship);
END;

create or replace TRIGGER TRI_address_nigeria_3
BEFORE INSERT OR UPDATE OF preferred
ON ya_address_nigeria
FOR EACH ROW
BEGIN
	:NEW.preferred := UPPER(:NEW.preferred);
END;