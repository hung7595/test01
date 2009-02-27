DROP TABLE Ya_Assoc_Hit_Count_Summary
/

CREATE TABLE Ya_Assoc_Hit_Count_Summary (
	count_dt    date             NOT NULL,
	hits        int              NOT NULL,
	code        nvarchar2(50)    NOT NULL,
	mod_user    varchar2(200)    NOT NULL,
	mod_dt      date             NOT NULL
)
/


CREATE PUBLIC SYNONYM Ya_Assoc_Hit_Count_Summary FOR Ya_Assoc_Hit_Count_Summary
/