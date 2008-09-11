DROP TABLE Tk_Test
/

CREATE TABLE Tk_Test (
	trial_id                     int                     NOT NULL ,
	message                      nvarchar2(10)           NOT NULL	
)
/


CREATE PUBLIC SYNONYM Tk_Test FOR Tk_Test
/