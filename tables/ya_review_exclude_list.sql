drop table ya_review_exclude_list
/

CREATE TABLE ya_review_exclude_list (
	review_id 		number	NOT NULL ,
	exclude_for		char(1) NOT NULL ,
	created_datetime 	date 	default (sysdate)
) 
/

ALTER TABLE ya_review_exclude_list
	ADD CONSTRAINT PK_review_exclude_list PRIMARY KEY (review_id) 
	USING INDEX TABLESPACE SSCommerceServer_INDEX  
/

