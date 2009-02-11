DROP TABLE Ya_Associate
/

CREATE TABLE Ya_Associate (
	associate_id                    int                       NOT NULL ,
	associate_approved              char(1)                   DEFAULT 'N' NOT NULL ,
	taxid_ssn                       varchar2(50)              ,
	company_name                    varchar2(100)             ,
	shopper_id                      char(32)                  NOT NULL ,
	site_id                         int                       NOT NULL ,
	join_date                       date                      DEFAULT SYSDATE ,
	"comment"                       varchar2(500)             ,
	payee_name                      varchar2(100)             ,
	payee_address1                  varchar2(500)             ,
	payee_address2                  varchar2(255)             ,
	payee_city                      varchar2(100)             ,
	payee_state                     varchar2(100)             ,
	payee_country_id                int                       ,
	payee_zip                       varchar2(50)              ,
	payee_phone                     varchar2(40)              ,
	payee_email                     varchar2(255)             ,
	contact_name                    varchar2(100)             ,
	contact_address1                varchar2(500)             ,
	contact_address2                varchar2(255)             ,
	contact_city                    varchar2(100)             ,
	contact_state                   varchar2(100)             ,
	contact_zip                     varchar2(50)              ,
	contact_country_id              int                       ,
	contact_phone                   varchar2(40)              ,
	contact_email                   varchar2(255)             ,
	how_learned                     int                       ,
	payment_threshold               int                       DEFAULT 3 NOT NULL ,
	payment_option                  int                       DEFAULT 2 NOT NULL ,
	ssn_approved                    char(1)                   DEFAULT 'N' NOT NULL ,
	type_id                         int                       DEFAULT 1 NOT NULL ,
	rowguid                         varchar2(50)              DEFAULT SYS_GUID() NOT NULL ,
	comm_lang                       int                       DEFAULT 1 NOT NULL ,
	news_pref                       char(1)                   DEFAULT 'N' ,
	commission_id                   int                       DEFAULT 1 NOT NULL ,
	lang_id                         int                       DEFAULT 1 NOT NULL ,
	paypal_email                    varchar2(50)
)
/

ALTER TABLE Ya_Associate
ADD CONSTRAINT PK_Associate PRIMARY KEY (associate_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Associate_01 ON Ya_Associate(shopper_id, associate_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_02 ON Ya_Associate(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_03 ON Ya_Associate(shopper_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate FOR Ya_Associate
/


create or replace TRIGGER TRI_associate_1
BEFORE INSERT OR UPDATE OF associate_approved
ON ya_associate
FOR EACH ROW
BEGIN
	:NEW.associate_approved := UPPER(:NEW.associate_approved);
END;

create or replace TRIGGER TRI_associate_2
BEFORE INSERT OR UPDATE OF ssn_approved
ON ya_associate
FOR EACH ROW
BEGIN
	:NEW.ssn_approved := UPPER(:NEW.ssn_approved);
END;

create or replace TRIGGER TRI_associate
BEFORE INSERT OR UPDATE OF news_pref
ON ya_associate
FOR EACH ROW
BEGIN
	:NEW.news_pref := UPPER(:NEW.news_pref);
END;