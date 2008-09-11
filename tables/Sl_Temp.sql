DROP TABLE Sl_Temp
/

CREATE TABLE Sl_Temp (
	sku                        int                        NOT NULL ,
	site_id                    int                        NOT NULL ,
	action_id                  int                        NOT NULL ,
	import                     varchar2(1)                NOT NULL
)
/


CREATE PUBLIC SYNONYM Sl_Temp FOR Sl_Temp
/


create or replace TRIGGER TRI_sl_temp
BEFORE INSERT OR UPDATE OF import
ON sl_temp
FOR EACH ROW
BEGIN
	:NEW.import := UPPER(:NEW.import);
END;