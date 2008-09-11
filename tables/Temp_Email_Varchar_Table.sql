DROP TABLE Temp_Email_Varchar_Table
/

CREATE GLOBAL TEMPORARY TABLE Temp_Email_Varchar_Table (
	content               varchar2(50)
) ON COMMIT PRESERVE ROWS
/