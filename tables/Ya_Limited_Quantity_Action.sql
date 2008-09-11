DROP TABLE Ya_Limited_Quantity_Action
/

CREATE TABLE Ya_Limited_Quantity_Action (
	sku                              int                  NOT NULL ,
	site_id                          int                  DEFAULT 1 NOT NULL ,
	action_id                        int                  DEFAULT 1 NOT NULL ,
	action_datetime                  date                 DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Limited_Quantity_Action
ADD CONSTRAINT PK_Limited_Quantity_Action PRIMARY KEY (sku, site_id, action_datetime)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Limited_Quantity_Action FOR Ya_Limited_Quantity_Action
/