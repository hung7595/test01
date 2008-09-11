create or replace PROCEDURE cron_campaignupdateaccess
AS
  iHistNo       NUMBER;
  irowAffected  NUMBER;
BEGIN
  Cronjob_adm.pkg_cronjob.Job_Start(12,iHistNo);

  IF iHistNo > 0 THEN
    CRON_FE_CAMPAIGNUPDATEACCESS.UpdateChineseDVDFreeList;
    Cronjob_adm.pkg_cronjob.Job_End(12,iHistNo);
  END IF;

END cron_campaignupdateaccess;