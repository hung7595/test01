DROP TABLE Ya_Review_Topreviewer
/

CREATE TABLE Ya_Review_Topreviewer (
	year                                 int                 NOT NULL ,
	month                                int                 NOT NULL ,
	shopper_id                           char(32)            NOT NULL ,
	this_month_submitted                 int                 ,
	total_submitted                      int                 ,
	helpful_votes                        int                 ,
	total_helpful_votes                  int
)	
/

ALTER TABLE Ya_Review_Topreviewer
ADD CONSTRAINT PK_Review_Topreviewer PRIMARY KEY (year, month, shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Topreviewer FOR Ya_Review_Topreviewer
/