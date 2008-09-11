DROP TABLE Ya_Asset_Category_Rel
/

CREATE TABLE Ya_Asset_Category_Rel (
	asset_id                    int                    NOT NULL ,
	category_id                 int                    NOT NULL
)
/

ALTER TABLE Ya_Asset_Category_Rel
ADD CONSTRAINT PK_Asset_Category_Rel PRIMARY KEY (asset_id, category_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset_Category_Rel FOR Ya_Asset_Category_Rel
/