create or replace PROCEDURE CRON_PopcornCampaign
AS
  iHistNo       NUMBER;
  irowAffected  NUMBER;
BEGIN
  Cronjob_adm.pkg_cronjob.Job_Start(17,iHistNo);

  IF iHistNo > 0 THEN
    Cron_fe_PopcornCampaign.CronJobUpdateCampaign;
    Cronjob_adm.pkg_cronjob.Job_End(17,iHistNo);
  END IF;

END CRON_PopcornCampaign;