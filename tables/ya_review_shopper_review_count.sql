drop table ya_review_shopper_review_count
/

CREATE TABLE ya_review_shopper_review_count (
	shopper_id 	char(32) NOT NULL ,
	review_count 	number	 NOT NULL 
)
/

ALTER TABLE ya_review_shopper_review_count
	ADD CONSTRAINT PK_review_shopper_review_count PRIMARY KEY (shopper_id)
	USING INDEX TABLESPACE SSCommerceServer_INDEX  
/
