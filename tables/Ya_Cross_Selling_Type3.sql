DROP TABLE Ya_Cross_Selling_Type3
/

CREATE TABLE Ya_Cross_Selling_Type3 (
	sku                                  int                         NOT NULL ,
	related_sku                          int                         NOT NULL ,
	last_modified_datetime               date                        NOT NULL ,
	rating                               int                         NOT NULL ,
	override_flag                        varchar2(1)                 NOT NULL ,
	type_id                              int                         NOT NULL
)
/

ALTER TABLE Ya_Cross_Selling_Type3
ADD CONSTRAINT PK_Cross_Selling_Type3 PRIMARY KEY (sku, related_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Cross_Selling_Type3_01 ON Ya_Cross_Selling_Type3(related_sku, sku, type_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Cross_Selling_Type3 FOR Ya_Cross_Selling_Type3
/