DROP TABLE Ya_Product_Rating
/

CREATE TABLE Ya_Product_Rating (
	rating_id                        int                        NOT NULL ,
	sku                              int                        ,
	product_rating                   int                        ,
	date_posted                      date                       ,
	shopper_id                       char(32)                   ,
	review_approved                  char(1)                    ,
	reviewer_type                    varchar2(100)              ,
	reviewer                         varchar2(100)              ,
	rowguid                          varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Product_Rating
ADD CONSTRAINT PK_Product_Rating PRIMARY KEY (rating_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Rating_01 ON Ya_Product_Rating(sku, rating_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_02 ON Ya_Product_Rating(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_03 ON Ya_Product_Rating(date_posted, reviewer_type, review_approved) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_04 ON Ya_Product_Rating(sku, shopper_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_05 ON Ya_Product_Rating(rating_id, reviewer_type, review_approved) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_06 ON Ya_Product_Rating(shopper_id, review_approved, reviewer_type) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_07 ON Ya_Product_Rating(sku, reviewer_type, review_approved) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_08 ON Ya_Product_Rating(rating_id, shopper_id, review_approved, reviewer_type) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_09 ON Ya_Product_Rating(CASE WHEN (review_approved='Y' AND reviewer_type='EDITOR') THEN 'Y' ELSE NULL END ) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Rating_10 ON Ya_Product_Rating(date_posted, reviewer_type, review_approved, sku, rating_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Rating FOR Ya_Product_Rating
/


create or replace TRIGGER TRAL_ya_product_rating
AFTER INSERT OR UPDATE OR DELETE
ON ya_product_rating
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_PRODUCT_RATING', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_PRODUCT_RATING', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;

create or replace TRIGGER TRI_product_rating_1
BEFORE INSERT OR UPDATE OF review_approved
ON ya_product_rating
FOR EACH ROW
BEGIN
	:NEW.review_approved := UPPER(:NEW.review_approved);
END;

create or replace TRIGGER TRI_product_rating_2
BEFORE INSERT OR UPDATE OF reviewer_type
ON ya_product_rating
FOR EACH ROW
BEGIN
	:NEW.reviewer_type := UPPER(:NEW.reviewer_type);
END;