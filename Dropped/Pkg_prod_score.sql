CREATE OR REPLACE PACKAGE pkg_prod_score
AS

PROCEDURE updt_prod_score_dtls(
    iP_sku INT,
    iP_has_sales INT
);

END pkg_prod_score;
/

CREATE OR REPLACE PACKAGE BODY pkg_prod_score AS

/*
 * sp_yaProdScoreDetails
 *
 * Store procedure for updating entries in ya_prod_score_details to compute 
 * all relevant information for YA Ranking for a given SKU in 2 sites. 
 * This procedure will compute based on 2 site IDs {1, 7} and it
 * will retrieve data from tables,
 * - ya_product
 * - ya_prod_lang
 * - backend..productAvailability
 * - ya_review_summary
 * - campaign
 * - ya_review
 * - ya_prod_rating_lang
 * - ya_product_rating
 * 
 * Input Parameters:
 * - int sku
 * - int hasSales (0 for no sales; 1 for sales in DataMining..dm_nDay_sales)
 *
 * Default Values:
 * - if ya_product.release_date, ya_product.us_launch_date, ya_product.tw_launch_date
 *   is null, assign '2000/1/1' as default values. See @default_date...
 *
 * Sample Usage:
 *    exec sp_yaProdScoreDetails <SKU>, <has Sales data Y/N: 1 | 0>
 *    exec sp_yaProdScoreDetails 1340, 1
 *
 * Last Updated Date: 2005-07-28
 * Last Update By: ywtsang
 * Created Date: 2004-9-8
 * Created By: Colin Cheung
 *
 */
PROCEDURE updt_prod_score_dtls (
    iP_sku INT,
    iP_has_sales INT
)
AS

    -- DECLARE Local Variable
    iL_campaign_count INT;
    iL_with_description INT;
    iL_pro_review_count INT;
    iL_customer_review_count INT;
    iL_customer_review_rating NUMBER(18, 2);
    iL_day_since_release INT;
    iL_with_cover_image INT;
    iL_account_id  INT;
    iL_inventory_qnty INT;
    iL_site_id INT;
    iL_day_since_launch_us INT;
    iL_discount_item_us INT;
    iL_day_since_launch_tw INT;
    iL_discount_item_tw INT;
    
    dL_default_date DATE;
    
BEGIN

    -- default date used when date is NULL value
    dL_default_date := TO_DATE('2000-01-01', 'YYYY-MM-DD');

    BEGIN
        SELECT SUM(qnty) INTO iL_inventory_qnty FROM inventory WHERE prod_id = iP_sku GROUP BY prod_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        iL_inventory_qnty := 0;
    END;
    
    BEGIN
        SELECT (CASE WHEN count(*) > 0 THEN 1 ELSE 0 END) INTO iL_campaign_count FROM ya_campaign WHERE sku = iP_sku;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        iL_campaign_count := 0;
    END;

    BEGIN
        SELECT 
           yp.account_id,
           (SYSDATE - (CASE WHEN (yp.release_date IS NULL) THEN dL_default_date ELSE yp.release_date END) ),
           (SYSDATE - (CASE WHEN (yp.us_launch_date IS NULL) THEN dL_default_date ELSE yp.us_launch_date END) ), 
           (CASE WHEN LENGTH(yp.cover_img_loc) > 0 THEN 1 ELSE 0 END), 
           (CASE WHEN (yp.us_sale_price > 0 AND yp.us_sale_start < SYSDATE AND yp.us_sale_end > SYSDATE) THEN 1 ELSE 0 END ) ,
    
           (SYSDATE - (CASE WHEN (yp.tw_launch_date IS NULL) THEN dL_default_date ELSE yp.tw_launch_date END) ) , 
           (CASE WHEN (yp.tw_sale_price > 0 AND yp.tw_sale_start < SYSDATE AND yp.tw_sale_end > SYSDATE) THEN 1 ELSE 0 END) 
    
            INTO iL_account_id, iL_day_since_release, iL_day_since_launch_us, iL_with_cover_image, iL_discount_item_us,
                iL_day_since_launch_tw, iL_discount_item_tw
        FROM ya_product yp
        WHERE yp.sku = iP_sku;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        iL_account_id := 0;
        iL_day_since_release := 0;
        iL_day_since_launch_us := 0;
        iL_with_cover_image := 0;
        iL_discount_item_us := 0;
        iL_day_since_launch_tw := 0;
        iL_discount_item_tw := 0;
    END;


    -- contentSuppot(reserved/NULL), is campaign item, has prod. description
    -- number of professional review,
    -- actual customer review count, avg customer rating
    -- days in release date, days in launch_date, has image, is onsale
    -- site = US
    iL_site_id := 1;
        BEGIN
            SELECT (CASE WHEN sum(us_description_id) > 0 THEN 1 ELSE 0 END) INTO iL_with_description FROM ya_prod_lang WHERE sku = iP_sku AND us_description_id IS NOT NULL;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            iL_with_description := 0;
        END;
            
        BEGIN
        
             SELECT COUNT(*) INTO iL_pro_review_count FROM (
                 SELECT COUNT(*)
                     FROM ya_review yr, ya_prod_rating_lang yprl, ya_product_rating ypr
                     WHERE yr.review_id = yprl.us_review_id   
                     AND yprl.rating_id = ypr.rating_id
                     AND ypr.sku = iP_sku  AND ypr.shopper_id = 'EDITORIAL' 
                     AND yprl.us_review_id IS NOT NULL
                     GROUP by TO_CHAR(yr.review));
        EXCEPTION WHEN NO_DATA_FOUND THEN
            iL_pro_review_count := 0;
        END;
        
        BEGIN
             SELECT SUM(actual_count) INTO iL_customer_review_count FROM ya_review_summary WHERE site_id = iL_site_id AND sku = iP_sku GROUP BY sku ;
        EXCEPTION WHEN NO_DATA_FOUND THEN
             iL_customer_review_count := 0;
        END;
    
        BEGIN
             SELECT SUM(average_rating * actual_count)/sum(actual_count) INTO iL_customer_review_rating FROM ya_review_summary WHERE site_id = iL_site_id AND sku = iP_sku GROUP BY sku;
        EXCEPTION WHEN NO_DATA_FOUND THEN
             iL_customer_review_rating := 0;
        END;
                 
         UPDATE ya_prod_score_details 
             SET lastUpdateDate=SYSDATE, 
                 campaignItem=iL_campaign_count, 
                 withProductDescription=iL_with_description, 
                 professionalReview=iL_pro_review_count, 
                 customerReview=iL_customer_review_count, 
                 customerRating=iL_customer_review_rating, 
                 daySinceRelease=iL_day_since_release, 
                 daySinceLaunch=iL_day_since_launch_us, 
                 withCoverImage=iL_with_cover_image, 
                 discountItem=iL_discount_item_us,
                 hasSales=iP_has_sales,
                 inventoryQuantity=iL_inventory_qnty,
                 account_id=iL_account_id
          WHERE sku=iP_sku and siteId=iL_site_id;

               
      -- site = GB
      iL_site_id := 7;
          BEGIN
               SELECT (CASE WHEN sum(tw_description_id) > 0 THEN 1 ELSE 0 END) INTO iL_with_description FROM ya_prod_lang WHERE sku = iP_sku AND tw_description_id IS NOT NULL;
          EXCEPTION WHEN NO_DATA_FOUND THEN
               iL_with_description := 0;
          END;
           
          BEGIN
                SELECT COUNT(*) INTO iL_pro_review_count FROM (
                     SELECT COUNT(*)
                         FROM ya_review yr, ya_prod_rating_lang yprl, ya_product_rating ypr
                         WHERE yr.review_id = yprl.tw_review_id   
                         AND yprl.rating_id = ypr.rating_id
                         AND ypr.sku = iP_sku  AND ypr.shopper_id = 'EDITORIAL' 
                         AND yprl.tw_review_id IS NOT NULL
                         GROUP by TO_CHAR(yr.review));
          EXCEPTION WHEN NO_DATA_FOUND THEN
                 iL_pro_review_count := 0;
          END;
          
          BEGIN
               SELECT sum(actual_count) INTO iL_customer_review_count FROM ya_review_summary WHERE site_id = iL_site_id AND sku = iP_sku GROUP BY sku;
          EXCEPTION WHEN NO_DATA_FOUND THEN
               iL_customer_review_count := 0;
          END;
   
          BEGIN
               SELECT sum(average_rating * actual_count)/sum(actual_count) INTO iL_customer_review_rating FROM ya_review_summary WHERE site_id = iL_site_id AND sku = iP_sku GROUP BY sku;
          EXCEPTION WHEN NO_DATA_FOUND THEN
               iL_customer_review_rating := 0;
          END;

                    
      UPDATE ya_prod_score_details 
         SET lastUpdateDate=SYSDATE, 
             campaignItem=iL_campaign_count, 
             withProductDescription=iL_with_description, 
             professionalReview=iL_pro_review_count, 
             customerReview=iL_customer_review_count, 
             customerRating=iL_customer_review_rating, 
             daySinceRelease=iL_day_since_release, 
             daySinceLaunch=iL_day_since_launch_tw, 
             withCoverImage=iL_with_cover_image, 
             discountItem=iL_discount_item_tw,
             hasSales=iP_has_sales,
             inventoryQuantity=iL_inventory_qnty,
             account_id=iL_account_id
      WHERE sku=iP_sku and siteId=iL_site_id;
         
    COMMIT;

END updt_prod_score_dtls;

END pkg_prod_score;
/