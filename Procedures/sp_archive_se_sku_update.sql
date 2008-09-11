create or replace PROCEDURE sp_archive_se_sku_update
(iArchiveHours	NUMBER)
AS
BEGIN

  DELETE FROM ya_se_sku_update
  WHERE UPDATED_DATE <= sysdate - iArchiveHours/24;

  COMMIT;

END;