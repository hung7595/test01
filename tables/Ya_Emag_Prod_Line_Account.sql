DROP TABLE Ya_Emag_Prod_Line_Account
/

CREATE TABLE Ya_Emag_Prod_Line_Account (
	prod_line_id                 int                  NOT NULL ,
	account_id                   int                  NOT NULL
)
/

ALTER TABLE Ya_Emag_Prod_Line_Account
ADD CONSTRAINT PK_Emag_Prod_Line_Account PRIMARY KEY (prod_line_id, account_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Emag_Prod_Line_Account FOR Ya_Emag_Prod_Line_Account
/