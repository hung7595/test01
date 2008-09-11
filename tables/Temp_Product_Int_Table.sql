DROP TABLE Temp_Product_Int_Table
/

CREATE GLOBAL TEMPORARY TABLE Temp_Product_Int_Table (
	column1                int               NOT NULL ,
	column2                int
) ON COMMIT PRESERVE ROWS
/


CREATE PUBLIC SYNONYM Temp_Product_Int_Table FOR Temp_Product_Int_Table
/