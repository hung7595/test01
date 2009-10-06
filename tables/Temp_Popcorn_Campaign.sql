DROP TABLE Temp_Popcorn_Campaign
/


CREATE GLOBAL TEMPORARY TABLE Temp_Popcorn_Campaign (
	SKU       number      NOT NULL
) ON COMMIT PRESERVE ROWS
/


ALTER TABLE Temp_Popcorn_Campaign
ADD CONSTRAINT PK_Temp_Popcorn_Campaign PRIMARY KEY (sku)
/
