DROP TABLE Ya_Emag_Prod_Line_Record_Limit
/

CREATE TABLE Ya_Emag_Prod_Line_Record_Limit (
	prod_line_id                 int                  NOT NULL ,
	start_date                   int                  NOT NULL
)
/

ALTER TABLE Ya_Emag_Prod_Line_Record_Limit
ADD CONSTRAINT PK_Emag_Prod_Line_Record_Limit PRIMARY KEY (prod_line_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Emag_Prod_Line_Record_Limit FOR Ya_Emag_Prod_Line_Record_Limit
/