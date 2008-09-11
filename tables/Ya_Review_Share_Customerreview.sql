DROP TABLE Ya_Review_Share_Customerreview
/

CREATE TABLE Ya_Review_Share_Customerreview (
	sku              int               NOT NULL
)	
/

ALTER TABLE Ya_Review_Share_Customerreview
ADD CONSTRAINT PK_Review_Share_Customerreview PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Share_Customerreview FOR Ya_Review_Share_Customerreview
/