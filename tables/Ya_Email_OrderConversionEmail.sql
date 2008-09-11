DROP TABLE Ya_Email_OrderConversionEmail
/

CREATE TABLE Ya_Email_OrderConversionEmail (
	order_num                  int                           NOT NULL ,
	email_message_id           int                           NOT NULL ,
	created_datetime           date                          DEFAULT SYSDATE NOT NULL ,
	rowguid                    varchar2(50)                  DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Email_OrderConversionEmail
ADD CONSTRAINT PK_Email_OrderConversionEmail PRIMARY KEY (order_num)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Email_OrderConversionEmail FOR Ya_Email_OrderConversionEmail
/