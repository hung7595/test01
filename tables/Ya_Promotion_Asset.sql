DROP TABLE Ya_Promotion_Asset
/

CREATE TABLE Ya_Promotion_Asset (
	id                    int               NOT NULL, 
	promotion_id          int               NOT NULL,
	type                  int               NOT NULL,
	asset_key             varchar2(100)     NOT NULL,
	priority              int               NOT NULL,
	display_type          int               NOT NULL
)
/
ALTER TABLE Ya_Promotion_Asset
ADD CONSTRAINT PK_Promotion_Asset PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Promotion_Asset
ADD CONSTRAINT Fk_Promotion_Asset_01 FOREIGN KEY (promotion_id) REFERENCES ya_promotion (id)
/

ALTER TABLE Ya_Promotion_Asset
ADD CONSTRAINT Un_Promotion_Asset_01 unique (promotion_id, type, asset_key, priority)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Promotion_Asset FOR Ya_Promotion_Asset
/
