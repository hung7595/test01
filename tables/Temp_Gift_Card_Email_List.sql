DROP TABLE Temp_Gift_Card_Email_List
/

CREATE GLOBAL TEMPORARY TABLE Temp_Gift_Card_Email_List (
	email                varchar2(255)               NOT NULL
) ON COMMIT PRESERVE ROWS
/