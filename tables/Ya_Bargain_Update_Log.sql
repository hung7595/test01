DROP TABLE Ya_Bargain_Update_Log
/

CREATE TABLE Ya_Bargain_Update_Log (
	last_updated_datetime          date        NOT NULL 
)
/

CREATE PUBLIC SYNONYM Ya_Bargain_Update_Log FOR Ya_Bargain_Update_Log
/
