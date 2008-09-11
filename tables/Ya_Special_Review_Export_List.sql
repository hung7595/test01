DROP TABLE Ya_Special_Review_Export_List
/

CREATE TABLE Ya_Special_Review_Export_List (
	review_id                 int                   NOT NULL ,
	sku                       int                   NOT NULL
)	
/

ALTER TABLE Ya_Special_Review_Export_List
ADD CONSTRAINT PK_Special_Review_Export_List PRIMARY KEY (review_id, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Special_Review_Export_List FOR Ya_Special_Review_Export_List
/