DROP TABLE Asset
/

CREATE TABLE Asset (
	id                      int                 NOT NULL ,
	version                 int                 NOT NULL ,
	key                     varchar2(100)       NOT NULL ,
	remark                  varchar2(2000)      ,
	app_enable              int                 NOT NULL ,
	create_dt               date                NOT NULL ,
	create_user             varchar2(50)        NOT NULL ,
	mod_dt                  date                NOT NULL ,
	mod_user                varchar2(50)        NOT NULL
)
/

ALTER TABLE Asset
ADD CONSTRAINT PK_Asset_01 PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Asset
ADD CONSTRAINT Un_asset_01 unique (key)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Asset FOR Asset
/
