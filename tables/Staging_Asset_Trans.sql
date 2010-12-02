DROP TABLE Staging_Asset_Trans
/

CREATE TABLE Staging_Asset_Trans (
	id                      int                 NOT NULL ,
	Asset_id                int                 NOT NULL ,
	locale                  varchar2(5)         NOT NULL ,
	content                 nvarchar2(2000)     ,
	mod_dt                  date                NOT NULL ,
	mod_user                varchar2(50)        NOT NULL
)
/

ALTER TABLE Staging_Asset_Trans
ADD CONSTRAINT PK_Staging_Asset_Trans PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Staging_Asset_Trans
ADD CONSTRAINT Un_Staging_Asset_trans_01 unique (Asset_id, locale)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Staging_Asset_Trans FOR Staging_Asset_Trans
/
