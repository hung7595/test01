DROP TABLE Tmp_Ya_Associate_Link_Orders
/

CREATE TABLE Tmp_Ya_Associate_Link_Orders (
	link_id                         number(28)                NOT NULL ,
	order_num                       number(28)                ,
	row_id                          number(28)                NOT NULL ,
	sku                             number(28)                ,
	order_date                      date                      NOT NULL ,
	credit_amount                   number(18,2)              ,
	credit_status                   number(28)                NOT NULL ,
	last_change_date                date                      ,
	rowguid                         varchar2(50)              NOT NULL ,
	quantity                        number(28)                ,
	unit_price                      number(18,2)              ,
	origin_order_id                 varchar2(150)             NOT NULL
)
/