  CREATE OR REPLACE PACKAGE PKG_FE_REVIEWACCESS_CRON 
AS
  TYPE refCur IS REF CURSOR;

    PROCEDURE GetEditorReviewNumBySku;
    
    PROCEDURE ReviewShareByYwkFamilyCode (
        iPsku IN INT
    );

END Pkg_Fe_ReviewAccess_cron;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_REVIEWACCESS_CRON
IS
    PROCEDURE GetEditorReviewNumBySku
  AS
  BEGIN
        INSERT INTO ya_emag_editor_review_prod(sku, site_id, lang_id)
        SELECT prodRat.sku, prodReg.originId, prodRatLang.lang_id
        FROM
        (
            SELECT sku, rating_id FROM ya_product_rating
            WHERE 1=1
            AND (CASE WHEN (review_approved='Y' AND reviewer_type = 'EDITOR') THEN 'Y' ELSE NULL END) = 'Y'
        ) prodRat,
        (
            SELECT rating_id, us_review_id, lang_id FROM ya_prod_rating_lang
        ) prodRatLang,
        (
            SELECT review_id FROM ya_review WHERE (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
        ) rev,
        (
            SELECT prod_id as productid, origin_id as originid FROM prod_region WHERE origin_id = region_id AND category_id = 1 AND is_enabled = 'Y' --  AND cansell = 'Y'
        ) prodReg
        WHERE prodRat.rating_id = prodRatLang.rating_id
        AND prodRatLang.us_review_id =  rev.review_id
        AND prodRat.sku = prodReg.productId
        and not exists(
            select * from ya_emag_editor_review_prod eerp where eerp.sku = prodRat.sku and eerp.site_id = prodReg.originId and eerp.lang_id = prodRatLang.lang_id
        )
        group by prodRat.sku, prodReg.originId, prodRatLang.lang_id;

        COMMIT;
    RETURN;
  END GetEditorReviewNumBySku;
  
    PROCEDURE ReviewShareByYwkFamilyCode
        (iPsku IN INT) 
    AS
 
    iLgroupId INT;
    iLcountProductFamilyCode INT;
    iLcountCustomerReview INT;
    cPupdatedUser NVARCHAR2(100);
    iLcountReviewShareCust INT;
    iLcountReviewShareGroup INT;
    curLgroupId refCur;
 
    BEGIN
        cPupdatedUser := 'frontend review share cron';
        
        -- check ywk family code exist
        SELECT count(DISTINCT prod_id) into iLcountProductFamilyCode
        FROM prod_mapper 
        WHERE source_type_id = 3 
        AND source_id = 0 
        AND source_prod_id IN (
            SELECT source_prod_id 
            FROM prod_mapper 
            WHERE source_type_id = 3 
            AND source_id = 0 
            AND prod_id = iPsku);

        IF (iLcountProductFamilyCode > 0) THEN
            select count(*) into iLcountReviewShareCust 
            from ya_review_share_customerReview 
            where sku = iPsku;
            
            IF (iLcountReviewShareCust = 0) THEN
            insert into ya_review_share_customerReview (sku) values (iPsku);
        END IF;
        
        select count(*) into iLcountReviewShareGroup from ya_review_share_group where sku = iPsku;
        IF (iLcountReviewShareGroup = 0) THEN
        
            OPEN curLgroupId FOR
                -- assume there is one group id in ya_review_share_group
                select distinct(rsg.GROUP_ID) from ya_review_share_group rsg, ya_review_share_customerReview rsc
                where rsg.sku = rsc.sku
                and rsg.sku in (select DISTINCT prod_id
                from prod_mapper where source_type_id = 3 and source_id = 0 and source_prod_id in (
                    select source_prod_id 
                    from prod_mapper 
                    where source_type_id = 3 
                    and source_id = 0 
                    and prod_id = iPsku));
            
            FETCH curLgroupId INTO iLgroupId;
                IF curLgroupId%NOTFOUND THEN
                     SELECT SEQ_ya_review_share_group.nextval into iLgroupId FROM dual;
                END IF;
                
            CLOSE curLgroupId;
            
            insert into ya_review_share_group (group_id, sku, updated_dt, updated_user) values (iLgroupId, iPsku, sysdate, cPupdatedUser);
        END IF;
    
    ELSE        
        select count(*) into iLcountReviewShareGroup
        from ya_review_share_group 
        where sku = iPsku 
        and updated_user = cPupdatedUser;
      
        IF (iLcountReviewShareGroup > 0) THEN
            delete from ya_review_share_group where sku = iPsku and updated_user = cPupdatedUser;
            
            delete from ya_review_share_customerReview where sku = iPsku;
        END IF;  
    END IF;
    
    IF (SQLCODE = 0) THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
 
    END ReviewShareByYwkFamilyCode;

END Pkg_Fe_ReviewAccess_cron;
/

