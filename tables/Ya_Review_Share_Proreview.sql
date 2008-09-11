DROP TABLE Ya_Review_Share_Proreview
/

CREATE TABLE Ya_Review_Share_Proreview (
	child_sku                  int                      NOT NULL ,
	parent_sku                 int                      NOT NULL
)	
/


CREATE INDEX IX_Review_Share_Proreview_01 ON Ya_Review_Share_Proreview(child_sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Share_Proreview FOR Ya_Review_Share_Proreview
/