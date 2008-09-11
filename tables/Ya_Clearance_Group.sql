DROP TABLE Ya_Clearance_Group
/

CREATE TABLE Ya_Clearance_Group (
	sku                       int                      NOT NULL ,
	group_id                  int                      NOT NULL ,
	site_id                   int                      NOT NULL ,
	enabled                   char(1)                  NOT NULL
)
/


ALTER TABLE Ya_Clearance_Group
ADD CONSTRAINT PK_Clearance_Group PRIMARY KEY (sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Clearance_Group FOR Ya_Clearance_Group
/


create or replace TRIGGER TRI_clearance_group
BEFORE INSERT OR UPDATE OF enabled
ON ya_clearance_group
FOR EACH ROW
BEGIN
	:NEW.enabled := UPPER(:NEW.enabled);
END;