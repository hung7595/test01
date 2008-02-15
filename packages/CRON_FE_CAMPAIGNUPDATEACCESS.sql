CREATE OR REPLACE PACKAGE CRON_FE_CAMPAIGNUPDATEACCESS AS

  PROCEDURE UpdateChineseDVDFreeList;

END CRON_FE_CAMPAIGNUPDATEACCESS;
/

CREATE OR replace PACKAGE BODY CRON_FE_CAMPAIGNUPDATEACCESS AS
 
  PROCEDURE UpdateChineseDVDFreeList
  AS
  BEGIN
 
    INSERT INTO ya_campaign (campaign_code, sku, campaign_datetime, created_datetime)
      SELECT distinct 135, p.sku, sysdate, sysdate
      FROM ya_product p  
      INNER JOIN ya_prod_attr pa ON p.sku = pa.sku AND attribute_id = 117  
        LEFT JOIN ya_campaign c ON p.sku = c.sku AND (campaign_code = 133 OR campaign_code = 134)  
        LEFT JOIN ya_bargain_product bp ON p.sku = bp.sku AND sysdate >= sale_start AND sysdate <= sale_end  
        INNER JOIN prod_avlb bpa ON p.sku = bpa.prod_id AND bpa.avlb < 60  
      WHERE account_id in (103,105,123,14,10,11,12,13,24,25,64,63,26,160,150,41,34,156,159,157,40,120,149,209,160,150,147,148)  
        AND c.sku is null  
        AND bp.sku is null  
        AND p.sku not in (select cp.sku from ya_campaign cp where cp.campaign_code = 135);
        
      DELETE FROM ya_campaign cp 
      WHERE cp.campaign_code = 135 
        AND cp.sku NOT IN (
        SELECT distinct p.sku
        FROM ya_product p  
        INNER JOIN ya_prod_attr pa ON p.sku = pa.sku AND attribute_id = 117  
          LEFT JOIN ya_campaign c ON p.sku = c.sku AND (campaign_code = 133 OR campaign_code = 134)  
          LEFT JOIN ya_bargain_product bp ON p.sku = bp.sku AND sysdate >= sale_start AND sysdate <= sale_end  
          INNER JOIN prod_avlb bpa ON p.sku = bpa.prod_id AND bpa.avlb < 60  
        WHERE account_id in (103,105,123,14,10,11,12,13,24,25,64,63,26,160,150,41,34,156,159,157,40,120,149,209,160,150,147,148)  
          AND c.sku is null  
          AND bp.sku is null 
        );
        
      COMMIT;
      RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END UpdateChineseDVDFreeList;
 
END CRON_FE_CAMPAIGNUPDATEACCESS;
/
