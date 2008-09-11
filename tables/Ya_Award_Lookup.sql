DROP TABLE Ya_Award_Lookup
/

CREATE TABLE Ya_Award_Lookup (
	award_lookup_id               int                      NOT NULL ,
	type                          int                      NOT NULL ,
	enable                        char(1)                  NOT NULL ,
	priority                      int                      NOT NULL
)
/

ALTER TABLE Ya_Award_Lookup
ADD CONSTRAINT PK_Award_Lookup PRIMARY KEY (award_lookup_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Lookup FOR Ya_Award_Lookup
/


create or replace TRIGGER TRI_award_lookup
BEFORE INSERT OR UPDATE OF enable
ON ya_award_lookup
FOR EACH ROW
BEGIN
	:NEW.enable := UPPER(:NEW.enable);
END;