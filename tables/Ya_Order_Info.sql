DROP TABLE Ya_Order_Info
/

CREATE TABLE Ya_Order_Info (
	order_num                int                         NOT NULL ,
	bank_name                varchar2(50)                ,
	bank_phone               varchar2(50)                ,
	bill_email               varchar2(50)
)
/

ALTER TABLE Ya_Order_Info
ADD CONSTRAINT PK_Order_Info PRIMARY KEY (order_num)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_Info FOR Ya_Order_Info
/