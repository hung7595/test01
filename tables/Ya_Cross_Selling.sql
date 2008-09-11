DROP TABLE Ya_Cross_Selling
/

CREATE TABLE Ya_Cross_Selling (
	sku                                  int                         NOT NULL ,
	related_sku                          int                         NOT NULL ,
	last_modified_datetime               date                        NOT NULL ,
	rating                               int                         NOT NULL ,
	override_flag                        varchar2(1)                 NOT NULL ,
	type_id                              int                         NOT NULL
)
/

ALTER TABLE Ya_Cross_Selling
ADD CONSTRAINT PK_Cross_Selling PRIMARY KEY (sku, related_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Cross_Selling_01 ON Ya_Cross_Selling(related_sku, sku, type_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Cross_Selling_02 ON Ya_Cross_Selling(sku, type_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Cross_Selling_03 ON Ya_Cross_Selling(sku, type_id, related_sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Cross_Selling FOR Ya_Cross_Selling
/


create or replace TRIGGER TRI_cross_selling
BEFORE INSERT OR UPDATE OF override_flag
ON ya_cross_selling
FOR EACH ROW
BEGIN
	:NEW.override_flag := UPPER(:NEW.override_flag);
END;