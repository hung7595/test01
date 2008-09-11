DROP TABLE Ya_Survey_Customer
/

CREATE TABLE Ya_Survey_Customer (
	survey_code                 int                        NOT NULL ,
	identity_value              varchar2(50)               NOT NULL ,
	get_coupon                  char(1)                    NOT NULL ,
	expiration_date             date                       NOT NULL
)	
/

ALTER TABLE Ya_Survey_Customer
ADD CONSTRAINT PK_Survey_Customer PRIMARY KEY (survey_code, identity_value)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Customer FOR Ya_Survey_Customer
/


create or replace TRIGGER TRI_survey_customer
BEFORE INSERT OR UPDATE OF get_coupon
ON ya_survey_customer
FOR EACH ROW
BEGIN
	:NEW.get_coupon := UPPER(:NEW.get_coupon);
END;