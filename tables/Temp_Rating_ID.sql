DROP TABLE Temp_Rating_ID
/

CREATE GLOBAL TEMPORARY TABLE Temp_Rating_ID (
	rating_id                int
) ON COMMIT PRESERVE ROWS
/