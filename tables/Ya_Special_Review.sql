DROP TABLE Ya_Special_Review
/

CREATE TABLE Ya_Special_Review (
	type_id                          int                       NOT NULL ,
	review_title                     nvarchar2(400)            NOT NULL ,
	review_body                      nclob                     NOT NULL ,
	reviewer_name                    nvarchar2(100)            ,
	reviewer_email                   nvarchar2(100)            ,
	reviewer_type                    nvarchar2(100)            DEFAULT 'USER' NOT NULL ,
	review_approved                  nchar(20)                 DEFAULT 'N' NOT NULL ,
	review_id                        int                       NOT NULL ,
	created_datetime                 date                      DEFAULT SYSDATE NOT NULL ,
	lang_id                          int                       NOT NULL	
)	
/

ALTER TABLE Ya_Special_Review
ADD CONSTRAINT PK_Special_Review PRIMARY KEY (review_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Special_Review FOR Ya_Special_Review
/