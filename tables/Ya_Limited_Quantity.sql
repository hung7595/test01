DROP TABLE Ya_Limited_Quantity
/

CREATE TABLE Ya_Limited_Quantity (
	sku                                   int                  NOT NULL ,
	site_id                               int                  NOT NULL ,
	frontend_quantity                     int                  DEFAULT 0 NOT NULL ,
	backend_quantity                      int                  DEFAULT 0 NOT NULL ,
	total_quantity                        int                  DEFAULT 0 NOT NULL ,
	action_id                             int                  NOT NULL ,
	campaign_code                         int                  ,
	campaign_datetime                     date                 DEFAULT SYSDATE NOT NULL ,
	fe_last_change_datetime               date                 DEFAULT SYSDATE NOT NULL ,
	be_last_change_datetime               date                 DEFAULT SYSDATE NOT NULL ,
	rowguid                               varchar2(50)         DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Limited_Quantity
ADD CONSTRAINT PK_Limited_Quantity PRIMARY KEY (sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Limited_Quantity_01 ON Ya_Limited_Quantity(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Limited_Quantity_02 ON Ya_Limited_Quantity(sku, site_id, frontend_quantity) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Limited_Quantity FOR Ya_Limited_Quantity
/