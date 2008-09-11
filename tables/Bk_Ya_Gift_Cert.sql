DROP TABLE Bk_Ya_Gift_Cert   
/

CREATE TABLE Bk_Ya_Gift_Cert (
	cert_code                     varchar2(50)             NOT NULL ,
	site_id                       int                      NOT NULL ,
	order_num                     int                      NOT NULL ,
	sku                           int                      NOT NULL ,
	cert_amount                   number(18,2)             NOT NULL ,
	created_datetime              date                     NOT NULL ,
	send_ecard_datetime           date                     NOT NULL ,
	expiration_date               date                     NOT NULL ,
	purchaser_shopper_id          char(32)                 NOT NULL ,
	purchaser_name                varchar2(50)             ,
	purchaser_email               varchar2(50)             ,
	recipient_name                varchar2(50)             ,
	recipient_email               varchar2(50)             ,
	recipient_shopper_id          char(32)                 ,
	ecard_type_id                 int                      ,
	msg_subject                   varchar2(200)            ,
	greeting_msg                  varchar2(4000)           ,
	redemption_id                 char(32)                 ,
	redemption_datetime           date                     ,
	customized                    char(1)                  NOT NULL ,
	cert_used                     char(1)                  NOT NULL ,
	bogus                         char(1)                  NOT NULL ,
	rowguid             	      varchar2(50)             NOT NULL
)
/


CREATE PUBLIC SYNONYM Bk_Ya_Gift_Cert FOR Bk_Ya_Gift_Cert
/


create or replace TRIGGER TRI_bk_gift_cert_1
BEFORE INSERT OR UPDATE OF customized
ON bk_ya_gift_cert
FOR EACH ROW
BEGIN
	:NEW.customized := UPPER(:NEW.customized);
END;

create or replace TRIGGER TRI_bk_gift_cert_2
BEFORE INSERT OR UPDATE OF cert_used
ON bk_ya_gift_cert
FOR EACH ROW
BEGIN
	:NEW.cert_used := UPPER(:NEW.cert_used);
END;

create or replace TRIGGER TRI_bk_gift_cert_3
BEFORE INSERT OR UPDATE OF bogus
ON bk_ya_gift_cert
FOR EACH ROW
BEGIN
	:NEW.bogus := UPPER(:NEW.bogus);
END;