CREATE OR REPLACE PROCEDURE CRON_UPDATECAMPAIGNORDER AS

  iHistNo       NUMBER;
  irowAffected  NUMBER;

BEGIN

  Cronjob_adm.pkg_cronjob.Job_Start(15,iHistNo);
  IF iHistNo > 0 THEN

  CRON_FE_UPDATECAMPAIGNORDER.UpdateCampaignOrder;

  Cronjob_adm.pkg_cronjob.Job_End(15,iHistNo);

  END IF;

END CRON_UPDATECAMPAIGNORDER;
/
