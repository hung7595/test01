DROP TABLE Bk_Ya_Frontend_Credit_System   
/

CREATE TABLE Bk_Ya_Frontend_Credit_System (
	credit_id                    int                     NOT NULL ,
	site_id                      int                     NOT NULL ,
	shopper_id                   char(32)                NOT NULL ,
	credit_code                  varchar2(50)            NOT NULL ,
	credit_type_id               int                     NOT NULL ,
	initial_balance              number(18,2)            ,
	current_balance              number(18,2)            ,
	transaction_datetime         date                    NOT NULL ,
	bogus                        char(1)                 NOT NULL ,
	remark                       varchar2(500)           ,
	rowguid                      varchar2(50)            NOT NULL
)
/


CREATE PUBLIC SYNONYM Bk_Ya_Frontend_Credit_System FOR Bk_Ya_Frontend_Credit_System
/


create or replace TRIGGER TRI_bk_frontend_credit_system
BEFORE INSERT OR UPDATE OF bogus
ON bk_ya_frontend_credit_system
FOR EACH ROW
BEGIN
	:NEW.bogus := UPPER(:NEW.bogus);
END;