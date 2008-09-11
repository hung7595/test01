DROP TABLE Ya_Customer_Promotion
/

CREATE TABLE Ya_Customer_Promotion (
	shopper_id                    char(32)                     NOT NULL ,
	question_type_id              int                          NOT NULL ,
	question_id                   int                          NOT NULL ,
	answer                        varchar2(2000)               NOT NULL ,
	reviewed                      char(1)                      DEFAULT 'N' NOT NULL ,
	guid                          varchar2(50)                 DEFAULT SYS_GUID() NOT NULL ,
	created_datetime              date                         DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Customer_Promotion
ADD CONSTRAINT PK_Customer_Promotion PRIMARY KEY (shopper_id, question_type_id, question_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Promotion FOR Ya_Customer_Promotion
/


create or replace TRIGGER TRI_customer_promotion
BEFORE INSERT OR UPDATE OF reviewed
ON ya_customer_promotion
FOR EACH ROW
BEGIN
	:NEW.reviewed := UPPER(:NEW.reviewed);
END;