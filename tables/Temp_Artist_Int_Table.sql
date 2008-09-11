DROP TABLE Temp_Artist_Int_Table
/

CREATE GLOBAL TEMPORARY TABLE Temp_Artist_Int_Table (
	column1               int                NOT NULL ,
	column2               int
) ON COMMIT PRESERVE ROWS
/ 
