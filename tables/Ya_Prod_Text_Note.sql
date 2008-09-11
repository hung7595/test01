DROP TABLE Ya_Prod_Text_Note
/

CREATE TABLE Ya_Prod_Text_Note (
	sku                        int                      NOT NULL ,
	note_id                    int                      NOT NULL ,
	refer_sku                  int
)
/

ALTER TABLE Ya_Prod_Text_Note
ADD CONSTRAINT PK_Prod_Text_Note PRIMARY KEY (sku, note_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Text_Note FOR Ya_Prod_Text_Note
/