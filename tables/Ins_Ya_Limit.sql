DROP TABLE Ins_Ya_Limit   
/

CREATE TABLE Ins_Ya_Limit (
	sku                        number(10)                 NOT NULL ,
	site_id                    number(10)                 NOT NULL ,
	action_id                  number(10)                 NOT NULL ,
	action_datetime            date                       NOT NULL
)
/