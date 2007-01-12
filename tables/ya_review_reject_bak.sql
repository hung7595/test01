drop table ya_review_reject_bak
/

CREATE TABLE ya_review_reject_bak (
	review_id 		number 		NOT NULL ,
	review 			clob 		NULL ,
	review_img_loc 		varchar2(200) 	NULL ,
	review_img_width	number 		NULL ,
	review_img_height 	number 		NULL 
)
/

ALTER TABLE ya_review_reject_bak
	ADD CONSTRAINT PK_review_reject_bak PRIMARY KEY (review_id)
	USING INDEX TABLESPACE SSCommerceServer_INDEX 
/