DROP TABLE Tk_Tmp_Gift_Cert_Data
/

CREATE TABLE Tk_Tmp_Gift_Cert_Data (
	recipient_email              nvarchar2(255)          ,
	recipient_name               nvarchar2(255)
)
/


CREATE PUBLIC SYNONYM Tk_Tmp_Gift_Cert_Data FOR Tk_Tmp_Gift_Cert_Data
/