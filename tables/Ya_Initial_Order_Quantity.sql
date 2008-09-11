DROP TABLE Ya_Initial_Order_Quantity
/

CREATE TABLE Ya_Initial_Order_Quantity (
	profile_name                 varchar2(50)            NOT NULL ,
	sku                          number                  NOT NULL ,
	all_order_qty                number                  ,
	us_order_qty                 number                  ,
	gb_order_qty                 number                  ,
	gb_b2b_order_qty             number                  ,
	jp_b2b_order_qty             number                  ,
	all_alert_qty                number                  ,
	us_alert_qty                 number                  ,
	gb_alert_qty                 number                  ,
	gb_b2b_alert_qty             number                  ,
	jp_b2b_alert_qty             number                  ,
	us_b2c_projection            number                  ,
	us_b2b_projection            number                  ,
	gb_b2c_projection            number                  ,
	gb_b2b_projection            number                  ,
	remark                       varchar2(500)           ,
	rowguid                      varchar2(50)            DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Initial_Order_Quantity
ADD CONSTRAINT PK_Initial_Order_Quantity PRIMARY KEY (profile_name, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Initial_Order_Quantity FOR Ya_Initial_Order_Quantity
/