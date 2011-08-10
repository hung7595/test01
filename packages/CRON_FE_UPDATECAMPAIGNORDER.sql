CREATE OR REPLACE PACKAGE CRON_FE_UPDATECAMPAIGNORDER AS

  PROCEDURE UpdateCampaignOrder;

END CRON_FE_UPDATECAMPAIGNORDER;
/

CREATE OR REPLACE PACKAGE BODY CRON_FE_UPDATECAMPAIGNORDER AS

  PROCEDURE UpdateCampaignOrder
  AS
  BEGIN
    UPDATE ya_campaign_order co
      SET (order_id)
      = (SELECT oi.id 
        FROM order_info oi
        WHERE co.order_num = oi.origin_order_id
        and rownum<=1)
    WHERE CAST(co.order_id AS nvarchar2(20)) = co.order_num;
    COMMIT;
  END UpdateCampaignOrder;

END CRON_FE_UPDATECAMPAIGNORDER;
/
