DROP TABLE Ya_Campaign
/

CREATE TABLE Ya_Campaign (
	campaign_code                   int                    NOT NULL ,
	sku                             int                    NOT NULL ,
	campaign_datetime               date                   NOT NULL ,
	created_datetime                date
)
/


ALTER TABLE Ya_Campaign
ADD CONSTRAINT PK_Campaign PRIMARY KEY (campaign_code, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Campaign_01 ON Ya_Campaign(sku, campaign_code) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Campaign FOR Ya_Campaign
/


create or replace TRIGGER TrID_ya_campaign
AFTER INSERT OR DELETE ON ya_campaign
FOR EACH ROW

DECLARE
BEGIN
    IF INSERTING THEN
      INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
            VALUES (:new.campaign_code, :new.sku, 1, sysdate);
    ELSIF DELETING THEN
        INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
            VALUES (:old.campaign_code, :old.sku, 2, sysdate);
    END IF;
END TrID_ya_campaign;