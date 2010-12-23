DROP TABLE Staging_Asset
/

CREATE TABLE Staging_Asset (
	id                      int                 NOT NULL ,
	key                     varchar2(100)       NOT NULL ,
	remark                  varchar2(2000)      ,
	app_enable              int                 NOT NULL ,
	create_dt               date                NOT NULL ,
	create_user             varchar2(50)        NOT NULL ,
	mod_dt                  date                NOT NULL ,
	mod_user                varchar2(50)        NOT NULL
)
/

ALTER TABLE Staging_Asset
ADD CONSTRAINT PK_Staging_Asset PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Staging_Asset
ADD CONSTRAINT Un_Staging_Asset_01 unique (key)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Staging_Asset FOR Staging_Asset
/
