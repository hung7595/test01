DROP TABLE Temp_Interest_Int_Table
/

CREATE GLOBAL TEMPORARY TABLE Temp_Interest_Int_Table (
	column1                int
) ON COMMIT PRESERVE ROWS
/