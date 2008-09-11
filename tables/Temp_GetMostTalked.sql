DROP TABLE Temp_GetMostTalked
/

CREATE GLOBAL TEMPORARY TABLE Temp_GetMostTalked (
	sku                   int                NOT NULL ,
	last_count            int                NOT NULL ,
	total_count           int                NOT NULL
) ON COMMIT PRESERVE ROWS
/