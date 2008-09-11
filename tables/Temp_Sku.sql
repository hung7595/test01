DROP TABLE Temp_Sku
/

CREATE GLOBAL TEMPORARY TABLE Temp_Sku (
	sku                   int
) ON COMMIT PRESERVE ROWS
/