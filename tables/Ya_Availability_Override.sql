DROP TABLE Ya_Availability_Override
/

CREATE TABLE Ya_Availability_Override (
	supplier_id                 int                      NOT NULL ,
	account_id                  int                      NOT NULL ,
	availability_id             int                      NOT NULL ,
	start_date                  date                     NOT NULL ,
	end_date                    date                     NOT NULL ,
	updated_date                date                     DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Availability_Override
ADD CONSTRAINT PK_Availability_Override PRIMARY KEY (supplier_id, account_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Availability_Override FOR Ya_Availability_Override
/