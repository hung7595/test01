create or replace PROCEDURE CRON_UpdateBargainFPH_v5
AS
  iHistNo       NUMBER;
  iStepNo       NUMBER;
  irowAffected  NUMBER;
BEGIN
  Cronjob_adm.pkg_cronjob.Job_Start(16,iHistNo);

  IF iHistNo > 0 THEN

    -- V5 - Movies and Videos - All Chinese -> 106
     CronJob_adm.pkg_cronjob.Step_Start(16,1,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,106,101,1,106); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,106,101,1,106); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,1,iStepNo);
    
    -- V5 - Movies and Videos - Japan -> 6918
    CronJob_adm.pkg_cronjob.Step_Start(16,2,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,6918,102,1,6918); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,6918,102,1,6918); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,2,iStepNo);
    
    -- V5 - Movies and Videos - Korea -> 295
    CronJob_adm.pkg_cronjob.Step_Start(16,3,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,295,103,1,295); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,295,103,1,295); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,3,iStepNo);
    
    -- V5 - Movies and Videos - Western -> 8648
    CronJob_adm.pkg_cronjob.Step_Start(16,4,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,8648,104,1,8648); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,8648,104,1,8648); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,4,iStepNo);
    
    -- V5 - Music - All Chinese -> 83
    CronJob_adm.pkg_cronjob.Step_Start(16,5,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,83,105,1,83); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,83,105,1,83); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,5,iStepNo);
    
    -- V5 - Music - Japanese -> 97
    CronJob_adm.pkg_cronjob.Step_Start(16,6,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,97,106,1,97); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,97,106,1,97); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,6,iStepNo);
    
    -- V5 - Music - Korean -> 91
    CronJob_adm.pkg_cronjob.Step_Start(16,7,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,91,107,1,91); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,91,107,1,91); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,7,iStepNo);
    
    -- V5 - Concerts and MVs - All Chinese -> 163
    CronJob_adm.pkg_cronjob.Step_Start(16,8,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,163,108,1,163); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,163,108,1,163); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,8,iStepNo);
    
    -- V5 - Games - All -> 5
    CronJob_adm.pkg_cronjob.Step_Start(16,9,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,5,109,1,5); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,5,109,1,5); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,9,iStepNo);
    
    -- V5 - Toys - All -> 7153
    CronJob_adm.pkg_cronjob.Step_Start(16,10,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,7153,110,1,7153); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,7153,110,1,7153); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,10,iStepNo);
    
    -- V5 - Books - In Chinese -> 3591
    CronJob_adm.pkg_cronjob.Step_Start(16,11,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,3591,111,1,3591); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,3591,111,1,3591); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,11,iStepNo);
    
    -- V5 - Comics - In Chinese -> 2980
    CronJob_adm.pkg_cronjob.Step_Start(16,12,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,2980,112,1,2980); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,2980,112,1,2980); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,12,iStepNo);
    
    -- V5 - TV - All Chinese -> 157
    CronJob_adm.pkg_cronjob.Step_Start(16,13,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,157,113,1,157); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,157,113,1,157); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,13,iStepNo);
    
    -- V5 - TV - Japan -> 179
    CronJob_adm.pkg_cronjob.Step_Start(16,14,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,179,114,1,179); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,179,114,1,179); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,14,iStepNo);
    
    -- V5 - TV - Korea -> 2957
    CronJob_adm.pkg_cronjob.Step_Start(16,15,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,2957,115,1,2957); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,2957,115,1,2957); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,15,iStepNo);
    
    -- V5 - TV - Western -> 10961
    CronJob_adm.pkg_cronjob.Step_Start(16,16,iHistNo,iStepNo);
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,10961,116,1,10961); --US
    Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,10961,116,1,10961); --GB
    CronJob_adm.pkg_cronjob.Step_End(16,16,iStepNo);

    Cronjob_adm.pkg_cronjob.Job_End(16,iHistNo);
  END IF;

END CRON_UpdateBargainFPH_v5;
/