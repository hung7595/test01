DROP TABLE Temp_Popcorn_Campaign
/


CREATE GLOBAL TEMPORARY TABLE Temp_Popcorn_Campaign (
	SKU       number      NOT NULL
) ON COMMIT PRESERVE ROWS
/