DROP TABLE Ya_Ass_Link_Ord_Tmp
/

CREATE TABLE Ya_Ass_Link_Ord_Tmp (
	link_id                        number(10)                  NOT NULL ,
	order_num                      number(10)                  ,
	row_id                         number(10)                  NOT NULL ,
	sku                            number(10)                  ,
	order_date                     date                        NOT NULL ,
	credit_amount                  number(18,2)                ,
	credit_status                  number(10)                  NOT NULL ,
	last_change_date               date                        ,
	rowguid                        long raw                    NOT NULL ,
	quantity                       number(10)                  ,
	unit_price                     number(18,2)                ,
	origin_order_id                varchar2(50)                NOT NULL
)
/