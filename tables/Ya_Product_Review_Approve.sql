DROP TABLE Ya_Product_Review_Approve
/

CREATE TABLE Ya_Product_Review_Approve (
	rating_id                        int                       NOT NULL ,
	approved_datetime                date
)	
/

ALTER TABLE Ya_Product_Review_Approve
ADD CONSTRAINT PK_Product_Review_Approve PRIMARY KEY (rating_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Review_Approve FOR Ya_Product_Review_Approve
/