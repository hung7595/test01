DROP TABLE Ya_Order_Line
/

CREATE TABLE Ya_Order_Line (
	order_id                        char(32)                    NOT NULL ,
	row_id                          int                         NOT NULL ,
	order_num                       int                         ,
	shopper_id                      char(32)                    ,
	sku                             int                         ,
	quantity                        int                         ,
	adjusted_price                  number(18,2)                ,
	unit_price                      number(18,2)                ,
	quantity_shipped                int                         ,
	line_status                     int                         ,
	line_tax                        number(18,2)                ,
	source_location                 int                         ,
	tracking_no                     varchaR2(50)                ,
	rowguid                         varchaR2(50)                DEFAULT SYS_GUID() NOT NULL ,
	quantity_billed                 int                         ,
	parent_row_id                   int                         ,
	action_qty                      int                         ,
	last_action_date                date                        ,
	amount_billed                   number(18,2)
)
/

ALTER TABLE Ya_Order_Line
ADD CONSTRAINT PK_Order_Line PRIMARY KEY (order_id, row_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Order_Line_01 ON Ya_Order_Line(order_num, row_id, sku, line_status, source_location, quantity, unit_price) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_Line_02 ON Ya_Order_Line(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Order_Line_03 ON Ya_Order_Line(shopper_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_Line FOR Ya_Order_Line
/