DROP TABLE Temp_Publisher
/

CREATE GLOBAL TEMPORARY TABLE Temp_Publisher (
	publisher_id                int               NOT NULL ,
	dept_id                     int
) ON COMMIT PRESERVE ROWS
/