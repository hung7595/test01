DROP TABLE Ya_Top_Sellers
/

CREATE TABLE Ya_Top_Sellers (
	dept_id                  int                    NOT NULL ,
	top_count                int                    NOT NULL
)	
/

ALTER TABLE Ya_Top_Sellers
ADD CONSTRAINT PK_Top_Sellers PRIMARY KEY (dept_id, top_count)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Top_Sellers FOR Ya_Top_Sellers
/