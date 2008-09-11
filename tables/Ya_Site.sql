DROP TABLE Ya_Site
/

CREATE TABLE Ya_Site (
	site_id                    int                   NOT NULL ,
	site_name                  varchar2(25)
)	
/

ALTER TABLE Ya_Site
ADD CONSTRAINT PK_Site PRIMARY KEY (site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Site FOR Ya_Site
/