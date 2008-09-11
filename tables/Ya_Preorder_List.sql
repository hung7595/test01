DROP TABLE Ya_Preorder_List
/

CREATE TABLE Ya_Preorder_List (
	sku                   int                 NOT NULL
)
/

ALTER TABLE Ya_Preorder_List
ADD CONSTRAINT PK_Preorder_List PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Preorder_List FOR Ya_Preorder_List
/