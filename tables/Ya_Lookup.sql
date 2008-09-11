DROP TABLE Ya_Lookup
/

CREATE TABLE Ya_Lookup (
	type_id                    int                        NOT NULL ,
	type                       varchar2(50)               NOT NULL ,
	code_id                    int                        NOT NULL ,
	code                       varchar2(50)               NOT NULL ,
	meaning                    varchar2(100)              ,
	img_loc                    varchar2(100)              ,
	img_height                 int                        ,
	img_width                  int                        ,
	enabled                    char(1)
)
/

ALTER TABLE Ya_Lookup
ADD CONSTRAINT PK_Lookup PRIMARY KEY (type_id, code_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Lookup_01 ON Ya_Lookup(type, code) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Lookup FOR Ya_Lookup
/


create or replace TRIGGER TRI_lookup
BEFORE INSERT OR UPDATE OF enabled
ON ya_lookup
FOR EACH ROW
BEGIN
	:NEW.enabled := UPPER(:NEW.enabled);
END;