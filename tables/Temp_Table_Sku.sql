DROP TABLE Temp_Table_Sku
/

CREATE GLOBAL TEMPORARY TABLE Temp_Table_Sku (
	sku                   int
) ON COMMIT PRESERVE ROWS
/

ALTER TABLE TEMP_ORDER_ID ADD
CONSTRAINT PK_temp_order_id PRIMARY KEY  (order_id)
/


CREATE PUBLIC SYNONYM Temp_Table_Sku FOR Temp_Table_Sku
/