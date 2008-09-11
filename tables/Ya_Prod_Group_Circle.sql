DROP TABLE Ya_Prod_Group_Circle
/

CREATE TABLE Ya_Prod_Group_Circle (
	group_circle_id              int                     NOT NULL ,
	group_sku                    int                     NOT NULL
)
/

ALTER TABLE Ya_Prod_Group_Circle
ADD CONSTRAINT PK_Prod_Group_Circle PRIMARY KEY (group_circle_id, group_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Group_Circle FOR Ya_Prod_Group_Circle
/