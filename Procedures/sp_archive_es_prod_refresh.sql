create or replace PROCEDURE sp_archive_es_prod_refresh
(iArchiveHours	NUMBER)
AS
BEGIN

  DELETE FROM ya_es_prod_refresh
  WHERE MOD_DT <= sysdate - iArchiveHours/24;

  COMMIT;

END;