create or replace PROCEDURE Cron_UpdateNewsSubscriber
AS
	iHistNo       NUMBER;

BEGIN
  Cronjob_adm.pkg_cronjob.Job_Start(13, iHistNo);

  IF iHistNo > 0 THEN
  Cron_fe_UpdateNewsSubscriber.UpdateNewsSubInfo(10);
  Cron_fe_UpdateNewsSubscriber.UpdateNewsSubInfo(11);

  Cronjob_adm.pkg_cronjob.Job_End(13, iHistNo);
  END IF;

END Cron_UpdateNewsSubscriber;
/