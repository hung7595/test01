DROP TABLE Ya_Page_Lot
/

CREATE TABLE Ya_Page_Lot (
	lot_id                         int                  NOT NULL ,
	page_id                        int                  NOT NULL ,
	lot_position                   int                  NOT NULL ,
	lot_type_id                    int                  NOT NULL
)
/

ALTER TABLE Ya_Page_Lot
ADD CONSTRAINT PK_Page_Lot PRIMARY KEY (lot_id, page_id, lot_position)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Page_Lot FOR Ya_Page_Lot
/