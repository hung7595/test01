DROP TABLE Ya_Order_Status
/

CREATE TABLE Ya_Order_Status (
	order_num                      int                          NOT NULL ,
	status                         int                          DEFAULT 0 NOT NULL ,
	lastupdate                     date                         ,
	reason                         varchar2(100)
)
/

ALTER TABLE Ya_Order_Status
ADD CONSTRAINT PK_Order_Status PRIMARY KEY (order_num)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_Status FOR Ya_Order_Status
/