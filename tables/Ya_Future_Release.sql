DROP TABLE Ya_Future_Release
/

CREATE TABLE Ya_Future_Release (
	site_id                          int                        NOT NULL ,
	sku                              int                        ,
	request_datetime                 date                       DEFAULT SYSDATE ,
	notified_datetime                date                       ,
	customer_name                    varchar2(100)              DEFAULT 'Unknown' ,
	customer_email                   varchar2(100)              ,
	rowguid                          varchar2(50)               DEFAULT SYS_GUID() NOT NULL,
	is_sent                          char(1)                    DEFAULT 'N' NOT NULL
)
/

ALTER TABLE Ya_Future_Release
ADD CONSTRAINT PK_Future_Release PRIMARY KEY (site_id, sku, request_datetime, customer_email)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Future_Release FOR Ya_Future_Release
/