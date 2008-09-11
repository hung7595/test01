DROP TABLE Temp_Int_Table
/

CREATE GLOBAL TEMPORARY TABLE Temp_Int_Table (
	column1                int               NOT NULL ,
	column2                int               NOT NULL
) ON COMMIT PRESERVE ROWS
/