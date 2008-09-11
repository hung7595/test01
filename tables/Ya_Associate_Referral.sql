DROP TABLE Ya_Associate_Referral
/

CREATE TABLE Ya_Associate_Referral (
	referrer_shopper_id               char(32)                 NOT NULL ,
	referee_email                     varchar2(100)            NOT NULL ,
	site_id                           int                      NOT NULL ,
	referree_shopper_id               char(32)                 ,
	referral_id                       char(32)                 NOT NULL ,
	signup_status                     int                      DEFAULT 1 NOT NULL ,
	created_datetime                  date                     DEFAULT SYSDATE NOT NULL ,
	rowguid                           varchar2(50)             DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Referral
ADD CONSTRAINT PK_Associate_Referral PRIMARY KEY (referrer_shopper_id, referee_email)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Referral_01 ON Ya_Associate_Referral(referral_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Referral_02 ON Ya_Associate_Referral(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Referral FOR Ya_Associate_Referral
/