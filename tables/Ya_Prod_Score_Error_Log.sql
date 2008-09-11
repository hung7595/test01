DROP TABLE Ya_Prod_Score_Error_Log
/

CREATE TABLE Ya_Prod_Score_Error_Log (
	logid                              int                           NOT NULL ,
	sku                                int                           NOT NULL ,
	siteid                             int                           NOT NULL ,
	logdatetime                        date                          ,
	logmessage                         nvarchar2(1000)
)
/

ALTER TABLE Ya_Prod_Score_Error_Log
ADD CONSTRAINT PK_Prod_Score_Error_Log PRIMARY KEY (logid)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Score_Error_Log_01 ON Ya_Prod_Score_Error_Log(lastupdatedate) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Score_Error_Log_02 ON Ya_Prod_Score_Error_Log(sku, siteid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Score_Error_Log FOR Ya_Prod_Score_Error_Log
/