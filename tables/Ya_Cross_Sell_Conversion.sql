DROP TABLE Ya_Cross_Sell_Conversion
/

CREATE TABLE Ya_Cross_Sell_Conversion (
	tracking_type                   varchar2(128)                 NOT NULL ,
	monitor_key                     varchar2(256)                 NOT NULL ,
	order_num                       int                           NOT NULL ,
	created_datetime                date                          NOT NULL ,
	rowguid                         varchar2(50)                  DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Cross_Sell_Conversion
ADD CONSTRAINT PK_Cross_Sell_Conversion PRIMARY KEY (order_num, monitor_key, tracking_type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Cross_Sell_Conversion FOR Ya_Cross_Sell_Conversion
/