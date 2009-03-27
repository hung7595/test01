DROP TABLE Ya_Order_Chg_Act
/

CREATE TABLE Ya_Order_Chg_Act (
	id                         int                      NOT NULL ,
	description                varchar2(255)            NOT NULL
)
/

ALTER TABLE Ya_Order_Chg_Act
ADD CONSTRAINT PK_Order_Chg_Act PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Order_Chg_Act FOR Ya_Order_Chg_Act
/