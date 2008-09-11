DROP TABLE Ya_Prod_Score_Details
/

CREATE TABLE Ya_Prod_Score_Details (
	sku                                    int                           NOT NULL ,
	siteid                                 int                           NOT NULL ,
	daysincerelease                        int                           ,
	daysincelaunch                         int                           ,
	customerrating                         number(20,2)                  ,
	customerreview                         int                           ,
	professionalreview                     int                           ,
	withproductdescription                 int                           ,
	withcoverimage                         int                           ,
	campaignitem                           int                           ,
	discountitem                           int                           ,
	contentsupport                         int                           ,
	lastupdatedate                         date                          ,
	inventoryquantity                      int                           DEFAULT (0) ,
	hassales                               number(5)                     ,
	account_id                             int
)
/

ALTER TABLE Ya_Prod_Score_Details
ADD CONSTRAINT PK_Prod_Score_Details PRIMARY KEY (sku, siteid)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Score_Details_01 ON Ya_Prod_Score_Details(lastupdatedate) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Score_Details_02 ON Ya_Prod_Score_Details(account_id, sku, hassales, lastupdatedate) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Score_Details FOR Ya_Prod_Score_Details
/