drop table ya_product_rating_reject_bak
/

CREATE TABLE ya_product_rating_reject_bak (
	rating_id 	number 		NOT NULL ,
	sku 		number 		NULL ,
	product_rating 	number(4)	NULL ,
	date_posted 	date 		NULL ,
	shopper_id 	char(32) 	NULL ,
	review_approved char(1) 	NULL ,
	reviewer_type 	varchar2(100) 	NULL ,
	reviewer 	varchar2(50) 	NULL 
)
/

ALTER TABLE ya_product_rating_reject_bak
	ADD CONSTRAINT PK_product_rating_reject_bak PRIMARY KEY (rating_id) 
	USING INDEX TABLESPACE SSCommerceServer_INDEX  
/

