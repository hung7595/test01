DROP TABLE Ya_Order_Chg_Ln_Act
/

CREATE TABLE Ya_Order_Chg_Ln_Act (
	id                           int                     NOT NULL ,
	order_change_id              int                     NOT NULL ,
	action_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Order_Chg_Ln_Act
ADD CONSTRAINT PK_Order_Chg_Ln_Act PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/