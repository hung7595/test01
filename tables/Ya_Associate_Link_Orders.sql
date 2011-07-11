DROP TABLE Ya_Associate_Link_Orders
/

CREATE TABLE Ya_Associate_Link_Orders (
	link_id                        int                     NOT NULL ,
	order_num                      int                     ,
	row_id                         int                     NOT NULL ,
	sku                            int                     ,
	order_date                     date                    NOT NULL ,
	credit_amount                  number(18,2)            ,
	credit_status                  int                     NOT NULL ,
	last_change_date               date                    DEFAULT SYSDATE ,
	rowguid                        varchar2(50)            DEFAULT SYS_GUID() NOT NULL ,
	quantity                       int                     ,
	unit_price                     number(18,2)            ,
	origin_order_id                nvarchar2(50)           NOT NULL
)
/

ALTER TABLE Ya_Associate_Link_Orders
ADD CONSTRAINT PK_Associate_Link_Orders PRIMARY KEY (link_id, origin_order_id, row_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Associate_Link_Orders_01 ON Ya_Associate_Link_Orders(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Link_Orders_02 ON Ya_Associate_Link_Orders(TO_CHAR(ORDER_NUM)) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Link_Orders_03 ON Ya_Associate_Link_Orders(order_date, credit_status) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Link_Orders_04 ON Ya_Associate_Link_Orders(origin_order_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Associate_Link_Orders_05 ON Ya_Associate_Link_Orders(CASE WHEN credit_status =1 THEN 'Y' ELSE NULL END) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Link_Orders FOR Ya_Associate_Link_Orders
/