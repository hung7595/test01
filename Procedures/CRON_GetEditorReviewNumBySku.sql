create or replace PROCEDURE CRON_GetEditorReviewNumBySku
AS
  iHistNo       NUMBER;
  irowAffected  NUMBER;
BEGIN
  Cronjob_adm.pkg_cronjob.Job_Start(2,iHistNo);

  IF iHistNo > 0 THEN
    Pkg_Fe_ReviewAccess_cron.GetEditorReviewNumBySku (irowAffected);
    DBMS_OUTPUT.PUT_LINE(irowAffected);
    Cronjob_adm.pkg_cronjob.Job_End(2,iHistNo);
  END IF;

END CRON_GetEditorReviewNumBySku;