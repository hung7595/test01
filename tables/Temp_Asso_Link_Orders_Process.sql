DROP TABLE Temp_Asso_Link_Orders_Process
/

CREATE GLOBAL TEMPORARY TABLE Temp_Asso_Link_Orders_Process (
	origin_order_id      nvarchar2(100)    NOT NULL
) ON COMMIT PRESERVE ROWS
/

ALTER TABLE Temp_Asso_Link_Orders_Process ADD
CONSTRAINT PK_Ass_Link_Orders_Process PRIMARY KEY  (origin_order_id)
/


CREATE PUBLIC SYNONYM Temp_Asso_Link_Orders_Process FOR Temp_Asso_Link_Orders_Process
/
