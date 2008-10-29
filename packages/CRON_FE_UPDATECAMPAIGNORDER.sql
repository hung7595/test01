CREATE OR REPLACE PACKAGE CRON_FE_UPDATECAMPAIGNORDER AS

  PROCEDURE UpdateCampaignOrder;

END CRON_FE_UPDATECAMPAIGNORDER;
/

CREATE OR REPLACE PACKAGE BODY CRON_FE_UPDATECAMPAIGNORDER AS

  PROCEDURE UpdateCampaignOrder
  AS
  BEGIN
    UPDATE ya_campaign_order 
      SET (ya_campaign_order.order_id)
      = (SELECT oi.id 
        FROM order_info oi
        WHERE ya_campaign_order.order_num = oi.origin_order_id)
    WHERE CAST(ya_campaign_order.order_id AS nvarchar2(20)) = ya_campaign_order.order_num;
    COMMIT;
  END UpdateCampaignOrder;

END CRON_FE_UPDATECAMPAIGNORDER;
/
