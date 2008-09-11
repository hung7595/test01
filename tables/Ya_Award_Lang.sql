DROP TABLE Ya_Award_Lang
/

CREATE TABLE Ya_Award_Lang (
	award_id                       int                      NOT NULL ,
	lang_id                        int                      NOT NULL
	award_name                     nvarchar2(510)           ,
	created_user                   varchar2(50)             ,
	created_date                   date                     NOT NULL ,
	updated_user                   varchar2(50)             ,
	updated_date                   date                     NOT NULL ,
	status                         int                      NOT NULL ,
	acdr                           char(1)                  ,
	data_supplier_id               int          
	action_owner                   varchar2(50)	
)
/

ALTER TABLE Ya_Award_Lang
ADD CONSTRAINT PK_Award_Lang PRIMARY KEY (award_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Lang FOR Ya_Award_Lang
/


create or replace TRIGGER TRI_award_lang
BEFORE INSERT OR UPDATE OF ACDR
ON ya_award_lang
FOR EACH ROW
BEGIN
	:NEW.ACDR := UPPER(:NEW.ACDR);
END;