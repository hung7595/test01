DROP TABLE Ya_Gift_Cert
/

CREATE TABLE Ya_Gift_Cert (
	cert_code                           varchar2(50)                NOT NULL ,
	site_id                             int                         NOT NULL ,
	order_num                           int                         NOT NULL ,
	sku                                 int                         NOT NULL ,
	cert_amount                         number(18,2)                NOT NULL ,
	created_datetime                    date                        DEFAULT SYSDATE NOT NULL ,
	send_ecard_datetime                 date                        ,
	expiration_date                     date                        NOT NULL ,
	purchaser_shopper_id                char(32)                    NOT NULL ,
	purchaser_name                      varchar2(50)                ,
	purchaser_email                     varchar2(50)                ,
	recipient_name                      varchar2(50)                ,
	recipient_email                     varchar2(50)                ,
	recipient_shopper_id                char(32)                    ,
	ecard_type_id                       int                         ,
	msg_subject                         varchar2(200)               ,
	greeting_msg                        varchar2(4000)              ,
	redemption_id                       char(32)                    ,
	redemption_datetime                 date                        ,
	customized                          char(1)                     DEFAULT 'N' NOT NULL  ,
	cert_used                           char(1)                     DEFAULT 'N' NOT NULL  ,
	bogus                               char(1)                     DEFAULT 'N' NOT NULL  ,
	rowguid                             varchar2(50)                DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Gift_Cert
ADD CONSTRAINT PK_Gift_Cert PRIMARY KEY (cert_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Gift_Cert_01 ON Ya_Gift_Cert(purchaser_shopper_id, cert_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Gift_Cert_02 ON Ya_Gift_Cert(redemption_id, cert_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Gift_Cert_03 ON Ya_Gift_Cert(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Gift_Cert_04 ON Ya_Gift_Cert(order_num) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Gift_Cert_05 ON Ya_Gift_Cert(recipient_email) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Gift_Cert FOR Ya_Gift_Cert
/


create or replace TRIGGER TRI_gift_cert_1
BEFORE INSERT OR UPDATE OF customized
ON ya_gift_cert
FOR EACH ROW
BEGIN
	:NEW.customized := UPPER(:NEW.customized);
END;

create or replace TRIGGER TRI_gift_cert_2
BEFORE INSERT OR UPDATE OF cert_used
ON ya_gift_cert
FOR EACH ROW
BEGIN
	:NEW.cert_used := UPPER(:NEW.cert_used);
END;

create or replace TRIGGER TRI_gift_cert_3
BEFORE INSERT OR UPDATE OF bogus
ON ya_gift_cert
FOR EACH ROW
BEGIN
	:NEW.bogus := UPPER(:NEW.bogus);
END;