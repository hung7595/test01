DROP TABLE Ya_Promotion_Bundle
/

CREATE TABLE Ya_Promotion_Bundle (
	sku                                      int                        NOT NULL ,
	partner_sku                              int                        NOT NULL ,
	bundled_discount                         number(18,2)               NOT NULL ,
	partner_bundled_discount                 number(18,2)               NOT NULL ,
	start_date                               date                       ,
	end_date                                 date                       ,
	site_id                                  int                        NOT NULL ,
	last_updated_user                        varchar2(20)               NOT NULL ,
	last_updated_datetime                    date                       NOT NULL
)	
/

ALTER TABLE Ya_Promotion_Bundle
ADD CONSTRAINT PK_Promotion_Bundle PRIMARY KEY (sku, partner_sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Promotion_Bundle_01 ON Ya_Promotion_Bundle(site_id, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Promotion_Bundle_02 ON Ya_Promotion_Bundle(site_id, partner_sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Promotion_Bundle_03 ON Ya_Promotion_Bundle(sku, site_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Promotion_Bundle_04 ON Ya_Promotion_Bundle(partner_sku, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Promotion_Bundle FOR Ya_Promotion_Bundle
/