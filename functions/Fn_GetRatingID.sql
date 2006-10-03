CREATE OR REPLACE FUNCTION Fn_GetRatingID (iSKU IN NUMBER)
RETURN NUMBER DETERMINISTIC
IS
  iRating_ID        NUMBER:=0;
BEGIN
  SELECT /*+ INDEX(R IX_REVIEW_2) */
  pr.rating_id INTO iRating_ID
  FROM ya_product_rating pr,
  ya_prod_rating_lang rl,
  ya_review r
  WHERE 1=1
  AND pr.rating_id = rl.rating_id
  AND rl.us_review_id = r.review_id
  AND (case when r.review is not null then r.review_id else NULL end) = RL.US_REVIEW_ID
  AND ROWNUM = 1
  AND pr.sku = iSKU
  AND pr.shopper_id = 'EDITORIAL';

  RETURN iRating_ID ;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL ;

END Fn_GetRatingID;
/

