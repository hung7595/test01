DROP TABLE Temp_Email_Int_Table
/

CREATE GLOBAL TEMPORARY TABLE Temp_Email_Int_Table (
	artist_id             int                NOT NULL ,
	pref_id               int                NOT NULL
) ON COMMIT PRESERVE ROWS
/