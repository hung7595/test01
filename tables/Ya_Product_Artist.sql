DROP TABLE Ya_Product_Artist
/

CREATE TABLE Ya_Product_Artist (
	sku                        int                        NOT NULL ,
	artist_id                  int                        NOT NULL ,
	rel_id                     int                        NOT NULL ,
	created_date               date                       ,
	updated_date               date                       ,
	created_user               varchar2(20)               ,
	updated_user               varchar2(20)               ,
	rel_ranking                int
)
/

ALTER TABLE Ya_Product_Artist
ADD CONSTRAINT PK_Product_Artist PRIMARY KEY (sku, artist_id, rel_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Artist_01 ON Ya_Product_Artist(artist_id, sku, rel_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Artist FOR Ya_Product_Artist
/