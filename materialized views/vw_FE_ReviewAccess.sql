drop materialized view vw_FE_ReviewAccess
/

Create materialized view vw_FE_ReviewAccess
REFRESH COMPLETE ON DEMAND
AS 
select 
prodRat.rating_id, rev.review_id, prodRat.sku,
cast(NVL(prodRat.product_rating, 0) AS int) AS product_rating,
prodRat.date_posted, 
prodRat.review_approved,
prodRat.shopper_id AS shopper_id,
prodRat.reviewer AS reviewer,
prodRat.reviewer_type,
cast(NVL(prodRatLang.lang_id, 1) AS int) AS lang_id,
prodRatLang.title AS title,
rev.review AS review,
rev.review_img_loc AS review_img_loc,
cast(NVL(rev.review_img_width, 0) AS int) AS review_img_width,
cast(NVL(rev.review_img_height, 0) AS int) AS review_img_height,
p.account_id
FROM
ya_product_rating prodRat, ya_product p, ya_prod_rating_lang prodRatLang, ya_review rev
WHERE 1=1
AND p.sku = prodRat.sku
AND prodRat.rating_id = prodRatLang.rating_id
AND prodRatLang.us_review_id = rev.review_id
AND (((review IS NOT NULL) AND (LENGTH(review)>0)) OR ((review_img_loc IS NOT NULL) AND (LENGTH(review_img_loc)>0)))
AND prodRat.review_approved='Y' 
AND prodRat.reviewer_type = 'EDITORIAL'	
/
