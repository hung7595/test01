DROP TABLE Ya_Order_Chg_Ln
/

CREATE TABLE Ya_Order_Chg_Ln (
	id                           int                     NOT NULL ,
	order_change_id              int                     NOT NULL ,
	action_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Order_Chg_Ln
ADD CONSTRAINT PK_Order_Chg_Ln PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/