DROP TABLE Sl_Discover_Backup
/

CREATE TABLE Sl_Discover_Backup (
	profile_id                     int                         NOT NULL ,
	shopper_id                     char(32)                    NOT NULL ,
	card_profile_name              varchar2(255)               ,
	name_on_card                   varchar2(100)               ,
	firstname_on_card              varchar2(50)                ,
	lastname_on_card               varchar2(50)                ,
	card_type_id                   int                         ,
	charge_back_flag               char(1)                     ,
	address1                       varchar2(255)               ,
	address2                       varchar2(255)               ,
	state                          varchar2(50)                ,
	zip                            varchar2(50)                ,
	phone                          varchar2(20)                ,
	card_number                    varchar2(50)                ,
	last_five_digits               varchar2(5)                 ,
	email                          varchar2(255)               ,
	country_id                     int                         ,
	city                           varchar2(50)                ,
	preferred                      char(1)                     ,
	expiration_month               int                         ,
	expiration_yera                int                         ,
	bank_name                      varchar2(100)               ,
	bank_phone                     varchar2(50)                ,
	site_id                        int	
)
/


CREATE PUBLIC SYNONYM Sl_Discover_Backup FOR Sl_Discover_Backup
/


create or replace TRIGGER TRI_sl_discover_backup_1
BEFORE INSERT OR UPDATE OF charge_back_flag
ON sl_discover_backup
FOR EACH ROW
BEGIN
	:NEW.charge_back_flag := UPPER(:NEW.charge_back_flag);
END;

create or replace TRIGGER TRI_sl_discover_backup_2
BEFORE INSERT OR UPDATE OF preferred
ON sl_discover_backup
FOR EACH ROW
BEGIN
	:NEW.preferred := UPPER(:NEW.preferred);
END;