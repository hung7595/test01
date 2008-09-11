DROP TABLE Ya_Prod_Group_Detail
/

CREATE TABLE Ya_Prod_Group_Detail (
	sku                          int                     NOT NULL ,
	group_circle_id              int                     NOT NULL
)
/

ALTER TABLE Ya_Prod_Group_Detail
ADD CONSTRAINT PK_Prod_Group_Detail PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Group_Detail FOR Ya_Prod_Group_Detail
/