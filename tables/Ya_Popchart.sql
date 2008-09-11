DROP TABLE Ya_Popchart
/

CREATE TABLE Ya_Popchart (
	popchart_id                    int                       NOT NULL ,
	file_id                        int                       ,
	lot_location                   int                       ,
	last_position                  nvarchar2(100)            ,
	desc_img_loc                   nvarchar2(200)            ,
	desc_img_width                 int                       ,
	desc_img_height                int
)
/

ALTER TABLE Ya_Popchart
ADD CONSTRAINT PK_Popchart PRIMARY KEY (popchart_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Popchart FOR Ya_Popchart
/