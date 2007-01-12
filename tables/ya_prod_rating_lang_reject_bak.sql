drop table ya_prod_rating_lang_reject_bak
/

CREATE TABLE ya_prod_rating_lang_reject_bak (
	rating_id 	number 		NOT NULL ,
	lang_id 	number(4) 	NOT NULL ,
	title 		varchar2(50) 	NULL ,
	us_review_id 	number 		NULL ,
	hk_review_id 	number 		NULL ,
	jp_review_id 	number 		NULL ,
	tw_review_id 	number 		NULL ,
	preferred_flag 	char(1)		NULL 
)
/

ALTER TABLE ya_prod_rating_lang_reject_bak
	ADD CONSTRAINT PK_prod_rating_lang_reject_bak PRIMARY KEY (rating_id,lang_id)  
	USING INDEX TABLESPACE SSCommerceServer_INDEX 
/

