DROP TABLE Asset_Trans_Site
/

CREATE TABLE Asset_Trans_Site (
	id                      int                 NOT NULL ,
	asset_trans_id          int                 NOT NULL ,
	mod_dt                  date                NOT NULL ,
	mod_user                varchar2(50)        NOT NULL ,
	content                 nvarchar2(2000)     ,
	site_id                 int                 NOT NULL
)
/

ALTER TABLE Asset_Trans_Site
ADD CONSTRAINT PK_Asset_Trans_Site PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Asset_Trans_Site
ADD CONSTRAINT Un_Asset_Trans_Site_01 unique (asset_trans_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Asset_Trans_Site FOR Asset_Trans_Site
/
