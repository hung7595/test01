DROP TABLE ya_campaign_history 
/

CREATE TABLE ya_campaign_history (
	campaign_code       int 	NOT NULL ,
	sku                 int 	NOT NULL ,
	action_type_id   	int 	NOT NULL ,
	action_datetime	    date 	NOT NULL 
) 
/

ALTER TABLE ya_campaign_history
ADD CONSTRAINT PK_campaign_history PRIMARY KEY (campaign_code, sku, action_type_id, action_datetime)
/

CREATE PUBLIC SYNONYM ya_campaign_history FOR ya_campaign_history;