DROP TABLE Associate_Link_Orders   
/

CREATE TABLE Associate_Link_Orders (
	link_id                      int                     NOT NULL ,
	order_num                    int                     NOT NULL ,
	row_id                       int                     NOT NULL ,
	sku                          int                     ,
	order_date                   date                    NOT NULL ,
	credit_amount                number(18,2)            ,
	credit_status                int                     NOT NULL ,
	last_change_date             date                    DEFAULT SYSDATE ,
	rowguid                      varchar2(50)            DEFAULT SYS_GUID() NOT NULL ,
	quantity                     int                     ,
	unit_price                   number(18,2)            ,
	origin_order_id              nvarchar2(50)           NOT NULL
)
/

ALTER TABLE Associate_Link_Orders
ADD CONSTRAINT PK_Associate_Link_Orders PRIMARY KEY (link_id, origin_order_id, row_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Associate_Link_Orders_1 ON Associate_Link_Orders (rowguid) TABLESPACE SSCommerceserver_Index
/