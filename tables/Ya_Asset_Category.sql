DROP TABLE Ya_Asset_Category
/

CREATE TABLE Ya_Asset_Category (
	category_id                 int                      NOT NULL ,
	category_name               nvarchar2(255)           NOT NULL
)
/

ALTER TABLE Ya_Asset_Category
ADD CONSTRAINT PK_Asset_Category PRIMARY KEY (category_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset_Category FOR Ya_Asset_Category
/