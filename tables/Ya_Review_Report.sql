DROP TABLE Ya_Review_Report
/

CREATE TABLE Ya_Review_Report (
	report_id                        int                           NOT NULL ,
	review_id                        int                           ,
	sku                              int                           ,
	shopper_id                       varchar2(50)                  ,
	reason                           int                           ,
	report_content                   clob                          ,
	created_datetime                 date                          DEFAULT SYSDATE ,
	updated_datetime                 date                          DEFAULT SYSDATE ,
	rowguid                          char(50)                      DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Review_Report
ADD CONSTRAINT PK_Review_Report PRIMARY KEY (report_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Report FOR Ya_Review_Report
/