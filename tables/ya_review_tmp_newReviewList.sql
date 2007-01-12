drop table ya_review_tmp_newReviewList
/

CREATE TABLE ya_review_tmp_newReviewList (
	review_id 	number 		NOT NULL ,
	review 		clob		NULL ,
	lang_id 	number(4) 	NULL ,
	title 		varchar2(50) 	NULL ,
	rating_id 	number 		NULL ,
	date_posted 	date 		NULL ,
	shopper_id 	char(32) 	NULL ,
	reviewer 	varchar2(50) 	NULL 
)
/

ALTER TABLE ya_review_tmp_newReviewList
	ADD CONSTRAINT PK_review_tmp_newReviewList PRIMARY KEY (review_id) 
	USING INDEX TABLESPACE SSCommerceServer_INDEX
/
