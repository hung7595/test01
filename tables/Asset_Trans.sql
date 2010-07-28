DROP TABLE Asset_Trans
/

CREATE TABLE Asset_Trans (
	id                      int                 NOT NULL ,
	asset_id                int                 NOT NULL ,
	locale                  varchar2(5)         NOT NULL ,
	content                 nvarchar2(2000)     ,
	mod_dt                  date                NOT NULL ,
	mod_user                varchar2(50)        NOT NULL
)
/

ALTER TABLE Asset_Trans
ADD CONSTRAINT PK_Asset_Trans PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Asset_Trans
ADD CONSTRAINT Un_asset_trans_01 unique (asset_id, locale)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Asset_Trans FOR Asset_Trans
/
