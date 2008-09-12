create or replace PROCEDURE CRON_UpdatePublisherDept
AS
  iHistNo       NUMBER;
  iStepNo       NUMBER;
  irowAffected  NUMBER;
BEGIN
  Cronjob_adm.pkg_cronjob.Job_Start(10,iHistNo);

  IF iHistNo > 0 THEN

    CronJob_adm.pkg_cronjob.Step_Start(10,1,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10864);
	CronJob_adm.pkg_cronjob.Step_End(10,1,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,2,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11143);
	CronJob_adm.pkg_cronjob.Step_End(10,2,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,3,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11296);
	CronJob_adm.pkg_cronjob.Step_End(10,3,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,4,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11118);
	CronJob_adm.pkg_cronjob.Step_End(10,4,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,5,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11213);
	CronJob_adm.pkg_cronjob.Step_End(10,5,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,6,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11276);
	CronJob_adm.pkg_cronjob.Step_End(10,6,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,7,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(7153);
	CronJob_adm.pkg_cronjob.Step_End(10,7,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,8,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10);
	CronJob_adm.pkg_cronjob.Step_End(10,8,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,9,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10795);
	CronJob_adm.pkg_cronjob.Step_End(10,9,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,10,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10799);
	CronJob_adm.pkg_cronjob.Step_End(10,10,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,11,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10801);
	CronJob_adm.pkg_cronjob.Step_End(10,11,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,12,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10803);
	CronJob_adm.pkg_cronjob.Step_End(10,12,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,13,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10805);
	CronJob_adm.pkg_cronjob.Step_End(10,13,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,14,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(10807);
	CronJob_adm.pkg_cronjob.Step_End(10,14,iStepNo);

	CronJob_adm.pkg_cronjob.Step_Start(10,15,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11434);
	CronJob_adm.pkg_cronjob.Step_End(10,15,iStepNo);
	
	CronJob_adm.pkg_cronjob.Step_Start(10,16,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11527);
	CronJob_adm.pkg_cronjob.Step_End(10,16,iStepNo);	

	CronJob_adm.pkg_cronjob.Step_Start(10,17,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11528);
	CronJob_adm.pkg_cronjob.Step_End(10,17,iStepNo);
	
	CronJob_adm.pkg_cronjob.Step_Start(10,18,iHistNo,iStepNo);
	SS_adm.Cron_fe_PublisherAccess.CronJobUpdatePublisherDept(11583);
	CronJob_adm.pkg_cronjob.Step_End(10,18,iStepNo);

    Cronjob_adm.pkg_cronjob.Job_End(10,iHistNo);
  END IF;

END CRON_UpdatePublisherDept;
/