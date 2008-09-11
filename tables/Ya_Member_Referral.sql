DROP TABLE Ya_Member_Referral
/

CREATE TABLE Ya_Member_Referral (
	site_id                          int                       NOT NULL ,
	campaign_code                    int                       NOT NULL ,
	referrer_email                   varchar2(100)             NOT NULL ,
	referree_email                   varchar2(100)             NOT NULL ,
	transaction_datetime             date                      DEFAULT SYSDATE NOT NULL ,
	registered_flag                  char(1)                   DEFAULT 'N' NOT NULL ,
	used_flag                        char(1)                   DEFAULT 'N' NOT NULL ,
	rowguid                          varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Member_Referral
ADD CONSTRAINT PK_Member_Referral PRIMARY KEY (site_id, campaign_code, referree_email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Member_Referral_01 ON Ya_Member_Referral(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Member_Referral FOR Ya_Member_Referral
/


create or replace TRIGGER TRI_member_referral_1
BEFORE INSERT OR UPDATE OF registered_flag
ON ya_member_referral
FOR EACH ROW
BEGIN
	:NEW.registered_flag := UPPER(:NEW.registered_flag);
END;

create or replace TRIGGER TRI_member_referral_2
BEFORE INSERT OR UPDATE OF used_flag
ON ya_member_referral
FOR EACH ROW
BEGIN
	:NEW.used_flag := UPPER(:NEW.used_flag);
END;