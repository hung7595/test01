CREATE OR REPLACE PACKAGE CRON_FE_INVALIDATIONACCESS AS

  PROCEDURE InvalidationListHouseKeeping
  (
    iPNumOfDays IN int
  );

END CRON_FE_INVALIDATIONACCESS;
/

create or replace PACKAGE BODY CRON_FE_INVALIDATIONACCESS AS
 
  PROCEDURE InvalidationListHouseKeeping
  (
    iPNumOfDays IN int
  ) AS
  BEGIN
 
      -- Delete the list in the table ya_asset_translation_invalid
      delete from ya_asset_translation_invalid where process_flag='Y' and sysdate > created_datetime + iPNumOfDays  ;
      
      -- Delete the list in the table ya_cache_invalidate
      delete from ya_cache_invalidate where process_flag='Y' and sysdate > created_datetime + iPNumOfDays  ;
 
      COMMIT;
      RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END InvalidationListHouseKeeping;
 
END CRON_FE_INVALIDATIONACCESS;
/
