Drop Table Ya_Brand_Review_Rating
/

CREATE TABLE Ya_Brand_Review_Rating (
	brand_review_id           int                 NOT NULL ,
	rating_metric_type        int                 NOT NULL ,
	rating                    int                 NOT NULL
)
/

ALTER TABLE Ya_Brand_Review_Rating
ADD CONSTRAINT PK_Brand_Review_Rating PRIMARY KEY (brand_review_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand_Review_Rating FOR Ya_Brand_Review_Rating
/