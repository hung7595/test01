DROP TABLE Ya_Promotion_Site
/

CREATE TABLE Ya_Promotion_Site (
	id                   int             NOT NULL, 
	promotion_id         int             NOT NULL,
	site_id              int             NOT NULL,
	is_enabled           char(1)         NOT NULL
)
/

ALTER TABLE Ya_Promotion_Site
ADD CONSTRAINT PK_promotion_site PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Promotion_Site
ADD CONSTRAINT Fk_Promotion_Site_01 FOREIGN KEY (promotion_id) REFERENCES ya_promotion (id)
/

ALTER TABLE Ya_Promotion_Site
ADD CONSTRAINT Un_Promotion_Site_01 unique (promotion_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Promotion_Site FOR Ya_Promotion_Site
/
