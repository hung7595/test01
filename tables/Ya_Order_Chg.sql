DROP TABLE Ya_Order_Chg
/

CREATE TABLE Ya_Order_Chg (
	id                         int                      NOT NULL ,
	order_number               int                      NOT NULL ,
	action_id                  int                      NOT NULL ,
	change_date                date                     NOT NULL
)
/

ALTER TABLE Ya_Order_Chg
ADD CONSTRAINT PK_Order_Chg PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_Chg FOR Ya_Order_Chg
/
