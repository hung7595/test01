DROP TABLE Ya_Email_Referral
/

CREATE TABLE Ya_Email_Referral (
	shopper_id                  char(32 char)                     NOT NULL ,
	refer_email                 varchar2(50 char)                 NOT NULL ,
	created_datetime            date                              DEFAULT SYSDATE ,
	refer_name                  varchar2(50)                      ,
	shopper_name                varchar2(50)
	
)
/

ALTER TABLE Ya_Email_Referral
ADD CONSTRAINT PK_Email_Referral PRIMARY KEY (shopper_id, refer_email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Email_Referral FOR Ya_Email_Referral
/