Drop Table Ya_Editor_Note
/

CREATE TABLE Ya_Editor_Note (
	id                       int                 NOT NULL ,
	sku                      int                 NOT NULL ,
	title                    varchar2(200)       NOT NULL ,
	date_posted              date                NOT NULL ,
	shopper_id               char(32)            NOT NULL ,
	lang_id                  int                 NOT NULL ,
	review                   nclob               NOT NULL ,
	mod_dt                   date                NOT NULL
)
/

ALTER TABLE Ya_Editor_Note
ADD CONSTRAINT PK_Editor_Note PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Editor_Note_01 ON Ya_Editor_Note(date_posted, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Editor_Note_02 ON Ya_Editor_Note(sku, shopper_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Editor_Note_03 ON Ya_Editor_Note(shopper_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Editor_Note FOR Ya_Editor_Note
/