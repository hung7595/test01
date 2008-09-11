DROP TABLE Ya_Prod_Rating_Summary
/

CREATE TABLE Ya_Prod_Rating_Summary (
	sku                           int                           NOT NULL ,
	num_rating                    int                           ,
	avg_score                     number(10,2)                  ,
	rowguid                       varchar2(50)                  DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Prod_Rating_Summary
ADD CONSTRAINT PK_Prod_Rating_Summary PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Rating_Summary_01 ON Ya_Prod_Rating_Summary(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Rating_Summary FOR Ya_Prod_Rating_Summary
/