DROP TABLE Ya_Lot_Entry
/

CREATE TABLE Ya_Lot_Entry (
	entry_id                         int                     NOT NULL ,
	lot_id                           int                     NOT NULL ,
	site_id                          int                     NOT NULL ,
	entry_position                   int                     NOT NULL ,
	start_date                       date                    ,
	end_date                         date                    ,
	entry_type_id                    int                     NOT NULL
)
/

ALTER TABLE Ya_Lot_Entry
ADD CONSTRAINT PK_Lot_Entry PRIMARY KEY (entry_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Lot_Entry_01 ON Ya_Lot_Entry(lot_id, site_id, entry_position, entry_type_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Lot_Entry FOR Ya_Lot_Entry
/