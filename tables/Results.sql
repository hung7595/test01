DROP TABLE Results   
/

CREATE TABLE Results (
	associate_id               int                         NOT NULL ,
	valid_date                 date                        NOT NULL ,
	comm_rate                  number(18,4)                ,
	payment_option             int                         NOT NULL ,
	rowguid                    varchar2(50)                NOT NULL

)
/


CREATE PUBLIC SYNONYM Results FOR Results
/