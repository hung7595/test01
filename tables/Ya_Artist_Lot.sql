DROP TABLE Ya_Artist_Lot
/

CREATE TABLE Ya_Artist_Lot (
	artist_lot_id               number(10)                  NOT NULL ,
	file_id                     number(10)                  ,
	lot_locatioin               number(10)                  ,
	artist_id                   number(10)
)
/

ALTER TABLE Ya_Artist_Lot
ADD CONSTRAINT PK_Artist_Lot PRIMARY KEY (artist_lot_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Artist_Lot_01 ON Ya_Artist_Lot(file_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Lot FOR Ya_Artist_Lot
/