DROP TABLE Ya_Asset_Tag
/

CREATE TABLE Ya_Asset_Tag (
	id                     int                      NOT NULL ,
	asset_id               int                      NOT NULL ,
	tag                    nvarchar2(255)           NOT NULL
)
/

ALTER TABLE Ya_Asset_Tag
ADD CONSTRAINT PK_Asset_Tag PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset_Tag FOR Ya_Asset_Tag
/