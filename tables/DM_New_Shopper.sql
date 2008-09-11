DROP TABLE DM_New_Shopper   
/

CREATE TABLE DM_New_Shopper (
	originid                   int                         ,
	category                   int                         ,
	customerid                 varchar2(100)               NOT NULL ,
	orderdate                  date                        ,
	feorderid                  varchar2(100)               ,
	beorderid                  int                         ,
	customeremail              varchar2(100)               ,
	shiptocountryid            int                         ,
	ethnicity                  int                         ,
	validorder                 varchar2(5)                 ,
	currentstatusid            int
)
/

ALTER TABLE DM_New_Shopper
ADD CONSTRAINT PK_DM_New_Shopper PRIMARY KEY (customerid)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_DM_New_Shopper_1 ON DM_New_Shopper (beorderid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_DM_New_Shopper_2 ON DM_New_Shopper (beorderid, validorder) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_DM_New_Shopper_3 ON DM_New_Shopper (feorderid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM DM_New_Shopper FOR DM_New_Shopper
/