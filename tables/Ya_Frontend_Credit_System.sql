DROP TABLE Ya_Frontend_Credit_System
/

CREATE TABLE Ya_Frontend_Credit_System (
	credit_id                      int                        NOT NULL ,
	site_id                        int                        NOT NULL ,
	shopper_id                     char(32)                   NOT NULL ,
	credit_code                    varchar2(50)               NOT NULL ,
	credit_type_id                 int                        NOT NULL ,
	initial_balance                number(18,2)               ,        
	current_balance                number(18,2)               ,        
	transaction_datetime           date                       DEFAULT SYSDATE NOT NULL ,
	bogus                          char(1)                    DEFAULT 'N' NOT NULL ,
	remark                         varchar2(500)              ,        
	rowguid                        varchar2(50)               DEFAULT SYS_GUID() NOT NULL ,
	currency                       char(3)                    DEFAULT 'USD'
)
/

ALTER TABLE Ya_Frontend_Credit_System
ADD CONSTRAINT PK_Frontend_Credit_System PRIMARY KEY (credit_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Frontend_Credit_System_01 ON Ya_Frontend_Credit_System(credit_code) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Frontend_Credit_System_02 ON Ya_Frontend_Credit_System(shopper_id, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Frontend_Credit_System FOR Ya_Frontend_Credit_System
/


create or replace TRIGGER TRI_frontend_credit_system
BEFORE INSERT OR UPDATE OF bogus
ON ya_frontend_credit_system
FOR EACH ROW
BEGIN
	:NEW.bogus := UPPER(:NEW.bogus);
END;